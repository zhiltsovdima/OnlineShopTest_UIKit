//
//  ImagePickable.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 15.03.2023.
//

import UIKit

protocol ImagePickable {
    func showImagePicker(sourceType: UIImagePickerController.SourceType)
    func didFinishPicking(_ image: UIImage)
}
