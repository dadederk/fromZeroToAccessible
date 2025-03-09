//
//  ToastView.swift
//  NSCoffee
//
//  Created by Rob Whitaker on 05/03/2025.
//

import SwiftUI

struct ToastView: View {
    enum AnimationDirection {
        case animateIn, animateOut
    }
    @Binding var message: String?
    @State var opacity = 0.0
    @State var toastDelay: Task<Void, Never>?
    @State var visibleMessage: String?

    private var removeAfterDelay: Task<Void, Never>? {
        Task {
            do {
                try await Task.sleep(for: .seconds(3.0))

                withAnimation(.linear(duration: 0.2)) {
                    opacity = 0.0

                } completion: {
                    visibleMessage = nil
                }
            } catch {}
        }
    }

    func animateToast(_ direction: AnimationDirection, completion: (() -> Void)? = nil) {
        withAnimation(.linear(duration: 0.2)) {
            switch direction {
            case .animateIn:
                opacity = 1.0

            case .animateOut:
                opacity = 0.0
            }
        } completion: {
            completion?()
        }
    }

    var body: some View {
        VStack {
            Group {
                Text(visibleMessage ?? "")
                    .padding()
            }
            .background(.gray
                .opacity(0.90))
            .cornerRadius(20)
            .opacity(opacity)
            .padding(.top)
            .onChange(of: message) { _, newValue in
                guard newValue != nil else { return }

                toastDelay?.cancel()

                let animateInNewToast = {
                    visibleMessage = newValue
                    animateToast(.animateIn)
                    toastDelay = removeAfterDelay
                }

                if visibleMessage != nil {
                    animateToast(.animateOut) {
                        animateInNewToast()
                    }

                } else {
                    animateInNewToast()
                }

                message = nil
            }

            Spacer()
        }
    }
}
