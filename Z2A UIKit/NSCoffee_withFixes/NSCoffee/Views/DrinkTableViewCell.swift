//
//  DrinkTableViewCell.swift
//  NSCoffee
//
//  Created by Dani on 28/02/2025.
//

import UIKit

protocol DrinkTableViewCellDelegate: AnyObject {
    func addOrderToCart(_ order: Order)
}

final class DrinkTableViewCell: UITableViewCell {
    static let identifier = String(describing: DrinkTableViewCell.self)
    
    @IBOutlet private weak var outerStackView: UIStackView!
    @IBOutlet private weak var drinkImageView: UIImageView!
    @IBOutlet private weak var drinkNameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var disclosureIndicatorImageView: UIImageView!
    @IBOutlet private weak var buyButton: UIButton!
    @IBOutlet private weak var imageHeightConstraint: NSLayoutConstraint!
    
    private var drink: (any Drink)?
    
    weak var delegate: DrinkTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buyButton.addTarget(self, action: #selector(buyDrink), for: .touchUpInside)
        
        /* Fix: Instead of fixing the font size, as
         it is done in the nib file, we specify a
         preferred font for a text style, that will
         adapt in size as per the user preference.
         */
        
        drinkNameLabel.font = .preferredFont(forTextStyle: .body)
        priceLabel.font = .preferredFont(forTextStyle: .body)
        
        /* Fix: Using semantic colors, instead of
         specifying the exact color, will lots
         of times make easier to have good color
         contrast ratios. And at the very least, you'll
         get support for Light/Dark modes, and Increase
         Contrast On/Off (in all four combinations), for
         free.
         */
        
        priceLabel.textColor = .secondaryLabel
        
        /* Fix: We'll group everything contained in
         the cell so the list of drinks is easier to
         navigate with assistive technologies.
         */
        
        isAccessibilityElement = true
        
        /* Fix: Because the cell is interactive, it needs
         to have the button accessibility trait.
         */
        
        accessibilityTraits.insert(.button)
        
        /* Fix: When the user enables Smart Invert Colors,
         there is no need to invert the images.
         */
        
        drinkImageView.accessibilityIgnoresInvertColors = true
        
        updateLayout()
    }
    
    /* Fix: When the cell itself becomes the accessibility
     element, it needs to be configured with everything
     necessary including: label, value, traits... We are
     overriding it, instead of configuring straight away,
     because the cell needs to be first configured with
     some data.
     */
    
    override var accessibilityLabel: String? {
        get {
            return [drinkNameLabel.accessibilityLabel,
                    priceLabel.accessibilityLabel]
                .compactMap { $0 }
                .formatted(.list(type: .and, width: .narrow))
        }
        set {}
    }
    
    /* Fix: Because the cell is now an accessibility
     element, assistive technology won't be able to
     find any of its subviews, including the "Add
     to cart" button.
     */
    
    override var accessibilityCustomActions: [UIAccessibilityCustomAction]? {
        get {
            return [UIAccessibilityCustomAction(name: String(localized: "addToCart"), target: self, selector: #selector(buyDrink))]
        }
        set {}
    }
    
    /* Fix: Voice Control users can say "Tap <name>"
     to interact with an accessibility element. The
     default <name> is the accessibility label. In
     this case it includes the price. It is easier
     to allow the user to just say "Tap Espresso",
     rather than "Tap Espresso, £2.00".
     
     Note: From iOS 18, <name> is also by default,
     the subset of words from the beginning of the
     accessibility label. So in this case, it is
     not strictly necessary for iOS 18+.
     */
    
    override var accessibilityUserInputLabels: [String]! {
        get {
            guard let drink = drink else { return [] }
            return [drink.name, accessibilityLabel].compactMap{ $0 }
        }
        set {}
    }
    
    /* Fix: Listening to trait collection changes
     and adapting the layout to better accommodate
     large text sizes.
     */
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
            updateLayout()
        }
    }
    
    /* Fix: In this case, if the text size is one
     of the accessibility text sizes, we change
     the stack view from horizontal to vertical
     so the text can flow from side to side of the
     screen, improving readability
     */
    
    /* Fix: We change the number of lines to 0, which
     confusingly means unlimited, as we'll need more
     lines of text than we'd need for the default text
     size, to get the same amount of content
     on screen.
     */
    
    private func updateLayout() {
        if traitCollection.preferredContentSizeCategory.isAccessibilityCategory {
            outerStackView.axis = .vertical
            outerStackView.alignment = .leading
            outerStackView.distribution = .equalSpacing
            drinkNameLabel.numberOfLines = 0
        } else {
            outerStackView.axis = .horizontal
            outerStackView.alignment = .center
            outerStackView.distribution = .fillProportionally
            drinkNameLabel.numberOfLines = 1
        }
    }
    
    @objc
    private func buyDrink(_ sender: UIButton) {
        guard let drink = drink else { return }
        guard let delegate = delegate else { return }
        
        delegate.addOrderToCart(Order(drink: drink))
    }
    
    func configure(with drink: any Drink) {
        self.drink = drink
        
        drinkNameLabel.text = drink.name
        priceLabel.text = CurrencyFormatter.format(drink.basePrice)
        buyButton.setTitle(String(localized: "addToCart"), for: .normal)
        
        if let imageName = drink.imageName {
            drinkImageView.image = UIImage(named: imageName)
            drinkImageView.contentMode = .scaleAspectFill
        } else {
            drinkImageView.image = UIImage(systemName: "cup.and.heat.waves.fill")
            drinkImageView.contentMode = .scaleAspectFit
        }
    }
}
