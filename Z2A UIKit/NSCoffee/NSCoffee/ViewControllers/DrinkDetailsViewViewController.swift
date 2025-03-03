//
//  DrinkDetailsViewViewController.swift
//  NSCoffee
//
//  Created by Dani on 28/02/2025.
//

import UIKit

final class DrinkDetailsViewViewController: UIViewController {
    @IBOutlet private weak var drinkImageView: UIImageView!
    @IBOutlet private weak var extraShotStackView: UIStackView!
    @IBOutlet private weak var removeShotButton: UIButton!
    @IBOutlet private weak var addShotButton: UIButton!
    @IBOutlet private weak var numberOfShotsLabel: UILabel!
    @IBOutlet private weak var extraPriceLabel: UILabel!
    @IBOutlet private weak var typeOfMilkStackView: UIStackView!
    @IBOutlet private weak var typeOfMilkView: UIView!
    @IBOutlet private weak var typeOfMilkLabel: UILabel!
    @IBOutlet private weak var typeOfMilkIcon: UIImageView!
    @IBOutlet private weak var drinkDescriptionLabel: UILabel!
    
    private let toastView = ToastView.loadFromNib()
    private let buyButton = UIButton(type: .system)
    private let drink: any Drink
    private var extraPrice: Double = 0.0
    private var numberOfShots: Int = 0 {
        didSet {
            updateExtraPrice()
        }
    }
    
    var addDrinkToCart: ((any Drink, Extras?) -> Void)?
    
    init(drink: any Drink) {
        self.drink = drink
        numberOfShots = 0
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
        
        var buyButtonConfiguration = UIButton.Configuration.borderedProminent()
        buyButtonConfiguration.title = String(localized: "buy")
        buyButtonConfiguration.subtitle = CurrencyFormatter.format(drink.basePrice)
        buyButtonConfiguration.image = UIImage(systemName: "cart.fill")
        buyButton.configuration = buyButtonConfiguration
        buyButton.addTarget(self, action: #selector(buyDrink), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buyButton)
        
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
        
        toastView?.configureWithTitle(String(localized: "addedToCart.\(drink.name)"))
        
        updateExtraPrice()
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
    
    @objc
    private func buyDrink() {
        var configuration = buyButton.configuration!
        configuration.showsActivityIndicator = true
        buyButton.configuration = configuration
        
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { timer in
            let numberOfShotsText = self.numberOfShotsText(self.numberOfShots)
            
            configuration.showsActivityIndicator = false
            self.buyButton.configuration = configuration
            self.addDrinkToCart?(self.drink, [(numberOfShotsText, self.extraPrice)])
            self.toastView?.present(inView: self.view)
        }
    }
    
    @IBAction func removeShotPressed(_ sender: Any) {
        guard numberOfShots > 0 else { return }
        numberOfShots -= 1
    }
    
    @IBAction func addShotPressed(_ sender: Any) {
        guard numberOfShots < 4 else { return }
        numberOfShots += 1
    }
    
    private func updateExtraPrice() {
        var buttonConfiguration = buyButton.configuration
        extraPrice = drink.shotPrice * Double(numberOfShots)
        numberOfShotsLabel.text = numberOfShotsText(numberOfShots)
        extraPriceLabel.text = "+ \(CurrencyFormatter.format(extraPrice))"
        buttonConfiguration?.subtitle = CurrencyFormatter.format(drink.basePrice + extraPrice)
        buyButton.configuration = buttonConfiguration
    }
    
    private func numberOfShotsText(_ numberOfShots: Int) -> String {
        return String(localized: "numberShots.\(numberOfShots)")
    }
}
