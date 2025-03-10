//
//  BasketView.swift
//  NSCoffee
//
//  Created by Dani on 28/02/2025.
//

import UIKit

final class BasketView: UIView, NibLoadable {
    @IBOutlet private weak var basketTableView: UITableView!
    @IBOutlet private weak var buyButton: UIButton!
    @IBOutlet private weak var messageLabel: UILabel!
    
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
        
        /* Fix: If the user configures Reduce
         Transparency, we make the view's
         background opaque.
         */
        
        updateBackground()
        
        layer.cornerRadius = 10.0
        
        basketTableView.dataSource = self
        basketTableView.register(orderNib, forCellReuseIdentifier: OrderTableViewCell.identifier)
        
        buyButton.setTitle(String(localized: "buy"), for: .normal)
        buyButton.addTarget(self, action: #selector(handleTapBuyButton), for: .touchUpInside)
        buyButton.alpha = 0.5
        buyButton.isUserInteractionEnabled = false
        
        messageLabel.text = String(localized: "emptyBasket")
        
        heightConstraint = heightAnchor.constraint(equalToConstant: 0.0)
        widthConstraint = widthAnchor.constraint(equalToConstant: 0.0)
        
        NSLayoutConstraint.activate([
            heightConstraint,
            widthConstraint
        ])
        
        /* Fix: This view will act as a modal view
         for assistive technologies. It avoids the
         cursor, or focus, to move to any sibling
         views.
         */
        
        accessibilityViewIsModal = true
        
        /* Fix: We can also listen to changes in
         accessibility settings, like Reduce
         Transparency, in case the user changes
         them while using the app.
         */
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateBackground), name: UIAccessibility.reduceTransparencyStatusDidChangeNotification, object: nil)
    }
    
    @objc
    private func handleTapBuyButton() {
        dismiss()
    }
    
    @objc
    private func updateBackground() {
        let opacity = UIAccessibility.isReduceTransparencyEnabled ? 1.0 : 0.95
        backgroundColor = UIColor.darkGray.withAlphaComponent(opacity)
    }
    
    func configure(withBasket basket: Basket) {
        self.basket = basket
        
        if basket.orders.isEmpty {
            messageLabel.isHidden = false
            basketTableView.isHidden = true
            buyButton.setTitle(String(localized: "buy"), for: .normal)
        } else {
            messageLabel.isHidden = true
            basketTableView.isHidden = false
            buyButton.alpha = 1.0
            buyButton.isUserInteractionEnabled = true
            buyButton.setTitle("\(CurrencyFormatter.format(basket.totalPrice)) \(String(localized: "buy"))", for: .normal)
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
                
                /* Fix: In the case that the user has
                 Reduce Motion enabled and prefers cross-fade
                 transitions, we change the animation so
                 the view just fades in.
                 */
                
                if !UIAccessibility.prefersCrossFadeTransitions {
                    self.layoutIfNeeded()
                }
            },
            completion: { _ in
                /* Fix: Notify assistive tech that the
                 screen has changed. The cursor will move
                 to the argument, in this case self, and
                 VoiceOver users will get a sound indicating
                 that they've been presented a new screen.
                 */
                UIAccessibility.post(notification: .screenChanged, argument: self)
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
                
                UIAccessibility.post(notification: .screenChanged, argument: self.superview)
            }
        )
    }
    
    /* Fix: Provides an easy way to "go back"
     with some assistive technologies. For
     example, "draw a Z" with two fingers with
     VoiceOver to execute it.
     */
    
    override func accessibilityPerformEscape() -> Bool {
        dismiss()
        return true
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
