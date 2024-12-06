//
//
//
//
//
//

import Foundation

@MainActor
@Observable // Will watch objects for changes so that SwiftUI will redraw the interface when needed
class Creatures {

    var urlString = "https://hp-api.herokuapp.com/api/characters"
    var creaturesArray: [Creature] = []
    var isLoading = false
    
    func getData() async {
        print("🕸️ We are accessing the url \(urlString)")
        isLoading = true
        
        // Create a URL
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Try to decode JSON data into our own data structures
            guard let creatures = try? JSONDecoder().decode([Creature].self, from: data) else {
                print("😡 JSON ERROR: Could not decode returned JSON data")
                isLoading = false
                return
            }
            Task { @MainActor in
                self.creaturesArray.append(contentsOf: creatures)
                isLoading = false
            }
        } catch {
            print("😡 ERROR: Could not get data from \(urlString)")
            isLoading = false
        }
    }
    
    func loadNextIfNeeded(creature: Creature) async {
        guard let lastCreature = creaturesArray.last else { return }
        if creature.id == lastCreature.id && urlString.hasPrefix("http") {
            await getData()
        }
    }
    
    func loadAll () async {
        Task { @MainActor in
            guard urlString.hasPrefix("http") else { return }
            await getData() // get next page of data
            await loadAll() // call loadAll again - will stop when all pages are retrieved
        }
    }
    
}
