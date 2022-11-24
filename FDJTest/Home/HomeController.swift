//
//  ViewController.swift
//  FDJTest
//
//  Created by Bilel Bouricha on 24/11/2022.
//
import Combine
import UIKit

class HomeController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    private let viewModel = HomeViewModel()
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, League>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, League>
    
    private lazy var searchBar: UISearchController = {
        let view = UISearchController()
        view.searchBar.placeholder = "Search by league"
        view.searchResultsUpdater = self
        view.searchBar.isHidden = true
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(LeagueCell.self)
        collectionView.delegate = self
        return collectionView
    }()
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private lazy var dataSource: DataSource = {
        return DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, league in
            let cell: LeagueCell = collectionView.dequeue(for: indexPath)
            cell.configure(league: league)
            return cell
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubscribers()
        configureStyleAndLayout()
        view.backgroundColor = .white
        navigationItem.searchController = searchBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getLeagues()
    }
    
    private func configureSubscribers() {
        viewModel.$leagues
            .receive(on: DispatchQueue.main)
            .sink { [weak self] leagues in
                self?.searchBar.searchBar.isHidden = false
                self?.configureSnapshot(leagues: leagues)
            }
            .store(in: &cancellables)
    }
    
    private func configureSnapshot(leagues: [League]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(leagues)
        dataSource.apply(snapshot)
    }
    
    private func configureStyleAndLayout() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension HomeController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        viewModel.handleSearch(text: text)
    }
}

extension HomeController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = viewModel.leagues[indexPath.item]
        let teamsViewModel = TeamsViewModel(team: cell.name)
        let controller = TeamsController(viewModel: teamsViewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
}
