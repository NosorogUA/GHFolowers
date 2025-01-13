//
//  GFInfoView.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 26.12.2024.
//
import UIKit

class GFInfoView: UIView {
    private lazy var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .fill
        return stack
    }()
    
    private lazy var topStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    let leftInfoItem : GFInfoItemView
    let rightInfoItem: GFInfoItemView
    let actionButton: GFButton
    let padding: CGFloat = 20
    
    required init(type: InfoType) {
        leftInfoItem = GFInfoItemView()
        rightInfoItem = GFInfoItemView()
        
        switch type {
        case .repo(let repos, let gists):
            leftInfoItem.set(type: .repos, withCount: repos)
            rightInfoItem.set(type: .gists, withCount: gists)
            actionButton = GFButton(background: .systemPurple, title: "GitHub Profile")
        case .followers(let followers, let following):
            leftInfoItem.set(type: .followers, withCount: followers)
            rightInfoItem.set(type: .following, withCount: following)
            actionButton = GFButton(background: .systemMint, title: "Get Followers")
        }
        
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerStack)
        backgroundColor = .secondarySystemFill
        layer.cornerRadius = 16
        
        containerStack.constrainToBounds(top: padding, left: padding, bottom: padding, right: padding)
        
        topStack.addArrangedSubview(leftInfoItem)
        topStack.addArrangedSubview(UIView())
        topStack.addArrangedSubview(rightInfoItem)
        
        containerStack.addArrangedSubview(topStack)
        containerStack.addArrangedSubview(actionButton)
    }
}

enum InfoType {
    case repo(countRepo: Int, countGists: Int)
    case followers(followers: Int, following: Int)
}
