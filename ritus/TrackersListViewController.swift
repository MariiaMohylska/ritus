//
//  TrackersListViewController.swift
//  ritus
//
//  Created by Mariia Mohylska on 4/16/24.
//

import UIKit

class TrackersListViewController: UIViewController {
    
    @IBOutlet weak var habitsTableView: UITableView!
    var habits = [Habit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.selectedIndex = 0
        
        habitsTableView.tableHeaderView =  UIView()
        habitsTableView.dataSource = self
        //        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshHabits()
    }
    
    private func refreshHabits() {
        let habits = Habit.getHabits()
        
        self.habits = habits
        
        //Add empy label logic
        
        //Check if it is needed to be tableView.reloadSelection and why
        habitsTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedRow = habitsTableView.indexPathForSelectedRow else {return}
        
        let selectedHabit = habits[selectedRow.row]
        
        guard let detailsViewController = segue.destination as? TackerDetailsViewController else  { return }
        detailsViewController.habit = selectedHabit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndex = habitsTableView.indexPathForSelectedRow {
            habitsTableView.deselectRow(at: selectedIndex, animated: animated)
        }
    }
}

extension TrackersListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = habitsTableView.dequeueReusableCell(withIdentifier: "HabitCell", for: indexPath) as! HabitCell
        
        let habit = habits[indexPath.row]
       
        cell.nameLabel.text = habit.name
        cell.progressPercentLabel.text = "\(habit.progress)%"
        cell.progressBar
            .progress = Float(habit.progress)
    
        
        return cell
    }
}


