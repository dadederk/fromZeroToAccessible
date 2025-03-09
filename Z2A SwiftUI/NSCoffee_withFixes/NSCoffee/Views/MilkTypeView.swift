//
//  MilkTypeView.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 02/03/2025.
//

import SwiftUI

struct MilkTypeView: View {
    @State private var selectedMilk = MilkOptions.dairy

    var body: some View {
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
}

#Preview {
    MilkTypeView()
}
