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
    
    private let searchBar = SearchView()
    
    private let tableView = UITableView()
    private let placeholder = UIActivityIndicatorView()
    private let errorLabel = UILabel()
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        viewModel.fetchData()
        showLoadingView()
        
        setupNavBar()
        setupViews()
        setupAppearance()
        setupConstraints()
    }
    
    private func updateUI() {
        viewModel.updateCompletion = { [weak self] errorMessage in
            guard errorMessage == nil else {
                self?.errorLabel.text = errorMessage
                self?.placeholder.stopAnimating()
                return
            }
            self?.tableView.reloadSections(IndexSet(integersIn: 1...2), with: .automatic)
            self?.hideLoadingView()
        }
    }
    
    private func showLoadingView() {
        tableView.isHidden = true
        placeholder.startAnimating()
    }
    private func hideLoadingView() {
        tableView.isHidden = false
        placeholder.stopAnimating()        
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
        let attributedTitle = NSMutableAttributedString(string: HomeViewModel.Constants.title, attributes: attributes)
        let range = (HomeViewModel.Constants.title as NSString).range(of: HomeViewModel.Constants.coloredPartOfTitle)
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
        
        view.addSubview(searchBar)
        searchBar.delegate = self
        
        view.addSubview(placeholder)
        placeholder.hidesWhenStopped = true
        
        view.addSubview(errorLabel)
        errorLabel.font = UIFont.semiBold(with: 16)
        errorLabel.textColor = Resources.Colors.black
        
        view.addSubview(tableView)
        tableView.register(CategoriesCell.self, forCellReuseIdentifier: Resources.CellIdentifier.categories)
        tableView.register(LatestItemsCell.self, forCellReuseIdentifier: Resources.CellIdentifier.latestItems)
        tableView.register(FlashSaleItemsCell.self, forCellReuseIdentifier: Resources.CellIdentifier.flashSaleItems)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
    }
    
    private func setupAppearance() {
        view.backgroundColor = Resources.Colors.background
        tableView.backgroundColor = Resources.Colors.background
    }
    
    private func setupConstraints() {
        [navBarView, profileImage, locationButton, searchBar, placeholder, errorLabel, tableView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
       
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

            searchBar.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 10),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.widthAnchor.constraint(equalToConstant: 262),
            searchBar.heightAnchor.constraint(equalToConstant: 24),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            placeholder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholder.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

// MARK: - UITableViewDataSource

extension HomeController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Resources.CellIdentifier.categories, for: indexPath) as! CategoriesCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Resources.CellIdentifier.latestItems, for: indexPath) as! LatestItemsCell
            cell.setup(with: viewModel.latestItems)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: Resources.CellIdentifier.flashSaleItems, for: indexPath) as! FlashSaleItemsCell
            cell.setup(with: viewModel.flashSaleItems)
            return cell
        default: fatalError("Invalid Section")
        }
    }
}

// MARK: - UITableViewDelegate

extension HomeController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewModel.viewFromHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return tableView.sectionHeaderHeight
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(tableViewWidth: tableView.bounds.width, indexPath)
    }
}

// MARK: - UISearchBarDelegate

extension HomeController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchTextDidChange(searchBar, searchText)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.searchBar.setOffset(false)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        self.searchBar.setOffset(true)
        return true
    }
}



