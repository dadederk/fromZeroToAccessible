//
//  DrinkTableViewCell.swift
//  NSCoffee
//
//  Created by Dani on 28/02/2025.
//

import UIKit

final class DrinkTableViewCell: UITableViewCell {
    static let identifier = String(describing: DrinkTableViewCell.self)
    
    @IBOutlet private weak var drinkImageView: UIImageView!
    @IBOutlet private weak var drinkNameLabel: UILabel!
    @IBOutlet private weak var disclosureIndicatorImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with drink: Drink) {
        drinkNameLabel.text = drink.name
        
        if let imageName = drink.imageName {
            drinkImageView.image = UIImage(named: imageName)
            drinkImageView.contentMode = .scaleAspectFill
        } else {
            drinkImageView.image = UIImage(systemName: "cup.and.heat.waves.fill")
            drinkImageView.contentMode = .scaleAspectFit
        }
    }
}
