//
//  UserInfoVC.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 23.12.2024.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var userName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dissmissVC))
        navigationItem.rightBarButtonItem = doneButton
//        title = userName
        getUser()
        // Do any additional setup after loading the view.
    }
    
    private func getUser() {
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let user):
                showInfo(user)
                print(user)
            case .failure(let failure):
                presentGFAlertOnMainThread(title: "Something went wrong", message: failure.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func showInfo(_ user: User) {
        DispatchQueue.main.async {
            let stackView = UIStackView(arrangedSubviews: [UserInfoHeaderView(user: user), UIView()])
            stackView.distribution = .fill
            stackView.alignment = .top
            stackView.spacing = 16
            stackView.axis = .vertical
            
            self.view.addSubview(stackView)
            stackView.constrainToBounds(top: 50, left: 20, bottom: 20, right: 20)
        }
    }

    @objc func dissmissVC() {
        dismiss(animated: true)
    }
}
