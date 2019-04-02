//
//  DailyCashController.swift
//  Apple Card
//
//  Created by Richard Witherspoon on 3/30/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

class DailyCashController: UIViewController, TransactionCellDelegate  {
    
    let transactions = [
        Transaction(title: "Bloomingdale's", city: "Chicago", state: "IL", date: "Just now", price: 15.78, image: #imageLiteral(resourceName: "dailyCash")),
        Transaction(title: "South Loop Market", city: "Chicago", state: "IL", date: "Just now", price: 2.71, image: #imageLiteral(resourceName: "dailyCash")),
        Transaction(title: "La Colombe Coffee", city: "Chicago", state: "IL", date: "Just now", price: 0.37, image: #imageLiteral(resourceName: "dailyCash")),
        Transaction(title: "Apple Store", city: "Chicago", state: "IL", date: "Yesterday", price: 17.34, image: #imageLiteral(resourceName: "dailyCash")),
        Transaction(title: "Walgreens", city: "Chicago", state: "IL", date: "Yesterday", price: 1.60, image: #imageLiteral(resourceName: "dailyCash")),
        Transaction(title: "Macys", city: "Chicago", state: "IL", date: "Yesterday", price: 8.47, image: #imageLiteral(resourceName: "dailyCash")),
    ]
    
    func push(indexPath: IndexPath) {
        let destinationVC = TransactionDetailsVC()
        destinationVC.transaction = transactions[indexPath.row]
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let totalPrice = transactions.reduce(0, {$0 + $1.price})
        let tableView = TransactionTableView(frame: view.frame, style: .plain, transactions: transactions)
        let headerView = HeaderView(frame: view.frame, image: #imageLiteral(resourceName: "dailyCash"), title: "Daily Cash", subTitle: "Apple Card")
        let bottomView = BottomView(frame: view.frame, amount: totalPrice)
        let stack = TableStackView(frame: view.frame, table: tableView, title: "March 2019")
        let scrollView = UIScrollView(frame: .zero)
        let tableViewHeight : CGFloat = (CGFloat(transactions.count) * 2.04 * 44.0)
        tableView.mydelegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height - 35)
        view.addSubview(scrollView)
        
        let containerView = UIView()
        containerView.frame = view.bounds
        scrollView.addSubview(containerView)
        
        [headerView, stack, bottomView].forEach({containerView.addSubview($0)})
        view.backgroundColor = UIColor.bgColor
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: (1/5.5)),
            
            stack.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:  -20),
            stack.heightAnchor.constraint(equalToConstant: tableViewHeight),

            bottomView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: (1/6)),
            bottomView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}