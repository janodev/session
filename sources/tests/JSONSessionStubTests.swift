@testable import Session
import XCTest

final class JSONSessionStubTests: XCTestCase
{
    /// Test *stubbing* a request to https://bananas.com that returns "{}" as JSON.
    func testSuccess()
    {
        // data we are stubbing
        let jsonStub = "{}"
        guard let data = jsonStub.data(using: .utf8) else { return XCTFail() }
        guard let url = URL(string: "https://bananas.com") else { return XCTFail() }
        
        // Given a stubbed session
        let request = URLRequest(url: url)
        guard let session = JSONSessionStub.success(data: data, url: url) else {
            XCTFail("Failed to create session.")
            return
        }
        
        // When running a dataTask request
        let exp = expectation(description: "Expected to complete within a second.")
        session.dataTask(with: request, completionHandler: { data, response, error in
                
            // It returns the same data
            guard let data = data else {
                XCTFail("Expected non nil data")
                return
            }
            XCTAssertEqual(jsonStub, String(data: data, encoding: .utf8))
            
            // It returns the same URL
            XCTAssertEqual(url, response?.url)
            
            // It has content type "application/json; charset=utf-8"
            XCTAssertEqual("utf-8", response?.textEncodingName)
            XCTAssertEqual("application/json", response?.mimeType)
            
            // It has nil error
            XCTAssertNil(error)
        
            exp.fulfill()
        })
        .resume()
        wait(for: [exp], timeout: 1.0)
    }

    func testFailure()
    {
        // data we are stubbing
        guard let url = URL(string: "https://bananas.com") else { return XCTFail() }
        
        // Given a stubbed session
        let request = URLRequest(url: url)
        guard let session = JSONSessionStub.failure(error: HTTPError.badServerResponse,
                                                    statusCode: HTTPError.badServerResponse.code,
                                                    url: url) else {
            XCTFail("Failed to create session.")
            return
        }
        
        // When running a dataTask request
        let exp = expectation(description: "Expected to complete within a second.")
        session.dataTask(with: request, completionHandler: { data, response, error in
                
            // It returns nil data
            XCTAssertNil(data)
            
            // It returns the same URL
            XCTAssertEqual(url, response?.url)
            
            // It has content type "application/json; charset=utf-8"
            XCTAssertEqual("utf-8", response?.textEncodingName)
            XCTAssertEqual("application/json", response?.mimeType)
            
            // It returns the same error
            guard let error = error as? HTTPError else {
                XCTFail("Expected non nil error")
                return
            }
            XCTAssertEqual(error, .badServerResponse)
        
            exp.fulfill()
        })
        .resume()
        wait(for: [exp], timeout: 1.0)
    }
}
