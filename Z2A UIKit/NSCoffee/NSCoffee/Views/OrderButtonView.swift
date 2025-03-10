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
    
    private var numberOfItems: UInt = 0
    
    var buttonPressed: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        numberOfItems = 0
        
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
        self.numberOfItems = numberOfItems
        
        let numberOfItemsText = "\(numberOfItems)"
        numberOfItemsLabel.text = numberOfItemsText
        
        if numberOfItems == 0 {
            numberOfItemsLabel.isHidden = true
        } else {
            numberOfItemsLabel.isHidden = false
        }
    }
}
