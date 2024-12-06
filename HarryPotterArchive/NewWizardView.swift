//
//  
//
//
//
// 

import SwiftUI
import SwiftData

struct NewWizardView: View {
    @State var wizard: Wizard
    @State private var name = ""
    @State private var birthday = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!
    @State private var notes = ""
    @State private var house = ""
    @State private var wizardAncestry = ""
    @Environment(\.modelContext) var modelContext
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            Color.gold
                .ignoresSafeArea()
            List {
                
                Text("Name:")
                    .padding(.top)
                    .listRowBackground(Color.clear)
                
                
                    TextField("Enter Name Here", text: $name)
                        .font(.title)
                        .textFieldStyle(.roundedBorder)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)

            
            DatePicker("Set Date of Birth:", selection: $birthday)
                .listRowSeparator(.hidden)
                .padding(.bottom)
                .listRowBackground(Color.clear)

                

            HStack {
                Text("Enter House:")

                TextField("Enter House Here", text: $house)
                    .font(.caption)
                    .textFieldStyle(.roundedBorder)
                    .listRowSeparator(.hidden)
                
            }
            .listRowBackground(Color.clear)
            
            HStack {
                Text("Enter Ancestry:")
                TextField("Enter Ancestry Here", text: $wizardAncestry)
                    .font(.caption)
                    .textFieldStyle(.roundedBorder)
                    .listRowSeparator(.hidden)
            }
                
            .listRowBackground(Color.clear)

        }
            .shadow(radius: 8, x: 10, y: 10)
        .foregroundStyle(Color.navy)
        .font(.custom("TimesNewRomanPS-BoldMT", size: 20))
        .listStyle(.plain)
        .onAppear() {
            name = wizard.name
            birthday = wizard.birthday
            notes = wizard.notes
            house = wizard.house
            wizardAncestry = wizard.wizardAncestry
        }
    }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundStyle(.gold)
                .font(.custom("TimesNewRomanPS-BoldMT", size: 25))
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    wizard.name = name
                    wizard.birthday = birthday
                    wizard.notes = notes
                    wizard.house = house
                    wizard.wizardAncestry = wizardAncestry
                    modelContext.insert(wizard)
                    guard let _ = try? modelContext.save() else {
                        print("😡 ERROR: Save on DetailView did not work.")
                        return
                    }
                    dismiss()
                }
                .foregroundStyle(.gold)
                .font(.custom("TimesNewRomanPS-BoldMT", size: 25))
            }
        }
    }
}

#Preview {
    NavigationStack{
       NewWizardView(wizard: Wizard())
            .modelContainer(for: Wizard.self, inMemory: true)
    }
}
