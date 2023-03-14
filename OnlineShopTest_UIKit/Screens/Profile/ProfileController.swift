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
        
        updateUI()
        setupViews()
        setupAppearance()
        setupConstraints()
    }
    
    func updateUI() {
        viewModel.updateImageCompletion = { [weak self] image in
            self?.photoView.image = image
        }
    }
    
    @objc private func uploadItemTapped() {
        viewModel.uploadItemTapped()
    }
}

// MARK: - Views Settings

extension ProfileController {
    
    private func setupViews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileCell.self, forCellReuseIdentifier: Resources.CellIdentifier.profile)
        tableView.rowHeight = Constants.rowHeigh
        
        [photoView, changePhotoLabel, nameLabel, uploadPhotoButton, tableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupAppearance() {
        navigationItem.title = Constants.title
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.bold(with: 16)!]
        view.backgroundColor = Resources.Colors.background
        
        photoView.image = viewModel.userPhoto
        photoView.contentMode = .scaleAspectFill
        photoView.layer.cornerRadius = 30
        photoView.layer.borderWidth = 1
        photoView.layer.borderColor = Resources.Colors.subTitle.cgColor
        photoView.clipsToBounds = true
        
        changePhotoLabel.text = Constants.changePhoto
        changePhotoLabel.font = UIFont.light(with: 8)
        changePhotoLabel.textColor = Resources.Colors.subTitle
        
        nameLabel.text = viewModel.userName
        nameLabel.textColor = Resources.Colors.title
        nameLabel.font = UIFont.bold(with: 16)
        
        uploadPhotoButton.addTarget(self, action: #selector(uploadItemTapped), for: .touchUpInside)
        
        tableView.backgroundColor = Resources.Colors.background
        tableView.separatorStyle = .none
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            photoView.widthAnchor.constraint(equalToConstant: 60),
            photoView.heightAnchor.constraint(equalToConstant: 60),
            
            changePhotoLabel.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 8.5),
            changePhotoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: changePhotoLabel.bottomAnchor, constant: 19.6),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            uploadPhotoButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 37.8),
            uploadPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uploadPhotoButton.widthAnchor.constraint(equalToConstant: 290),
            uploadPhotoButton.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: uploadPhotoButton.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }
}

// MARK: - UITableViewDataSource

extension ProfileController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cellViewModel(for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.CellIdentifier.profile, for: indexPath) as! ProfileCell
        cell.setup(with: cellViewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ProfileController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Constants

extension ProfileController {
    private enum Constants {
        static let title = "Profile"
        static let changePhoto = "Change photo"
        static let uploadItem = "Upload Item"
        
        static let rowHeigh: CGFloat = 60
    }
}
