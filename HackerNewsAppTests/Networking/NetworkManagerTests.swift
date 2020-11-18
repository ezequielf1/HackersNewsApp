//
//  NetworkManagerTests.swift
//  HackerNewsAppTests
//
//  Created by Brian Ezequiel Fritz on 18/11/2020.
//

import XCTest

@testable import HackerNewsApp

class NetworkManagerTests: XCTestCase {
    private let internalServerErrorMessage = "Internal server error"
    
    private var networkManager: NetworkManagerImplementation?
    private var mockSession = URLSessionMock()
    private var request: APIRequest!
    private var expectation: XCTestExpectation!
    private var mockResponse = MockResponse(mockFirstProperty: "FirstProperty",
                                            mockSecondProperty: "SecondProperty")
    
    override func setUp() {
        networkManager = NetworkManagerImplementation.shared
        networkManager?.session = mockSession
    }
    
    func testInvalidURLReturnsFailure() {
        givenExpectation(description: "Invalid URL failure")
        givenInvalidURLRequest()
        var response: APIResult<MockResponse>?
        
        whenDoRequest { (result: APIResult<MockResponse>) in
            response = result
        }
        
        thenResponseMatchesError(response: response, expectedError: InvalidURLError())
    }
    
    func testSuccessPutRequestReturnsSuccess() {
        givenExpectation(description: "Success request")
        givenMockModel()
        givenSuccessResponse()
        givenPutRequest()
        
        var response: APIResult<MockResponse>?
        
        whenDoRequest { (result: APIResult<MockResponse>) in
            response = result
        }
        
        thenResponseDataMatches(response: response, expectedData: mockResponse)
    }
    
    func testFailureRequestForDecodingError() {
        givenExpectation(description: "Decoding failure")
        givenSuccessResponse()
        givenPutRequest()
        
        var response: APIResult<MockResponse>?
        
        whenDoRequest { (result: APIResult<MockResponse>) in
            response = result
        }
        
        thenResponseMatchesError(response: response, expectedError: DecodingError())
    }
    
    func testNoContentSuccessResponse() {
        givenExpectation(description: "No content response")
        givenSuccessResponse(statusCode: 204)
        givenPutRequest()
        
        var response: APIResult<MockResponse>?
        
        whenDoRequest { (result: APIResult<MockResponse>) in
            response = result
        }
        
        thenResponseDataMatches(response: response, expectedData: nil)
        
    }
    
    func testFailureDueToInternalServerError() {
        givenExpectation(description: "Internal error")
        givenPutRequest()
        givenFailureResponse()
        givenInvalidBody()
        
        var response: APIResult<MockResponse>?
        
        whenDoRequest { (result: APIResult<MockResponse>) in
            response = result
        }
        
        thenResponseMatchesError(response: response, expectedError: InternalServerError(message: internalServerErrorMessage))
    }
    
    private func whenDoRequest<T: Codable>(completionHandler: @escaping ((APIResult<T>) -> Void)) {
        networkManager?.doRequest(request, { (result: APIResult<T>) in
            self.expectation.fulfill()
            completionHandler(result)
        })
    }
    
    private func givenExpectation(description: String) {
        expectation = expectation(description: description)
    }
    
    private func givenInvalidURLRequest() {
        request = APIRequest(request: MockInvalidURLAPIRequest())
    }
    
    private func givenFailureResponse(statusCode: Int = 500) {
        mockSession.response =  createMockURLResponseWith(statusCode: statusCode)
    }
    
    private func givenSuccessResponse(statusCode: Int = 200) {
        mockSession.response = createMockURLResponseWith(statusCode: statusCode)
    }
    
    private func givenPutRequest() {
        request = APIRequest(request: MockPutAPIRequest())
    }
    
    private func thenResponseMatchesError<T: Codable>(response: APIResult<T>?,
                                                      expectedError: NetworkError) {
        wait(for: [expectation], timeout: 0.1)
        if case .failure(let error) = response {
            XCTAssertEqual(error.message, expectedError.message)
        } else {
            XCTFail("Success was not expected")
        }
    }
    
    private func thenResponseDataMatches<T: Equatable>(response: APIResult<T>?, expectedData: T?) {
        wait(for: [expectation], timeout: 0.05)
        switch response {
        case .success(let data):
            XCTAssertEqual(data, expectedData)
        default:
            XCTFail("Failure was not expected")
        }
    }
    
    private func givenMockModel() {
        let jsonResponse = createJson(with: mockResponse)
        mockSession.data = jsonResponse
    }
    
    private func givenInvalidBody() {
        let data: [String: String] = ["message": internalServerErrorMessage]
        mockSession.data = data.convertToJson()
    }
    
    private func createJson(with response: MockResponse) -> Data? {
        let parameters: [String: String] = ["mockFirstProperty": response.mockFirstProperty,
                                            "mockSecondProperty": response.mockSecondProperty]
        return parameters.convertToJson()
    }
    
    private func createMockURLResponseWith(statusCode: Int) -> URLResponse? {
        HTTPURLResponse(url: URL(fileURLWithPath: "url"), statusCode: statusCode, httpVersion: nil, headerFields: nil)
    }
}

private extension Dictionary {
    func convertToJson() -> Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
}

