//
//  PasswordTextField.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 12.03.2023.
//

import UIKit

final class PasswordTextField: UITextField {

    private let showPasswordButton = UIButton()
    override var isSecureTextEntry: Bool {
        didSet {
            if isSecureTextEntry {
                showPasswordButton.setImage(Resources.Images.hidePassword, for: .normal)
            } else {
                showPasswordButton.setImage(Resources.Images.showPassword, for: .normal)
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let rightPadding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: showPasswordButton.frame.width + 10)
        rightView?.frame = CGRect(x: frame.width - rightPadding.right, y: 0, width: showPasswordButton.frame.width, height: frame.height)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
        
    private func setupView() {
        isSecureTextEntry = true
        showPasswordButton.imageView?.tintColor = Resources.Colors.textFieldPlaceholder
        showPasswordButton.addTarget(self, action: #selector(showPasswordButtonTapped), for: .touchUpInside)
        
        rightViewMode = .always
        rightView = showPasswordButton
    }

    @objc private func showPasswordButtonTapped() {
        isSecureTextEntry.toggle()
    }
}
