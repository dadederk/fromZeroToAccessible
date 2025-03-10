//
//  SectionHeaderView.swift
//  NSCoffee
//
//  Created by Dani on 09/03/2025.
//

import UIKit

enum HeaderState {
    case none
    case expanded(() -> Void)
    case collapsed(() -> Void)
}

final class SectionHeaderView: UIView, NibLoadable {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var stateImageView: UIImageView!
    
    var state: HeaderState = .none

    override func awakeFromNib() {
        super.awakeFromNib()
        
        stateImageView.isHidden = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGestureRecognizer)

    }
    
    func configure(title: String, state: HeaderState = .none) {
        self.state = state
        titleLabel.text = title
        updateState()
    }
    
    @objc
    private func handleTap() {
        switch state {
        case .expanded(let action):
            state = .collapsed(action)
            action()
            updateState()
        case .collapsed(let action):
            state = .expanded(action)
            updateState()
            action()
        case .none: break
        }
    }
    
    private func updateState() {
        switch state {
        case .expanded:
            stateImageView.isHidden = false
            stateImageView.image = UIImage(systemName: "chevron.down")
        case .collapsed:
            stateImageView.isHidden = false
            stateImageView.image = UIImage(systemName: "chevron.up")
        case .none:
            stateImageView.isHidden = true
        }
    }
}
