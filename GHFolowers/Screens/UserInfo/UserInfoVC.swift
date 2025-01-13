//
//  UserInfoVC.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 23.12.2024.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didTapGitGubProfile()
    func didTapGetFollowers()
}

final class UserInfoVC: UIViewController {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.axis = .vertical
        return stackView
    }()
    weak var delegate: FollowerListVCDelegate?
    
    var userName: String!
    var user: User?

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
                self.user = user
                showInfo()
               
            case .failure(let failure):
                presentGFAlertOnMainThread(title: "Something went wrong", message: failure.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func showInfo() {
        guard let user else { return }
        DispatchQueue.main.async {
            
            let header = UserInfoHeaderView(user: user)
            let repoInfo = GFInfoView(type: .repo(countRepo: user.publicRepos, countGists: user.publicGists), delegate: self)
            let followersInfo = GFInfoView(type: .followers(followers: user.followers, following: user.following), delegate: self)
            
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

extension UserInfoVC: UserInfoVCDelegate {
    func didTapGitGubProfile() {
        guard let user else { return }
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "User's GitHub profile URL is invalid", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowers() {
        guard user?.followers ?? 0 > 0 else {
            presentGFAlertOnMainThread(title: "this user has no followers", message: "Only users with followers can request followers", buttonTitle: "Ok")
            return
        }
        delegate?.dadRequestFollowers(for: user?.login ?? "")
        self.dissmissVC()
    }
}
