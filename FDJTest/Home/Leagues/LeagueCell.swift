//
//  LeagueCell.swift
//  FDJTest
//
//  Created by Bilel Bouricha on 24/11/2022.
//

import UIKit

final class LeagueCell: UICollectionViewCell {
    
    private lazy var leagueLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStyleAndLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(league: League) {
        leagueLabel.text = league.name
        leagueLabel.textColor = .black
    }
    
    private func configureStyleAndLayout() {
        contentView.addSubview(leagueLabel)
        
        NSLayoutConstraint.activate([
            leagueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            leagueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ])
    }
    
}
