//
//  Priority.swift
//  CoreDataExample
//
//  Created by Piera Marchesini on 28/09/17.
//  Copyright © 2017 Piera Marchesini. All rights reserved.
//

import UIKit

enum Priority: Int, CustomStringConvertible {
    case high = 0
    case medium
    case low
    
    var description: String {
        switch self {
        case .high:
            return "High"
        case .medium:
            return "Medium"
        case .low:
            return "Low"
        }
    }
}
