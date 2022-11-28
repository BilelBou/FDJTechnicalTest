//
//  HomeViewModel.swift
//  FDJTest
//
//  Created by Bilel Bouricha on 24/11/2022.
//

import Foundation

final class HomeViewModel {
    let leagueManager: LeagueManagerProtocol
    var allLeagues: [League] = []
    @Published var leagues: [League] = []
    
    init(leagueManager: LeagueManagerProtocol) {
        self.leagueManager = leagueManager
    }
    
    func getLeagues() {
        leagueManager.fetchLeagues { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let league):
                var result: [League] = []
                for league in league.leagues {
                    if league.sport == "Soccer" {
                        result.append(league)
                    }
                }
                self.allLeagues = result
                self.leagues = self.allLeagues
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func handleSearch(text: String) {
        if text.isEmpty {
            leagues = allLeagues
        } else {
            leagues = allLeagues.filter { $0.name.localizedCaseInsensitiveContains(text) }
        }
    }
}
