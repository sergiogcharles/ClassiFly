//
//  Date+Extension.swift
//  exmachina
//
//  Created by Sergio Charles on 05-06-2019.
//  Copyright © 2020 Sergio Charles. All rights reserved.
//

import UIKit

extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
