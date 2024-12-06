//
//
//
//
//  
//

import Foundation

struct Creature: Codable, Identifiable {
    let id  = UUID().uuidString
    var name: String
    var house: String // url for detail on Pokemon
    var image: String
    var wizard: Bool
    var species: String
    var ancestry: String
    var dateOfBirth: String?
    
    enum CodingKeys: CodingKey { // ignore the ID property when decoding
        case name
        case house
        case image
        case wizard
        case species
        case ancestry
        case dateOfBirth
    }
    
    func wizardOrNot() -> String {
        wizard ? "Yes" : "No"
    }
    
    func houseOrNot() -> String {
        if house == "" {
            return "None"
        } else {
            return house
        }
    }
    
    func ancestryOrNot() -> String {
        if ancestry == "" {
            return "Unknown"
        } else {
            return ancestry
        }
    }
}
