//
//  ProfileController.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 12.03.2023.
//

import UIKit

final class ProfileController: UIViewController {
    
    private let viewModel: ProfileViewModelProtocol
    
    private let photoView = UIImageView()
    private let changePhotoLabel = UILabel()
    private let nameLabel = UILabel()
    private let uploadPhotoButton = UploadItemButton()
    
    private let tableView = UITableView()
    
    init(viewModel: ProfileViewModelProtocol) {
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
    }
    
    @objc private func uploadItemTapped() {
        viewModel.uploadItemTapped()
    }
    
    private func setupViews() {
        [
            photoView,
            changePhotoLabel,
            nameLabel,
            uploadPhotoButton
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupAppearance() {
        navigationItem.title = Constants.title
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.bold(with: 16)!]
        view.backgroundColor = Resources.Colors.background
        
        photoView.backgroundColor = .gray
        photoView.layer.cornerRadius = 30
        photoView.layer.borderWidth = 1
        photoView.layer.borderColor = Resources.Colors.subTitle.cgColor
        
        changePhotoLabel.text = Constants.changePhoto
        changePhotoLabel.font = UIFont.light(with: 8)
        changePhotoLabel.textColor = Resources.Colors.subTitle
        
        nameLabel.text = "Test"
        nameLabel.textColor = Resources.Colors.title
        nameLabel.font = UIFont.bold(with: 16)
        
        uploadPhotoButton.addTarget(self, action: #selector(uploadItemTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 96.5),
            photoView.widthAnchor.constraint(equalToConstant: 60),
            photoView.heightAnchor.constraint(equalToConstant: 60),
            
            changePhotoLabel.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 8.5),
            changePhotoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: changePhotoLabel.bottomAnchor, constant: 19.6),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            uploadPhotoButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 37.8),
            uploadPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uploadPhotoButton.widthAnchor.constraint(equalToConstant: 290),
            uploadPhotoButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension ProfileController {
    private enum Constants {
        static let title = "Profile"
        static let changePhoto = "Change photo"
        static let uploadItem = "Upload Item"
    }
}
