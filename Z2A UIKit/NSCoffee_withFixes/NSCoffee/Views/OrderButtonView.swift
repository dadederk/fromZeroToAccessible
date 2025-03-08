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
    
    private var numberOfItems: UInt = 0 {
        didSet {
            /* Fix: By default the Large Content Viewer
             (implemented in a function below) will
             show the button's configuration. In this
             case, the icon. It is important to show
             the number of items in the cart too.
             */
            
            orderButton.largeContentTitle = String(localized: "cartButtonTitle.\(numberOfItems)")
        }
    }
    
    var buttonPressed: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        numberOfItems = 0
        
        numberOfItemsLabel.textColor = .white
        numberOfItemsLabel.isHidden = true
        
        numberOfItemsLabel.layer.cornerRadius = numberOfItemsLabel.frame.height / 2
        numberOfItemsLabel.layer.backgroundColor = UIColor.red.cgColor
        
        orderButton.addTarget(self, action: #selector(handleOrderButtonPressed), for: .touchUpInside)
        
        /* Fix: The button and the label are two accessibility
         elements. It makes more sense to express the value in
         the badge, as an accessibility value of the component
         as a whole. In this case, we are making the label not
         accessible, and configuring the button's accessibilty
         value with the text in the label later when configuring
         the component.
         */
        
        numberOfItemsLabel.isAccessibilityElement = false
        
        /* Fix: Because the button doesn't have a title,
         it also lacks of a meaningful accessibility
         label. In this case we need to configure one
         manually.
         */
        orderButton.accessibilityLabel = String(localized: "cart")
    }
    
    @objc
    private func handleOrderButtonPressed() {
        buttonPressed?()
    }
    
    func configureWith(numberOfItems: UInt) {
        self.numberOfItems = numberOfItems
        
        let numberOfItemsText = "\(numberOfItems)"
        numberOfItemsLabel.text = numberOfItemsText
        
        /* Fix: Configure the accessibility value of the
         order button with the number of items in the
         basket.
         */
        
        if numberOfItems == 0 {
            orderButton.accessibilityValue = nil
            numberOfItemsLabel.isHidden = true
        } else {
            orderButton.accessibilityValue = numberOfItemsText
            numberOfItemsLabel.isHidden = false
        }
    }
    
    /* Fix: Because our bar button item is a custom
      view, it doesn't support the Large Content
      Viewer. Let's fix that, it will allow Large
      Accessibility Size user to tap-and-hold to
      view the content of the button bigger in the
      middle of the screen.
      */
    
    func enableLargeContentViewer(_ enabled: Bool = true) {
        orderButton.showsLargeContentViewer = enabled
        orderButton.addInteraction(UILargeContentViewerInteraction())
    }
}
