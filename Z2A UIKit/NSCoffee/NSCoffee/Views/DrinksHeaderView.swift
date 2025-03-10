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
        headerTitleLabel.textColor = .darkGray
        backgroundColor = .lightGray

    }
    
    func configure(withTitle title: String) {
        headerTitleLabel.text = title
    }
}
