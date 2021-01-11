//
//  UIViewControllerExtension.swift
//  CentralTechAssignment
//
//  Created by Nantarat Buranajinda on 11/1/2564 BE.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc public func dismissKeyboard() {
        view.endEditing(true)
    }
}
