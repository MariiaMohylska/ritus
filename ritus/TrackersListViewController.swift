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
}

extension TrackersListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = habitsTableView.dequeueReusableCell(withIdentifier: "HabitCell", for: indexPath) as! HabitCell
        
        let habit = habits[indexPath.row]
        
        cell.nameLabel.text = habit.name
        cell.progressLabel.text = "\(habit.progress)%"
        cell.progressBar.progress = Float(habit.progress)
    
        
        return cell
    }
}

//extension TrackersListViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        habitsTableView.deselectRow(at: indexPath, animated: false)
//        let selectedHabit = habits[indexPath.row]
//        
//        //TODO
////        performSegue(withIdentifier: "", sender: Any?)
//    }
//}
