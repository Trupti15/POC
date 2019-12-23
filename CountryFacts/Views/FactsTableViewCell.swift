//
//  FactsTableViewCell.swift
//  CountryFacts
//
//  Created by Trupti sahoo on 23/12/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit

class FactsTableViewCell: UITableViewCell {
    private let minimumCellHeight: CGFloat = 100
    private lazy var factView = {
        return FactView()
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(factView)
        factView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: minimumCellHeight),
            
            factView.topAnchor.constraint(equalTo: self.topAnchor),
            factView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            factView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            factView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var facts: Facts? {
        didSet {
            guard let facts = facts else {
                return
            }
            factView.titleText = facts.title
            factView.descriptionText = facts.description
            factView.setImage(imageUrl: facts.imageUrl, placeHolder: "imageNotAvailable")
        }
    }
}
