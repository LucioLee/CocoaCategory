//
//  UIViewController+Extension.swift
//  Daiqian
//
//  Created by 李新新 on 16/4/20.
//

import UIKit


public protocol SegueHandlerType {
    associatedtype SegueIdentifiers: RawRepresentable
}

public extension SegueHandlerType where Self: UIViewController, SegueIdentifiers.RawValue == String {
    
    func performSegue(withIdentifier segueIdentifier: SegueIdentifiers, sender: Any?) {
        performSegue(withIdentifier: segueIdentifier.rawValue, sender: sender)
    }
    
    func segueIdentifier(for segue: UIStoryboardSegue) -> SegueIdentifiers {
        guard let identifier = segue.identifier, let segueIdentifier = SegueIdentifiers(rawValue: identifier) else {
            fatalError("Invalid segue identifier \(String(describing: segue.identifier))")
        }
        return segueIdentifier
    }
}



