//
//  UIImage+Extension.swift
//  exmachina
//
//  Created by Sergio Charles on 30-05-2019.
//  Copyright © 2020 Sergio Charles. All rights reserved.
//

import UIKit

extension UIImage {
    
    func resized(newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
