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

    
    
    @IBOutlet weak var currencyFromLabel: UILabel!
    @IBOutlet weak var currencyToLabel: UILabel!
    @IBOutlet weak var currencyInputField: UITextField!
    @IBOutlet weak var currencyOutputField: UITextField!
    @IBOutlet weak var currencyInputPicker: UIPickerView!
    @IBOutlet weak var currencyOutputPicker: UIPickerView!
    
    @IBOutlet weak var currencyConvertButton: UIButton!
    @IBOutlet weak var currencyBackButton: UIButton!
    @IBOutlet weak var currencyClearButton: UIButton!
    
    
    func settngUpInterface(){
        let xPos = self.view.frame.minX
        let yPos = self.view.frame.minY
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        currencyFromLabel.frame.origin = CGPoint(x: xPos + (width * 0.05), y: yPos + (height * 0.05))
        currencyFromLabel.frame.size.width = width * 0.15
        currencyFromLabel.frame.size.height = height * 0.05
        currencyFromLabel.font = UIFont(name: currencyFromLabel.font.fontName, size: CGFloat(100))
        currencyFromLabel.adjustsFontSizeToFitWidth = true
        currencyFromLabel.baselineAdjustment = .alignCenters
        
        
        currencyInputField.frame.size.width = width * 0.70
        currencyInputField.frame.size.height = height * 0.05
        currencyInputField.frame.origin = CGPoint(x: xPos + currencyFromLabel.frame.size.width + width * 0.1, y: yPos + (height * 0.05))
        
        
        currencyInputPicker.frame.size.width = width * 0.5
        currencyInputPicker.frame.size.height = height * 0.30
        currencyInputPicker.frame.origin = CGPoint(x: xPos + width * 0.25, y: yPos + (height * 0.1))
        
        
        currencyToLabel.frame.origin = CGPoint(x: xPos + (width * 0.05), y: yPos + (height * 0.50))
        currencyToLabel.frame.size.width = width * 0.08
        currencyToLabel.frame.size.height = height * 0.05
        currencyToLabel.font = UIFont(name: currencyToLabel.font.fontName, size: CGFloat(100))
        currencyToLabel.adjustsFontSizeToFitWidth = true
        currencyToLabel.baselineAdjustment = .alignCenters
        
        
        currencyOutputField.frame.size.width = width * 0.70
        currencyOutputField.frame.size.height = height * 0.05
        currencyOutputField.frame.origin = CGPoint(x: xPos + currencyFromLabel.frame.size.width + width * 0.10, y: yPos + (height * 0.50))
        
        
        currencyOutputPicker.frame.size.width = width * 0.5
        currencyOutputPicker.frame.size.height = height * 0.30
        currencyOutputPicker.frame.origin = CGPoint(x: xPos + width * 0.25, y: yPos + (height * 0.55))
        
        let btnWidth = CGFloat(width * 0.22)
        let btnHeight = CGFloat(height * 0.05)
        
        currencyConvertButton.frame.size.width = btnWidth
        currencyConvertButton.frame.size.height = btnHeight
        currencyConvertButton.layer.borderColor = UIColor.black.cgColor
        currencyConvertButton.layer.borderWidth = 2
        currencyConvertButton.backgroundColor = UIColor.white
        currencyConvertButton.frame.origin = CGPoint(x: xPos + (width * 0.15), y: yPos + (height * 0.9))
        
        currencyBackButton.frame.size.width = btnWidth
        currencyBackButton.frame.size.height = btnHeight
        currencyBackButton.layer.borderColor = UIColor.black.cgColor
        currencyBackButton.layer.borderWidth = 2
        currencyBackButton.backgroundColor = UIColor.white
        currencyBackButton.frame.origin = CGPoint(x: xPos + (width * 0.39), y: yPos + (height * 0.9))
        
        currencyClearButton.frame.size.width = btnWidth
        currencyClearButton.frame.size.height = btnHeight
        currencyClearButton.layer.borderColor = UIColor.black.cgColor
        currencyClearButton.layer.borderWidth = 2
        currencyClearButton.backgroundColor = UIColor.white
        currencyClearButton.frame.origin = CGPoint(x: xPos + (width * 0.63), y: yPos + (height * 0.9))
        
    }
    
    
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
        
        self.settngUpInterface()
        self.view.backgroundColor = UIColor.orange

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
