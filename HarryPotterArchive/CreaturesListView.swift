//
//
//
//
//  
//

import SwiftUI
import SwiftData

struct CreaturesListView: View {
    @State var creatures = Creatures()
    @State private var searchText = ""
    @State private var sortingHatIsPresented = false
    @State var hat = SortingHat()
    @FocusState private var isSearchBarFocused: Bool
    @Environment(\.modelContext) var modelContext


    
    init() {
            // Set up the appearance of the navigation bar
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor.black

            // Set the title font for both large and small titles
            // Use the custom font "HarryP"
            let titleFont = UIFont(name: "HarryP", size: 80) ?? UIFont.systemFont(ofSize: 24) // Fallback to system font if custom font is not found
            let titleAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.gold,
                .font: titleFont
            ]
            
            appearance.largeTitleTextAttributes = titleAttributes // Large title attributes
            appearance.titleTextAttributes = titleAttributes      // Regular title attributes

            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        if let customFont = UIFont(name: "TimesNewRomanPS-BoldMT", size: 18) {
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [
                .foregroundColor: UIColor.gold, // Set text color
                .font: customFont                 // Set custom font
            ]
        }
        if let customFont = UIFont(name: "TimesNewRomanPS-BoldMT", size: 18) {
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([
                .font: customFont,
                .foregroundColor: UIColor.gold
            ], for: .normal)
        }
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor.gold // Change to your desired cursor color
        }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.navy
                    .ignoresSafeArea()
                List(searchResults) { creature in
                    LazyVStack {
                        NavigationLink {
                            DetailView(creature: creature)
                        } label: {
                            HStack {
                                
                                Spacer()
                                
                                Text("\(creature.name)")
                                    .font(.custom("TimesNewRomanPS-BoldMT", size: 30))
                                    .bold()
                                    .foregroundStyle(Color.gold)
                                    .padding()
                                    .border(Color.gold)
                                
                                Spacer()
                            }

                        }
                    }
                    .listRowBackground(Color.clear)

                }
                .scrollContentBackground(.hidden)

                .navigationTitle("Characters")
                
                
                    Image("SortingHat")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .background(.gold)
                        .buttonBorderShape(.circle)
                        .clipShape(Circle())
                        .shadow(radius: 8, x: 10, y: 10)
                        .overlay(
                            Circle()
                                .stroke(Color.black, lineWidth: 5)
                        )
                        .offset(x: 130, y: 200)
                        .onTapGesture {
                            sortingHatIsPresented.toggle()
                        }
                
                        .sheet(isPresented: $sortingHatIsPresented) {
                            NavigationStack {
                                SortingHatView()
                                    .presentationDetents([.height(740)])
                                    .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
                            }
                        }
                
                        
                VStack {
                    Spacer()
                    NavigationLink {
                        MyWizardsView()
                    } label: {
                        Text("My Wizards")
                            .frame(width: 150, height: 70)
                            .background(Color.black)
                            .buttonBorderShape(.buttonBorder)
                            .clipShape(.buttonBorder)
                            .font(.custom("TimesNewRomanPS-BoldMT", size: 20))
                            .shadow(radius: 8, x: 10, y: 10)
                      
                            .foregroundStyle(.gold)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .searchable(text: $searchText)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                
                
                if creatures.isLoading {
                    ProgressView()
                        .tint(.red)
                        .scaleEffect(4)
                }
            }
        }
        .task {
            await creatures.getData()
        }
    }
    
    var searchResults: [Creature] {
        if searchText.isEmpty {
            return creatures.creaturesArray
        } else { // We have some searchText
            return creatures.creaturesArray.filter {$0.name.capitalized.contains(searchText)}
        }
    }
    
}
#Preview {
        CreaturesListView()
        .modelContainer(Wizard.preview)
}
