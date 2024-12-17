//
//  GFButton.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 17.12.2024.
//

import UIKit

class GFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(background: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = background
        setTitle(title, for: .normal)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        setTitleColor(.gray, for: .highlighted)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
}
