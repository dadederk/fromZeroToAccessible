//
//  DescriptionView.swift
//  NSCoffee
//
//  Created by Dani on 10/03/2025.
//

import UIKit

final class DescriptionView: UIView, NibLoadable {
    @IBOutlet private weak var descriptionLabel: UILabel!
    
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
        
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.textColor = .label
        descriptionLabel.numberOfLines = 0
        
        /* Fix: Listening to changes in the Reduce
         Motion setting so we can adjust accordingly.
         */
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateBackground),
                                               name: UIAccessibility.reduceTransparencyStatusDidChangeNotification,
                                               object: nil)
        
        updateBackground()
    }
    
    @objc
    private func updateBackground() {
        let alpha = UIAccessibility.isReduceTransparencyEnabled ? 1.0 : 0.9
        
        /* Fix: Adding a background to text can guarantee
         the text will always have suitable contrast against
         the image behind.
         */
        
        backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(alpha)
    }
    
    func configureWith(description: String) {
        descriptionLabel.text = description
    }
}
