//
//  UIBarButtonItem+Extension.swift
//  LucioExtension
//
//  Created by 李新新 on 16/4/13.
//  Copyright © 2016年 Person. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    class func item(with image: UIImage, highlightedImage: UIImage? = nil, target: Any?, action: Selector) -> UIBarButtonItem {
        
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(image, for: UIControl.State.normal)
        if highlightedImage != nil {
            button.setImage(highlightedImage, for: UIControl.State.highlighted)
        }
        button.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
    
        return UIBarButtonItem(customView: button)
    }
}
