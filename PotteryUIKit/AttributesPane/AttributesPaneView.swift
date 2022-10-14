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
    var brushSizeValueChanged: ((Float) -> Void)?
    var speedValueChanged: ((Float) -> Void)?
    
    private var verticalStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpStackView()
        addDiscColorButton()
        addBrushSizeSlider()
        addSpeedSlider()
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
    
    private func addBrushSizeSlider() {
        addSlider(title: "Brush size: ", range: (min: 0.1, max: 10, currentValue: 1), selector: #selector(brushSizeValueChangedSelector(_:)))
    }
    
    private func addSpeedSlider() {
        addSlider(title: "Speed: ", range: (min: 0.01, max: 1, currentValue: 0.1), selector: #selector(speedValueChangedSelector(_:)))
    }
    
    private func addSlider(title: String, range: (min: Float, max: Float, currentValue: Float), selector: Selector) {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        let label = UILabel()
        label.text = title
        label.textColor = .white
        horizontalStackView.addArrangedSubview(label)
        
        let slider = UISlider()
        slider.minimumValue = range.min
        slider.maximumValue = range.max
        slider.value = range.currentValue
        slider.addTarget(self, action: selector, for: .valueChanged)
        horizontalStackView.addArrangedSubview(slider)
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
    
    @objc private func brushSizeValueChangedSelector(_ slider: UISlider) {
        brushSizeValueChanged?(slider.value)
    }
    
    @objc private func speedValueChangedSelector(_ slider: UISlider) {
        speedValueChanged?(slider.value)
    }
}
