//
//  DetailViewModelTests.swift
//  OnlineShopTest_UIKitTests
//
//  Created by Dima Zhiltsov on 21.03.2023.
//

import XCTest
@testable import OnlineShopTest_UIKit

final class DetailViewModelTests: XCTestCase {
    
    var sut: DetailViewModel!
    var networkManager: NetworkManagerMock!
    var coordinator: HomeCoordinatorMock!
    
    override func setUpWithError() throws {
        networkManager = NetworkManagerMock()
        coordinator = HomeCoordinatorMock()
        sut = DetailViewModel(coordinator: coordinator, networkManager)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        coordinator = nil
        networkManager = nil
    }
    
    func testFetchData_Failure() {
        let expect = expectation(description: "Expect noInternet error")
        sut.updateCompletion = {
            expect.fulfill()
        }
        networkManager.dataResult = .failure(NetworkError.noInternet)
        
        sut.fetchData()
        
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(sut.errorMessage, NetworkError.noInternet.description)
    }
    
}
