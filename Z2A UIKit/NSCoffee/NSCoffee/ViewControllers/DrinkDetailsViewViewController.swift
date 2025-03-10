//
//  DrinkDetailsViewViewController.swift
//  NSCoffee
//
//  Created by Dani on 28/02/2025.
//

import UIKit

final class DrinkDetailsViewViewController: UIViewController {
    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var toolBar: UIToolbar!
    
    private let leadingView = DrinkLeadingView.loadFromNib()!
    private let descriptionView = DescriptionView.loadFromNib()!
    private let extraShotsHeaderView = SectionHeaderView.loadFromNib()!
    private let extraShotsView = ExtraShotsView.loadFromNib()!
    private let rateDrinkHeaderView = SectionHeaderView.loadFromNib()!
    private let rateDrinkView = RaterView()
    private let typeOfMilkHeaderView = SectionHeaderView.loadFromNib()!
    private let typeOfMilkStackView = UIStackView()
    private let toastView = ToastView.loadFromNib()
    private let buyButton = UIButton(type: .system)
    private var buyButtonConfiguration: UIButton.Configuration = {
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.title = String(localized: "buy")
        configuration.image = UIImage(systemName: "cart.fill.badge.plus")
        return configuration
    }()
    
    private let drink: any Drink
    private var extraPrice: Double = 0.0
    private var numberOfShots: Int = 0 {
        didSet {
            updateExtraPrice()
        }
    }
    
    var addDrinkToCart: ((any Drink, [Extra]?) -> Void)?
    
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
        
        mainStackView.addArrangedSubview(leadingView)
        mainStackView.addArrangedSubview(extraShotsHeaderView)
        mainStackView.addArrangedSubview(extraShotsView)
        mainStackView.addArrangedSubview(rateDrinkHeaderView)
        mainStackView.addArrangedSubview(rateDrinkView)
        mainStackView.addArrangedSubview(typeOfMilkHeaderView)
        
        leadingView.configure(imageName: drink.imageName, description: drink.description)
        descriptionView.configureWith(description: drink.description)
        
        extraShotsHeaderView.configure(title: String(localized: "extraShots"))
        extraShotsView.extraShotsUpdated = { [weak self] newValue in
            self?.numberOfShots = newValue
        }
        
        rateDrinkHeaderView.configure(title: String(localized: "rateDrink"))
        
        typeOfMilkHeaderView.configure(title: String(localized: "typeOfMilk"), state: .collapsed(toggleTypesOfMilk))
        typeOfMilkStackView.axis = .vertical
        
        buyButtonConfiguration.subtitle = CurrencyFormatter.format(drink.basePrice)
        buyButton.configuration = buyButtonConfiguration
        buyButton.addTarget(self, action: #selector(buyDrink), for: .touchUpInside)
        buyButton.showsLargeContentViewer = true
        buyButton.addInteraction(UILargeContentViewerInteraction())
        
        toolBar.items = [UIBarButtonItem(customView: buyButton)]
        
        for (index, option) in MilkOptions.allCases.enumerated() {
            guard let view = PickerOptionView.loadFromNib() else { return }
            view.configureWith(option: option.rawValue, state: index == 0) { sender in
                for view in self.typeOfMilkStackView.arrangedSubviews {
                    (view as? PickerOptionView)?.configureState(view == sender)
                }
            }
            typeOfMilkStackView.addArrangedSubview(view)
        }
        
        toastView?.configureWithTitle(String(localized: "addedToCart.\(drink.name)"))
        
        updateExtraPrice()
    }
    
    @objc private func toggleTypesOfMilk() {
        if case .expanded = self.typeOfMilkHeaderView.state {
            self.mainStackView.addArrangedSubview(self.typeOfMilkStackView)
            self.typeOfMilkStackView.isHidden = false
        } else if case .collapsed = self.typeOfMilkHeaderView.state {
            self.mainStackView.removeArrangedSubview(self.typeOfMilkStackView)
            self.typeOfMilkStackView.isHidden = true
        }
    }
    
    @objc
    private func buyDrink() {
        var configuration = buyButton.configuration!
        configuration.showsActivityIndicator = true
        buyButton.configuration = configuration
        
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { timer in
            let numberOfShotsText = String(localized: "numberShots.\(self.numberOfShots)")
            
            configuration.showsActivityIndicator = false
            self.buyButton.configuration = configuration
            self.addDrinkToCart?(self.drink, [Extra(description: numberOfShotsText, price: self.extraPrice, quantity: self.numberOfShots)])
            self.toastView?.present(inView: self.view)
        }
    }
    
    private func updateExtraPrice() {
        var buttonConfiguration = buyButton.configuration
        extraPrice = drink.shotPrice * Double(numberOfShots)
        extraShotsView.configure(numberOfShots: numberOfShots, price: extraPrice)
        
        buttonConfiguration?.subtitle = CurrencyFormatter.format(drink.basePrice + extraPrice)
        buyButton.configuration = buttonConfiguration
        
        buyButton.largeContentTitle = [buttonConfiguration?.title, buttonConfiguration?.subtitle]
            .compactMap { $0 }
            .formatted(.list(type: .and, width: .narrow))
    }
}
