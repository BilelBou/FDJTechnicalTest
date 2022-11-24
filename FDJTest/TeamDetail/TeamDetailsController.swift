//
//  TeamDetailsController.swift
//  FDJTest
//
//  Created by Bilel Bouricha on 24/11/2022.
//

import Combine
import UIKit

import Kingfisher

class TeamDetailsController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    let viewModel: TeamDetailViewModel
    
    private static let imageHeight: CGFloat = 50
    
    private lazy var bannerImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        guard let banner = viewModel.team.banner else { return view }
        view.kf.setImage(with: URL(string: banner))
        return view
    }()
    
    private lazy var countryLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = viewModel.team.country
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var leagueLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldSystemFont(ofSize: 20)
        view.text = viewModel.team.league
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var descriptionLabel: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = viewModel.team.description
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    init(viewModel: TeamDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyleAndLayout()
        view.backgroundColor = .white
        title = viewModel.team.name
    }
    
    private func configureStyleAndLayout() {
        view.addSubview(bannerImageView)
        view.addSubview(countryLabel)
        view.addSubview(leagueLabel)
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            bannerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            bannerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            bannerImageView.heightAnchor.constraint(equalToConstant: TeamDetailsController.imageHeight),
            
            countryLabel.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 20),
            countryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            leagueLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 20),
            leagueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            descriptionLabel.topAnchor.constraint(equalTo: leagueLabel.bottomAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])
    }
}
