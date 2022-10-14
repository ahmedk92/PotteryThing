//
//  AttributesPaneView.swift
//  PotteryUIKit
//
//  Created by Ahmed Khalaf on 15/10/2022.
//

import UIKit

final class AttributesPaneView: UIView {
    
    var didTapDiscColorButton: (() -> Void)?
    
    private var verticalStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpStackView()
        addDiscColorButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpStackView() {
        verticalStackView = UIStackView()
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(verticalStackView)
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            verticalStackView.topAnchor.constraint(equalTo: topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func addDiscColorButton() {
        let button = UIButton()
        button.setTitle("Disc color", for: .normal)
        verticalStackView.addArrangedSubview(button)
        button.addTarget(self, action: #selector(discColorButtonTapped), for: .touchUpInside)
    }
    
    @objc private func discColorButtonTapped() {
        didTapDiscColorButton?()
    }
}
