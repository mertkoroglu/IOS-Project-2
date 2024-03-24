//
//  CalculationVC.swift
//  MertKoroglu_HW2
//
//  Created by CTIS Student on 23.03.2024.
//  Copyright © 2024 koroglu. All rights reserved.
//

import UIKit

class CalculationVC: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, InputControllerDelegate{
    
  
    func inputControllerDidFinish(controller: InputVC, text: (Double, Double, String)) {
        print(text.0)
        print(text.1)
        print(text.2)
        
        controller.dismiss(animated: true)
        
        let mAlert = UIAlertController(title: "Result", message: "\(text.2) Surface Area = \(text.0) and Volume = \(text.1)", preferredStyle: .alert)
        // Event Handler for the button
        mAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        // Displaying the Alert
        self.present(mAlert, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mPickerView: UIPickerView!
    @IBOutlet weak var mButton: UIButton!
    let shapes = ["Sphere", "Cone", "Cylinder"]
    var shapeName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mImageView.image = UIImage(named: "sphere")
        shapeName = "Sphere"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onButtonClick(_ sender: UIButton) {
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return shapes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return shapes[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      switch row {
             case 0:
                 mImageView.image = UIImage(named: "sphere")
                 shapeName = "Sphere"
             case 1:
                 mImageView.image = UIImage(named: "cone")
                 shapeName = "Cone"
             case 2:
                 mImageView.image = UIImage(named: "cylinder")
                 shapeName = "Cylinder"
             default:
                 break
             }
             
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let navigationController = segue.destination as? UINavigationController,
           let desitnationVC = navigationController.topViewController as? InputVC{
            desitnationVC.mText = shapeName
            desitnationVC.delegate = self
        }
        
    }

    @IBAction func unwindSegueCalculation(_ sender: UIStoryboardSegue){
        print("unwind")
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
