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
    
    // MARK: - FetchData tests

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
    
    func testFetchData_Success() throws {
        let expect = expectation(description: "Expect success")
        sut.updateCompletion = {
            expect.fulfill()
        }
        
        let shopItem = ShopItem(
            name: "Test",
            category: "Category",
            description: "Description",
            rating: 4.5,
            numberOfReviews: 40000,
            price: 10.0,
            colors: ["#FFFFFF", "#000000"],
            imageUrl: nil,
            imageUrls: [],
            discount: nil
        )
        let expectedDetailData = DetailModel(
            name: shopItem.name,
            description: shopItem.description ?? "No data",
            priceDouble: shopItem.price,
            rating: String(format: "%.1f", shopItem.rating ?? 0),
            reviews: "(\(shopItem.numberOfReviews ?? 0) reviews)",
            colors: shopItem.colors?.compactMap { UIColor(hexString: $0) }
        )
        networkManager.dataResult = .success(shopItem)
        
        sut.fetchData()
        
        waitForExpectations(timeout: 1.0)
        XCTAssertNotNil(sut.detailData)
        XCTAssertEqual(sut.detailData?.name, expectedDetailData.name)
        XCTAssertEqual(sut.detailData?.description, expectedDetailData.description)
        XCTAssertEqual(sut.detailData?.priceDouble, expectedDetailData.priceDouble)
        XCTAssertEqual(sut.detailData?.rating, expectedDetailData.rating)
        XCTAssertEqual(sut.detailData?.reviews, expectedDetailData.reviews)
        XCTAssertEqual(sut.detailData?.colors, expectedDetailData.colors)
    }
    
    // MARK: - FetchImages tests
    
    func testFetchImages_Success() throws {
        let expect = expectation(description: "Expect success")
        sut.updateImagesCompletion = {
            expect.fulfill()
        }
        
        sut.detailData = DetailModel(
            name: "test",
            description: "test",
            priceDouble: 100,
            rating: "test",
            reviews: "test",
            colors: nil,
            images: nil
        )
        let imageUrls = [
            URL(string: "https://test.com/image1.jpg")!,
            URL(string: "https://test.com/image2.jpg")!
        ]
        networkManager.imageResult = .success(UIImage())
        
        sut.fetchImages(from: imageUrls)
        
        waitForExpectations(timeout: 1.0)
        XCTAssertNil(sut.errorMessage)
        XCTAssertNotNil(sut.detailData?.images)
        XCTAssertEqual(sut.detailData?.images?.count, 2)
    }
    
    func testFetchImageData_Failed() throws {
        let expect = expectation(description: "Expect wrongURL error")
        sut.updateImagesCompletion = {
            expect.fulfill()
        }
        
        sut.detailData = DetailModel(
            name: "test",
            description: "test",
            priceDouble: 100,
            rating: "test",
            reviews: "test",
            colors: nil,
            images: nil
        )
        let imageUrls = [
            URL(string: "www")!,
            URL(string: "www")!
        ]
        networkManager.imageResult = .failure(NetworkError.wrongURL)
        
        sut.fetchImages(from: imageUrls)
        
        waitForExpectations(timeout: 1.0)
        XCTAssertNotNil(sut.errorMessage)
        XCTAssertEqual(sut.errorMessage, NetworkError.wrongURL.description)
    }
    
}
