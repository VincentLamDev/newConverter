//
//  DistanceConversions.swift
//  OneConverter
//
//  Created by Vincent Lam on 2017-02-17.
//  Copyright © 2017 Vincent Lam. All rights reserved.
//

import Foundation

enum Unit: Int {
    case inch = 0, centimeter, foot, meter, mile, kilometer
    
    static func allCases() -> [String] {
        var i = 0
        var list = [String]()
        while let unit = Unit(rawValue: i) {
            list.append(unit.description())
            i = i + 1
        }
        return list
    }
    
    func description() -> String {
        switch self {
        case .inch:
            return "inch"
        case .centimeter:
            return "centimeter"
        case .foot:
            return "foot"
        case .meter:
            return "meter"
        case .mile:
            return "mile"
        case .kilometer:
            return "kilometer"
        }
    }
    
    static func fromString(_ string: String) -> Unit? {
        if string == "inch" {
            return .inch
        } else if string == "centimeter" {
            return .centimeter
        } else if string == "foot" {
            return .foot
        } else if string == "meter" {
            return .meter
        } else if string == "mile" {
            return .mile
        } else if string == "kilometer" {
            return .kilometer
        } else {
            return nil
        }
    }
    
    func convertTo(unit to: Unit, value val: Double) -> Double {
        var constant = 1.0
        switch self {
        case .inch:
            if to == .centimeter {
                constant = 2.54
            } else if to == .foot {
                constant = 0.08333333
            } else if to == .meter {
                constant = 0.0254
            } else if to == .mile {
                constant = 1.5783e-5
            } else if to == .kilometer{
                constant = 0.00002540000
            }
            
        case .centimeter:
            if to == .inch {
                constant = 0.0393701
            } else if to == .foot {
                constant = 0.0328084
            } else if to == .meter {
                constant = 0.01
            } else if to == .mile {
                constant = 6.2137e-6
            } else if to == .kilometer{
                constant = 0.00001000000
            }
            
        case .foot:
            if to == .inch {
                constant = 12;
            } else if to == .centimeter {
                constant = 30.48
            } else if to == .meter {
                constant = 0.3048
            } else if to == .mile {
                constant = 0.000189394
            } else if to == .kilometer{
                constant = 0.0003048
            }
            
        case .meter:
            if to == .inch {
                constant = 39.3701
            } else if to == .centimeter {
                constant = 100
            } else if to == .foot {
                constant = 3.28084
            } else if to == .mile {
                constant = 0.000621371
            } else if to == .kilometer{
                constant = 0.001
            }
            
        case .mile:
            if to == .inch {
                constant = 63360
            } else if to == .centimeter {
                constant = 160934
            } else if to == .foot {
                constant = 5280
            } else if to == .meter {
                constant = 1609.34
            } else if to == .kilometer{
                constant = 1.60934
            }
        case .kilometer:
            if to == .inch {
                constant = 39370.1
            } else if to == .centimeter {
                constant = 100000
            } else if to == .foot {
                constant = 3280.84
            } else if to == .meter {
                constant = 1000
            } else if to == .mile {
                constant = 0.621371
            }
        }
        
        return constant * val
    }
}

