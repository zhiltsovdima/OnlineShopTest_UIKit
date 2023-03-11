//
//  SignInController.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 10.03.2023.
//

import UIKit
import RxSwift
import RxCocoa

class SignInController: UIViewController {
    
    private let viewModel: SignInViewModelProtocol
    private let disposeBag = DisposeBag()
    
    private let titleLabel = UILabel()
    private let firstNameTextField = UITextField()
    private let lastNameTextField = UITextField()
    private let emailTextField = UITextField()
    private let signInButton = UIButton()
    private let logInStackView = UIStackView()
    private let alreadyHaveLabel = UILabel()
    private let logInButton = UIButton()
    private let signInGoogle = SignInWithButton()
    private let sigInApple = SignInWithButton()
    private let errorMessage = UILabel()
    
    init(viewModel: SignInViewModelProtocol) {
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
        lastNameTextField.layer.cornerRadius = lastNameTextField.frame.height / 2
        emailTextField.layer.cornerRadius = emailTextField.frame.height / 2
        signInButton.layer.cornerRadius = signInButton.frame.height / 2
    }
    
    
    
    private func bind() {
        viewModel.errorMessageRelay
            .bind(to: errorMessage.rx.text)
            .disposed(by: disposeBag)
    }
    
    @objc private func signInTapped() {
        viewModel.signInTapped(firstName: firstNameTextField.text,
                               lastName: lastNameTextField.text,
                               email: emailTextField.text)
    }
    
    @objc private func logInTapped() {
        viewModel.logInTapped()
    }
    
}

// MARK: - Views Settings

extension SignInController {

    private func setupViews() {
        [
            titleLabel,
            firstNameTextField,
            lastNameTextField,
            emailTextField,
            signInButton,
            logInStackView,
            sigInApple,
            signInGoogle,
            errorMessage
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        [ alreadyHaveLabel, logInButton].forEach { logInStackView.addArrangedSubview($0) }
        logInStackView.axis = .horizontal
        logInStackView.spacing = 5
        alreadyHaveLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func setupAppearance() {
        view.backgroundColor = Resources.Colors.background
        titleLabel.font = UIFont.bold(with: 27.0)
        titleLabel.textColor = Resources.Colors.title
        titleLabel.text = Constants.signIn
        titleLabel.textAlignment = .center
        
        firstNameTextField.backgroundColor = Resources.Colors.textFieldBack
        firstNameTextField.font = UIFont.regular(with: 12)
        firstNameTextField.textColor = Resources.Colors.black
        firstNameTextField.textAlignment = .center
        firstNameTextField.placeholder = Constants.firstNamePlaceholder
        
        lastNameTextField.backgroundColor = Resources.Colors.textFieldBack
        lastNameTextField.font = UIFont.regular(with: 12)
        lastNameTextField.textColor = Resources.Colors.black
        lastNameTextField.textAlignment = .center
        lastNameTextField.placeholder = Constants.lastNamePlaceholder
        
        emailTextField.backgroundColor = Resources.Colors.textFieldBack
        emailTextField.font = UIFont.regular(with: 12)
        emailTextField.textColor = Resources.Colors.black
        emailTextField.textAlignment = .center
        emailTextField.placeholder = Constants.emailPlaceholder
        emailTextField.keyboardType = .emailAddress

        signInButton.backgroundColor = Resources.Colors.accentColor
        signInButton.titleLabel?.font = UIFont.bold(with: 15)
        signInButton.setTitleColor(Resources.Colors.buttonTitle, for: .normal)
        signInButton.setTitle(Constants.signIn, for: .normal)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        signInButton.makeSystemAnimation()
        
        alreadyHaveLabel.font = UIFont.regular(with: 10)
        alreadyHaveLabel.text = Constants.alreadyHave
        alreadyHaveLabel.textColor = Resources.Colors.subTitle
        
        logInButton.setTitle(Constants.logIn, for: .normal)
        logInButton.titleLabel?.font = UIFont.regular(with: 10)
        logInButton.setTitleColor(Resources.Colors.tappableText, for: .normal)
        logInButton.backgroundColor = Resources.Colors.background
        logInButton.addTarget(self, action: #selector(logInTapped), for: .touchUpInside)
        logInButton.makeSystemAnimation()
        
        signInGoogle.setup(with: Resources.Images.googleLogo, text: Constants.signInWithGoogle)
        signInGoogle.makeSystemAnimation()
        sigInApple.setup(with: Resources.Images.appleLogo, text: Constants.signInWithApple)
        sigInApple.makeSystemAnimation()
        
        errorMessage.textColor = .red
        errorMessage.font = UIFont.regular(with: 12)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 158),
            
            errorMessage.bottomAnchor.constraint(equalTo: firstNameTextField.topAnchor, constant: -20),
            errorMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            firstNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 77),
            firstNameTextField.widthAnchor.constraint(equalToConstant: 289),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 29),
            
            lastNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 35),
            lastNameTextField.widthAnchor.constraint(equalToConstant: 289),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 29),
            
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 35),
            emailTextField.widthAnchor.constraint(equalToConstant: 289),
            emailTextField.heightAnchor.constraint(equalToConstant: 29),
            
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 35),
            signInButton.widthAnchor.constraint(equalToConstant: 289),
            signInButton.heightAnchor.constraint(equalToConstant: 46),
            
            logInStackView.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 17),
            logInStackView.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
            
            sigInApple.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -133),
            sigInApple.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 99),
            
            signInGoogle.bottomAnchor.constraint(equalTo: sigInApple.topAnchor, constant: -38),
            signInGoogle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 99),
        ])
    }
}

// MARK: - Constants

extension SignInController {
    
    private enum Constants {
        static let signIn = "Sign in"
        static let alreadyHave = "Already have an account?"
        static let logIn = "Log in"
        static let firstNamePlaceholder = "First Name"
        static let lastNamePlaceholder = "Last Name"
        static let emailPlaceholder = "Email"
        static let signInWithApple = "Sign in with Apple"
        static let signInWithGoogle = "Sign in with Google"
    }
}

