//
//  BtnPleinLarge.swift
//  exmachina
//
//  Created by Sergio Charles on 30-05-2019.
//  Copyright © 2020 Sergio Charles. All rights reserved.
//

import UIKit

class BtnPleinLarge: BtnPlein {
    override func awakeFromNib() {
        super.awakeFromNib()
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
