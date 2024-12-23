//
//  SearchVC.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 17.12.2024.
//

import UIKit

class SearchVC: UIViewController {
    
    private let padding: CGFloat = 50
    
    private var isUserNameEntered: Bool {
       return !(usernameTextField.text?.isEmpty ?? true)
    }
    
    private lazy var spacing: CGFloat = view.bounds.height * 0.15
    private lazy var imageSize: CGFloat = view.bounds.width * 0.5
    
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "gh-logo")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var usernameTextField: GFTextField = {
        let field = GFTextField()
        field.delegate = self
        return field
    }()
    
    private lazy var callToActionButton: GFButton = {
        let button = GFButton(background: .systemGreen, title: "Get Followers")
        button.addTarget(self, action: #selector(pushFollowersVC), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func addObservers() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func setupUI() {
        view.addSubview(logoImageView)
        view.addSubview(usernameTextField)
        view.addSubview(callToActionButton)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: spacing),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: imageSize),
            logoImageView.heightAnchor.constraint(equalToConstant: imageSize),
            
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: spacing),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameTextField.heightAnchor.constraint(equalToConstant: padding),
            
            callToActionButton.topAnchor.constraint(greaterThanOrEqualTo: usernameTextField.bottomAnchor, constant: spacing),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            callToActionButton.heightAnchor.constraint(equalToConstant: padding),
            ])
    }
    
    @objc
    private func pushFollowersVC() {
        guard let name = usernameTextField.text, name.isNameValid else {
            // show alert to hendl error
//            let alert = GFAlertVC(allertTitle: "Error", message: "Some random text kshdfkhs lkjshdf lkhskjhkjhksf dfsfsd.", buttonTitle: "Ok")
//            navigationController?.present(alert, animated: true)
            presentGFAlertOnMainThread(title: "title", message: "Some text", buttonTitle: "ok")
            return
        }
        
        let followersVC = FollowerListVC()
        followersVC.username = name
        followersVC.title = name
        navigationController?.pushViewController(followersVC, animated: true)
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // return action
        pushFollowersVC()
        return true
    }
}

