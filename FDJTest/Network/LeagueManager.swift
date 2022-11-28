//
//  LeagueManager.swift
//  FDJTest
//
//  Created by Bilel Bouricha on 24/11/2022.
//

import Foundation

protocol LeagueManagerProtocol {
    func fetchLeagues(completion: @escaping (Result<Leagues, Error>) -> Void)
}

final class LeagueManager: LeagueManagerProtocol {
    let url = URL(string: "https://www.thesportsdb.com/api/v1/json/50130162/all_leagues.php")
    
    func fetchLeagues(completion: @escaping (Result<Leagues, Error>) -> Void) {
        guard let url = url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let leagues = try JSONDecoder().decode(Leagues.self, from: data)
                    completion(.success(leagues))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }.resume()
    }
}

final class LeagueManagerMock: LeagueManagerProtocol {
    func fetchLeagues(completion: @escaping (Result<Leagues, Error>) -> Void) {
        completion(.success(Leagues(leagues: [League(id: "123", name: "Ligue 1", sport: "Soccer")])))
    }
}
