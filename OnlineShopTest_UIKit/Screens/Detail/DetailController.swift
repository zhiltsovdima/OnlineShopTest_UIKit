//
//  DetailController.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 19.03.2023.
//

import UIKit

final class DetailController: UIViewController {
    
    private let viewModel: DetailViewModelProtocol
    
    private let imagesView = ImagesView()
    private let favoriteShareView = FavoriteShareView()
    
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()
    
    private let ratingStackView = UIStackView()
    private let ratingIcon = UIImageView(image: Resources.Images.rating)
    private let ratingLabel = UILabel()
    private let reviewsLabel = UILabel()
    
    private let colorLabel = UILabel()
    private let colorsSegments = ColorSegmentedControl()
    
    private let addingToCartView = UIView()
    private let itemStepper = ItemStepper(ItemStepper.ViewData(minimum: 1, maximum: 100, stepValue: 1))
    private let addToCartButton = AddToCartButton()
    
    init(_ viewModel: DetailViewModelProtocol) {
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
                
        setupViews()
        setupAppearance()
        setupConstraints()
    }
    
    private func updateUI() {
        viewModel.updateCompletion = { [weak self] in
            guard let self, let detailData = self.viewModel.detailData else { return }
            self.nameLabel.text = detailData.name
            self.descriptionLabel.text = detailData.description
            self.priceLabel.text = detailData.price
            self.ratingLabel.text = detailData.rating
            self.reviewsLabel.text = detailData.reviews
            self.addToCartButton.priceLabel.text = detailData.fullPrice
            if !self.colorsSegments.isSetup {
                self.colorsSegments.setup(withColors: detailData.colors ?? [])
            }
        }
        viewModel.updateImagesCompletion = { [weak self] in
            guard let self, let images = self.viewModel.detailData?.images else { return }
            self.imagesView.updateUI(with: images)
        }
    }
    
    @objc private func backToHome() {
        viewModel.backToHome()
    }
    @objc private func stepperValueChanged() {
        viewModel.stepperValueChanged(itemStepper.value)
    }
    @objc private func colorSelected() {
    }
    
}

// MARK: - Views Settings

extension DetailController {
    
    private func setupViews() {
        [imagesView, favoriteShareView, nameLabel, priceLabel, descriptionLabel, ratingStackView, colorLabel, colorsSegments, addingToCartView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        [ratingIcon, ratingLabel, reviewsLabel].forEach { ratingStackView.addArrangedSubview($0) }
        [itemStepper, addToCartButton].forEach {
            addingToCartView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        ratingStackView.axis = .horizontal
        ratingStackView.spacing = 4
        
        colorsSegments.addTarget(self, action: #selector(colorSelected), for: .valueChanged)

        itemStepper.setup(value: 1)
        itemStepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
    }
    
    private func setupAppearance() {
        let leftBarButton = UIBarButtonItem(image: Resources.Images.back, style: .done, target: self, action: #selector(backToHome))
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.leftBarButtonItem?.tintColor = Resources.Colors.black
        view.backgroundColor = Resources.Colors.background

        nameLabel.font = UIFont.bold(with: 22)
        nameLabel.textColor = Resources.Colors.title
        
        priceLabel.font = UIFont.bold(with: 16)
        priceLabel.textColor = Resources.Colors.title
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.regular(with: 12)
        descriptionLabel.textColor = Resources.Colors.subTitle
        
        ratingIcon.contentMode = .scaleAspectFit
        
        ratingLabel.font = UIFont.bold(with: 12)
        ratingLabel.textColor = Resources.Colors.black
        
        reviewsLabel.font = UIFont.regular(with: 12)
        reviewsLabel.textColor = Resources.Colors.subTitle
        
        colorLabel.text = "Color:"
        colorLabel.font = UIFont.semiBold(with: 12)
        colorLabel.textColor = Resources.Colors.colorTitle
        
        addingToCartView.layer.cornerRadius = 30
        addingToCartView.backgroundColor = Resources.Colors.black
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imagesView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imagesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imagesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imagesView.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            
            favoriteShareView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            favoriteShareView.widthAnchor.constraint(equalToConstant: 42),
            favoriteShareView.heightAnchor.constraint(equalToConstant: 95),
            favoriteShareView.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -136),
            
            nameLabel.topAnchor.constraint(equalTo: imagesView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: priceLabel.leadingAnchor, constant: -10),
            nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            
            ratingStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15),
            ratingStackView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            colorLabel.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            colorsSegments.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 13),
            colorsSegments.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            colorsSegments.bottomAnchor.constraint(lessThanOrEqualTo: addingToCartView.topAnchor, constant: -5),
            
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
