//
//  Teams.swift
//  FDJTest
//
//  Created by Bilel Bouricha on 24/11/2022.
//

import Foundation

struct Teams: Decodable, Hashable {
    var teams: [Team]
}

struct Team: Decodable, Hashable, Equatable {
    var id: String
    var image: String
    var name: String
    var banner: String?
    var country: String
    var league: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idTeam"
        case image = "strTeamBadge"
        case name = "strTeam"
        case banner = "strTeamBanner"
        case country = "strCountry"
        case league = "strLeague"
        case description = "strDescriptionEN"
    }
    
    init(id: String, image: String, name: String, banner: String? = nil, country: String, league: String, description: String) {
        self.id = id
        self.image = image
        self.name = name
        self.banner = banner
        self.country = country
        self.league = league
        self.description = description
    }
}
