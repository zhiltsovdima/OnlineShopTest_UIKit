//
//  ProfileCellViewModel.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 13.03.2023.
//

import UIKit

final class ProfileCellViewModel {
    
    let type: CellType
    let title: String
    let iconType: IconType
    let pushIcon = Resources.Images.push
    var balance: String?
    
    init(type: CellType, title: String, iconType: IconType, balance: String? = nil) {
        self.type = type
        self.title = title
        self.iconType = iconType
        self.balance = balance
    }
}

extension ProfileCellViewModel {
    
    enum CellType {
        case push
        case balance
        case normal
    }
    
    enum IconType {
        case balance
        case restore
        case help
        case logout
        
        var image: UIImage? {
            switch self {
            case .restore:
                return Resources.Images.restore
            case .logout:
                return Resources.Images.logout
            case .help:
                return Resources.Images.help
            case .balance:
                return Resources.Images.balance
            }
        }
    }
}
