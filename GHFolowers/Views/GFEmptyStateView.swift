//
//  GFEmptyStateView.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 23.12.2024.
//

import UIKit

class GFEmptyStateView: UIView {
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoView = UIImageView(image: .emptyStateLogo)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        titleLabel.text = message
        configure()
    }
    
    private func configure() {
        addSubview(logoView)
        addSubview(titleLabel)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.numberOfLines = 3
        titleLabel.textColor = .secondaryLabel
      
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            logoView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
            logoView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
            logoView.centerXAnchor.constraint(equalTo: self.rightAnchor, constant: -50),
            logoView.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: -200)
            ])
    }
}
