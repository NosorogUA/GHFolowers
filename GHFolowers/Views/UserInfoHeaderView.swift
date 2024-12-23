//
//  UserInfoHeaderView.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 23.12.2024.
//
import UIKit

final class UserInfoHeaderView: UIView {
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var userStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var avatarImageView: GFAvatarImageView = {
        let imageView = GFAvatarImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var userNameLabel: GFTitleLabel = {
        GFTitleLabel(textAlignment: .left, fontSize: 34)
    }()
    
    private lazy var nameLabel: GFSecondaryTitleLabel = {
        GFSecondaryTitleLabel(fontSize: 18)
    }()
    
    private lazy var locationLabel: GFSecondaryTitleLabel = {
        GFSecondaryTitleLabel(fontSize: 18)
    }()
    
    private lazy var bioLabel: GFBodyLabel = {
        GFBodyLabel(textAlignment: .left)
    }()
    
    let user: User
    
    init(user: User!) {
        self.user = user
        super.init(frame: .zero)
        
        NetworkManager.shared.downloadImage(from: user.avatarUrl) { [weak self] image in
            self?.avatarImageView.image = image
        }
        
        userNameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationLabel.text = user.location ?? "No Location"
        bioLabel.text = user.bio ?? "no bio available"
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(mainStackView)
        mainStackView.constrainToBounds()
        
        mainStackView.addArrangedSubview(userStackView)
        mainStackView.addArrangedSubview(bioLabel)
        
        userStackView.addArrangedSubview(avatarImageView)
        userStackView.addArrangedSubview(infoStackView)
        
        infoStackView.addArrangedSubview(userNameLabel)
        infoStackView.addArrangedSubview(nameLabel)
        infoStackView.addArrangedSubview(locationLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarImageView.heightAnchor.constraint(equalToConstant: 120)
            ])
    }
}
