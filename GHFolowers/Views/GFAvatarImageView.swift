//
//  GFAvatarImageView.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 19.12.2024.
//
import UIKit

final class GFAvatarImageView: UIImageView {
    override init(frame: CGRect = .zero) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        contentMode = .scaleAspectFill
        clipsToBounds = true
        image = .avatarPlaceholder
    }
}
