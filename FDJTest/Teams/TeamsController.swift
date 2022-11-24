//
//  TeamsController.swift
//  FDJTest
//
//  Created by Bilel Bouricha on 24/11/2022.
//

import Combine
import UIKit

class TeamsController: UIViewController {
    
    let viewModel: TeamsViewModel
    private var cancellables = Set<AnyCancellable>()
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Team>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Team>
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(TeamCell.self)
        collectionView.delegate = self
        return collectionView
    }()
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private lazy var dataSource: DataSource = {
        return DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, team in
            let cell: TeamCell = collectionView.dequeue(for: indexPath)
            cell.configure(team: team)
            return cell
        }
    }()
    
    private func configureSnapshot(teams: [Team]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(teams)
        dataSource.apply(snapshot)
    }
    
    init(viewModel: TeamsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubscribers()
        configureStyleAndLayout()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getTeams()
    }
    
    private func configureSubscribers() {
        viewModel.$teams
            .receive(on: DispatchQueue.main)
            .sink { [weak self] teams in
                self?.configureSnapshot(teams: teams)
            }
            .store(in: &cancellables)
    }
    
    private func configureStyleAndLayout() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension TeamsController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let team = viewModel.teams[indexPath.item]
        let viewModel = TeamDetailViewModel(team: team)
        let controller = TeamDetailsController(viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
}
