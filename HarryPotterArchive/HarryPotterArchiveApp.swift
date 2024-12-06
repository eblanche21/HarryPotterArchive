//
//  HarryPotterArchiveApp.swift
//  HarryPotterArchive
//
//  Created by Ethan Blanche on 12/4/24.
//

import SwiftUI

@main
struct HarryPotterArchiveApp: App {
    var body: some Scene {
        WindowGroup {
            CreaturesListView()
                .modelContainer(for: Wizard.self)
        }
    }
}
