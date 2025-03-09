//
//  RatingView.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 02/03/2025.
//

import SwiftUI

struct RatingView: View {
    @State private var rating = 1

    var body: some View {
        HStack {
            ForEach(1..<6) { value in
                Button {
                    withAnimation {
                        rating = value
                    }

                } label: {
                    Image(systemName: value <= rating ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .containerRelativeFrame(.horizontal, count: 12, span: 2, spacing: 10)
                        .foregroundStyle(.tint)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    RatingView()
}
