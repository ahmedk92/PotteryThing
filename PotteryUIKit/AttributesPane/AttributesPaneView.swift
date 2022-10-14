//
//  AttributesPaneView.swift
//  PotteryUIKit
//
//  Created by Ahmed Khalaf on 15/10/2022.
//

import UIKit

final class AttributesPaneView: UIView {
    
    var didTapDiscColorButton: (() -> Void)?
    var didTapBrushColorButton: (() -> Void)?
    
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
        verticalStackView.axis = .vertical
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
        addButton(title: "Disc color", selector: #selector(discColorButtonTapped))
        addButton(title: "Brush color", selector: #selector(brushColorButtonTapped))
    }
    
    private func addButton(title: String, selector: Selector) {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        verticalStackView.addArrangedSubview(button)
        button.addTarget(self, action: selector, for: .touchUpInside)
    }
    
    @objc private func discColorButtonTapped() {
        didTapDiscColorButton?()
    }
    
    @objc private func brushColorButtonTapped() {
        didTapBrushColorButton?()
    }
}
