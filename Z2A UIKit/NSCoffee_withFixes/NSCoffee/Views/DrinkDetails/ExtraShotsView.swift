//
//  ExtraShotsView.swift
//  NSCoffee
//
//  Created by Dani on 09/03/2025.
//

import UIKit

final class ExtraShotsView: UIView, NibLoadable {
    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var stepperStackView: UIStackView!
    @IBOutlet private weak var removeShotButton: UIButton!
    @IBOutlet private weak var addShotButton: UIButton!
    @IBOutlet private weak var numberOfShotsLabel: UILabel!
    @IBOutlet private weak var extraPriceLabel: UILabel!
    
    private var numberOfShots = 0
    
    var extraShotsUpdated: (Int) -> Void = { _ in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /* Fix: A preferred font for a text style
         will let the font scale for Dynamic Type.
         Adjusting for content size category, means
         that the text size will automatically adapt
         if the user changes the configured text size.
         The semantic color ".label" means it will
         work well both in Dark and Light Modes.
         */
        
        numberOfShotsLabel.font = UIFont.preferredFont(forTextStyle: .body)
        numberOfShotsLabel.adjustsFontForContentSizeCategory = true
        numberOfShotsLabel.textColor = .label
        
        extraPriceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        extraPriceLabel.adjustsFontForContentSizeCategory = true
        extraPriceLabel.textColor = .label
        
        /* Fix: Grouping these buttons together as a single
         element for assistive technologies makes the control
         easier to understand and interact with
         */
        
        isAccessibilityElement = true
        
        /* Fix: We need to add an accessible label to our new
         grouped control
         */
        
        accessibilityLabel = String(localized: "extraShots")
        
        /* Fix: Adding the adjustable trait allows assistive
         technologies to interact directly with the control.
         In UIKit it requires implementing accessibilityIncrement
         and accessibilityDecrement
         */
        
        accessibilityTraits.insert(.adjustable)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        /* Fix: At larger text sizes moving content
         stacked horizontally to being stacked
         vertically allows for improved readability
         */
        
        if traitCollection.preferredContentSizeCategory.isAccessibilityCategory {
            mainStackView.axis = .vertical
        } else {
            mainStackView.axis = .horizontal
        }
    }
    
    /* Fix: Telling assistive technologies what to do
     when the user increments or decrements the value.
     of the adjustable component.
     */

    override func accessibilityIncrement() {
        increaseNumberOfShots()
    }

    override func accessibilityDecrement() {
        decreaseNumberOfShots()
    }
    
    func configure(numberOfShots: Int, price: Double) {
        self.numberOfShots = numberOfShots
        numberOfShotsLabel.text = String(localized: "numberShots.\(numberOfShots)")
        extraPriceLabel.text = "+ \(CurrencyFormatter.format(price))"
    }
    
    @IBAction func removeShotPressed(_ sender: Any) {
        decreaseNumberOfShots()
    }
    
    @IBAction func addShotPressed(_ sender: Any) {
        increaseNumberOfShots()
    }
    
    private func increaseNumberOfShots() {
        guard numberOfShots < 4 else { return }
        numberOfShots += 1
        extraShotsUpdated(numberOfShots)
        updateAccessibilityValue()
    }
    
    private func decreaseNumberOfShots() {
        guard numberOfShots > 0 else { return }
        numberOfShots -= 1
        extraShotsUpdated(numberOfShots)
        updateAccessibilityValue()
    }
    
    private func updateAccessibilityValue() {
        
        /* Fix: Report the value in a meaningful way
         */
        
        accessibilityValue = [numberOfShotsLabel.text, extraPriceLabel.text]
            .compactMap { $0 }
            .formatted(.list(type: .and, width: .narrow))
    }
}
