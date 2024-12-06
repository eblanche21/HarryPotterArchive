//
//  HarryPotterArchive.swift
//
//
//
//

import Foundation
import SwiftData

@MainActor
@Model
class Wizard {
    var name: String = ""
    var birthday = Date.now
    var notes = ""
    var house = ""
    var wizardAncestry = ""
    
    init(name: String = "", birthday: Date = Date.now + 60*60*24, notes: String = "", house: String = "", wizardAncestry: String = "") {
        self.name = name
        self.birthday = birthday
        self.notes = notes
        self.house = house
        self.wizardAncestry = wizardAncestry
        
        print("Initialized Wizard: \(name), House: \(house), Ancestry: \(wizardAncestry)")
    }
}

extension Wizard {
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: Wizard.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        
        container.mainContext.insert(Wizard(name: "Ethan Blanche", birthday: Date.now + 60*60*24, notes: "Now with iOS 16 & Xcode 18", house: "Gryffindor", wizardAncestry: "Muggleborn"))
        container.mainContext.insert(Wizard(name: "Snoop Dogg", birthday: Date.now + 60*60*44, notes: "They want to learn about entrepreneurship", house: "Gryffindor", wizardAncestry: "Muggleborn"))
        container.mainContext.insert(Wizard(name: "LeBron", birthday: Date.now + 60*60*72, notes: "To be held at UAH in Chile", house: "Gryffindor", wizardAncestry: "Muggleborn"))
        container.mainContext.insert(Wizard(name: "Tim", birthday: Date.now + 60*60*12, notes: "She gets my old pro", house: "Gryffindor", wizardAncestry: "Muggleborn"))
        
        return container
    }
}
