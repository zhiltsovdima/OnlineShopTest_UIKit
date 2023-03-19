//
//  ItemStepper.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 19.03.2023.
//

import UIKit

class ItemStepper: UIControl {
    
    struct ViewData {
      let minimum: Int
      let maximum: Int
      let stepValue: Int
    }
    
    private let quantityLabel = UILabel()
    lazy private var plusButton = createStepperButton(image: Resources.Images.plus, value: 1)
    lazy private var minusButton = createStepperButton(image: Resources.Images.minus, value: -1)

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }()
    
    private(set) var value = 1
    private let viewData: ViewData
    
    init(_ viewData: ViewData) {
        self.viewData = viewData
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        plusButton.layer.cornerRadius = 7
        minusButton.layer.cornerRadius = 7
    }
    
    func setup(value: Int) {
        self.value = value
        backgroundColor = Resources.Colors.black
        [quantityLabel, stackView].forEach { addSubview($0) }
        quantityLabel.text = "Quantity: \(value)"
        quantityLabel.font = UIFont.medium(with: 10)
        quantityLabel.textColor = Resources.Colors.subTitle
        
        [minusButton, plusButton].forEach { stackView.addArrangedSubview($0) }
        stackView.spacing = 20
        
        [quantityLabel, stackView, plusButton, minusButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            quantityLabel.topAnchor.constraint(equalTo: topAnchor),
            quantityLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            quantityLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            quantityLabel.bottomAnchor.constraint(lessThanOrEqualTo: stackView.topAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            minusButton.widthAnchor.constraint(equalToConstant: 40),
            minusButton.heightAnchor.constraint(equalToConstant: 22),
            plusButton.widthAnchor.constraint(equalToConstant: 40),
            plusButton.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
    
    private func updateValue(_ stepValue: Int) {
        guard (viewData.minimum...viewData.maximum) ~= (value + stepValue) else { return }
        value += stepValue
        quantityLabel.text = "Quantity: \(value)"
        sendActions(for: .valueChanged)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        updateValue(sender.tag * viewData.stepValue)
    }
    
    private func createStepperButton(image: UIImage?, value: Int) -> UIButton {
        let button = UIButton()
        button.backgroundColor = Resources.Colors.accentColor
        button.setImage(image, for: .normal)
        button.tintColor = Resources.Colors.buttonTitle
        button.tag = value
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.makeSystemAnimation()
        return button
    }
}
