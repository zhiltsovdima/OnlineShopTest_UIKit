//
//  ProfileCell.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 13.03.2023.
//

import UIKit

final class ProfileCell: UITableViewCell {
    
    private let icon = UIImageView()
    private let title = UILabel()
    private let balanceLabel = UILabel()
    private let pushIcon = UIImageView()
    private let stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with viewModel: ProfileCellViewModel) {
        icon.image = viewModel.iconType.image
        title.text = viewModel.title
        balanceLabel.text = viewModel.balance
        pushIcon.image = viewModel.pushIcon

        balanceLabel.isHidden = viewModel.type != .balance
        pushIcon.isHidden = viewModel.type != .push
    }
    
    private func setupViews() {
        backgroundColor = Resources.Colors.background
        addSubview(stackView)
        
        [icon, title, balanceLabel, pushIcon].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        stackView.axis = .horizontal
        stackView.spacing = 7
        
        title.font = UIFont.regular(with: 14)
        title.textColor = Resources.Colors.title
        title.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        balanceLabel.font = UIFont.bold(with: 14)
        balanceLabel.textColor = Resources.Colors.title
        balanceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        icon.contentMode = .scaleAspectFit
        pushIcon.contentMode = .scaleAspectFit
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -45),
            
            icon.widthAnchor.constraint(equalToConstant: 40),
            pushIcon.widthAnchor.constraint(equalToConstant: 10)
        ])
    }
}
