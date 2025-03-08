import UIKit

class RaterView: UIView {
    private let stackView = UIStackView()
    private var icon = UIImage(systemName: "hand.thumbsup")
    private var iconSelected = UIImage(systemName: "hand.thumbsup.fill")

    private var maxRate: UInt = 5

    var rating: Int = 0 {
        didSet {
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

    private func pressButton(at index: Int) {
        guard let button = button(at: index) else { return }
        ratingButtonPressed(button)
    }

    private func button(at index: Int) -> UIButton? {
        return stackView.arrangedSubviews[index] as? UIButton
    }
}
