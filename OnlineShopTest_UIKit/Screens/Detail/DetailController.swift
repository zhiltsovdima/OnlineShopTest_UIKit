//
//  DetailController.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 19.03.2023.
//

import UIKit

final class DetailController: UIViewController {
    
    private let viewModel: DetailViewModelProtocol
    
    private let addingToCartView = UIView()
    private let itemStepper = ItemStepper(ItemStepper.ViewData(minimum: 1, maximum: 100, stepValue: 1))
    private let addToCartButton = UIButton()
    
    init(_ viewModel: DetailViewModelProtocol) {
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
    
    private func setupViews() {
        view.addSubview(addingToCartView)
        [itemStepper, addToCartButton].forEach { addingToCartView.addSubview($0)}
        itemStepper.setup(value: 1)
    }
    
    private func setupAppearance() {
        view.backgroundColor = Resources.Colors.background
        
        addingToCartView.layer.cornerRadius = 30
        addingToCartView.backgroundColor = Resources.Colors.black
        
        addToCartButton.backgroundColor = Resources.Colors.accentColor
        addToCartButton.layer.cornerRadius = 15
        addToCartButton.makeSystemAnimation()
    }
    
    private func setupConstraints() {
        [addingToCartView, itemStepper, addToCartButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            addingToCartView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            addingToCartView.widthAnchor.constraint(equalTo: view.widthAnchor),
            addingToCartView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            
            itemStepper.topAnchor.constraint(equalTo: addToCartButton.topAnchor),
            itemStepper.leadingAnchor.constraint(equalTo: addingToCartView.leadingAnchor, constant: 23),
            itemStepper.heightAnchor.constraint(equalTo: addToCartButton.heightAnchor),
            
            addToCartButton.topAnchor.constraint(equalTo: addingToCartView.topAnchor, constant: 19),
            addToCartButton.leadingAnchor.constraint(equalTo: addingToCartView.centerXAnchor),
            addToCartButton.trailingAnchor.constraint(equalTo: addingToCartView.trailingAnchor, constant: -23),
            addToCartButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
}
