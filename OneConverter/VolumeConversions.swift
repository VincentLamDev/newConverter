//
//  VolumeConversions.swift
//  OneConverter
//
//  Created by Administrator on 2017-02-25.
//  Copyright © 2017 Vincent Lam. All rights reserved.
//

import Foundation
enum VolumeUnits: Int {
    case milliliter = 0, litre, teaspoon, tablespoon, cup, fluid_ounce, pint, quart, gallon
    
    static func allCases() -> [String] {
        var i = 0
        var list = [String]()
        while let unit = VolumeUnits(rawValue: i) {
            list.append(unit.description())
            i = i + 1
        }
        return list
    }
    
    func description() -> String {
        switch self {
        case .milliliter:
            return "milliliter"
        case .litre:
            return "litre"
        case .teaspoon:
            return "teaspoon"
        case .tablespoon:
            return "tablespoon"
        case .cup:
            return "cup"
        case .fluid_ounce:
            return "fluid_ounce"
        case .pint:
            return "pint"
        case .quart:
            return "quart"
        case .gallon:
            return "gallon"
        }
    }
    
    static func fromString(_ string: String) -> VolumeUnits? {
        if string == "milliliter" {
            return .milliliter
        } else if string == "litre" {
            return .litre
        } else if string == "teaspoon" {
            return .teaspoon
        } else if string == "tablespoon" {
            return .tablespoon
        } else if string == "cup" {
            return .cup
        } else if string == "fluid_ounce" {
            return .fluid_ounce
        } else if string == "pint" {
            return .pint
        } else if string == "quart" {
            return .quart
        } else if string == "gallon" {
            return .gallon
        } else {
            return nil
        }
    }
    
    func convertTo(unit to: VolumeUnits, value val: Double) -> Double {
        var constant = 1.0
        switch self {
        case .milliliter:
            if to == .litre {
                constant = 0.001
            } else if to == .teaspoon {
                constant = 0.202884
            } else if to == .tablespoon {
                constant = 0.067628
            } else if to == .cup {
                constant = 0.00422675
            } else if to == .fluid_ounce {
                constant = 0.033814
            } else if to == .pint {
                constant = 0.00211338
            } else if to == .quart {
                constant = 0.00105669
            } else if to == .gallon {
                constant = 0.000264172
            }
            
        
        case .litre:
            if to == .milliliter {
                constant = 1000
            } else if to == .teaspoon {
                constant = 202.884
            } else if to == .tablespoon {
                constant = 67.628
            } else if to == .cup {
                constant = 4.22675
            } else if to == .fluid_ounce {
                constant = 33.814
            } else if to == .pint {
                constant = 2.11338
            } else if to == .quart {
                constant = 1.05669
            } else if to == .gallon {
                constant = 0.264172
            }
        
        case .teaspoon:
            if to == .milliliter {
                constant = 4.92892
            } else if to == .litre {
                constant = 0.00492892
            } else if to == .tablespoon {
                constant = 0.333333
            } else if to == .cup {
                constant = 0.0208333
            } else if to == .fluid_ounce {
                constant = 0.166667
            } else if to == .pint {
                constant = 0.0104167
            } else if to == .quart {
                constant = 0.00520833
            } else if to == .gallon {
                constant = 0.00130208
            }
            
        case .tablespoon:
            if to == .milliliter {
                constant = 14.7868
            } else if to == .litre {
                constant = 0.0147868
            } else if to == .teaspoon {
                constant = 3
            } else if to == .cup {
                constant = 0.0625
            } else if to == .fluid_ounce {
                constant = 0.5
            } else if to == .pint {
                constant = 0.03125
            } else if to == .quart {
                constant = 0.015625
            } else if to == .gallon {
                constant = 0.00390625
            }

        case .cup:
            if to == .milliliter {
                constant = 236.588
            } else if to == .litre {
                constant = 0.236588
            } else if to == .teaspoon {
                constant = 48
            } else if to == .tablespoon {
                constant = 16
            } else if to == .fluid_ounce {
                constant = 8
            } else if to == .pint {
                constant = 0.5
            } else if to == .quart {
                constant = 0.25
            } else if to == .gallon {
                constant = 0.0625
            }
        
        case .fluid_ounce:
            if to == .milliliter {
                constant = 29.5735
            } else if to == .litre {
                constant = 0.0295735
            } else if to == .teaspoon {
                constant = 6
            } else if to == .tablespoon {
                constant = 2
            } else if to == .cup {
                constant = 0.125
            } else if to == .pint {
                constant = 0.0625
            } else if to == .quart {
                constant = 0.03125
            } else if to == .gallon {
                constant = 0.0078125
            }
        
        case .pint:
            if to == .milliliter {
                constant = 473.176
            } else if to == .litre {
                constant = 0.473176
            } else if to == .teaspoon {
                constant = 96
            } else if to == .tablespoon {
                constant = 32
            } else if to == .cup {
                constant = 2
            } else if to == .fluid_ounce {
                constant = 16
            } else if to == .quart {
                constant = 0.5
            } else if to == .gallon {
                constant = 0.125
            }
        
        case .quart:
            if to == .milliliter {
                constant = 946.353
            } else if to == .litre {
                constant = 0.946353
            } else if to == .teaspoon {
                constant = 192
            } else if to == .tablespoon {
                constant = 64
            } else if to == .cup {
                constant = 4
            } else if to == .fluid_ounce {
                constant = 32
            } else if to == .pint {
                constant = 2
            } else if to == .gallon {
                constant = 0.25
            }
            
        case .gallon:
            if to == .milliliter {
                constant = 3785.41
            } else if to == .litre {
                constant = 3.78541
            } else if to == .teaspoon {
                constant = 768
            } else if to == .tablespoon {
                constant = 256
            } else if to == .cup {
                constant = 16
            } else if to == .fluid_ounce {
                constant = 128
            } else if to == .pint {
                constant = 8
            } else if to == .quart {
                constant = 4
            }
        }
        return constant * val
    }
}
