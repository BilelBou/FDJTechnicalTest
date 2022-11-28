//
//  League.swift
//  FDJTest
//
//  Created by Bilel Bouricha on 24/11/2022.
//

import Foundation

struct Leagues: Decodable, Hashable {
    var leagues: [League]
    
    init(leagues: [League]) {
        self.leagues = leagues
    }
}

struct League: Decodable, Hashable {
    var id: String
    var name: String
    var sport: String
    var alternateName: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idLeague"
        case name = "strLeague"
        case sport = "strSport"
        case alternateName = "strLeagueAlternate"
    }
    
    init(id: String, name: String, sport: String, alternateName: String? = nil) {
        self.id = id
        self.name = name
        self.sport = sport
        self.alternateName = alternateName
    }
}
