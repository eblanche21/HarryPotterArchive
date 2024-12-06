//
//  SortingHatView.swift
//  
//
//  Created by Ethan Blanche on 12/3/24.
//

import SwiftUI

struct SortingHatView: View {
    
    @State var hat = SortingHat()
    @State var decision = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        ZStack {
            if decision != "" {
                hat.decisionColor(decision: decision)
                    .ignoresSafeArea()
            } else {
                Color.navy
                    .ignoresSafeArea()
            }
        VStack(alignment: .center) {
            Text("Tap the Hat to Be Sorted Into a House!")
                .font(.custom("HarryP", size: 70))
                .bold()
                .multilineTextAlignment(.center)
                .padding()
                .shadow(radius: 8, x: 10, y: 10)
                .foregroundStyle(hat.decisionFontColor(decision: decision))
            
            Spacer()
            
            Image("SortingHat")
                .resizable()
                .scaledToFit()
                .padding()
                .frame(width: 300, height: 300)
                .position(x: 195, y: 128)
                .shadow(radius: 8, x: 10, y: 10)
                .onTapGesture {
                    decision = hat.sortingHatDecision()
                }

            
            if decision != "" {
                Text("You were sorted into \(decision)!")
                    .font(.custom("HarryP", size: 70))
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                    .shadow(radius: 8, x: 10, y: 10)
                    .foregroundStyle(hat.decisionFontColor(decision: decision))
            }
            
            
            Spacer()
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Return") {
                    dismiss()
                }
                .font(.custom("TimesNewRomanPS-BoldMT", size: 25))
                .foregroundStyle(hat.decisionFontColor(decision: decision))
                
            }
        }
    }
    }
}

#Preview {
    NavigationStack {
        SortingHatView()
    }
}
