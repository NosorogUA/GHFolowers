//
//  GFAlertVC.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 17.12.2024.
//

import UIKit

final class GFAlertVC: UIViewController {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 25
        return stack
    }()
    
    private lazy var titleLabel: GFTitleLabel = {
        let label = GFTitleLabel(textAlignment: .center, fontSize: 20)
        return label
    }()
    
    private lazy var messageLabel: GFBodyLabel = {
        let label = GFBodyLabel(textAlignment: .center)
        return label
    }()
    
    private lazy var actionButton: GFButton = {
        let button = GFButton(background: .red, title: "Ok")
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var allertTitle: String?
    private var message: String?
    private var buttonTitle: String?
    
    init(allertTitle: String? = nil, message: String? = nil, buttonTitle: String? = "Ok") {
        super.init(nibName: nil, bundle: nil)
        self.buttonTitle = buttonTitle
        self.allertTitle = allertTitle
        self.message = message
        configureUI()
        setStrings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .overFullScreen
//        modalTransitionStyle = .crossDissolve
        view.backgroundColor = .black.withAlphaComponent(0)
       
        addObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatedOpen()
    }
    
    private func addObservers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(actionButtonTapped))
        view.addGestureRecognizer(tap)
    }
    
    private func configureUI() {
        view.addSubview(containerView)
        
        containerView.addSubview(stack)
        stack.constrainToBounds(top: 16, left: 16, bottom: 16, right: 16)
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(messageLabel)
        stack.addArrangedSubview(actionButton)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            actionButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    private func setStrings() {
        titleLabel.text = allertTitle
        messageLabel.text = message
        actionButton.setTitle(buttonTitle, for: .normal)
    }
    
    private func animatedOpen() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.view.backgroundColor = .black.withAlphaComponent(0.4)
        }
    }
    
    private func animatedClose() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.view.backgroundColor = .black.withAlphaComponent(0.0)
        } completion: { [weak self] _ in
            self?.dismiss(animated: true)
        }
    }
    
    @objc private func actionButtonTapped() {
        animatedClose()
    }
}


extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String?, buttonTitle: String?) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(allertTitle: title, message: message, buttonTitle: buttonTitle)
            self.present(alertVC, animated: true)
        }
    }
}
