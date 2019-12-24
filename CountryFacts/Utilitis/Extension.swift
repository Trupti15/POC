//
//  Extension.swift
//  CountryFacts
//
//  Created by Trupti sahoo on 23/12/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit

/*
 Used to avoide using of hardcoded tableCell name
 *
 */

protocol Identifier { }

extension Identifier where Self: UITableViewCell {
  static var identifier: String {
    return String(describing: self)
  }
}
extension UITableViewCell: Identifier {}
