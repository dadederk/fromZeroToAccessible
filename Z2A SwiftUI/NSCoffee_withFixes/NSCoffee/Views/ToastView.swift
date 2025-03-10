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
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency

    private var removeAfterDelay: Task<Void, Never>? {
        Task {
            do {
                voiceOverAnnouncement(visibleMessage!)
                
                try await Task.sleep(for: .seconds(3.0))

                withAnimation(.linear(duration: 0.2)) {
                    opacity = 0.0

                } completion: {
                    visibleMessage = nil
                }
            } catch {}
        }
    }

    @MainActor
    func voiceOverAnnouncement(_ message: String) {
        /* Fix: Because toasts auto dismiss, it
         is very unlikely VoiceOver users will
         get to it. One option is to announce
         the message in the toast.

         Note: But there are more issues with
         this UI pattern. It is very challenging
         to make toasts accessible and we'd
         encourage you to explore other options
         if possible.
         */
        var highPriorityAnnouncement = AttributedString(message)
        highPriorityAnnouncement.accessibilitySpeechAnnouncementPriority = .high
        AccessibilityNotification.Announcement(highPriorityAnnouncement).post()
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

            /* Fix: Using semantic colors, instead of
             specifying the exact color, will lots
             of times make easier to have good color
             contrast ratios. And at the very least, you'll
             get support for Light/Dark modes, and Increase
             Contrast On/Off (in all four combinations), for
             free.
             */
            .background(Color(UIColor.secondarySystemBackground)

                        /* Fix: When the user has enabled reduce transparency
                         we'll respect the users choice and remove the
                         transparency from the toast background
                         */
                .opacity(reduceTransparency ? 1.0 : 0.90))

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
