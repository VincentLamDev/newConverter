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
                constant = 1000
            } else if to == .teaspoon {
                constant = 1000000
            } else if to == .tablespoon {
                constant = 2.20462
            } else if to == .cup {
                constant = 35.274
            } else if to == .fluid_ounce {
                constant = 0.001
            } else if to == .pint {
                constant = 0.001
            } else if to == .quart {
                constant = 0.001
            } else if to == .gallon {
                constant = 0.001
            }
            
        
        case .litre:
            if to == .milliliter {
                constant = 1000
            } else if to == .teaspoon {
                constant = 1000000
            } else if to == .tablespoon {
                constant = 2.20462
            } else if to == .cup {
                constant = 35.274
            } else if to == .fluid_ounce {
                constant = 0.001
            } else if to == .pint {
                constant = 0.001
            } else if to == .quart {
                constant = 0.001
            } else if to == .gallon {
                constant = 0.001
            }
        
            
        
        
            
        
        
        return constant * val
    }
}

