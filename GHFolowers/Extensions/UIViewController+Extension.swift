//
//  UIViewController+Extension.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 23.12.2024.
//
import UIKit

fileprivate var containerView: UIView?

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String?, buttonTitle: String?) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(allertTitle: title, message: message, buttonTitle: buttonTitle)
            self.present(alertVC, animated: true)
        }
    }
    
    func showGFLoadingIndicator() {
        containerView = UIView(frame: view.bounds)
        guard let containerView else { return }
        
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemBlue
        containerView.addSubview(activityIndicator)
        activityIndicator.center = containerView.center
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        activityIndicator.startAnimating()
    }
    
    func hideGFLoadingIndicator() {
        DispatchQueue.main.async {
            containerView?.removeFromSuperview()
        }
    }
}
