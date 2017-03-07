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

    
    @IBOutlet weak var weightFromLabel: UILabel!
    
    @IBOutlet weak var weightToLabel: UILabel!
    
    @IBOutlet weak var weightOutputField: UITextField!
    @IBOutlet weak var weightOutputPicker: UIPickerView!
    @IBOutlet weak var weightinputPicker: UIPickerView!
    @IBOutlet weak var weightInputField: UITextField!
    
    @IBOutlet weak var weightClearButton: UIButton!
    @IBOutlet weak var weightBackButton: UIButton!
    @IBOutlet weak var weightConvertButton: UIButton!
    let weightList = WeightUnits.allCases()

    
    func settngUpInterface(){
        let xPos = self.view.frame.minX
        let yPos = self.view.frame.minY
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        weightFromLabel.frame.origin = CGPoint(x: xPos + (width * 0.05), y: yPos + (height * 0.05))
        weightFromLabel.frame.size.width = width * 0.15
        weightFromLabel.frame.size.height = height * 0.05
        weightFromLabel.font = UIFont(name: weightFromLabel.font.fontName, size: CGFloat(100))
        weightFromLabel.adjustsFontSizeToFitWidth = true
        weightFromLabel.baselineAdjustment = .alignCenters
        
        
        weightInputField.frame.size.width = width * 0.70
        weightInputField.frame.size.height = height * 0.05
        weightInputField.frame.origin = CGPoint(x: xPos + weightFromLabel.frame.size.width + width * 0.1, y: yPos + (height * 0.05))
        
        
        weightinputPicker.frame.size.width = width * 0.5
        weightinputPicker.frame.size.height = height * 0.30
        weightinputPicker.frame.origin = CGPoint(x: xPos + width * 0.25, y: yPos + (height * 0.1))
        
        
        weightToLabel.frame.origin = CGPoint(x: xPos + (width * 0.05), y: yPos + (height * 0.50))
        weightToLabel.frame.size.width = width * 0.08
        weightToLabel.frame.size.height = height * 0.05
        weightToLabel.font = UIFont(name: weightToLabel.font.fontName, size: CGFloat(100))
        weightToLabel.adjustsFontSizeToFitWidth = true
        weightToLabel.baselineAdjustment = .alignCenters
        
        
        weightOutputField.frame.size.width = width * 0.70
        weightOutputField.frame.size.height = height * 0.05
        weightOutputField.frame.origin = CGPoint(x: xPos + weightFromLabel.frame.size.width + width * 0.10, y: yPos + (height * 0.50))
        
        
        weightOutputPicker.frame.size.width = width * 0.5
        weightOutputPicker.frame.size.height = height * 0.30
        weightOutputPicker.frame.origin = CGPoint(x: xPos + width * 0.25, y: yPos + (height * 0.55))
        
        let btnWidth = CGFloat(width * 0.22)
        let btnHeight = CGFloat(height * 0.05)
        
        weightConvertButton.frame.size.width = btnWidth
        weightConvertButton.frame.size.height = btnHeight
        weightConvertButton.layer.borderColor = UIColor.black.cgColor
        weightConvertButton.layer.borderWidth = 2
        weightConvertButton.backgroundColor = UIColor.white
        weightConvertButton.frame.origin = CGPoint(x: xPos + (width * 0.15), y: yPos + (height * 0.9))
        
        weightBackButton.frame.size.width = btnWidth
        weightBackButton.frame.size.height = btnHeight
        weightBackButton.layer.borderColor = UIColor.black.cgColor
        weightBackButton.layer.borderWidth = 2
        weightBackButton.backgroundColor = UIColor.white
        weightBackButton.frame.origin = CGPoint(x: xPos + (width * 0.39), y: yPos + (height * 0.9))
        
        weightClearButton.frame.size.width = btnWidth
        weightClearButton.frame.size.height = btnHeight
        weightClearButton.layer.borderColor = UIColor.black.cgColor
        weightClearButton.layer.borderWidth = 2
        weightClearButton.backgroundColor = UIColor.white
        weightClearButton.frame.origin = CGPoint(x: xPos + (width * 0.63), y: yPos + (height * 0.9))
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
        
        weightinputPicker.delegate = self
        weightinputPicker.dataSource = self
        
        weightOutputPicker.delegate = self
        weightOutputPicker.dataSource = self
        weightOutputPicker.selectRow(1, inComponent: 0, animated: false)
        
        
        self.settngUpInterface()
        
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
