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


    @IBOutlet weak var volumeToLabel: UILabel!
    @IBOutlet weak var volumeFromLabel: UILabel!
    @IBOutlet weak var volumeInputField: UITextField!
    @IBOutlet weak var volumeOutputField: UITextField!
    @IBOutlet weak var volumeInputPicker: UIPickerView!
    @IBOutlet weak var volumeOutputPicker: UIPickerView!
    
    @IBOutlet weak var volumeConvertButton: UIButton!
    @IBOutlet weak var volumeClearButton: UIButton!
    @IBOutlet weak var volumeBackButton: UIButton!
    
    let volumeList = VolumeUnits.allCases()

    
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
        
        
        volumeInputField.frame.size.width = width * 0.70
        volumeInputField.frame.size.height = height * 0.05
        volumeInputField.frame.origin = CGPoint(x: xPos + volumeFromLabel.frame.size.width + width * 0.1, y: yPos + (height * 0.05))
        
        
        volumeInputPicker.frame.size.width = width * 0.5
        volumeInputPicker.frame.size.height = height * 0.30
        volumeInputPicker.frame.origin = CGPoint(x: xPos + width * 0.25, y: yPos + (height * 0.1))
        
        
        volumeToLabel.frame.origin = CGPoint(x: xPos + (width * 0.05), y: yPos + (height * 0.50))
        volumeToLabel.frame.size.width = width * 0.08
        volumeToLabel.frame.size.height = height * 0.05
        volumeToLabel.font = UIFont(name: volumeToLabel.font.fontName, size: CGFloat(100))
        volumeToLabel.adjustsFontSizeToFitWidth = true
        volumeToLabel.baselineAdjustment = .alignCenters
        
        
        volumeOutputField.frame.size.width = width * 0.70
        volumeOutputField.frame.size.height = height * 0.05
        volumeOutputField.frame.origin = CGPoint(x: xPos + volumeFromLabel.frame.size.width + width * 0.10, y: yPos + (height * 0.50))
        
        
        volumeOutputPicker.frame.size.width = width * 0.5
        volumeOutputPicker.frame.size.height = height * 0.30
        volumeOutputPicker.frame.origin = CGPoint(x: xPos + width * 0.25, y: yPos + (height * 0.55))
        
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
        self.view.backgroundColor = UIColor.blue

        volumeInputPicker.delegate = self
        volumeInputPicker.dataSource = self
        
        volumeOutputPicker.delegate = self
        volumeOutputPicker.dataSource = self
        volumeOutputPicker.selectRow(1, inComponent: 0, animated: false)

        self.settngUpInterface()
        
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
        return volumeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return volumeList[row]
    }
    
    @IBAction func convertVolume(_ sender: UIButton) {
        let fromUnitIdx = volumeInputPicker.selectedRow(inComponent: 0)
        let toUnitIdx = volumeOutputPicker.selectedRow(inComponent: 0)
        
        let fromUnit = VolumeUnits.fromString(volumeList[fromUnitIdx])!
        let toUnit = VolumeUnits.fromString(volumeList[toUnitIdx])!
        
        if let inputText = volumeInputField.text {
            if !inputText.isEmpty {
                let inputNum = Double(inputText)!
                let outputNum = fromUnit.convertTo(unit: toUnit, value: inputNum)
                volumeOutputField.text = String(outputNum)
            }
        }
    }
    
    
    @IBAction func resetField(_ sender: UIButton) {
        volumeInputField.text = ""
    }
    
    

}
