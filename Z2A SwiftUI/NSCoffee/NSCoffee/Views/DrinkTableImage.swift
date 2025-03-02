//
//  DrinkTableImage.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 02/03/2025.
//

import SwiftUI

struct DrinkTableImage: View {
    let imageName: String?

    var body: some View {
        Group {
            if let imageName = imageName {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)

            } else {
                Image(systemName: "cup.and.heat.waves.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .containerRelativeFrame(.horizontal, count: 4, span: 1, spacing: 10)
    }
}
