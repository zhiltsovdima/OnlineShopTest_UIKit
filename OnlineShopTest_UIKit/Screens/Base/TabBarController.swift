//
//  TabBarController.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 12.03.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
    }

    private func setupAppearance() {
        let newHeight: CGFloat = 100
    
        let roundedLayer = CAShapeLayer()

        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: tabBar.bounds.origin.x,
                y: tabBar.bounds.minY - 15,
                width: tabBar.bounds.width,
                height: newHeight
            ),
            cornerRadius: 30
        )
        roundedLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundedLayer, at: 0)
        
        roundedLayer.fillColor = Resources.Colors.white.cgColor
        tabBar.tintColor = Resources.Colors.tabBarTint
    }
    
}
