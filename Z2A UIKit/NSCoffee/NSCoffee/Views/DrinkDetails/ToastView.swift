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
        
        updateBackground()
    }
    
    @objc
    private func updateBackground() {
        backgroundView.layer.backgroundColor = UIColor.darkGray.withAlphaComponent(0.9).cgColor
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
