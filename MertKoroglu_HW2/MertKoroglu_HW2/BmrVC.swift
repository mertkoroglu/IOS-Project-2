//
//  BmrVC.swift
//  MertKoroglu_HW2
//
//  Created by CTIS Student on 23.03.2024.
//  Copyright © 2024 koroglu. All rights reserved.
//

import UIKit

class BmrVC: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var mHeightTextField: UITextField!
    @IBOutlet weak var mWeightTextField: UITextField!
    @IBOutlet weak var mGenderButton: UISwitch!
    @IBOutlet weak var mGenderText: UILabel!
    @IBOutlet weak var mAgeSlider: UISlider!
    @IBOutlet weak var mActivityPickerView: UIPickerView!
    @IBOutlet weak var mAgeLabel: UILabel!
    
    @IBOutlet weak var mView1: UIView!
    @IBOutlet weak var mView2: UIView!
    
    var ActivityArray: NSArray = []
    var gender = "Male"
    var Bmr = 0.0
    var age = 10
    var activityLevel = "Not active"
    var height = 0.0
    var weight = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mView1.layer.cornerRadius = 5
        mView1.layer.borderWidth = 1
        mView1.layer.shadowOpacity = 125
        mView1.layer.shadowOffset = CGSize(width: 5, height: 5)

        mView2.layer.cornerRadius = 5
        mView2.layer.borderWidth = 1
        mView2.layer.shadowOpacity = 125
        mView2.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        
        if let path = Bundle.main.path(forResource: "types", ofType: "plist") {
            if let dictArray = NSArray(contentsOfFile: path) {
                print(dictArray)
                ActivityArray  = dictArray
                mActivityPickerView.reloadAllComponents()
                
            }
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ActivityArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ActivityArray[row] as? String
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activityLevel = ActivityArray[row] as? String ?? "Not active"
        dismissKeyboard()
    }
    
    @IBAction func onSliderValueChange(_ sender: UISlider) {
        age = Int(round(sender.value))
        mAgeLabel.text = "Age (\(age))"
        dismissKeyboard()
    }
    
    @IBAction func onGenderButtonChange(_ sender: UISwitch) {
        if(sender.isOn){
            gender = "Male"
        }else{
            gender = "Female"
        }
        
        mGenderText.text = "Gender (\(gender))"
        dismissKeyboard()
    }
    
    @IBAction func onCallculateButtonClicked(_ sender: UIButton) {
        if(mHeightTextField.text == "" || mWeightTextField.text == ""){
            Bmr = 0.0
        }else{
            weight = Double(mWeightTextField.text!) ?? 0.0
            height = Double(mHeightTextField.text!) ?? 0.0
            
            if(gender == "Male"){
                Bmr = (10.0 * weight) + (6.25 * height) - (5.0 * Double(age)) + 5.0
                
            }else{
                Bmr = (10.0 * weight) + (6.25 * height) - (5.0 * Double(age)) - 161.0
                
            }
            
            switch(activityLevel){
            case "Not active":
                break;
            case "Lightly active":
                Bmr = Bmr * 1.375
                break;
            case "Moderately active":
                Bmr = Bmr * 1.55
                break;
            case "Very active":
                Bmr = Bmr * 1.725
                break;
            case "Extremely active":
                Bmr = Bmr * 1.9
                break;
            default:
                break;
            }
            
            Bmr =  round(Bmr * 100) / 100.0
        }
        let mAlert = UIAlertController(title: "BMR Result", message: "BMR(\(gender), \(age) years) = \(Bmr)", preferredStyle: .alert)
        // Event Handler for the button
        mAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        // Displaying the Alert
        self.present(mAlert, animated: true, completion: nil)
        dismissKeyboard()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           view.endEditing(true)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
       
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
