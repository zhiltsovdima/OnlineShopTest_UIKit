//
//  Resources.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 10.03.2023.
//

import UIKit

enum Resources {
    
    enum Colors {
        static let background = UIColor(hexString: "#FAF9FF")
        static let title = UIColor(hexString: "#161826")
        static let subTitle = UIColor(hexString: "#808080")
        static let textFieldBack = UIColor(hexString: "#E8E8E8")
        static let textFieldPlaceholder = UIColor(hexString: "#7B7B7B")
        static let accentColor = UIColor(hexString: "#4E55D7")
        static let buttonTitle = UIColor(hexString: "#EAEAEA")
        static let tappableText = UIColor(hexString: "#254FE6")
        static let black = UIColor(hexString: "#000000")
        static let white = UIColor(hexString: "#FFFFFF")
        static let tabBarTint = UIColor(hexString: "#737297")
        static let tabBarItemSelected = UIColor(hexString: "#EEEFF4")
    }
    
    enum Images {
        static let appleLogo = UIImage(named: "apple")
        static let googleLogo = UIImage(named: "google")
        static let hidePassword = UIImage(systemName: "eye.slash")
        static let showPassword = UIImage(systemName: "eye")
        
        static let downIcon = UIImage(named: "down")
        static let menu = UIImage(named: "menu")
        
        static let defaultUserImage = UIImage(named: "defaultUserImage")
        static let uploadItem = UIImage(named: "upload")
        static let balance = UIImage(named: "balance")
        static let push = UIImage(named: "push")
        static let help = UIImage(named: "help")
        static let restore = UIImage(named: "restore")
        static let logout = UIImage(named: "logout")
        
        enum TabBar {
            static let home = UIImage(named: "home")
            static let favorites = UIImage(named: "favorites")
            static let cart = UIImage(named: "cart")
            static let chat = UIImage(named: "chat")
            static let profile = UIImage(named: "profile")
        }
    }
    
    enum CellIdentifier {
        static let profile = "ProfileCell"
    }
}
