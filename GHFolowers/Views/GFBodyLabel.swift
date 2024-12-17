//
//  GFBodyLabel.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 17.12.2024.
//

import UIKit

final class GFBodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
    private func configure() {
        self.font = UIFont.preferredFont(forTextStyle: .body)
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byClipping
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
}
