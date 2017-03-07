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

    //Labels
    @IBOutlet weak var volumeToLabel: UILabel!
    @IBOutlet weak var volumeFromLabel: UILabel!
    
    //Input fields
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var outputField: UITextField!
    
    //Picker views
    @IBOutlet weak var inputPicker: UIPickerView!
    @IBOutlet weak var outputPicker: UIPickerView!
    
    //Buttons
    @IBOutlet weak var volumeConvertButton: UIButton!
    @IBOutlet weak var volumeBackButton: UIButton!
    @IBOutlet weak var volumeClearButton: UIButton!
    
    let list = Unit.allCases()
    
    
    func settngUpInterface(){
        let xPos = self.view.frame.minX
        let yPos = self.view.frame.minY
        let width = self.view.frame.width
        let height = self.view.frame.height
            
        volumeFromLabel.frame.origin = CGPoint(x: xPos + (width * 0.05), y: yPos + (height * 0.05))
        volumeFromLabel.frame.size.width = width * 0.15
        volumeFromLabel.frame.size.height = height * 0.05
        volumeFromLabel.font = UIFont(name: volumeFromLabel.font.fontName, size: CGFloat(100))
        volumeFromLabel.adjustsFontSizeToFitWidth = true
        volumeFromLabel.baselineAdjustment = .alignCenters
        
        
        inputField.frame.size.width = width * 0.70
        inputField.frame.size.height = height * 0.05
        inputField.frame.origin = CGPoint(x: xPos + volumeFromLabel.frame.size.width + width * 0.1, y: yPos + (height * 0.05))
        
        
        inputPicker.frame.size.width = width * 0.5
        inputPicker.frame.size.height = height * 0.30
        inputPicker.frame.origin = CGPoint(x: xPos + width * 0.25, y: yPos + (height * 0.1))
        
        
        volumeToLabel.frame.origin = CGPoint(x: xPos + (width * 0.05), y: yPos + (height * 0.50))
        volumeToLabel.frame.size.width = width * 0.08
        volumeToLabel.frame.size.height = height * 0.05
        volumeToLabel.font = UIFont(name: volumeToLabel.font.fontName, size: CGFloat(100))
        volumeToLabel.adjustsFontSizeToFitWidth = true
        volumeToLabel.baselineAdjustment = .alignCenters
        
        
        outputField.frame.size.width = width * 0.70
        outputField.frame.size.height = height * 0.05
        outputField.frame.origin = CGPoint(x: xPos + volumeFromLabel.frame.size.width + width * 0.10, y: yPos + (height * 0.50))

        
        outputPicker.frame.size.width = width * 0.5
        outputPicker.frame.size.height = height * 0.30
        outputPicker.frame.origin = CGPoint(x: xPos + width * 0.25, y: yPos + (height * 0.55))
        
        let btnWidth = CGFloat(width * 0.22)
        let btnHeight = CGFloat(height * 0.05)
        
        volumeConvertButton.frame.size.width = btnWidth
        volumeConvertButton.frame.size.height = btnHeight
        volumeConvertButton.layer.borderColor = UIColor.black.cgColor
        volumeConvertButton.layer.borderWidth = 2
        volumeConvertButton.backgroundColor = UIColor.white
        volumeConvertButton.frame.origin = CGPoint(x: xPos + (width * 0.15), y: yPos + (height * 0.9))
        
        volumeBackButton.frame.size.width = btnWidth
        volumeBackButton.frame.size.height = btnHeight
        volumeBackButton.layer.borderColor = UIColor.black.cgColor
        volumeBackButton.layer.borderWidth = 2
        volumeBackButton.backgroundColor = UIColor.white
        volumeBackButton.frame.origin = CGPoint(x: xPos + (width * 0.39), y: yPos + (height * 0.9))

        volumeClearButton.frame.size.width = btnWidth
        volumeClearButton.frame.size.height = btnHeight
        volumeClearButton.layer.borderColor = UIColor.black.cgColor
        volumeClearButton.layer.borderWidth = 2
        volumeClearButton.backgroundColor = UIColor.white
        volumeClearButton.frame.origin = CGPoint(x: xPos + (width * 0.63), y: yPos + (height * 0.9))

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.purple
        
        inputPicker.delegate = self
        inputPicker.dataSource = self
        
        outputPicker.delegate = self
        outputPicker.dataSource = self
        outputPicker.selectRow(1, inComponent: 0, animated: false)

        self.settngUpInterface()
        
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
