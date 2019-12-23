//
//  FactView.swift
//  CountryFacts
//
//  Created by Trupti sahoo on 23/12/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit
import SDWebImage

final class FactView: UIView {
    enum Constant {
        static let padding: CGFloat = 16
        static let imageSize = (width: CGFloat(70), height: CGFloat(70))
    }
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: init
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initPhase2()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initPhase2()
    }
    
    private func initPhase2() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constant.padding),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constant.padding),
            imageView.widthAnchor.constraint(equalToConstant: Constant.imageSize.width),
            imageView.heightAnchor.constraint(equalToConstant: Constant.imageSize.height),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constant.padding),
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -Constant.padding),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.padding/2),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constant.padding)
            ])
    }
}

extension FactView {
    func setImage(imageUrl: String?, placeHolder: String) {
        imageView.sd_setImage(with: URL(string: imageUrl ?? ""), placeholderImage: UIImage(named: "imageNotAvailable"))
    }

    var titleText: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    var descriptionText: String? {
        get {
            return descriptionLabel.text
        }
        set {
            descriptionLabel.text = newValue
        }
    }
}
