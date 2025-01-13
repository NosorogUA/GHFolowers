//
//  GFInfoItemView.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 26.12.2024.
//

import UIKit

final class GFInfoItemView: UIView {
    let imageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    private lazy var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .fill
        return stack
    }()
    
    private lazy var topStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(type: infoItemType, withCount count: Int = 0) {
        DispatchQueue.main.async {
            self.countLabel.text = "\(count)"
            self.imageView.image = type.image
            self.titleLabel.text = type.title
        }
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerStack)
        containerStack.constrainToBounds()
        containerStack.addArrangedSubview(topStack)
        containerStack.addArrangedSubview(countLabel)
        
        topStack.addArrangedSubview(imageView)
        topStack.addArrangedSubview(titleLabel)
    }
}
