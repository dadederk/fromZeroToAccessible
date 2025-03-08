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
    
    @IBOutlet weak var outerStackView: UIStackView!
    @IBOutlet private weak var drinkImageView: UIImageView!
    @IBOutlet private weak var drinkNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet private weak var disclosureIndicatorImageView: UIImageView!
    @IBOutlet weak var buyButton: UIButton!
    
    private var drink: (any Drink)?
    
    weak var delegate: DrinkTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buyButton.addTarget(self, action: #selector(buyDrink), for: .touchUpInside)
//        updateLayout()
    }
    
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        if previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
//            updateLayout()
//        }
//    }
//    
//    private func updateLayout() {
//        if traitCollection.preferredContentSizeCategory.isAccessibilityCategory {
//            outerStackView.axis = .vertical
//            outerStackView.alignment = .leading
//            outerStackView.distribution = .equalSpacing
//        } else {
//            outerStackView.axis = .horizontal
//            outerStackView.alignment = .center
//            outerStackView.distribution = .fillProportionally
//        }
//    }
    
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
