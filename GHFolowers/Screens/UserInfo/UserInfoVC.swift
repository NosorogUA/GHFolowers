//
//  UserInfoVC.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 23.12.2024.
//

import UIKit

class UserInfoVC: UIViewController {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.axis = .vertical
        return stackView
    }()
    
    var userName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dissmissVC))
        navigationItem.rightBarButtonItem = doneButton
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
            
            let header = UserInfoHeaderView(user: user)
            let repoInfo = GFInfoView(type: .repo(countRepo: user.publicRepos, countGists: user.publicGists))
            let followersInfo = GFInfoView(type: .followers(followers: user.followers, following: user.following))
            
            let dateLabel = GFBodyLabel(textAlignment: .center)
            if let date = Date.fromISOStringToDate(user.createdAt) {
                let formattedDate = date.toCustomFormattedString()
                dateLabel.text = "GitHub since: " + formattedDate
            }
            
            let items = [header, repoInfo, followersInfo, dateLabel, UIView()]
           
            items.forEach {
                self.stackView.addArrangedSubview($0)
            }
            
            self.view.addSubview(self.stackView)
            self.stackView.constrainToBounds(top: 50, left: 20, bottom: 20, right: 20)
        }
    }

    @objc func dissmissVC() {
        dismiss(animated: true)
    }
}
