//
//  DrinksHeaderView.swift
//  NSCoffee
//
//  Created by Dani on 28/02/2025.
//

import UIKit

final class DrinksHeaderView: UITableViewCell, NibLoadable {
    static let identifier = String(describing: DrinksHeaderView.self)
    
    @IBOutlet private weak var headerTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /* Fix: Use semantic colors instead so we
         get better color contrast and good support
         for Dark/Light Mode and Increase Contrast
         for both modes.
         */
        
//        headerTitleLabel.textColor = .darkGray
//        backgroundColor = .lightGray
        headerTitleLabel.textColor = .secondaryLabel
        backgroundColor = .secondarySystemBackground
        
        /* Fix: This should also be configured as headings
         for accessibility purposes.
         */
        
        accessibilityTraits.insert(.header)
        
        /* Fix: Use a preferred font style, instead
         of configuring fixed font size (in the nib
         file) to support Dynamic Type.
         */
        headerTitleLabel.font = .preferredFont(forTextStyle: .headline)
    }
    
    func configure(withTitle title: String) {
        headerTitleLabel.text = title
    }
}
