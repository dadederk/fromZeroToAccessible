import UIKit

class RaterView: UIView {
    private let stackView = UIStackView()
    
    /* Fix: Setting the image configuration to
     be a symbol configuration with a text style
     will make that symbol scale at the same size
     of a text with that style.
     */
    
    private var icon = UIImage(systemName: "hand.thumbsup", withConfiguration: UIImage.SymbolConfiguration(textStyle: .body))
    private var iconSelected = UIImage(systemName: "hand.thumbsup.fill", withConfiguration: UIImage.SymbolConfiguration(textStyle: .body))
    
    private var maxRate: UInt = 5

    var rating: Int = 0 {
        didSet {
            
            /* Fix: And report the value in a meaningful way
             */
            
            accessibilityValue = String(localized: "thumbsUp.\(rating + 1)")
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    private func setUp() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        NSLayoutConstraint.activate(
            [
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ]
        )

        for _ in 0..<maxRate {
            let ratingButton = UIButton(type: .custom)
            ratingButton.imageView?.contentMode = .scaleAspectFit
            ratingButton.setImage(icon, for: .normal)
            ratingButton.setImage(iconSelected, for: .selected)
            ratingButton.addTarget(self, action: #selector(ratingButtonPressed(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(ratingButton)
        }

        pressButton(at: 0)

        /* Fix: Grouping these buttons together as a single
         element for assistive technologies makes the control
         easier to understand and interact with
         */
        
        isAccessibilityElement = true
        
        /* Fix: We need to add an accessible label to our new
         grouped control
         */
        
        accessibilityLabel = String(localized: "rating")
        
        /* Fix: Adding the adjustable trait allows assistive
         technologies to interact directly with the control.
         In UIKit it requires implementing accessibilityIncrement
         and accessibilityDecrement
         */
        
        accessibilityTraits = UIAccessibilityTraits.adjustable
        
        /* Fix: Hints are optional extra pieces of information
         that can help describe the action of unusual controls
         */
        
        accessibilityHint = String(localized: "ratingHint")

        backgroundColor = .systemBackground
        stackView.backgroundColor = .systemBackground
    }

    @objc
    private func ratingButtonPressed(_ sender: UIButton) {
        var selectedIndex = stackView.arrangedSubviews.count

        for (index, arrangedSubview) in stackView.arrangedSubviews.enumerated() {
            guard let arrangedSubview = arrangedSubview as? UIButton else { break }

            if arrangedSubview == sender {
                selectedIndex = index
                rating = selectedIndex
            }

            if index <= selectedIndex {
                arrangedSubview.isSelected = true
            } else {
                arrangedSubview.isSelected = false
            }
        }
    }
    
    /* Fix: Telling assistive technologies what to do
     when the user increments or decrements the value.
     of the adjustable component.
     */

    override func accessibilityIncrement() {
        guard rating < maxRate - 1 else { return }
        pressButton(at: rating + 1)
    }

    override func accessibilityDecrement() {
        guard rating > 0 else { return }
        pressButton(at: rating - 1)
    }

    private func pressButton(at index: Int) {
        guard let button = button(at: index) else { return }
        ratingButtonPressed(button)
    }

    private func button(at index: Int) -> UIButton? {
        return stackView.arrangedSubviews[index] as? UIButton
    }
}
