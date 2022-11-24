//
//  TeamsViewModel.swift
//  FDJTest
//
//  Created by Bilel Bouricha on 24/11/2022.
//

import Foundation

final class TeamsViewModel {
    @Published var teams: [Team] = []
    
    let manager: TeamsManager
    
    init(team: String) {
        manager = TeamsManager(team: team)
    }
    
    func getTeams() {
        manager.fetchTeams { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let teams):
                let result = self.computeEveryOtherElement(teams: teams.teams)
                let ordered = self.computeAntiAlphabeticOrder(teams: result)
                self.teams = ordered
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func computeEveryOtherElement(teams: [Team]) -> [Team] {
        var result: [Team] = []
        for i in stride(from: 0, through: teams.count - 1, by: 2) {
            result.append(teams[i])
        }
        return result
    }
    
    func computeAntiAlphabeticOrder(teams: [Team]) -> [Team] {
        return teams.sorted { $0.name.lowercased() > $1.name.lowercased() }
    }
}

