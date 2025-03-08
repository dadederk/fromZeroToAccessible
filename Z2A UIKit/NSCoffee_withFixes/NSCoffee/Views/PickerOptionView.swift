//
//  PickerOptionView.swift
//  NSCoffee
//
//  Created by Dani on 02/03/2025.
//

import UIKit

final class PickerOptionView: UIView, NibLoadable {
    @IBOutlet private weak var selectionIconImageView: UIImageView!
    @IBOutlet private weak var optionLabel: UILabel!
    
    private var state: Bool = false {
        didSet {
            if state {
                selectionIconImageView.image = UIImage(systemName: "checkmark.circle.fill")
            } else {
                selectionIconImageView.image = UIImage(systemName: "circle")
            }
        }
    }
    
    private var toggled: ((PickerOptionView) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionIconImageView.image = UIImage(systemName: "circle")
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    func configureWith(option: String, state: Bool, toggled: @escaping (PickerOptionView) -> Void) {
        optionLabel.text = option
        self.toggled = toggled
        self.state = state
    }
    
    func configureState(_ state: Bool) {
        self.state = state
    }
    
    @objc
    private func handleTap() {
        toggled?(self)
    }
}
