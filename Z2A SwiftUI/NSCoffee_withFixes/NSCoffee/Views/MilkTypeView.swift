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

            /* Fix: Use system-provided options where possible.
             Adding the selectable row as a button gives
             us the correct assistive technology
             behaviour for free.
             */
            Button {
                selectedMilk = milk

            } label: {
                HStack {
                    Text(milk.rawValue)

                    Spacer()

                    Image(systemName: selectedMilk == milk ? "checkmark.circle" : "circle")
                        .accessibilityHidden(true)
                }
            }
            .buttonStyle(.plain)
            
            /* Fix: So VoiceOver and Braille users know
             which option is currently selected, we need
             to add the selected trait.
             */
            .if(selectedMilk == milk) {
                $0.accessibilityAddTraits(.isSelected)
            }
        }
    }
}

#Preview {
    MilkTypeView()
}
