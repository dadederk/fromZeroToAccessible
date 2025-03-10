//
//  DescriptionView.swift
//  NSCoffee
//
//  Created by Dani on 10/03/2025.
//

import UIKit

final class DescriptionView: UIView, NibLoadable {
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateBackground()
    }
    
    @objc
    private func updateBackground() {
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.9)
    }
    
    func configureWith(description: String) {
        descriptionLabel.text = description
    }
}
