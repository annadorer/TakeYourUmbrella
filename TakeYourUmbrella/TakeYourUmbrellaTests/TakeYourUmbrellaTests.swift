//
//  TakeYourUmbrellaTests.swift
//  TakeYourUmbrellaTests
//
//  Created by Anna on 11.03.2024.
//

import XCTest
@testable import TakeYourUmbrella

final class TakeYourUmbrellaTests: XCTestCase {

    override func setUpWithError() throws {
       
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() async throws {
        let test = WeatherService()
        let a = test.fetch(forCity: "Moscow")
        let b = 10
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
