//
//  SortingHat.swift
// 
//
//  Created by Ethan Blanche on 12/3/24.
//

import Foundation
import UIKit
import SwiftUICore

struct SortingHat {
    
    func sortingHatDecision() -> String {
        
        let decision = ["Gryffindor", "Slytherin", "Hufflepuff", "Ravenclaw"]
        
        return decision.randomElement() ?? ""
    }
    
    func decisionFontColor(decision: String) -> Color {
        if decision == "Gryffindor" {
            return Color.gold
        } else if decision == "Slytherin" {
            return Color.black
        } else if decision == "Hufflepuff" {
            return Color.black
        } else if decision == "Ravenclaw" {
            return Color.white
        } else {
            return Color.gold
        }
    }
    
    func decisionColor(decision: String) -> Color {
        if decision == "Gryffindor" {
            return Color.gryffindor
        } else if decision == "Slytherin" {
            return Color.slytherin
        } else if decision == "Hufflepuff" {
            return Color.hufflepuff
        } else if decision == "Ravenclaw" {
            return Color.ravenclaw
        } else {
            return Color.white
        }
    }
}
