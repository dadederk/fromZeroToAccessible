//
//  DrinkDetailsViewViewController.swift
//  NSCoffee
//
//  Created by Dani on 28/02/2025.
//

import UIKit

final class DrinkDetailsViewViewController: UIViewController {
    @IBOutlet private weak var drinkImageView: UIImageView!
    @IBOutlet private weak var drinkDescriptionLabel: UILabel!
    
    let drink: Drink
    
    init(drink: Drink) {
        self.drink = drink
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = drink.name
        drinkDescriptionLabel.text = drink.description
        
        if let imageName = drink.imageName {
            drinkImageView.image = UIImage(named: imageName)
            drinkImageView.contentMode = .scaleAspectFill
        }
    }
}
