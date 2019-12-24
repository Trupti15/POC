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
        static let padding: CGFloat = 8
        static let imageSize = (width: CGFloat(70), height: CGFloat(70))
    }
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [self.titleLabel, self.descriptionLabel]
        )
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Constant.imageSize.width),
            imageView.heightAnchor.constraint(equalToConstant: Constant.imageSize.height),
            
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constant.padding),
            stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
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
