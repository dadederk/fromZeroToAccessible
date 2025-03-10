//
//  ExtraShotsView.swift
//  NSCoffee
//
//  Created by Dani on 09/03/2025.
//

import UIKit

final class ExtraShotsView: UIView, NibLoadable {
    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var stepperStackView: UIStackView!
    @IBOutlet private weak var removeShotButton: UIButton!
    @IBOutlet private weak var addShotButton: UIButton!
    @IBOutlet private weak var numberOfShotsLabel: UILabel!
    @IBOutlet private weak var extraPriceLabel: UILabel!
    
    private var numberOfShots = 0
    
    var extraShotsUpdated: (Int) -> Void = { _ in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(numberOfShots: Int, price: Double) {
        self.numberOfShots = numberOfShots
        numberOfShotsLabel.text = String(localized: "numberShots.\(numberOfShots)")
        extraPriceLabel.text = "+ \(CurrencyFormatter.format(price))"
    }
    
    @IBAction func removeShotPressed(_ sender: Any) {
        decreaseNumberOfShots()
    }
    
    @IBAction func addShotPressed(_ sender: Any) {
        increaseNumberOfShots()
    }
    
    private func increaseNumberOfShots() {
        guard numberOfShots < 4 else { return }
        numberOfShots += 1
        extraShotsUpdated(numberOfShots)
    }
    
    private func decreaseNumberOfShots() {
        guard numberOfShots > 0 else { return }
        numberOfShots -= 1
        extraShotsUpdated(numberOfShots)
    }
}
