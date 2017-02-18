//
//  DistanceViewController.swift
//  OneConverter
//
//  Created by Vincent Lam on 2017-02-17.
//  Copyright © 2017 Vincent Lam. All rights reserved.
//

import Foundation

import UIKit

class DistanceViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{

    
    @IBOutlet weak var inputField: UITextField!

    @IBOutlet weak var outputField: UITextField!
    @IBOutlet weak var inputPicker: UIPickerView!
    @IBOutlet weak var outputPicker: UIPickerView!
    
    let list = Unit.allCases()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputPicker.delegate = self
        inputPicker.dataSource = self
        
        outputPicker.delegate = self
        outputPicker.dataSource = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DistanceViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    
    @IBAction func clearButton(_ sender: UIButton) {
        inputField.text = ""
    }
    
    
    @IBAction func convertTo(_ sender: UIButton) {
        let fromUnitIdx = inputPicker.selectedRow(inComponent: 0)
        let toUnitIdx = outputPicker.selectedRow(inComponent: 0)
        
        let fromUnit = Unit.fromString(list[fromUnitIdx])!
        let toUnit = Unit.fromString(list[toUnitIdx])!
        
        if let inputText = inputField.text {
            if !inputText.isEmpty {
                let inputNum = Double(inputText)!
                let outputNum = fromUnit.convertTo(unit: toUnit, value: inputNum)
                outputField.text = String(outputNum)
            }
        }
    }

}
