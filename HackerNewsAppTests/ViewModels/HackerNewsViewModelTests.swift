//
//  HackerNewsViewModelTests.swift
//  HackerNewsAppTests
//
//  Created by Brian Ezequiel Fritz on 19/11/2020.
//

import XCTest

@testable import HackerNewsApp

class HackerNewsViewModelTests: XCTestCase {
    private var viewModel: HackerNewsViewModel?
    private let service = HackerNewsServiceMock()
    private let mockResponse = [HackerNewDTO(createdAt: "2020:04:03T03:06:25.000Z",
                                             title: "title",
                                             author: "author",
                                             storyUrl: "storyUrl",
                                             storyTitle: "storyTitle"),
                                HackerNewDTO(createdAt: "2019:04:03T03:06:25.000Z",
                                             title: "title2",
                                             author: "author2",
                                             storyUrl: "storyUrl2",
                                             storyTitle: "storyTitle2")]
    
    private let expectedSortedResponse = [HackerNewDTO(createdAt: "2019:04:03T03:06:25.000Z",
                                                       title: "title2",
                                                       author: "author2",
                                                       storyUrl: "storyUrl2",
                                                       storyTitle: "storyTitle2"),
                                          HackerNewDTO(createdAt: "2020:04:03T03:06:25.000Z",
                                                       title: "title",
                                                       author: "author",
                                                       storyUrl: "storyUrl",
                                                       storyTitle: "storyTitle")]
    
    private let expectedResponseWithDeletedNew = [HackerNewDTO(createdAt: "2020:04:03T03:06:25.000Z",
                                                               title: "title",
                                                               author: "author",
                                                               storyUrl: "storyUrl",
                                                               storyTitle: "storyTitle")]
    private var hackerNewsValue: [HackerNew]!
    private var expect: XCTestExpectation!
    
    override func setUp() {
        viewModel = HackerNewsViewModel(service: service)
    }
    
    func testWhenFetchHackerNewsThenDynamicHackerNewsIsUpdated() {
        givenExpectation(description: "Dynamic Hacker News updated")
        givenMockResponse()
        givenHackerNewsBinds()
        
        whenFetchHackerNews()
        
        thenWaitForExpectation(time: 0.1)
        thenFetchHackerNewsFromServiceIsCalled(times: 1)
        thenResponseIsEqualTo(expectedResponse: expectedSortedResponse)
    }
    
    func testWhenDeleteOneNewThenTheyAreRemovedFromNextFetchResponse() {
        givenExpectation(description: "First fetch")
        givenMockResponse()
        givenHackerNewsBinds()
        
        whenFetchHackerNews()
        
        thenWaitForExpectation(time: 0.1)
        
        whenDeleteHackerNew()
        
        givenExpectation(description: "Second fetch")
        givenHackerNewsBinds()
        
        whenFetchHackerNews()
        
        thenWaitForExpectation(time: 0.1)
        thenFetchHackerNewsFromServiceIsCalled(times: 2)
        thenResponseIsEqualTo(expectedResponse: expectedResponseWithDeletedNew)
    }
    
    private func givenMockResponse() {
        service.response = mockResponse
    }
    
    private func givenExpectation(description: String) {
        expect = expectation(description: description)
    }
    
    private func givenHackerNewsBinds() {
        viewModel?.hackerNews.bind { hackerNews in
            self.hackerNewsValue = hackerNews
            self.expect.fulfill()
        }
    }
    
    private func whenFetchHackerNews() {
        viewModel?.fetchHackerNews()
    }
    
    private func whenDeleteHackerNew() {
        viewModel?.hackerNewWasDeleted(viewModel!.hackerNews.value.first!)
    }
    
    private func thenWaitForExpectation(time: TimeInterval) {
        wait(for: [expect], timeout: time)
    }
    
    private func thenResponseIsEqualTo(expectedResponse: [HackerNewDTO]) {
        let mappedExpectedResponse = expectedResponse.map { HackerNew(from: $0) }
        XCTAssertEqual(hackerNewsValue, mappedExpectedResponse)
    }
    
    private func thenFetchHackerNewsFromServiceIsCalled(times: Int) {
        XCTAssertEqual(service.fetchHackerNewsTimeCalled, times)
    }
}
