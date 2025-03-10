//
//  SectionHeaderView.swift
//  NSCoffee
//
//  Created by Dani on 09/03/2025.
//

import UIKit

enum HeaderState {
    case none
    case expanded(() -> Void)
    case collapsed(() -> Void)
}

final class SectionHeaderView: UIView, NibLoadable {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var stateImageView: UIImageView!
    
    var state: HeaderState = .none

    override func awakeFromNib() {
        super.awakeFromNib()
    
        /* Fix: A preferred font for a text style
         will let the font scale for Dynamic Type.
         Adjusting for content size category, means
         that the text size will automatically adapt
         if the user changes the configured text size.
         The semantic color ".label" means it will
         work well both in Dark and Light Modes.
         Setting the number of lines to 0 lets the
         text grow to an unlimited number of lines.
         */
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 0
        
        backgroundColor = .secondarySystemBackground
        
        stateImageView.isHidden = true
        
        /* Fix: This view will always act as a
         section header. Adding this trait will
         announce it as a "heading" to VoiceOver
         users, and they'll be able to navigate
         through headers with the Headings Rotor.
         */
        
        isAccessibilityElement = true
        accessibilityTraits.insert(.header)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGestureRecognizer)

    }
    
    func configure(title: String, state: HeaderState = .none) {
        self.state = state
        titleLabel.text = title
        accessibilityLabel = title
        updateState()
    }
    
    @objc
    private func handleTap() {
        switch state {
        case .expanded(let action):
            state = .collapsed(action)
            action()
            updateState()
        case .collapsed(let action):
            state = .expanded(action)
            updateState()
            action()
        case .none: break
        }
    }
    
    private func updateState() {
        switch state {
        case .expanded:
            stateImageView.isHidden = false
            stateImageView.image = UIImage(systemName: "chevron.down")
            accessibilityValue = String(localized: "expanded")
            accessibilityTraits.insert(.button)
        case .collapsed:
            stateImageView.isHidden = false
            stateImageView.image = UIImage(systemName: "chevron.up")
            accessibilityValue = String(localized: "collapsed")
            accessibilityTraits.insert(.button)
        case .none:
            stateImageView.isHidden = true
            accessibilityValue = nil
            accessibilityTraits.remove(.button)
        }
    }
}
