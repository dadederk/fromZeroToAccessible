//
//  ViewController.swift
//  NSCoffee
//
//  Created by Dani on 28/02/2025.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let drinks = Drinks()
    private let orderButtonView = OrderButtonView.loadFromNib()
    
    private var basket = Basket()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let drinkNib = UINib(nibName: DrinkTableViewCell.identifier, bundle: nil)
        let headerNib = UINib(nibName: DrinksHeaderView.identifier, bundle: nil)
        let customRightBarButtonItem = UIBarButtonItem(customView: orderButtonView ?? UIView())
        
        tableView.register(drinkNib, forCellReuseIdentifier: DrinkTableViewCell.identifier)
        tableView.register(headerNib, forCellReuseIdentifier: DrinksHeaderView.identifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        
        title = String(localized: "appName")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = customRightBarButtonItem
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return DrinkType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let drinkType = DrinkType.allCases[section]
        return drinks.drinks(for: drinkType).count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell =  tableView.dequeueReusableCell(withIdentifier: DrinksHeaderView.identifier, for: indexPath) as? DrinksHeaderView
            let drinkType = DrinkType.allCases[indexPath.section]
            
            cell?.configure(withTitle: drinkType.localizedName())
            
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DrinkTableViewCell.identifier, for: indexPath) as? DrinkTableViewCell
            let drinkType = DrinkType.allCases[indexPath.section]
            let drink = drinks.drinks(for: drinkType)[indexPath.row - 1]
            
            cell?.configure(with: drink)
            cell?.delegate = self
            
            return cell ?? UITableViewCell()
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let drinkType = DrinkType.allCases[indexPath.section]
        let drink = drinks.drinks(for: drinkType)[indexPath.row - 1]
        
        navigationController?.pushViewController(DrinkDetailsViewViewController(drink: drink), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: DrinkTableViewCellDelegate {
    func addDrinkToCart(drink: any Drink) {
        if let order = basket.orders.first(where: { $0.drink.name == drink.name }) {
            order.quantity += 1
        } else {
            basket.orders.append(Order(drink: drink))
        }
        
        orderButtonView?.configureWith(numberOfItems: UInt(basket.orders.count))
    }
}
