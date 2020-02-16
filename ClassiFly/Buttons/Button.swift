//
//  Button.swift
//  exmachina
//
//  Created by Sergio Charles on 30-05-2019.
//  Copyright © 2020 Sergio Charles. All rights reserved.
//

import UIKit

class Button: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel?.font = UIFont(name: "Avenir", size: 12)
    }
}
