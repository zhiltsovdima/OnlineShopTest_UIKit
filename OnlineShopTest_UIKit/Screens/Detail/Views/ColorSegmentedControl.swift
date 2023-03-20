//
//  ColorSegmentedControl.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 20.03.2023.
//

import UIKit

final class ColorSegmentedControl: UIControl {
    
    private let stackView = UIStackView()
    private var buttons = [UIButton]()
    private var selectedSegmentIndex = 0
    var isSetup = false
    
    func setup(withColors colors: [UIColor]) {
        colors.forEach {
            let button = createButton(color: $0)
            buttons.append(button)
        }
        buttons[selectedSegmentIndex].layer.borderWidth = 3
        buttons[selectedSegmentIndex].layer.borderColor = Resources.Colors.selectedColor.cgColor
        
        setupStackView()
        isSetup = true
    }
    
    private func createButton(color: UIColor) -> UIButton {
        let button = UIButton()
        button.backgroundColor = color
        button.layer.cornerRadius = 7
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }
    
    private func setupStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.spacing = 15
        
        buttons.forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalToConstant: 32).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 24).isActive = true
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else { return }
        setSelectedSegmentIndex(buttonIndex)
        sendActions(for: .valueChanged)
    }
    
    private func setSelectedSegmentIndex(_ index: Int) {
        if selectedSegmentIndex == index { return }
        
        buttons[selectedSegmentIndex].layer.borderColor = Resources.Colors.black.cgColor
        buttons[selectedSegmentIndex].layer.borderWidth = 0.3
        selectedSegmentIndex = index
        buttons[selectedSegmentIndex].layer.borderWidth = 2
        buttons[selectedSegmentIndex].layer.borderColor = Resources.Colors.selectedColor.cgColor
    }
}
