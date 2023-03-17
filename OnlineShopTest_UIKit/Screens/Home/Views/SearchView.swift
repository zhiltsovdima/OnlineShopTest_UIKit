//
//  SearchView.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 17.03.2023.
//

import UIKit

final class SearchView: UISearchBar {
    
    private let icon = UIImageView(image: Resources.Images.search)
    
    private let noOffset = UIOffset(horizontal: 0, vertical: 0)
    private var offset: UIOffset {
        return UIOffset(
            horizontal: (searchTextField.bounds.width - placeholderWidth - rightViewWidth - 5) / 2,
            vertical: 0
        )
    }
    private var placeholderWidth: CGFloat {
        return searchTextField.attributedPlaceholder?.size().width ?? 0
    }
    private var rightViewWidth: CGFloat {
        return searchTextField.rightView?.frame.width ?? 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayout()
        setOffset(true)
    }
    
    private func setupView() {
        let atrributedPlaceholder = NSAttributedString(
            string: HomeViewModel.Constants.searchBarPlaceholder,
            attributes: [
                .foregroundColor: Resources.Colors.searchBarText,
                .font: UIFont.light(with: 10)!
            ]
        )
        searchTextField.attributedPlaceholder = atrributedPlaceholder
        searchTextField.backgroundColor = Resources.Colors.searchBarBackground
        searchTextField.textAlignment = .left
        searchTextField.textColor = Resources.Colors.searchBarText
        searchBarStyle = .minimal
    }
    
    private func setupLayout() {
        searchTextField.layer.cornerRadius = searchTextField.frame.height / 2
        searchTextField.layer.masksToBounds = true
        searchTextField.leftView = nil
        searchTextField.rightView = icon
        searchTextField.rightViewMode = .always
    }
    
    func setOffset(_ isOffset: Bool) {
        switch isOffset {
        case true: setPositionAdjustment(offset, for: .search)
        case false: setPositionAdjustment(noOffset, for: .search)
        }
    }
}


