//
//  PickerOptionView.swift
//  NSCoffee
//
//  Created by Dani on 02/03/2025.
//

import UIKit

final class PickerOptionView: UIView, NibLoadable {
    @IBOutlet private weak var selectionIconImageView: UIImageView!
    @IBOutlet private weak var optionLabel: UILabel!
    
    private var isToggled: Bool = false {
        didSet {
            /* Fix: The selection state needs to be
             conveyed to VoiceOver, and other assistive
             technology, users.
             */
            
            if isToggled {
                selectionIconImageView.image = UIImage(systemName: "checkmark.circle.fill")
                accessibilityTraits.insert(.selected)
            } else {
                selectionIconImageView.image = UIImage(systemName: "circle")
                accessibilityTraits.remove(.selected)
            }
        }
    }
    
    private var toggled: ((PickerOptionView) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionIconImageView.image = UIImage(systemName: "circle")
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
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
        
        optionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        optionLabel.adjustsFontForContentSizeCategory = true
        optionLabel.textColor = .label
        optionLabel.numberOfLines = 0
        
        selectionIconImageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        /* Fix: Because we've added the tap gesture
         recognizer, it needs to be exposed as a
         button to assistive technologies.
         */
        isAccessibilityElement = true
        accessibilityTraits.insert(.button)
    }
    
    func configureWith(option: String, state: Bool, toggled: @escaping (PickerOptionView) -> Void) {
        optionLabel.text = option
        self.toggled = toggled
        self.isToggled = state
        
        accessibilityLabel = option
    }
    
    func configureState(_ state: Bool) {
        self.isToggled = state
    }
    
    @objc
    private func handleTap() {
        toggled?(self)
    }
}
