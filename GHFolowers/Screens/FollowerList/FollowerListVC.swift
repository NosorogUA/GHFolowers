
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
    
    private var datasource: UICollectionViewDiffableDataSource<Section, Follower>?
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: view.frame, collectionViewLayout: UIHelper.createThreeColumnLayout(width: view.bounds.width))
        collection.backgroundColor = .systemBackground
        collection.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseIdentifier)
//        collection.delegate = self
//        collection.dataSource = self
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
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in
            
            switch result {
            case .success(let followers):
                self?.followers = followers
                self?.updateData()
                
            case .failure(let failure):
                self?.presentGFAlertOnMainThread(title: "Bad stuff Happened", message: failure.rawValue, buttonTitle: "Ok")
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
