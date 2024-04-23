//
//  NewTrackerViewController.swift
//  ritus
//
//  Created by Mariia Mohylska on 4/16/24.
//

import UIKit

class NewTrackerViewController: UIViewController, UITextViewDelegate {

    private let descriptionHintText = "You can describe your goal or add some inspiration quotes here"
    
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
    
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    @IBOutlet weak var sundayButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        descriptionTextField.layer.borderColor = UIColor.systemGray6.cgColor
        descriptionTextField.layer.borderWidth = 0.9
        descriptionTextField.layer.cornerRadius = 5
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func addTrackerSubmit(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty else {
                emptyName()
                return
            }
        let frequency = frequency()
        if frequency.isEmpty  {
            emptyDays()
            return
        }
        let description = descriptionTextField.text != descriptionHintText ? descriptionTextField.text : ""
        let habit = Habit(name: name, description: description ?? "", frequency: frequency, toDoDates: nil)
        habit.save()
        resetScreen()
        confirmCreating()
    }
    
    private func confirmCreating() {
        let alert = UIAlertController(title: "Congradulation!", message: "New habit was succesfully added. \n You can find it in 'Trackers' section", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func emptyName() {
        let alert = UIAlertController(title: "Ooooops we have a problem", message: "Please, specify name of your habit", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    private func emptyDays() {
        let alert = UIAlertController(title: "Ooooops we have a problem", message: "Please, select days, when you want to perform your habit", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    private func frequency() -> [Frequency] {
        var frequencies: [Frequency] = []
        
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
    
        
        return frequencies
    }
    
    
    @IBAction func mondayButton(_ sender: UIButton) {
        checkButton(mondayButton, mondayIsChecked)
        mondayIsChecked = !mondayIsChecked
    }
    
    @IBAction func tuesdayButton(_ sender: UIButton) {
        checkButton(tuesdayButton, tuesdayIsChecked)
        tuesdayIsChecked = !tuesdayIsChecked
    }
    
    @IBAction func wednesdayButton(_ sender: UIButton) {
        checkButton(wednesdayButton, wednesdayIsChecked)
       wednesdayIsChecked = !wednesdayIsChecked
    }
    
    @IBAction func thursdayButton(_ sender: UIButton) {
        checkButton(thursdayButton, thursdayIsChecked)
        thursdayIsChecked = !thursdayIsChecked
    }
    
    @IBAction func fridayButton(_ sender: UIButton) {
        checkButton(fridayButton, fridayIsChecked)
        fridayIsChecked = !fridayIsChecked
    }
    
    @IBAction func saturdayButton(_ sender: UIButton) {
        checkButton(saturdayButton, saturdayIsChecked)
        saturdayIsChecked = !saturdayIsChecked
    }
    
    @IBAction func sundayButton(_ sender: UIButton) {
        checkButton(sundayButton, sundayIsChecked)
        sundayIsChecked = !sundayIsChecked
    }
    
    private func checkButton(_ button: UIButton, _ isChecked: Bool){
        if !isChecked {
            button.backgroundColor = UIColor.blue
        } else {
            button.backgroundColor = UIColor.quaternarySystemFill
        }
    }
    
    private func resetScreen() {
        nameTextField.text = ""
        descriptionTextField.text = ""
        textViewDidEndEditing(descriptionTextField)
        mondayIsChecked = false
        mondayButton.backgroundColor = UIColor.quaternarySystemFill
        tuesdayIsChecked = false
        tuesdayButton.backgroundColor = UIColor.quaternarySystemFill
        wednesdayIsChecked = false
        wednesdayButton.backgroundColor = UIColor.quaternarySystemFill
        thursdayIsChecked = false
        thursdayButton.backgroundColor = UIColor.quaternarySystemFill
        fridayIsChecked = false
        fridayButton.backgroundColor = UIColor.quaternarySystemFill
        saturdayIsChecked = false
        saturdayButton.backgroundColor = UIColor.quaternarySystemFill
        sundayIsChecked = false
        sundayButton.backgroundColor = UIColor.quaternarySystemFill
    }
    
    // Function to set up the initial state of the UITextView
       private func setupTextView() {
            // Set the text color to light gray
           descriptionTextField.textColor = UIColor.lightGray
            
            // Set the text to the hint text
           descriptionTextField.text = descriptionHintText
            
            // Set the delegate to handle the text view events
           descriptionTextField.delegate = self
        }
        
        // UITextViewDelegate method called when the text view begins editing
    @objc func textViewDidBeginEditing(_ textView: UITextView) {
            // Clear the hint text if it matches the current text
            if descriptionTextField.text == descriptionHintText {
                descriptionTextField.text = ""
                descriptionTextField.textColor = UIColor.black // Set text color to black when editing
            }
        }
        
        // UITextViewDelegate method called when the text view ends editing
    @objc func textViewDidEndEditing(_ textView: UITextView) {
            // Restore the hint text if the text view is empty
            if descriptionTextField.text.isEmpty {
                descriptionTextField.text = descriptionHintText
                descriptionTextField.textColor = UIColor.lightGray // Set text color back to light gray
            }
        descriptionTextField.resignFirstResponder()
        }
}
