//
//  UIBarButtonItem+Extension.swift
//  LucioExtension
//
//  Created by 李新新 on 16/4/13.
//  Copyright © 2016年 Person. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    class func item(withImage image: String, highlightImage: String?, target: Any?, action: Selector) -> UIBarButtonItem {
        
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: image), for: .normal)
        if highlightImage != nil {
            button.setBackgroundImage(UIImage(named: highlightImage!), for: .highlighted)
        }
        button.size = button.currentBackgroundImage!.size
        
        button.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }
}
