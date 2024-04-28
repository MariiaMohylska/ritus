//
//  TackerDetailsViewController.swift
//  ritus
//
//  Created by Mariia Mohylska on 4/16/24.
//

import UIKit

class TackerDetailsViewController: UIViewController, UITextViewDelegate, UICalendarSelectionMultiDateDelegate {
    
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressPercentLabel: UITextView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var calendarContainerView: UIView!
    private var calendarView: UICalendarView!
    
    var habit: Habit?
    
    var datesForCurrentMonth: [Date] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = habit?.name
        descriptionLabel.text = habit?.description
        descriptionLabel.isEditable = false
        setProgress()
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
        calendarView.selectionBehavior = UICalendarSelectionMultiDate(delegate: self)
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
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, canSelectDate dateComponents: DateComponents) -> Bool {
        guard let selectedDay = dateComponents.date else { return false}
        return selectedDay.compareDateToCurrent()
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        guard let selectedDay = dateComponents.date else { return}
        if !selectedDay.compareDateToCurrent() {return}
        
        if habit?.toDoDates[selectedDay] != nil{
            habit?.toDoDates[selectedDay] = !(habit?.toDoDates[selectedDay] ?? true)
            let dateComponentsArray: [DateComponents] = [dateComponents]
            habit?.save()
            setProgress()
            calendarView.reloadDecorations(forDateComponents: dateComponentsArray, animated: true)
        }
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        guard let selectedDay = dateComponents.date else { return}
        if !selectedDay.compareDateToCurrent() {return}
        
        if habit?.toDoDates[selectedDay] != nil{
            habit?.toDoDates[selectedDay] = !(habit?.toDoDates[selectedDay] ?? false)
            let dateComponentsArray: [DateComponents] = [dateComponents]
            habit?.save()
            setProgress()
            calendarView.reloadDecorations(forDateComponents: dateComponentsArray, animated: true)
        }
    }
    
    private func setProgress(){
        let progress = habit?.progress ?? 0
        progressPercentLabel.text = "\((progress * 100).rounded())%"
        progressBar.progress = Float(progress)
    }
}

extension TackerDetailsViewController: UICalendarViewDelegate {
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        if let date = dateComponents.date  {
            let isCurrentDay = date.compareDateToCurrent()
            if let isCompleted = habit?.toDoDates[date] {
                let image = UIImage(systemName:  !isCompleted ? "circle" : "circle.inset.filled")
                return .image(image, color: isCurrentDay ? .systemBlue : .systemGray, size: .large)
            }
        }
        return nil
    }
}
