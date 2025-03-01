//
//  DrinkTableViewCell.swift
//  NSCoffee
//
//  Created by Dani on 28/02/2025.
//

import UIKit

protocol DrinkTableViewCellDelegate: AnyObject {
    func addDrinkToCart(drink: Drink)
}

final class DrinkTableViewCell: UITableViewCell {
    static let identifier = String(describing: DrinkTableViewCell.self)
    
    @IBOutlet private weak var drinkImageView: UIImageView!
    @IBOutlet private weak var drinkNameLabel: UILabel!
    @IBOutlet private weak var disclosureIndicatorImageView: UIImageView!
    @IBOutlet weak var buyButton: UIButton!
    
    private var drink: Drink?
    
    weak var delegate: DrinkTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buyButton.addTarget(self, action: #selector(buyDrink), for: .touchUpInside)
    }
    
    @objc
    private func buyDrink(_ sender: UIButton) {
        guard let drink = drink else { return }
        guard let delegate = delegate else { return }
        
        delegate.addDrinkToCart(drink: drink)
    }
    
    func configure(with drink: Drink) {
        self.drink = drink
        
        drinkNameLabel.text = drink.name
        
        buyButton.setTitle(String(localized: "buy"), for: .normal)
        
        if let imageName = drink.imageName {
            drinkImageView.image = UIImage(named: imageName)
            drinkImageView.contentMode = .scaleAspectFill
        } else {
            drinkImageView.image = UIImage(systemName: "cup.and.heat.waves.fill")
            drinkImageView.contentMode = .scaleAspectFit
        }
    }
}
