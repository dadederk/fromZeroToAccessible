//
//  OrderButtonView.swift
//  NSCoffee
//
//  Created by Dani on 28/02/2025.
//

import UIKit

final class OrderButtonView: UIView, NibLoadable {
    @IBOutlet private weak var orderButton: UIButton!
    @IBOutlet private weak var numberOfItemsLabel: UILabel!
    
    var buttonPressed: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        numberOfItemsLabel.textColor = .white
        numberOfItemsLabel.isHidden = true
        
        numberOfItemsLabel.layer.cornerRadius = numberOfItemsLabel.frame.height / 2
        numberOfItemsLabel.layer.backgroundColor = UIColor.red.cgColor
        
        orderButton.addTarget(self, action: #selector(handleOrderButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func handleOrderButtonPressed() {
        buttonPressed?()
    }
    
    func configureWith(numberOfItems: UInt) {
        numberOfItemsLabel.text = "\(numberOfItems)"
        
        if numberOfItems == 0 {
            numberOfItemsLabel.isHidden = true
        } else {
            numberOfItemsLabel.isHidden = false
        }
    }
}
