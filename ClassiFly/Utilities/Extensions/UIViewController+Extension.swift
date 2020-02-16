//
//  UIViewController+Extension.swift
//  JOOD
//
//  Created by Sergio Charles on 05-06-2019.
//  Copyright © 2020 Sergio Charles. All rights reserved.
//

import UIKit

extension UIViewController {
    func dismissKey()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
