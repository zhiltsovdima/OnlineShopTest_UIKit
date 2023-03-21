//
//  LogInController.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 11.03.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class LogInController: UIViewController {
    
    private let viewModel: LogInViewModelProtocol
    
    private let disposeBag = DisposeBag()
    
    private let titleLabel = UILabel()
    private let firstNameTextField = UITextField()
    private let passwordTextField = PasswordTextField()
    private let errorMessage = UILabel()
    private let logInButton = UIButton()
    
    init(viewModel: LogInViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupAppearance()
        setupConstraints()
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        firstNameTextField.layer.cornerRadius = firstNameTextField.frame.height / 2
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 2
        logInButton.layer.cornerRadius = logInButton.frame.height / 2
    }
    
    private func bind() {
        viewModel.errorMessageRelay
            .bind(to: errorMessage.rx.text)
            .disposed(by: disposeBag)
    }
    
    @objc private func logInTapped() {
        viewModel.logInTapped(name: firstNameTextField.text, password: passwordTextField.text)
    }
    @objc private func backToHome() {
        viewModel.backToLogIn()
    }
    @objc private func handleTap() {
        view.endEditing(true)
    }
}

// MARK: - Views Settings

extension LogInController {

    private func setupViews() {
        [
            titleLabel,
            firstNameTextField,
            passwordTextField,
            logInButton,
            errorMessage
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupAppearance() {
        let leftBarButton = UIBarButtonItem(image: Resources.Images.back, style: .done, target: self, action: #selector(backToHome))
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.leftBarButtonItem?.tintColor = Resources.Colors.black
        view.backgroundColor = Resources.Colors.background
        titleLabel.font = UIFont.bold(with: 27.0)
        titleLabel.textColor = Resources.Colors.title
        titleLabel.text = Constants.welcome
        titleLabel.textAlignment = .center
        
        firstNameTextField.backgroundColor = Resources.Colors.textFieldBack
        firstNameTextField.font = UIFont.regular(with: 12)
        firstNameTextField.textColor = Resources.Colors.black
        firstNameTextField.textAlignment = .center
        firstNameTextField.placeholder = Constants.firstNamePlaceholder
        
        passwordTextField.backgroundColor = Resources.Colors.textFieldBack
        passwordTextField.font = UIFont.regular(with: 12)
        passwordTextField.textColor = Resources.Colors.black
        passwordTextField.textAlignment = .center
        passwordTextField.placeholder = Constants.passwordPlaceholder
        
        logInButton.backgroundColor = Resources.Colors.accentColor
        logInButton.titleLabel?.font = UIFont.bold(with: 15)
        logInButton.setTitleColor(Resources.Colors.buttonTitle, for: .normal)
        logInButton.setTitle(Constants.logIn, for: .normal)
        logInButton.makeSystemAnimation()
        logInButton.addTarget(self, action: #selector(logInTapped), for: .touchUpInside)
        
        errorMessage.textColor = .red
        errorMessage.font = UIFont.regular(with: 12)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 158),
            
            errorMessage.bottomAnchor.constraint(equalTo: firstNameTextField.topAnchor, constant: -20),
            errorMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            firstNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 77),
            firstNameTextField.widthAnchor.constraint(equalToConstant: 289),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 29),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 35),
            passwordTextField.widthAnchor.constraint(equalToConstant: 289),
            passwordTextField.heightAnchor.constraint(equalToConstant: 29),
            
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 99),
            logInButton.widthAnchor.constraint(equalToConstant: 289),
            logInButton.heightAnchor.constraint(equalToConstant: 46)
        ])
    }
}

// MARK: - Constants

extension LogInController {
    
    private enum Constants {
        static let welcome = "Welcome back"
        static let logIn = "Log in"
        static let firstNamePlaceholder = "First Name"
        static let passwordPlaceholder = "Password"
    }
}
