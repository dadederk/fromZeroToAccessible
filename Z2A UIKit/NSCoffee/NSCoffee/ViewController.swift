//
//  ViewController.swift
//  NSCoffee
//
//  Created by Dani on 28/02/2025.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: DrinkTableViewCell.identifier, bundle: nil)
        let orderButtonView = OrderButtonView.loadFromNib()
        let customRightBarButtonItem = UIBarButtonItem(customView: orderButtonView ?? UIView())
        
        tableView.register(nib, forCellReuseIdentifier: DrinkTableViewCell.identifier)
        
        orderButtonView?.configureWith(numberOfItems: 1)
        
        navigationItem.rightBarButtonItem = customRightBarButtonItem
        
        title = "NSCoffee"
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "DrinkTableViewCell", for: indexPath)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(DrinkDetailsViewViewController(), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
