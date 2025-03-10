//
//  BasketView.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 04/03/2025.
//

import SwiftUI

struct BasketView: View {
    @ObservedObject var basket: Basket
    @State var loading = false
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    @AccessibilityFocusState var initialFocus
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @Binding var showBasket: Bool

    @MainActor
    func purchase(success: Bool) {
        loading = false

        /* Fix: VoiceOver users need to be informed of
         state changes. Posting an announcement lets
         us keep them up to date.
         */
        if success {
            voiceOverAnnouncement("Order complete")
        } else {
            voiceOverAnnouncement("Order failed")
        }
    }

    @MainActor
    func voiceOverAnnouncement(_ message: String) {
        var highPriorityAnnouncement = AttributedString(message)
        highPriorityAnnouncement.accessibilitySpeechAnnouncementPriority = .high
        AccessibilityNotification.Announcement(highPriorityAnnouncement).post()
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    if basket.isEmpty {
                        Text("Cart empty")
                            .accessibilityFocused($initialFocus)
                    }

                    ForEach(basket.orders, id: \.self) {
                        BasketRow(order: $0)
                            .accessibilityFocused($initialFocus)
                    }
                }

                Spacer()

                Button {
                    if !basket.isEmpty {
                        loading = true

                        /* Fix: VoiceOver users need to be informed of
                         state changes. Posting an announcement lets
                         us keep them up to date.
                         */
                        voiceOverAnnouncement("Placing order")

                        Task {
                            let success = await basket.placeOrder()
                            purchase(success: success)
                        }
                    }

                } label: {
                    ZStack {
                        HStack {
                            if loading {
                                ProgressView()
                            }

                            Spacer()
                        }

                        Text("\(CurrencyFormatter.format(basket.totalPrice)) Buy")
                            .frame(maxWidth: .infinity)
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
                .disabled(basket.isEmpty || loading)

                /* Fix: Marking the button as disabled when
                 it performs no action informs VoiceOver
                 users that it will not perform an action
                 in its current state.
                 */
            }
            .navigationTitle("Cart")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        showBasket = false
                    }
                }
            }
        }
    }
}
