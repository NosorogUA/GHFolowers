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
    
    private lazy var dateLabel = GFBodyLabel(textAlignment: .center)
    
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
            let items = [UserInfoHeaderView(user: user),
                         GFInfoView(type: .repo(countRepo: user.publicRepos, countGists: user.publicGists)),
                         GFInfoView(type: .followers(followers: user.followers, following: user.following)),
                         self.dateLabel,
                         UIView()]
            
            if let date = Date.fromISOStringToDate(user.createdAt) {
                let formattedDate = date.toCustomFormattedString()
                self.dateLabel.text = "GitHub since: " + formattedDate
            }
            
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


extension Date {
    
    // Function to convert a date string to a specific format
    static func fromISOStringToDate(_ isoString: String) -> Date? {
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Input format of the ISO string
        return isoFormatter.date(from: isoString)
    }
    
    // Function to convert the date into "DD.month.YYYY" format
    func toCustomFormattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy" // Output format (e.g., "26.April.2009")
        dateFormatter.locale = Locale(identifier: "en_US") // Ensure English month names
        return dateFormatter.string(from: self)
    }
}
