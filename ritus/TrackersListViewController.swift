import UIKit

class TrackersListViewController: UIViewController {
    
    @IBOutlet weak var emptyListLabel: UILabel!
    @IBOutlet weak var habitsTableView: UITableView!
    
    var habits = [Habit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.selectedIndex = 0
        
        habitsTableView.tableHeaderView =  UIView()
        habitsTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshHabits()
        if habits.isEmpty{
            emptyListLabel.isHidden = false
            habitsTableView.isHidden = true
        } else {
            emptyListLabel.isHidden = true
            habitsTableView.isHidden = false
        }
        
        if shouldRunFunctionOnFirstLaunchOfDay() {
                    UserDefaults.standard.set(Date(), forKey: "LastLaunchDate")
            
            print("NEW")
            
            AwardsService.fetchImage(){
                images in
                AwardsService.fetchInspirationQuotes(){
                    quotes in
                     let awardsList = AwardsCalculation.checkAwards(imagesForAward: images ?? [], inspirationsForAward: quotes)
                    if !awardsList.isEmpty {
                        self.showAwardsListAlert(list: awardsList)
                    }
                }
            }
        }
    }
    
    private func shouldRunFunctionOnFirstLaunchOfDay() -> Bool {
          let userDefaults = UserDefaults.standard
          
          if let lastLaunchDate = userDefaults.object(forKey: "LastLaunchDate") as? Date {
              return !lastLaunchDate.compareDateToCurrent()
          }
          
          return true
      }
      
    
    private func showAwardsListAlert(list: String) {
        let alert = UIAlertController(title: "Congratulations!", message: "You gained new awards: \n \(list)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    private func refreshHabits() {
        let habits = Habit.getHabits()
        
        self.habits = habits
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
        cell.progressPercentLabel.text = "\((habit.progress * 100).rounded())%"
        cell.progressBar
            .progress = Float(habit.progress)
    
        
        return cell
    }
}


