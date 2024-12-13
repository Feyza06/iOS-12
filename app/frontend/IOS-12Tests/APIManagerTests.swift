////
////  APIManagerTests.swift
////  IOS-12
////
////  Created by Amira Kostadinova on 11.12.24.
////
//
//import XCTest
//
//class APIManagerTests: XCTestCase {
//    
//    var apiManager: APIManager!
//    
//    override func setUp() {
//        super.setUp()
//        apiManager = APIManager()
//        URLProtocol.registerClass(MockURLProtocol.self)
//    }
//    
//    override func tearDown() {
//        URLProtocol.unregisterClass(MockURLProtocol.self)
//        apiManager = nil
//        super.tearDown()
//    }
//    
//    // Test: Successful API Request
//    func testRequest_Success(){
//        let mockData = """
//        {
//         "message": "Post uploaded successfully"
//        }
//        """.data(using: .utf8)
//        MockURLProtocol.mockData = mockData
//        
//        // simulate a mock response
//        let mockResponse = HTTPURLResponse(url: URL(string: "http://localhost:3000/posts")!,
//                                           statusCode: 200,
//                                           httpVersion: nil,
//                                           headerFields: nil)
//        MockURLProtocol.mockResponse = mockResponse
//        
//        let postRequest = PostRequest(petName: "Buddy",
//                                      fee: 100,
//                                      gender:"Male",
//                                      petType:"Dog",
//                                      petBreed:"Jack Russel",
//                                      birthday: Date(),
//                                      description: "A playful dog",
//                                      location: "123 Street",
//                                      photo: false)
//        let endpoint = UploadPostEndpoint(postRequest: postRequest)
//        
//        let expectation = self.expectation(description: "Upload Post Success")
//        
//        apiManager.request(modelType: PostResponse.self, type:endpoint) { result in
//            switch result{
//            case .success(let response):
//                XCTAssertEqual(response.message, "Post uploaded successfully")
//                expectation.fulfill()
//            case .failure:
//                XCTFail("Request should succeed")
//            }
//        }
//        waitForExpectations(timeout: 5, handler: nil)
//    }
//    
//    
//    // Test: Failed API Request
//    
//    // Test: Decoding Error
//    
//    
//}
//
