//
//  VolumeViewController.swift
//  OneConverter
//
//  Created by Administrator on 2017-02-25.
//  Copyright © 2017 Vincent Lam. All rights reserved.
//

import Foundation
import UIKit

class VolumeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{


    @IBOutlet weak var volumeInputField: UITextField!
    @IBOutlet weak var volumeOutputField: UITextField!
    @IBOutlet weak var volumeInputPicker: UIPickerView!
    @IBOutlet weak var volumeOutputPicker: UIPickerView!
    let tempList = TempUnits.allCases()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        volumeInputPicker.delegate = self
        volumeInputPicker.dataSource = self
        
        volumeOutputPicker.delegate = self
        volumeOutputPicker.dataSource = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VolumeViewController.dismissKeyboard))
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
        return tempList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tempList[row]
    }
    
    @IBAction func convertVolume(_ sender: UIButton) {
        let fromUnitIdx = volumeInputPicker.selectedRow(inComponent: 0)
        let toUnitIdx = volumeOutputPicker.selectedRow(inComponent: 0)
        
        let fromUnit = TempUnits.fromString(tempList[fromUnitIdx])!
        let toUnit = TempUnits.fromString(tempList[toUnitIdx])!
        
        if let inputText = volumeInputField.text {
            if !inputText.isEmpty {
                let inputNum = Double(inputText)!
                let outputNum = fromUnit.convertTo(unit: toUnit, value: inputNum)
                volumeOutputField.text = String(outputNum)
            }
        }
    }
    
    
    @IBAction func resetField(_ sender: UIButton) {
    }
    
    

}
