//
//  UIButton+Extension.swift
//  CocoaCategory-Swift
//
//  Created by 李新新 on 2018/11/23.
//  Copyright © 2018 李新新. All rights reserved.
//

import UIKit

extension UIButton {
    private struct AssociatedKeys {
        static var enlargeEdgeKey = "UIButton.enlargeEdge.key"
    }
    /// 扩大的点击区域
    var enlargedEdge: UIEdgeInsets {
        get {
            if let edges = objc_getAssociatedObject(self, &AssociatedKeys.enlargeEdgeKey) as? UIEdgeInsets {
                return edges
            }
            return UIEdgeInsets.zero
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.enlargeEdgeKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var enlargedRect: CGRect {
        return CGRect(x: self.bounds.origin.x - enlargedEdge.left,
                      y: self.bounds.origin.y - enlargedEdge.top,
                      width: self.bounds.size.width + enlargedEdge.left + enlargedEdge.right,
                      height: self.bounds.size.height + enlargedEdge.top + enlargedEdge.bottom)
    }
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if enlargedRect == self.bounds {
            return super.point(inside: point, with: event)
        }
        return enlargedRect.contains(point)
    }
}
