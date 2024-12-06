//
//
//  HarryPotterArchive
//
//
// 

import SwiftUI
import SwiftData


struct MyWizardsView: View {
    @Query var wizards: [Wizard]
    @Environment(\.modelContext) var modelContext
    @State private var newWizardIsPresented = false
    @Environment(\.dismiss) private var dismiss

    
    
    var body: some View {
        
        
        ZStack {
            Color.navy
                .ignoresSafeArea()
            List {
                ForEach(wizards) { wizard in
                    VStack (alignment: .leading) {
                        HStack {

                                Text(wizard.name)
                                    .foregroundStyle(.gold)
                                    .font(.custom("HarryP", size: 30))

                      
                            .swipeActions {
                                Button("Delete", role: .destructive) {
                                    modelContext.delete(wizard)
                                    guard let _ = try? modelContext.save() else {
                                        print("😡 ERROR: Save after .delete on ToDoListView did not work.")
                                        return
                                    }
                                }
                            }
                        }
                        .font(.title2)
                        
                        HStack {
                            Text("Date of Birth:")
                                .foregroundStyle(.gold)
                                .font(.custom("TimesNewRomanPS-BoldMT", size: 20))

                            
                            Text(wizard.birthday.formatted(date: .abbreviated, time: .shortened))
                                .foregroundStyle(.white)
                                .font(.custom("TimesNewRomanPSMT", size: 20))

                        }
                        
                        HStack {
                            Text("House:")
                                .foregroundStyle(.gold)
                                .font(.custom("TimesNewRomanPS-BoldMT", size: 20))
                            
                            Text(wizard.house.capitalized)
                                .foregroundStyle(.white)
                                .font(.custom("TimesNewRomanPSMT", size: 20))

                        }
                        
                        HStack {
                            Text("Ancestry:")
                                .foregroundStyle(.gold)
                                .font(.custom("TimesNewRomanPS-BoldMT", size: 20))
                            
                            Text(wizard.wizardAncestry.capitalized)
                                .foregroundStyle(.white)
                                .font(.custom("TimesNewRomanPSMT", size: 20))

                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach({ modelContext.delete(wizards[$0])})
                    guard let _ = try? modelContext.save() else {
                        print("😡 ERROR: Save after .delete in ToDoListView did not work.")
                        return
                    }
                }
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            .background(Color.clear)
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        newWizardIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .bold()
                            .foregroundColor(.gold)
                    }
                }
            }
            .sheet(isPresented: $newWizardIsPresented) {
                NavigationStack {
                    NewWizardView(wizard: Wizard())
                        .presentationDetents([.height(740)])
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Back") {
                    dismiss()
                }
                .foregroundStyle(.gold)
                .font(.custom("TimesNewRomanPS-BoldMT", size: 25))
            }
        }
    }
}

#Preview {
    NavigationStack {
        MyWizardsView()
            .modelContainer(Wizard.preview)
    }
}
