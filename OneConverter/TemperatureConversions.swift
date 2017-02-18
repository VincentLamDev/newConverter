//
//  TemperatureConversions.swift
//  OneConverter
//
//  Created by Vincent Lam on 2017-02-17.
//  Copyright © 2017 Vincent Lam. All rights reserved.
//

import Foundation

enum TempUnits: Int {
    case fahrenheit = 0, celsius, kelvin
    
    static func allCases() -> [String] {
        var i = 0
        var list = [String]()
        while let unit = TempUnits(rawValue: i) {
            list.append(unit.description())
            i = i + 1
        }
        return list
    }
    
    func description() -> String {
        switch self {
        case .fahrenheit:
            return "fahrenheit"
        case .celsius:
            return "celsius"
        case .kelvin:
            return "kelvin"
        }
    }
    
    static func fromString(_ string: String) -> TempUnits? {
        if string == "fahrenheit" {
            return .fahrenheit
        } else if string == "celsius" {
            return .celsius
        } else if string == "kelvin" {
            return .kelvin
        } else {
            return nil
        }
    }
    
    func convertTo(unit to: TempUnits, value val: Double) -> Double {
        var constant = 1.0
        switch self {
        case .fahrenheit:
            if to == .celsius {
                constant = 2.54
            } else if to == .kelvin {
                constant = 0.08333333
            }
            
        case .celsius:
            if to == .fahrenheit {
                constant = 0.0393701
            } else if to == .kelvin {
                constant = 0.0328084
            }
            
        case .kelvin:
            if to == .celsius {
                constant = 12;
            } else if to == .fahrenheit {
                constant = 30.48
            }
            
        }
        
        return constant * val
    }
}

