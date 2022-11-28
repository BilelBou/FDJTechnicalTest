//
//  LeagueManagerTests.swift
//  FDJTestTests
//
//  Created by Bilel Bouricha on 28/11/2022.
//

import XCTest
@testable import FDJTest

final class LeagueManagerTests: XCTestCase {
    
    func testLeagueManager() {
        let leagueMock = LeagueManagerMock()
        let expectation = self.expectation(description: "Fetching...")
        var leaguesData: Leagues?

        leagueMock.fetchLeagues { result in
            switch result {
            case .success(let leagues):
                leaguesData = leagues
                expectation.fulfill()
            case .failure:
                break
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(leaguesData)
    }
}
