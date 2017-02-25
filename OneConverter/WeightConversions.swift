//
//  WeightConversions.swift
//  OneConverter
//
//  Created by Administrator on 2017-02-25.
//  Copyright © 2017 Vincent Lam. All rights reserved.
//

import Foundation
enum WeightUnits: Int {
    case kilogram = 0, gram, milligram, pound, ounce, tonne
    
    static func allCases() -> [String] {
        var i = 0
        var list = [String]()
        while let unit = WeightUnits(rawValue: i) {
            list.append(unit.description())
            i = i + 1
        }
        return list
    }
    
    func description() -> String {
        switch self {
        case .kilogram:
            return "kilogram"
        case .gram:
            return "gram"
        case .milligram:
            return "milligram"
        case .pound:
            return "pound"
        case .ounce:
            return "ounce"
        case .tonne:
            return "tonne"
        }
    }
    
    static func fromString(_ string: String) -> WeightUnits? {
        if string == "kilogram" {
            return .kilogram
        } else if string == "gram" {
            return .gram
        } else if string == "milligram" {
            return .milligram
        } else if string == "pound" {
            return .pound
        } else if string == "ounce" {
            return .ounce
        } else if string == "tonne" {
            return .tonne
        } else {
            return nil
        }
    }
    
    func convertTo(unit to: WeightUnits, value val: Double) -> Double {
        var constant = 1.0
        switch self {
        case .kilogram:
            if to == .gram {
                constant = 1000
            } else if to == .milligram {
                constant = 1000000
            } else if to == .pound {
                constant = 2.20462
            } else if to == .ounce {
                constant = 35.274
            } else if to == .tonne {
                constant = 0.001
            }
        case .gram:
            if to == .kilogram {
                constant = 0.001
            } else if to == .milligram {
                constant = 1000
            } else if to == .pound {
                constant = 0.00220462
            } else if to == .ounce {
                constant = 0.035274
            } else if to == .tonne {
                constant = 0.000001
            }
            
        case .milligram:
            if to == .gram {
                constant = 0.001
            } else if to == .kilogram {
                constant = 0.000001
            } else if to == .pound {
                constant = 0.0000022046226
            } else if to == .ounce {
                constant = 0.00003527
            } else if to == .tonne {
                constant = 0.000000001
            }
        
        case .pound:
            if to == .gram {
                constant = 453.592
            } else if to == .kilogram {
                constant = 0.453592
            } else if to == .milligram {
                constant = 453592
            } else if to == .ounce {
                constant = 16
            } else if to == .tonne {
                constant = 0.000453592
            }
        
        case .ounce:
            if to == .gram {
                constant = 28.3495
            } else if to == .kilogram {
                constant = 0.0283495
            } else if to == .pound {
                constant = 0.0625
            } else if to == .milligram {
                constant = 28349.5
            } else if to == .tonne {
                constant = 0.0000283495231
            }
            
        case .tonne:
            if to == .gram {
                constant = 1000000
            } else if to == .kilogram {
                constant = 1000
            } else if to == .pound {
                constant = 2204.62
            } else if to == .milligram {
                constant = 1000000000
            } else if to == .ounce {
                constant = 35274
            }
        }
        
        return constant * val
    }
}

