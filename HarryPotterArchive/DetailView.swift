//
//  
//
//
//  
//

import SwiftUI

struct DetailView: View {
    let creature: Creature
    @State private var creatureDetail = CreatureDetail()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color(.navy)
                .ignoresSafeArea()
            VStack (alignment: .leading, spacing: 3){
                Text(creature.name.capitalized)
                    .font(.custom("HarryP", size: 70))
                    .bold()
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                
                HStack {
                    creatureImage
                    
                    
                    VStack (alignment: .leading) {
                        HStack {
                            Text("Species:")
                                .font(.custom("TimesNewRomanPS-BoldMT", size: 20))
                                .bold()
                                .foregroundStyle(.white)
                            
                            Text(String(creature.species.capitalized))
                                .font(.custom("TimesNewRomanPSMT", size: 20))
                                .bold()
                        }
                        
                        HStack {
                            Text("Date Of Birth:")
                                .font(.custom("TimesNewRomanPS-BoldMT", size: 18))
                                .bold()
                                .foregroundStyle(.white)
                            
                            Text(String(creature.dateOfBirth ?? "Unknown"))
                                .font(.custom("TimesNewRomanPSMT", size: 20))
                                .bold()
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                        }
                        
                        HStack {
                            Text("Wizard:")
                                .font(.custom("TimesNewRomanPS-BoldMT", size: 20))
                                .bold()
                                .foregroundStyle(.white)
                            
                            Text(String(creature.wizardOrNot()).capitalized)
                                .font(.custom("TimesNewRomanPSMT", size: 20))
                                .bold()
                                .lineLimit(1)
                        }
                        
                        HStack {
                            Text("House:")
                                .font(.custom("TimesNewRomanPS-BoldMT", size: 20))
                                .bold()
                                .foregroundStyle(.white)
                            
                            Text(String(creature.houseOrNot()))
                                .font(.custom("TimesNewRomanPSMT", size: 20))
                                .bold()
                        }
                        
                        HStack {
                            Text("Ancestry:")
                                .font(.custom("TimesNewRomanPS-BoldMT", size: 20))
                                .bold()
                                .foregroundStyle(.white)
                            
                            Text(String(creature.ancestryOrNot().capitalized))
                                .font(.custom("TimesNewRomanPSMT", size: 20))
                                .bold()
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                        }
                    }
                    
                }
                
                Spacer()
            }
            .foregroundStyle(.gold)
            .padding()
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

extension DetailView {
    var creatureImage: some View {
        AsyncImage(url: URL(string: creature.image)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.gold, lineWidth: 3)
                    )
                    .shadow(radius: 8, x: 10, y: 10)
                    .padding(.top)
                    .padding(.top)
                
            } else if creature.image == "" {
                Image(systemName: "questionmark.square.dashed")
                    .resizable()
                    .scaledToFit()
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 8, x: 5, y: 5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray.opacity(0.5), lineWidth: 1)
                    }
            } else { // Use a placeholder - image loading
                ProgressView()
                    .tint(.red)
                    .scaleEffect(4)
            }
        }
        .frame(width: 96, height: 96)
        .padding(.trailing)
    }
}

#Preview {
    NavigationStack {
        DetailView(creature: Creature(name: "Harry Potter", house: "Gryffindor", image: "https://ik.imagekit.io/hpapi/harry.jpg", wizard: true, species: "Human", ancestry: "half-blood", dateOfBirth: "31-07-1980"))
    }
}

