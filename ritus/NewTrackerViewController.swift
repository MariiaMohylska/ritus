//
//  NewTrackerViewController.swift
//  ritus
//
//  Created by Mariia Mohylska on 4/16/24.
//

import UIKit

class NewTrackerViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    
    var everydayIsChecked = false
    var mondayIsChecked = false
    var tuesdayIsChecked = false
    var wednesdayIsChecked = false
    var thursdayIsChecked = false
    var fridayIsChecked = false
    var saturdayIsChecked = false
    var sundayIsChecked = false
    
    @IBOutlet weak var everydayButton: UIButton!
    
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    @IBOutlet weak var sundayButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addTrackerSubmit(_ sender: Any) {
        let name = nameTextField.text ?? "New habit"
        let description = descriptionTextField.text ?? ""
        let habit = Habit(name: name, description: description, frequency: frequency(), toDoDates: nil)
        habit.save()
    }
    
    func frequency() -> [Frequency] {
        var frequencies: [Frequency] = []
        if everydayIsChecked{
//            frequencies.append(Frequency.everyMonday)
//            frequencies.append(Frequency.everyTuesday)
//            frequencies.append(Frequency.everyWednesday)
//            frequencies.append(Frequency.everyThursday)
//            frequencies.append(Frequency.everyFriday)
//            frequencies.append(Frequency.everySunday)
//            frequencies.append(Frequency.everySaturday)
        } else {
            if mondayIsChecked {
                frequencies.append(Frequency.everyMonday)
            }
            if tuesdayIsChecked{
                frequencies.append(Frequency.everyTuesday)
            }
            if wednesdayIsChecked {
                frequencies.append(Frequency.everyWednesday)
            }
            if thursdayIsChecked {
                frequencies.append(Frequency.everyThursday)
            }
            if fridayIsChecked {
                frequencies.append(Frequency.everyFriday)
            }
            if saturdayIsChecked {
                frequencies.append(Frequency.everySaturday)
            }
            if sundayIsChecked{
                frequencies.append(Frequency.everySunday)
            }
        }
        
        return frequencies
    }
    
    //TODO: redo selection logic
    @IBAction func everydayButton(_ sender: UIButton) {
        checkButton(everydayButton, everydayIsChecked)
        everydayIsChecked = !everydayIsChecked
        checkEverything()
    }
    
    
    @IBAction func mondayButton(_ sender: UIButton) {
        mondayIsChecked = !mondayIsChecked
        checkButton(mondayButton, mondayIsChecked)
        checkEverydaySelected()
    }
    
    @IBAction func tuesdayButton(_ sender: UIButton) {
        checkButton(tuesdayButton, tuesdayIsChecked)
        tuesdayIsChecked = !tuesdayIsChecked
        checkEverydaySelected()
    }
    
    @IBAction func wednesdayButton(_ sender: UIButton) {
        checkButton(wednesdayButton, wednesdayIsChecked)
       wednesdayIsChecked = !wednesdayIsChecked
        checkEverydaySelected()
    }
    
    @IBAction func thursdayButton(_ sender: UIButton) {
        checkButton(thursdayButton, thursdayIsChecked)
        thursdayIsChecked = !thursdayIsChecked
        checkEverydaySelected()
    }
    
    @IBAction func fridayButton(_ sender: UIButton) {
        checkButton(fridayButton, fridayIsChecked)
        fridayIsChecked = !fridayIsChecked
        checkEverydaySelected()
    }
    
    @IBAction func saturdayButton(_ sender: UIButton) {
        checkButton(saturdayButton, saturdayIsChecked)
        saturdayIsChecked = !saturdayIsChecked
        checkEverydaySelected()
    }
    
    @IBAction func sundayButton(_ sender: UIButton) {
        checkButton(sundayButton, sundayIsChecked)
        sundayIsChecked = !sundayIsChecked
        checkEverydaySelected()
    }
    
    func checkButton(_ button: UIButton, _ isChecked: Bool){
        if !isChecked {
            button.backgroundColor = UIColor.blue
        } else {
            button.backgroundColor = UIColor.quaternarySystemFill
        }
    }
    
    func checkEverydaySelected()  {
        let allSelected = sundayIsChecked && mondayIsChecked && tuesdayIsChecked && wednesdayIsChecked && thursdayIsChecked && fridayIsChecked && saturdayIsChecked
        
        if allSelected && !everydayIsChecked {
            checkButton(everydayButton, everydayIsChecked)
        } else if !allSelected && everydayIsChecked {
            checkButton(everydayButton, everydayIsChecked)
        }
        
        everydayIsChecked = !everydayIsChecked
    }
    
    func checkEverything() {
        if everydayIsChecked {
            mondayIsChecked = false
            tuesdayIsChecked = false
            wednesdayIsChecked = false
            thursdayIsChecked = false
            fridayIsChecked = false
            saturdayIsChecked = false
            sundayIsChecked = false
        } else if !everydayIsChecked{
            mondayIsChecked = true
            tuesdayIsChecked = true
            wednesdayIsChecked = true
            thursdayIsChecked = true
            fridayIsChecked = true
            saturdayIsChecked = true
            sundayIsChecked = true
        }
        
        checkButton(mondayButton, mondayIsChecked)
        checkButton(tuesdayButton, tuesdayIsChecked)
        checkButton(wednesdayButton, wednesdayIsChecked)
        checkButton(thursdayButton, thursdayIsChecked)
        checkButton(fridayButton, fridayIsChecked)
        checkButton(saturdayButton, saturdayIsChecked)
        checkButton(sundayButton, sundayIsChecked)
        
        mondayIsChecked = !mondayIsChecked
        tuesdayIsChecked = !tuesdayIsChecked
        wednesdayIsChecked = !wednesdayIsChecked
        thursdayIsChecked = !thursdayIsChecked
        fridayIsChecked = !fridayIsChecked
        saturdayIsChecked = !saturdayIsChecked
        sundayIsChecked = !sundayIsChecked
    }
}
