//
//  TeamCell.swift
//  FDJTest
//
//  Created by Bilel Bouricha on 24/11/2022.
//

import UIKit

import Kingfisher

class TeamCell: UICollectionViewCell {
    
    private static let imageSize: CGFloat = 100
    
    private lazy var teamImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStyleAndLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(team: Team) {
        teamImageView.kf.setImage(with: URL(string: team.image))
    }
    
    override func prepareForReuse() {
        teamImageView.image = nil
        teamImageView.kf.cancelDownloadTask()
    }
    
    private func configureStyleAndLayout() {
        contentView.addSubview(teamImageView)
        
        NSLayoutConstraint.activate([
            teamImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            teamImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            teamImageView.heightAnchor.constraint(equalToConstant: TeamCell.imageSize),
            teamImageView.widthAnchor.constraint(equalToConstant: TeamCell.imageSize),
        ])
    }
}
