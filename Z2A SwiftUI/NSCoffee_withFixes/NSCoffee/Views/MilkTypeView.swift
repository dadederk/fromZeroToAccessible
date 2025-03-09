//
//  MilkTypeView.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 02/03/2025.
//

import SwiftUI

struct MilkTypeView: View {
    @State private var milkExpanded = false
    @State private var selectedMilk = MilkOptions.dairy
    
    var body: some View {
        Section {
            if milkExpanded {
                ForEach(MilkOptions.allCases, id: \.self) { milk in

                    HStack {
                        Text(milk.rawValue)

                        Spacer()

                        Image(systemName: selectedMilk == milk ? "checkmark.circle" : "circle")
                            .accessibilityHidden(true)
                    }
                    .onTapGesture {
                        selectedMilk = milk
                    }
                }
            }
        } header: {
            HStack {
                Text("Type of Milk")

                Image(systemName: "chevron.up")
                    .rotationEffect(.degrees(milkExpanded ? 180 : 0))
            }
            .onTapGesture {
                withAnimation {
                    milkExpanded.toggle()
                }
            }
        }
    }
}

#Preview {
    MilkTypeView()
}
