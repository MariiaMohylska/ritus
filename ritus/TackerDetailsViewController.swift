//
//  TackerDetailsViewController.swift
//  ritus
//
//  Created by Mariia Mohylska on 4/16/24.
//

import UIKit

class TackerDetailsViewController: UIViewController, UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let selectedDay = dateComponents?.date else { return}
        if !compareDateToCurrent(selectedDay: selectedDay) {return}
        
        if habit?.toDoDates[selectedDay] != nil{
            habit?.toDoDates[selectedDay] = !(habit?.toDoDates[selectedDay] ?? true)
            let dateComponentsArray: [DateComponents] = [dateComponents!]
            habit?.save()
            calendarView.reloadDecorations(forDateComponents: dateComponentsArray, animated: true)
        }
    }
    
    private func compareDateToCurrent(selectedDay: Date) -> Bool {
        let currentDay = Date()

        let calendar = Calendar.current

        let components1 = calendar.dateComponents([.year, .month, .day], from: currentDay)
        let components2 = calendar.dateComponents([.year, .month, .day], from: selectedDay)

        if components1.year == components2.year && components1.month == components2.month && components1.day == components2.day {
            return true
        } else {
            return false
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var progressPercentLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var calendarContainerView: UIView!
    private var calendarView: UICalendarView!
    
    var habit: Habit?
    
    var datesForCurrentMonth: [Date] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = habit?.name
        descriptionLabel.text = habit?.description
        progressPercentLabel.text = "\(habit?.progress ?? 0)%"
        progressBar.progress = Float(habit?.progress ?? 0)
        
        
        self.calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
                calendarContainerView.addSubview(calendarView)
        
                NSLayoutConstraint.activate([
                    calendarView.leadingAnchor.constraint(equalTo: calendarContainerView.leadingAnchor),
                    calendarView.topAnchor.constraint(equalTo: calendarContainerView.topAnchor),
                    calendarView.trailingAnchor.constraint(equalTo: calendarContainerView.trailingAnchor),
                    calendarView.bottomAnchor.constraint(equalTo: calendarContainerView.bottomAnchor)
                ])
        
        calendarView.delegate = self
        
        calendarView.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
    }

    @IBAction func deleteTracker(_ sender: Any) {
        let alert = UIAlertController(title: "Do you want to delete this habit?", message: "All progress related to this habit will be deleted", preferredStyle: .alert)
        
        let delete = {
            (_ action: UIAlertAction) in
            self.habit?.delete()
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: delete))
        present(alert, animated: true)
    }
    
    private func checkCompletion(selectedDay: Date){
    }
}

extension TackerDetailsViewController: UICalendarViewDelegate {
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        if let date = dateComponents.date  {
            let isCurrentDay = compareDateToCurrent(selectedDay: date)
            if let isCompleted = habit?.toDoDates[date] {
                let image = UIImage(systemName:  !isCompleted ? "circle" : "circle.inset.filled")
                return .image(image, color: isCurrentDay ? .systemBlue : .systemGray, size: .large)
            }
        }
        return nil
    }
}
