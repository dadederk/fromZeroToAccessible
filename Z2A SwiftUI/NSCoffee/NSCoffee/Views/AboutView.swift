//
//  AboutView.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 26/09/2026.
//

import SwiftUI

struct CoffeeOrigin {
    let name: String
    let isOrganic: Bool
}

struct AboutView: View {
    @State private var showMoreDetails = false

    private let origins = [
        CoffeeOrigin(name: "Colombia", isOrganic: true),
        CoffeeOrigin(name: "Ethiopia", isOrganic: true),
        CoffeeOrigin(name: "Sumatra", isOrganic: false)
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                DrinkTableImage(imageName: "Latte")
                    .frame(height: 180)
                    .clipped()

                Text("Our Coffee")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("Once Dani & Rob have completed making all iOS apps accessible, they will open NSCoffee, a specialist coffee roasters sourcing beans from small farms across Colombia, Ethiopia and Sumatra. We'll roast in small batches every week to keep things fresh, and work directly with growers to make sure they're paid fairly for their harvest.")
                    .font(.subheadline)
                    .foregroundStyle(.gray)

                Text("Organic Status")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 10) {
                    ForEach(origins, id: \.name) { origin in
                        HStack {
                            Circle()
                                .fill(origin.isOrganic ? .green : .red)
                                .frame(width: 14, height: 14)

                            Text(origin.name)
                        }
                    }
                }

                Text("Roasting Process")
                    .font(.headline)

                Text("Beans are roasted at 200°C for 12-15 minutes depending on origin, then rested for 48 hours before grinding. This brings out the natural sweetness without any bitterness.")
                    .font(.subheadline)
                    .foregroundStyle(.gray)

                Image(systemName: "info.circle")
                    .font(.title3)
                    .onTapGesture {
                        showMoreDetails.toggle()
                    }

                if showMoreDetails {
                    Text("Our roastery has been running since 2014 and now supplies over 40 independent cafes.")
                        .font(.footnote)
                        .padding()
                        .background(Color(white: 0.93))
                }

                Divider()

                Text("Find Us")
                    .font(.headline)

                Text("123 Bean Street, Brewford")
                    .font(.subheadline)

                HStack(spacing: 0) {
                    Text("Tap ")
                        .font(.caption)

                    Text("here")
                        .font(.caption)
                        .foregroundStyle(.blue)
                        .onTapGesture {
                            let query = "123 Bean Street, Brewford".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                            if let url = URL(string: "http://maps.apple.com/?q=\(query)") {
                                UIApplication.shared.open(url)
                            }
                        }

                    Text(" for directions")
                        .font(.caption)
                }
            }
            .padding()
        }
        .navigationTitle("About")
    }
}

#Preview {
    NavigationStack {
        AboutView()
    }
}
