//
//  PotteryViewController.swift
//  PotteryUIKit
//
//  Created by Ahmed Khalaf on 08/10/2022.
//

import UIKit

final class PotteryViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var discView: DiscView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        addDiscView()
    }
    
    private func addDiscView() {
        discView = .init()
        discView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(discView)
        
        let equalWidthToSuperviewConstraint = discView.widthAnchor.constraint(equalTo: view.widthAnchor)
        equalWidthToSuperviewConstraint.priority = .defaultHigh
        
        let equalHeitToSuperviewConstraint = discView.heightAnchor.constraint(equalTo: view.heightAnchor)
        equalHeitToSuperviewConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            discView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            discView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            discView.widthAnchor.constraint(equalTo: discView.heightAnchor),
            equalWidthToSuperviewConstraint,
            equalHeitToSuperviewConstraint
        ])
    }
}
