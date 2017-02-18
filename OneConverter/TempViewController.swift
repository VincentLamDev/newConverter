import Foundation
import UIKit

class TempViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{

    
    @IBOutlet weak var tempInputField: UITextField!
    
    @IBOutlet weak var tempOutputField: UITextField!
    
    @IBOutlet weak var tempOutputPicker: UIPickerView!
    @IBOutlet weak var tempInputPicker: UIPickerView!
    let tempList = TempUnits.allCases()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tempInputPicker.delegate = self
        tempInputPicker.dataSource = self
        
        tempOutputPicker.delegate = self
        tempOutputPicker.dataSource = self
        
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
