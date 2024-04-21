//
//  TackerDetailsViewController.swift
//  ritus
//
//  Created by Mariia Mohylska on 4/16/24.
//

import UIKit

class TackerDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var progressPercentLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calendarView: UIView!
    
    var habit: Habit?

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = habit?.name
        descriptionLabel.text = habit?.description
        progressPercentLabel.text = "\(habit?.progress ?? 0)%"
        progressBar.progress = Float(habit?.progress ?? 0)
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        monthLabel.text = dateFormatter.string(from: Date())
        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteTracker(_ sender: Any) {
    }
    
}
