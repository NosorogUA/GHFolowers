//
//  UIView+extension.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 17.12.2024.
//
import UIKit

extension UIView {
    /// Adds constraints to the view that pin it to the provided bounds.
    /// - Parameters:
    ///   - top: The top margin (default is 0).
    ///   - left: The left margin (default is 0).
    ///   - bottom: The bottom margin (default is 0).
    ///   - right: The right margin (default is 0).
    ///   - toSafeArea: Whether to constrain to the safe area of the superview (default is true).
    func constrainToBounds(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        
        guard let superview = self.superview else { return }
        
        // Set translatesAutoresizingMaskIntoConstraints to false
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top),
            self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: left),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom),
            self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -right)
        ])
    }
}
