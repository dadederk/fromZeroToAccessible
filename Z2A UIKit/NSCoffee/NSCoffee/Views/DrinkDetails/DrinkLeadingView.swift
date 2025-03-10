//
//  DrinkLeadingView.swift
//  NSCoffee
//
//  Created by Dani on 09/03/2025.
//

import UIKit

final class DrinkLeadingView: UIView, NibLoadable {
    @IBOutlet private weak var leadingImageView: UIImageView!
    
    private let descriptionView = DescriptionView.loadFromNib()!

    override func awakeFromNib() {
        super.awakeFromNib()
        leadingImageView.contentMode = .scaleAspectFill
        
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(descriptionView)
        
        NSLayoutConstraint.activate([
            descriptionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            descriptionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            descriptionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            descriptionView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor)
        ])
    }
    
    func configure(imageName: String?, description: String?) {
        var image = UIImage(systemName: "cup.and.heat.waves.fill")
        
        if let imageName = imageName {
            image = UIImage(named: imageName)
        }
        
        leadingImageView.image = image
        
        if let description = description {
            descriptionView.configureWith(description: description)
            descriptionView.isHidden = false
        } else {
            descriptionView.isHidden = true
        }
    }
}
