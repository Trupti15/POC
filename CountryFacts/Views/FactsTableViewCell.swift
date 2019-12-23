//
//  FactsTableViewCell.swift
//  CountryFacts
//
//  Created by Trupti sahoo on 23/12/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit

class FactsTableViewCell: UITableViewCell {

    var facts: Facts? {
        didSet {
            guard let facts = facts else {
                return
            }
            //config UI
        }
    }
}
