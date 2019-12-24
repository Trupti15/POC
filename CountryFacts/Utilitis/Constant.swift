//
//  Constant.swift
//  CountryFacts
//
//  Created by Trupti sahoo on 24/12/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

//import Foundation
import UIKit

enum Font {
  static let neue     = "Helvetica Neue"
  static let medium   = "HelveticaNeue-Medium"
  static let regular  = "HelveticaNeue-Regular"
}

enum Size {
  static let image = (width: CGFloat(120), height: CGFloat(120))
}

enum Height {
  static let factTableEstimated: CGFloat = 100
  static let factTableCellMinimum: CGFloat = 100
  static let margin: CGFloat = 8
}

enum Message {
  static let initialLoading = "Please wait..."
  static let pullToRefresh = "Fetching"
}
