//
//  ToastView.swift
//  NSCoffee
//
//  Created by Dani on 28/02/2025.
//

import UIKit

final class ToastView: UIView, NibLoadable {
    @IBOutlet private weak var toastTitleLabel: UILabel!
    @IBOutlet private weak var backgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundView.layer.cornerRadius = 10.0
        
        /* Fix: If the user configures Reduce
         Transparency, we make the view's
         background opaque.
         */
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateBackground), name: UIAccessibility.reduceTransparencyStatusDidChangeNotification, object: nil)
        
        updateBackground()
    }
    
    @objc
    private func updateBackground() {
        let opacity = UIAccessibility.isReduceTransparencyEnabled ? 1.0 : 0.9
        backgroundView.layer.backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(opacity).cgColor
    }
    
    func configureWithTitle(_ title: String) {
        toastTitleLabel.text = title
        accessibilityLabel = toastTitleLabel.accessibilityLabel
    }
    
    func present(inView view: UIView) {
        guard let text = toastTitleLabel.text else { return }
        
        isHidden = false
        translatesAutoresizingMaskIntoConstraints = false
        
        if superview == nil {
            view.addSubview(self)
            
            NSLayoutConstraint.activate(
                [
                    topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
                    centerXAnchor.constraint(equalTo: view.centerXAnchor)
                ]
            )
        }
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0.0,
            options: .curveEaseIn,
            animations: { self.alpha = 1.0 },
            completion: { _ in
                
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
                
                var highPriorityAnnouncement = AttributedString(text)
                highPriorityAnnouncement.accessibilitySpeechAnnouncementPriority = .high
                AccessibilityNotification.Announcement(highPriorityAnnouncement).post()
                
                UIView.animate(
                    withDuration: 0.2,
                    delay: 3.0,
                    options: .curveEaseOut,
                    animations: { self.alpha = 0.0 },
                    completion: { _ in self.isHidden = true }
                )
            }
        )
    }
}
