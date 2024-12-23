//
//  FollowerCell.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 19.12.2024.
//

import UIKit

final class FollowerCell: UICollectionViewCell {
    static let reuseIdentifier = "FollowerCell"
    private let padding = CGFloat(8)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = padding
        return stackView
    }()
    
    private lazy var avatarImageView: GFAvatarImageView = {
        let imageView = GFAvatarImageView()
        return imageView
    }()
    
    private lazy var usernameLabel: GFTitleLabel = {
        let label = GFTitleLabel()
        return label
    }()
    
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        configure()
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
    
    private func configure() {
        addSubview(stackView)
        stackView.addArrangedSubview(avatarImageView)
        stackView.addArrangedSubview(usernameLabel)
        
        stackView.constrainToBounds(top: padding, left: padding, bottom: padding, right: padding)
        
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            ])
    }
}
