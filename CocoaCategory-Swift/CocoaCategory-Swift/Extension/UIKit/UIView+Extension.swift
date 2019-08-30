//
//  UIView+Extension.swift
//  LucioExtension
//
//  Created by Lucio on 16/3/10.
//  Copyright © 2016年 Person. All rights reserved.
//

import UIKit

public extension UIView {
    
     var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
     var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
     var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
            frame.origin = newValue
        }
    }
    
     var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
     var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
     var size: CGSize {
        get {
            return frame.size
        }
        set {
            frame.size = newValue
        }
    }
}

@IBDesignable extension UIView {
    
    @IBInspectable  var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable  var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable  var borderColor: UIColor? {
        get {
            if let borderColor = layer.borderColor {
                return UIColor(cgColor: borderColor)
            }
            return .none
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable  var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            return layer.masksToBounds = newValue
        }
    }
    
    @IBInspectable  var shadowColor: UIColor? {
        get {
            if let shadowColor = layer.shadowColor {
                return UIColor(cgColor: shadowColor)
            }
            return .none
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable  var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable  var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable  var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
}

public extension UIView {
    
     func snapshot(in frame: CGRect) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)
        guard let currentContext = UIGraphicsGetCurrentContext() else {
            return nil
        }
        currentContext.translateBy(x: frame.origin.x * -1, y: frame.origin.y * -1)
        layer.render(in: currentContext)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
