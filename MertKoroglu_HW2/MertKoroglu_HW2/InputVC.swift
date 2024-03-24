//
//  InputVC.swift
//  MertKoroglu_HW2
//
//  Created by CTIS Student on 23.03.2024.
//  Copyright © 2024 koroglu. All rights reserved.
//

import UIKit

protocol InputControllerDelegate {
    func inputControllerDidFinish(controller: InputVC, text: (Double, Double, String))
}

class InputVC: UIViewController {

    var mText: String? = nil
    var type = ""
    var area = 0.0
    var volume = 0.0
    var radius = 0.0
    var height = 0.0
    var output = ""
    
    var delegate: InputControllerDelegate?
    
    @IBOutlet weak var NavItem: UINavigationItem!
    
    @IBOutlet weak var mHeightLabel: UILabel!
    @IBOutlet weak var mRadiusTextField: UITextField!
    @IBOutlet weak var mHeightTextField: UITextField!
    
    @IBOutlet weak var mView: UIView!
    
    @IBAction func OnDoneClicked(_ sender: UIButton) {
        if(mText != "Sphere"){
            if(mRadiusTextField.text == "" || mHeightTextField.text == ""){
                let mAlert = UIAlertController(title: "Error", message: "Radius or Height Cannot be Empty", preferredStyle: .alert)
                // Event Handler for the button
                mAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                // Displaying the Alert
                self.present(mAlert, animated: true, completion: nil)
            }else{
                height = Double(mHeightTextField.text!) ?? 0.0
                radius = Double(mRadiusTextField.text!) ?? 0.0
                
                if(mText == "Cone"){
                    area = Double.pi * radius * (radius + sqrt(radius * radius + height * height))
                    volume = 1 / 3 * Double.pi * (radius * radius) * height
                }else{
                    area = 2 * Double.pi * radius * (radius + height)
                    volume = Double.pi * (radius * radius) * height
                }
                
                area = round(area * 100) / 100.0
                volume = round(volume * 100) / 100.0
                
                // output = "Surface Area = \(area) and Volume = \(volume) "
                // print(output)
                
                if let tempDelegate = delegate {
                    tempDelegate.inputControllerDidFinish(controller: self, text: (area, volume, type))
                }
            }
        }else{
            if(mRadiusTextField.text == ""){
                let mAlert = UIAlertController(title: "Error", message: "Radius Cannot be Empty", preferredStyle: .alert)
                // Event Handler for the button
                mAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                // Displaying the Alert
                self.present(mAlert, animated: true, completion: nil)
            }else{
                radius = Double(mRadiusTextField.text!) ?? 0.0
                
                area = 4 * Double.pi * (radius * radius)
                volume = 4 / 3 * Double.pi * (radius * radius * radius)
                
                area = round(area * 100) / 100.0
                volume = round(volume * 100) / 100.0
                //output = "Surface Area = \(area) and Volume = \(volume) "
                //print(output)
                
                if let tempDelegate = delegate {
                    tempDelegate.inputControllerDidFinish(controller: self, text: (area, volume, type))
                }
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mView.layer.cornerRadius = 5
        mView.layer.borderWidth = 1
        mView.layer.shadowOpacity = 125
        mView.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        mRadiusTextField.placeholder = "Enter value for radius"
        mHeightTextField.placeholder = "Enter value for height"
        
    
       
        if let temp = mText {
            NavItem.title = temp
            type = temp
            if(temp == "Sphere"){
                mHeightLabel.isHidden = true
                mHeightTextField.isHidden = true
            }else{
                mHeightLabel.isHidden = false
                mHeightTextField.isHidden = false
            }
        }
        // Do any additional setup after loading the view.
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
