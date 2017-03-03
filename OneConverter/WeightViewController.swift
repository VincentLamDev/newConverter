//
//  WeightViewController.swift
//  OneConverter
//
//  Created by Administrator on 2017-02-25.
//  Copyright © 2017 Vincent Lam. All rights reserved.
//

import Foundation
import UIKit

class WeightViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{

    @IBOutlet weak var weightOutputField: UITextField!
    @IBOutlet weak var weightOutputPicker: UIPickerView!
    @IBOutlet weak var weightinputPicker: UIPickerView!
    @IBOutlet weak var weightInputField: UITextField!
    
    let weightList = WeightUnits.allCases()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weightinputPicker.delegate = self
        weightinputPicker.dataSource = self
        
        weightOutputPicker.delegate = self
        weightOutputPicker.dataSource = self
        weightOutputPicker.selectRow(1, inComponent: 0, animated: false)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(WeightViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weightList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return weightList[row]
    }
    
    @IBAction func resetInput(_ sender: UIButton) {
        weightInputField.text = ""
    }
    
    
    @IBAction func convertWeight(_ sender: UIButton) {
        let fromUnitIdx = weightinputPicker.selectedRow(inComponent: 0)
        let toUnitIdx = weightOutputPicker.selectedRow(inComponent: 0)
        
        let fromUnit = WeightUnits.fromString(weightList[fromUnitIdx])!
        let toUnit = WeightUnits.fromString(weightList[toUnitIdx])!
        
        if let inputText = weightInputField.text {
            if !inputText.isEmpty {
                let inputNum = Double(inputText)!
                let outputNum = fromUnit.convertTo(unit: toUnit, value: inputNum)
                weightOutputField.text = String(outputNum)
            }
        }
    }

}
