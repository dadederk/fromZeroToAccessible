//
//  ToastView.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 05/03/2025.
//

import SwiftUI

struct ToastView: View {
    @Binding var message: String?
    @State var opacity = 0.0

    var body: some View {
        VStack {
            Spacer()

            if let message = message {
                Group {
                    Text(message)
                        .padding()
                }
                .background(.gray)
                .cornerRadius(20)
                .opacity(0.75)
                .opacity(opacity)
                .padding(.bottom)
                .onAppear {
                    withAnimation(.linear(duration: 0.2)) {
                        opacity = 1.0

                    } completion: {
                        withAnimation(.linear(duration: 0.2)
                            .delay(3.0)) {
                                opacity = 0.0

                            } completion: {
                                self.message = nil
                            }
                    }
                }
            }
        }
    }
}
