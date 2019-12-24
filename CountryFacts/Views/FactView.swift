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
  
  private lazy var titleLabel : UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = UIFont(name: Font.medium, size: 18.0)
    label.textAlignment = .left
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var descriptionLabel : UILabel = {
    let label = UILabel()
    label.textColor = .gray
    label.font = UIFont(name: Font.neue, size: 18.0)
    label.textAlignment = .left
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  //putting title and description in stackview vertically
  lazy var verticalStackView: UIStackView = {
    let stackView = UIStackView(
      arrangedSubviews: [self.titleLabel, self.descriptionLabel]
    )
    stackView.axis = .vertical
    stackView.spacing = Height.margin
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  private lazy var imageView : UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.masksToBounds = true
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  //putting imageView and verticalStackView in another horizontal stackView
  lazy var stackView: UIStackView = {
    let stackView = UIStackView(
      arrangedSubviews: [self.imageView, self.verticalStackView]
    )
    stackView.axis = .horizontal
    stackView.spacing = 2*Height.margin
    stackView.alignment = .top
    stackView.distribution = .fill
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
    addSubview(stackView)
    
    NSLayoutConstraint.activate([
      imageView.widthAnchor.constraint(equalToConstant: Size.image.width),
      imageView.heightAnchor.constraint(equalToConstant: Size.image.height),
      stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
      stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
      ])
  }
}

extension FactView {
  func setImage(imageUrl: String?, placeHolder: String) {
    DispatchQueue.global().async { [weak self] in
      guard let self  = self else { return }
      self.imageView.sd_setImage(with: URL(string: imageUrl ?? ""), placeholderImage: UIImage(named: "imageNotAvailable"))
    }
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
