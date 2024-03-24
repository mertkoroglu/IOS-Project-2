//
//  CurrencyVC.swift
//  MertKoroglu_HW2
//
//  Created by CTIS Student on 23.03.2024.
//  Copyright © 2024 koroglu. All rights reserved.
//

import UIKit

class CurrencyVC: UIViewController {

    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mSegmentedControl: UISegmentedControl!
    @IBOutlet weak var mCurrencyField: UILabel!
    
    @IBOutlet weak var mOther_TextField: UITextField!
    @IBOutlet weak var mTL_TextField: UITextField!
    
    var EurRate = 36.0, USDRate = 33.0, GBPRate = 38.5
    var TL_TextFieldVal = 0.0, Other_TextFieldVal = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mCurrencyField.text = "USD ($):"
        mImageView.image = UIImage(named: "tl_usd")
        mImageView.isUserInteractionEnabled = true
        mTL_TextField.placeholder = "Enter TL"
        mOther_TextField.placeholder = "Enter USD"
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func OnTap(_ sender: UITapGestureRecognizer) {
        switch mSegmentedControl.selectedSegmentIndex {  // switch sender.selectedSegmentIndex
        case 0:
            mSegmentedControl.selectedSegmentIndex = 1
            mCurrencyField.text = "EUR (€):"
            mImageView.image = UIImage(named: "tl_euro")
            mOther_TextField.placeholder = "Enter EUR"
        case 1:
            mSegmentedControl.selectedSegmentIndex = 2
            mCurrencyField.text = "GBP (£):"
            mImageView.image = UIImage(named: "tl_gbp")
            mOther_TextField.placeholder = "Enter GBP"
        case 2:
            mSegmentedControl.selectedSegmentIndex = 0
            mCurrencyField.text = "USD ($):"
            mImageView.image = UIImage(named: "tl_usd")
            mOther_TextField.placeholder = "Enter USD"
        default:
            break
        }
        mTL_TextField.text = ""
        mOther_TextField.text = ""
    }
    
    @IBAction func TlEditingBegin(_ sender: UITextField) {
        mTL_TextField.text = ""
        mOther_TextField.text = ""
        mTL_TextField.becomeFirstResponder()
    }
    
    @IBAction func OtherEditingBegin(_ sender: UITextField) {
        mTL_TextField.text = ""
        mOther_TextField.text = ""
        mOther_TextField.becomeFirstResponder()
    }
    
    @IBAction func OtherEditingChanged(_ sender: UITextField) {
        Other_TextFieldVal = Double(mOther_TextField.text!) ?? 0.0
        
        switch mSegmentedControl.selectedSegmentIndex {  // switch sender.selectedSegmentIndex
        case 0:
            mTL_TextField.text = String(format: "%.2f", Other_TextFieldVal * USDRate)
        case 1:
            mTL_TextField.text = String(format: "%.2f", Other_TextFieldVal * EurRate)
        case 2:
            mTL_TextField.text = String(format: "%.2f", Other_TextFieldVal * GBPRate)
        default:
            break
        }
    }
    
    @IBAction func TLEditingChanged(_ sender: UITextField) {
        TL_TextFieldVal = Double(mTL_TextField.text!) ?? 0.0
        
        switch mSegmentedControl.selectedSegmentIndex {  // switch sender.selectedSegmentIndex
        case 0:
            mOther_TextField.text = String(format: "%.2f", TL_TextFieldVal / USDRate)
        case 1:
            mOther_TextField.text = String(format: "%.2f", TL_TextFieldVal / EurRate)
        case 2:
            mOther_TextField.text = String(format: "%.2f", TL_TextFieldVal / GBPRate)
        default:
            break
        }
    }
    
    @IBAction func onSegmentChange(_ sender: UISegmentedControl) {
        switch mSegmentedControl.selectedSegmentIndex {  // switch sender.selectedSegmentIndex
        case 0:
            mCurrencyField.text = "USD ($):"
            mImageView.image = UIImage(named: "tl_usd")
            mOther_TextField.placeholder = "Enter USD"
        case 1:
            mCurrencyField.text = "EUR (€):"
            mImageView.image = UIImage(named: "tl_euro")
            mOther_TextField.placeholder = "Enter EUR"
        case 2:
            mCurrencyField.text = "GBP (£):"
            mImageView.image = UIImage(named: "tl_gbp")
            mOther_TextField.placeholder = "Enter GBP"
        default:
            break
        }
        mTL_TextField.text = ""
        mOther_TextField.text = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
