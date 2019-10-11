//https://stackoverflow.com/questions/28394933/how-do-i-check-when-a-uitextfield-changes
//  ViewController.swift
//https://stackoverflow.com/questions/44305016/how-to-restrict-textfield-to-accept-only-decimal-values-in-swift
//  1
//
//  Created by GayaneA on 10/10/19.
//  Copyright © 2019 GayaneA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var enteramount: UITextField!
    
    @IBOutlet weak var numofpeople: UITextField!
    
    @IBOutlet weak var peoplenum: UILabel!
    
    @IBOutlet weak var amountperperson: UILabel!
    
    @IBOutlet weak var totalamount: UILabel!
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    
    
    var checkAmount = 0.0
    var tipPercent = 20.0
    var numpeople = 2.0
    var total = 0.0
    var perperson = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assign textfield delegate
        enteramount.delegate = self
        numofpeople.delegate = self
        
        
        enteramount.text = "0.0"
        numofpeople.text = "2"
        segment.selectedSegmentIndex = 2
        title = "Split WE"
    }

    
    //Textfields will accept only doubles. if i have multiple textfields, i can use if
    // if textfield == ... {} else...
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text != "" || string != "" {
            let res = (textField.text ?? "") + string
            return Double(res) != nil
        }
        return true
    }
    
    //Empty text when start editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == enteramount{
            enteramount.text = ""
        }
        else if textField == numofpeople{
            numofpeople.text = ""
        }
    }
    
    fileprivate func calculateSumPerPerson() {
        total = checkAmount * tipPercent/100 + checkAmount
        numpeople = Double(numofpeople.text!) ?? 1
        perperson = total/numpeople
        
        
        amountperperson.text = "$" + String(format: "%.2f", perperson)
        totalamount.text = String(format: "%.2f", total)
    }
    
    //made from editing changed outlet of textfield(on right click), tracks changed in tetfield
    @IBAction func amountChanged(_ sender: UITextField) {
        
        checkAmount = Double(sender.text!) ?? 0
        calculateSumPerPerson()
    }
    
    
    
    //When we enter number of people recalculate. If it's nil - it will be 2
    @IBAction func numofpeopletextfieldChanged(_ sender: UITextField) {
        numpeople = Double(sender.text!) ?? 2
        calculateSumPerPerson()
    }
    
    
    
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            tipPercent = 10.0
            calculateSumPerPerson()

        case 1:
            tipPercent = 15.0
            calculateSumPerPerson()

        case 2:
            tipPercent = 20.0
            calculateSumPerPerson()

        case 3:
            tipPercent = 25.0
            calculateSumPerPerson()

        case 4:
            tipPercent = 0.0
            calculateSumPerPerson()

        default:
            tipPercent = 0.0
        }
        
    }
    
    
}

