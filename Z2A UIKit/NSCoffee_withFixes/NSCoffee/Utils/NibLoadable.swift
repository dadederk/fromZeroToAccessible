import UIKit

protocol NibLoadable: AnyObject {
    static func loadFromNib() -> Self?
    static func loadFromNib(withName name: String) -> Self?
}

extension NibLoadable where Self: UIView {
    static func loadFromNib() -> Self? {
        let viewClassName = String(describing: self)

        return loadFromNib(withName: viewClassName)
    }

    static func loadFromNib(withName name: String) -> Self? {
        let bundle = Bundle(for: self)
        let views = bundle.loadNibNamed(name, owner: nil, options: nil)
        let firstView = views?.first

        return firstView as? Self
    }
}
