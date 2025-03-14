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
    private let basketView = BasketView.loadFromNib()
    
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
        
        if let basketView = basketView {
            view.addSubview(basketView)
            basketView.alpha = 0.0
            basketView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                basketView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                basketView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        }
        
        if let orderButtonView = orderButtonView {
            orderButtonView.buttonPressed = {
                if self.basketView?.alpha == 0.0 {
                    self.basketView?.present()
                } else {
                    self.basketView?.dismiss()
                }
            }
            
            orderButtonView.enableLargeContentViewer()
        }
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
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard indexPath.row - 1 >= 0 else { return nil }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let drinkType = DrinkType.allCases[indexPath.section]
        let drink = drinks.drinks(for: drinkType)[indexPath.row - 1]
        let drinkDetailsViewController = DrinkDetailsViewViewController(drink: drink)
        
        drinkDetailsViewController.addDrinkToCart = { drink, extras in
            self.addOrderToCart(Order(drink: drink, quantity: 1, extras: extras))
        }
        
        navigationController?.pushViewController(drinkDetailsViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
        basketView?.dismiss()
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        basketView?.dismiss(withAnimation: false)
    }
}

extension ViewController: DrinkTableViewCellDelegate {
    func addOrderToCart(_ order: Order) {
        if let index = basket.orders.firstIndex(where: {
            $0.drink.name == order.drink.name &&
            $0.extras == order.extras }) {
            let existingOrder = basket.orders[index]
            order.quantity = existingOrder.quantity + 1
            basket.orders[index] = order
        } else {
            basket.orders.append(order)
        }
        
        orderButtonView?.configureWith(numberOfItems: UInt(basket.orders.reduce(into: 0) { $0 += $1.quantity }))
        basketView?.configure(withBasket: basket)
    }
}
