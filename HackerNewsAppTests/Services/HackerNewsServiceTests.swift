//
//  HackerNewsServiceTests.swift
//  HackerNewsAppTests
//
//  Created by Brian Ezequiel Fritz on 19/11/2020.
//

import XCTest

@testable import HackerNewsApp

class HackerNewsServiceTests: XCTestCase {
    private var service: HackerNewsService!
    private let networkManager = NetworkManagerMock<HackerNews>()
    private var response: [HackerNew] = []
    private let cacheManager = CacheManagerMock<[HackerNew]>()
    private let successResponse: APIResult = .success(HackerNews(hits: [HackerNew(createdAt: "createdAt",
                                                                                  title: "title",
                                                                                  author: "author",
                                                                                  url: "url",
                                                                                  storyTitle: "storyTitle")]))
    private var expect: XCTestExpectation!
    
    override func setUp() {
        service = HackerNewsService(networkManager: networkManager, cacheManager: cacheManager)
    }
    

    func testReturnAPIResponseOnSuccess() {
        givenSuccessResponse()
        
        whenFetchHackerNews()
        
        thenNetworkManagerIsCalled(times: 1)
        thenCacheManagerIsCalled(times: 0)
    }
    
    func testReturnCachedResponseOnFailure() {
        givenFailureResponse()
        
        whenFetchHackerNews()
        
        thenNetworkManagerIsCalled(times: 1)
        thenCacheManagerIsCalled(times: 1)
    }
    
    private func givenSuccessResponse() {
        expect = expectation(description: "Expect success")
        networkManager.response = successResponse
    }
    
    private func givenFailureResponse() {
        expect = expectation(description: "Failure expected")
        networkManager.response = .failure(InvalidURLError())
    }
    
    private func whenFetchHackerNews() {
        service.fetchHackerNews { result in
            self.expect.fulfill()
            self.response = result
        }
        wait(for: [expect], timeout: 0.5)
    }
    
    private func thenNetworkManagerIsCalled(times: Int) {
        XCTAssertEqual(networkManager.timesCalled, times)
    }
    
    private func thenCacheManagerIsCalled(times: Int) {
        XCTAssertEqual(cacheManager.timesCalled, times)
    }
}