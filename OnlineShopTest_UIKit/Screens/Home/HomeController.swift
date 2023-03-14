//
//  HomeController.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 14.03.2023.
//

import UIKit

final class HomeController: UIViewController {
    
    private let viewModel: HomeViewModelProtocol
    
    private let navBarView = UIView()
    private let profileImage = ProfileImage()
    private let locationButton = LocationButton()
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupViews()
        setupAppearance()
        setupConstraints()
    }
    
    @objc private func locationTapped() {
        print("location tapped")
    }

}

// MARK: - Views Settings

extension HomeController {
    
    private func setupNavBar() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.bold(with: 20)!,
            .foregroundColor: Resources.Colors.title
        ]
        let attributedTitle = NSMutableAttributedString(string: Constants.title, attributes: attributes)
        let range = (Constants.title as NSString).range(of: Constants.coloredPartOfTitle)
        attributedTitle.addAttribute(.foregroundColor, value: Resources.Colors.accentColor, range: range)
        
        let titleLabel = UILabel()
        titleLabel.attributedText = attributedTitle
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel

        navBarView.addSubview(profileImage)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navBarView)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Resources.Images.menu, style: .done, target: nil, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = Resources.Colors.title
    }
    
    private func setupViews() {
        profileImage.image = viewModel.userPhoto
        
        view.addSubview(locationButton)
        locationButton.addTarget(self, action: #selector(locationTapped), for: .touchUpInside)
    }
    
    private func setupAppearance() {
        view.backgroundColor = Resources.Colors.background

    }
    
    private func setupConstraints() {
        [navBarView, profileImage, locationButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
       
        NSLayoutConstraint.activate([
            profileImage.centerXAnchor.constraint(equalTo: navBarView.centerXAnchor),
            profileImage.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 30),
            profileImage.heightAnchor.constraint(equalToConstant: 30),
            
            navBarView.widthAnchor.constraint(equalToConstant: 80),
            
            locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            locationButton.widthAnchor.constraint(equalToConstant: 80),
            locationButton.heightAnchor.constraint(equalToConstant: 15),

        ])
    }
}

// MARK: - Constants

extension HomeController {
    private enum Constants {
        static let title = "Trade by bata"
        static let coloredPartOfTitle = "bata"
    }
}
