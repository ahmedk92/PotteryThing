//
//  PotteryViewController.swift
//  PotteryUIKit
//
//  Created by Ahmed Khalaf on 08/10/2022.
//

import UIKit

final class PotteryViewController: UIViewController, UIColorPickerViewControllerDelegate {
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
        addAttributesPaneView()
    }
    
    private enum ColorPickerContext {
        case disc, brush
    }
    
    private var colorPickerContext: ColorPickerContext?
    
    private func addAttributesPaneView() {
        let attributesPanView = AttributesPaneView()
        attributesPanView.didTapDiscColorButton = { [weak self] in
            self?.colorPickerContext = .disc
            self?.showColorPicker()
        }
        attributesPanView.didTapBrushColorButton = { [weak self] in
            self?.colorPickerContext = .brush
            self?.showColorPicker()
        }
        attributesPanView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(attributesPanView)
        
        NSLayoutConstraint.activate([
            attributesPanView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            attributesPanView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            attributesPanView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func showColorPicker() {
        let colorPickerViewController = UIColorPickerViewController()
        colorPickerViewController.delegate = self
        present(colorPickerViewController, animated: true)
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
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        switch colorPickerContext {
        case .brush:
            discView.brushColor = color
        case .disc:
            discView.discColor = color
        default:
            break
        }
    }
}
