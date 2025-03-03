//
//  BasketView.swift
//  NSCoffee
//
//  Created by Dani on 28/02/2025.
//

import UIKit

final class BasketView: UIView, NibLoadable {
    @IBOutlet weak var basketTableView: UITableView!
    @IBOutlet weak var buyButton: UIButton!
    
    private var heightConstraint: NSLayoutConstraint!
    private var widthConstraint: NSLayoutConstraint!
    
    private var basket: Basket? {
        didSet {
            basketTableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let orderNib = UINib(nibName: OrderTableViewCell.identifier, bundle: nil)
        
        backgroundColor = UIColor.darkGray.withAlphaComponent(0.95)
        layer.cornerRadius = 10.0

        basketTableView.dataSource = self
        basketTableView.register(orderNib, forCellReuseIdentifier: OrderTableViewCell.identifier)
        
        buyButton.setTitle(String(localized: "buy"), for: .normal)
        buyButton.addTarget(self, action: #selector(handleTapBuyButton), for: .touchUpInside)
        buyButton.alpha = 0.5
        buyButton.isUserInteractionEnabled = false
        
        heightConstraint = heightAnchor.constraint(equalToConstant: 0.0)
        widthConstraint = widthAnchor.constraint(equalToConstant: 0.0)
        
        NSLayoutConstraint.activate([
            heightConstraint,
            widthConstraint
        ])
    }
    
    @objc
    private func handleTapBuyButton() {
        dismiss()
    }
    
    func configure(withBasket basket: Basket) {
        self.basket = basket
        
        if !basket.orders.isEmpty {
            buyButton.alpha = 1.0
            buyButton.isUserInteractionEnabled = true
            buyButton.setTitle("\(CurrencyFormatter.format(basket.totalPrice())) \(String(localized: "buy"))", for: .normal)
        } else {
            buyButton.setTitle(String(localized: "buy"), for: .normal)
        }
    }
    
    func present() {
        self.heightConstraint?.constant = 450.0
        self.widthConstraint?.constant = 300.0
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.25,
            options: .curveEaseIn,
            animations: {
                self.alpha = 1.0
                self.layoutIfNeeded()
            },
            completion: { _ in
                // Presented
            }
            
        )
    }
    
    func dismiss(withAnimation animated: Bool = true) {
        UIView.animate(
            withDuration:animated ? 0.5 : 0.0,
            delay: 0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.25,
            options: .curveEaseOut,
            animations: {
                self.alpha = 0.0
                self.layoutIfNeeded()
            },
            completion: { _ in
                self.heightConstraint?.constant = 0.0
                self.widthConstraint?.constant = 0.0
            }
        )
    }
}

extension BasketView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basket?.orders.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.identifier) as? OrderTableViewCell,
              let order = basket?.orders[indexPath.row]else {
            return UITableViewCell()
        }
        
        cell.configure(withOrder: order)
        
        return cell
    }
}
