//
//  DrinkDetailsViewViewController.swift
//  NSCoffee
//
//  Created by Dani on 28/02/2025.
//

import UIKit

final class DrinkDetailsViewViewController: UIViewController {
    @IBOutlet private weak var drinkImageView: UIImageView!
    @IBOutlet weak var extraShotStackView: UIStackView!
    @IBOutlet weak var removeShotButton: UIButton!
    @IBOutlet weak var addShotButton: UIButton!
    @IBOutlet weak var numberOfShotsLabel: UILabel!
    @IBOutlet weak var extraPriceLabel: UILabel!
    @IBOutlet private weak var typeOfMilkStackView: UIStackView!
    @IBOutlet private weak var typeOfMilkView: UIView!
    @IBOutlet private weak var typeOfMilkLabel: UILabel!
    @IBOutlet private weak var typeOfMilkIcon: UIImageView!
    @IBOutlet private weak var drinkDescriptionLabel: UILabel!
    
    private let drink: Drink
    private var numberOfShots: Int = 1 {
        didSet {
            numberOfShotsLabel.text = String(localized: "numberShots.\(numberOfShots)")
        }
    }
    
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
        typeOfMilkLabel.text = String(localized: "typeOfMilk")
        
        if let imageName = drink.imageName {
            drinkImageView.image = UIImage(named: imageName)
            drinkImageView.contentMode = .scaleAspectFill
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleTypesOfMilk))
        typeOfMilkView.addGestureRecognizer(tapGestureRecognizer)
        
        for (index, option) in MilkOptions.allCases.enumerated() {
            guard let view = PickerOptionView.loadFromNib() else { return }
            view.configureWith(option: option.rawValue, state: index == 0) { sender in
                for view in self.typeOfMilkStackView.arrangedSubviews {
                    (view as? PickerOptionView)?.configureState(view == sender)
                }
            }
            typeOfMilkStackView.addArrangedSubview(view)
            view.isHidden = true
            view.alpha = 0
        }
    }
    
    @objc private func toggleTypesOfMilk() {
        guard let isExpanded = typeOfMilkStackView.arrangedSubviews.last?.isHidden else { return }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.typeOfMilkIcon.transform = isExpanded
            ? CGAffineTransform(rotationAngle: .pi / 2)
            : CGAffineTransform.identity
        })
        
        UIView.animate(withDuration: 0.3) {
            for view in self.typeOfMilkStackView.arrangedSubviews.dropFirst() {
                view.isHidden.toggle()
            }
        }
        
        UIView.animate(withDuration: 0.2, delay: isExpanded ? 0.2 : 0.0) {
            for view in self.typeOfMilkStackView.arrangedSubviews.dropFirst() {
                view.alpha = isExpanded ? 1 : 0
            }
        }
    }
    
    @IBAction func removeShotPressed(_ sender: Any) {
        guard numberOfShots > 1 else { return }
        numberOfShots -= 1
    }
    
    @IBAction func addShotPressed(_ sender: Any) {
        guard numberOfShots < 5 else { return }
        numberOfShots += 1
    }
}
