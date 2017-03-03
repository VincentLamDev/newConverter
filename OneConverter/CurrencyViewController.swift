//
//  CurrencyViewController.swift
//  OneConverter
//
//  Created by Administrator on 2017-03-02.
//  Copyright © 2017 Vincent Lam. All rights reserved.
//

import Foundation
import UIKit

class CurrencyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{

    var myCurrency:[String] = []
    var myValues:[Double] = []
    var activeCurrency:Double = 0;

    @IBOutlet weak var currencyInputField: UITextField!
    @IBOutlet weak var currencyOutputField: UITextField!
    @IBOutlet weak var currencyInputPicker: UIPickerView!
    @IBOutlet weak var currencyOutputPicker: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return myCurrency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return myCurrency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        activeCurrency = myValues[row]
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        currencyInputPicker.delegate = self
        currencyInputPicker.dataSource = self
        
        currencyOutputPicker.delegate = self
        currencyOutputPicker.dataSource = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VolumeViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        //GETTING DATA
        let url = URL(string: "http://api.fixer.io/latest")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil
            {
                print ("ERROR")
            }
            else
            {
                if let content = data
                {
                    do
                    {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        if let rates = myJson["rates"] as? NSDictionary
                        {
                            let sortedArray = rates.sorted(by:
                                {
                                    (a, b) in (a.key as! String) < (b.key as! String)
                            });
                            
                            for (key, value) in sortedArray
                            {
                                self.myCurrency.append((key as? String)!)
                                self.myValues.append((value as? Double)!)
                            }
                        }
                    }
                    catch
                    {
                        
                    }
                }
            }
            self.currencyInputPicker.reloadAllComponents()
            self.currencyOutputPicker.reloadAllComponents()
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    @IBAction func reset(_ sender: UIButton) {
        currencyInputField.text = ""
    }
    
    
    @IBAction func convertCurrency(_ sender: UIButton) {
        if (currencyInputField.text != "")
        {
            let fromUnitIdx = currencyInputPicker.selectedRow(inComponent: 0)
            let toUnitIdx = currencyOutputPicker.selectedRow(inComponent: 0)
            
            let currencyFrom = myValues[fromUnitIdx]
            let currencyTo = myValues[toUnitIdx]
            
            let fromEURtoInput1 = (Double(currencyInputField.text!)! * currencyFrom)
            let fromInput1toInput2 = (Double(currencyInputField.text!)! * currencyTo)
            var final = Double(currencyInputField.text!)! * (fromInput1toInput2 / fromEURtoInput1)
            
            final = Double(round(1000*final)/1000)
            
            currencyOutputField.text = String(final)
        }
    }

}
