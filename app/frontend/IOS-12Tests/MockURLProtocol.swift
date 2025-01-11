//
//  MockURLProtocol.swift
//  IOS-12
//
//  Created by Amira Kostadinova on 11.12.24.
//

import Foundation

class MockURLProtocol: URLProtocol {
    
    static var mockData: Data?
    static var mockError: Error?
    static var mockResponse: HTTPURLResponse?
    
    // determines whether this protocol can handle the request
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    // return request changes
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    // Starts loading the request and mocks the response
        override func startLoading() {
            if let data = MockURLProtocol.mockData {
                client?.urlProtocol(self, didReceive: MockURLProtocol.mockResponse ?? HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: data)
            } else if let error = MockURLProtocol.mockError {
                client?.urlProtocol(self, didFailWithError: error)
            }
            client?.urlProtocolDidFinishLoading(self)
        }
        
        override func stopLoading() {
            // No-op for mocking
        }
}

