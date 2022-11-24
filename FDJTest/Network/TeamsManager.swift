//
//  TeamsManager.swift
//  FDJTest
//
//  Created by Bilel Bouricha on 24/11/2022.
//

import Foundation

final class TeamsManager {
    let urlString : String
    
    init(team: String) {
        urlString = "https://www.thesportsdb.com/api/v1/json/50130162/search_all_teams.php?l=" + team
    }
    
    func fetchTeams(completion: @escaping (Result<Teams, Error>) -> Void) {
        guard let urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
        let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let leagues = try JSONDecoder().decode(Teams.self, from: data)
                    completion(.success(leagues))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }.resume()
    }
}
