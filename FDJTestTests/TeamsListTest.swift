//
//  FDJTestTests.swift
//  FDJTestTests
//
//  Created by Bilel Bouricha on 24/11/2022.
//

import XCTest
@testable import FDJTest

final class TeamsListTest: XCTestCase {

    func testOneOnAnother() throws {
        let teams = [Team(id: "123", image: "", name: "PSG", country: "", league: "", description: ""),
                     Team(id: "345", image: "", name: "OM", country: "", league: "", description: ""),
                     Team(id: "456", image: "", name: "OL", country: "", league: "", description: ""),
        ]
        let viewModel = TeamsViewModel(team: "PSG")
        let result = viewModel.computeEveryOtherElement(teams: teams)
        let expected = [Team(id: "123", image: "", name: "PSG", country: "", league: "", description: ""),
                        Team(id: "456", image: "", name: "OL", country: "", league: "", description: "")]
        XCTAssertEqual(result, expected)
    }
    
    func testAntiAlphabeticalOrder() throws {
        let teams = [
            Team(id: "123", image: "", name: "West Ham", country: "", league: "", description: ""),
            Team(id: "345", image: "", name: "Arsenal", country: "", league: "", description: ""),
            Team(id: "456", image: "", name: "Leicester", country: "", league: "", description: ""),
        ]
        let viewModel = TeamsViewModel(team: "West Ham")
        let result = viewModel.computeAntiAlphabeticOrder(teams: teams)
        let expected = [
            Team(id: "123", image: "", name: "West Ham", country: "", league: "", description: ""),
            Team(id: "456", image: "", name: "Leicester", country: "", league: "", description: ""),
            Team(id: "345", image: "", name: "Arsenal", country: "", league: "", description: ""),
        ]
        XCTAssertEqual(result, expected)
    }

}
