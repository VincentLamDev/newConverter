import Foundation
import UIKit

class TempViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{

    
    @IBOutlet weak var tempFromLabel: UILabel!
    @IBOutlet weak var tempToLabel: UILabel!
    @IBOutlet weak var tempInputField: UITextField!
    @IBOutlet weak var tempOutputField: UITextField!
    @IBOutlet weak var tempOutputPicker: UIPickerView!
    @IBOutlet weak var tempInputPicker: UIPickerView!
    
    @IBOutlet weak var tempConvertButton: UIButton!
    @IBOutlet weak var tempBackButton: UIButton!
    @IBOutlet weak var tempClearButton: UIButton!
    
    
    let tempList = TempUnits.allCases()
    
    
    func settngUpInterface(){
        let xPos = self.view.frame.minX
        let yPos = self.view.frame.minY
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        tempFromLabel.frame.origin = CGPoint(x: xPos + (width * 0.05), y: yPos + (height * 0.05))
        tempFromLabel.frame.size.width = width * 0.15
        tempFromLabel.frame.size.height = height * 0.05
        tempFromLabel.font = UIFont(name: tempFromLabel.font.fontName, size: CGFloat(100))
        tempFromLabel.adjustsFontSizeToFitWidth = true
        tempFromLabel.baselineAdjustment = .alignCenters
        
        
        tempInputField.frame.size.width = width * 0.70
        tempInputField.frame.size.height = height * 0.05
        tempInputField.frame.origin = CGPoint(x: xPos + tempFromLabel.frame.size.width + width * 0.1, y: yPos + (height * 0.05))
        
        
        tempInputPicker.frame.size.width = width * 0.5
        tempInputPicker.frame.size.height = height * 0.30
        tempInputPicker.frame.origin = CGPoint(x: xPos + width * 0.25, y: yPos + (height * 0.1))
        
        
        tempToLabel.frame.origin = CGPoint(x: xPos + (width * 0.05), y: yPos + (height * 0.50))
        tempToLabel.frame.size.width = width * 0.08
        tempToLabel.frame.size.height = height * 0.05
        tempToLabel.font = UIFont(name: tempToLabel.font.fontName, size: CGFloat(100))
        tempToLabel.adjustsFontSizeToFitWidth = true
        tempToLabel.baselineAdjustment = .alignCenters
        
        
        tempOutputField.frame.size.width = width * 0.70
        tempOutputField.frame.size.height = height * 0.05
        tempOutputField.frame.origin = CGPoint(x: xPos + tempFromLabel.frame.size.width + width * 0.10, y: yPos + (height * 0.50))
        
        
        tempOutputPicker.frame.size.width = width * 0.5
        tempOutputPicker.frame.size.height = height * 0.30
        tempOutputPicker.frame.origin = CGPoint(x: xPos + width * 0.25, y: yPos + (height * 0.55))
        
        let btnWidth = CGFloat(width * 0.22)
        let btnHeight = CGFloat(height * 0.05)
        
        tempConvertButton.frame.size.width = btnWidth
        tempConvertButton.frame.size.height = btnHeight
        tempConvertButton.layer.borderColor = UIColor.black.cgColor
        tempConvertButton.layer.borderWidth = 2
        tempConvertButton.backgroundColor = UIColor.white
        tempConvertButton.frame.origin = CGPoint(x: xPos + (width * 0.15), y: yPos + (height * 0.9))
        
        tempBackButton.frame.size.width = btnWidth
        tempBackButton.frame.size.height = btnHeight
        tempBackButton.layer.borderColor = UIColor.black.cgColor
        tempBackButton.layer.borderWidth = 2
        tempBackButton.backgroundColor = UIColor.white
        tempBackButton.frame.origin = CGPoint(x: xPos + (width * 0.39), y: yPos + (height * 0.9))
        
        tempClearButton.frame.size.width = btnWidth
        tempClearButton.frame.size.height = btnHeight
        tempClearButton.layer.borderColor = UIColor.black.cgColor
        tempClearButton.layer.borderWidth = 2
        tempClearButton.backgroundColor = UIColor.white
        tempClearButton.frame.origin = CGPoint(x: xPos + (width * 0.63), y: yPos + (height * 0.9))
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red

        tempInputPicker.delegate = self
        tempInputPicker.dataSource = self
        
        tempOutputPicker.delegate = self
        tempOutputPicker.dataSource = self
        tempOutputPicker.selectRow(1, inComponent: 0, animated: false)

        self.settngUpInterface()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TempViewController.dismissKeyboard))
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
    
    
    @IBOutlet weak var tempConvert: UIButton!
    
    
    @IBAction func tempConvertButton(_ sender: UIButton) {
                let fromUnitIdx = tempInputPicker.selectedRow(inComponent: 0)
                let toUnitIdx = tempOutputPicker.selectedRow(inComponent: 0)
        
                let fromUnit = TempUnits.fromString(tempList[fromUnitIdx])!
                let toUnit = TempUnits.fromString(tempList[toUnitIdx])!
        
                if let inputText = tempInputField.text {
                    if !inputText.isEmpty {
                        let inputNum = Double(inputText)!
                        let outputNum = fromUnit.convertTo(unit: toUnit, value: inputNum)
                        tempOutputField.text = String(outputNum)
                    }
                }
    
    }
    
}
