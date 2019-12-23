//
//  Extension.swift
//  CountryFacts
//
//  Created by Trupti sahoo on 23/12/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit
protocol Identifier { }

extension Identifier where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}
extension UIView: Identifier {}
