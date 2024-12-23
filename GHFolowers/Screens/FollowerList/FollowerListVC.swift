
//
//  FollowerListVC.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 17.12.2024.
//
import UIKit

final class FollowerListVC: UIViewController {
    private enum Section {
        case main
    }
    
    var username: String!
    private var followers: [Follower] = []
    private var page = 1
    private var isLoading = false
    private var isMoreFollowers = true
    
    private var datasource: UICollectionViewDiffableDataSource<Section, Follower>?
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: view.frame, collectionViewLayout: UIHelper.createThreeColumnLayout(width: view.bounds.width))
        collection.backgroundColor = .systemBackground
        collection.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseIdentifier)
        collection.delegate = self
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        setupCollection()
        getData()
        configureDatasource()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func getData() {
        guard !isLoading else { return }
        isLoading = true
        showGFLoadingIndicator()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self else { return }
            
            hideGFLoadingIndicator()
            isLoading = false
            
            switch result {
            case .success(let followers):
                isMoreFollowers = followers.count == 100
                
                self.followers.append(contentsOf: followers)
                
                if followers.isEmpty {
                    let message = "No followers found for \(username ?? "")"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(message: message, in: self.view)
                    }
                    return
                }
                
                updateData()
                
            case .failure(let failure):
                presentGFAlertOnMainThread(title: "Bad stuff Happened", message: failure.rawValue, buttonTitle: "Ok")
                let message = "No followers found for \(username ?? "")"
                DispatchQueue.main.async {
                    self.showEmptyStateView(message: message, in: self.view)
                }
            }
        }
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureDatasource() {
        datasource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collection) { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseIdentifier, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        }
    }
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async {
            self.datasource?.apply(snapshot, animatingDifferences: true)
        }
    }
    
    private func setupCollection() {
        view.addSubview(collection)
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard isMoreFollowers else { return }
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY >= contentHeight - height {
            page += 1
            getData()
        }
    }
}
