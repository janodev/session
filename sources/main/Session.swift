import Foundation

/// Protocol that mimics `URLSession.shared.dataTask`.
///
/// The network client will use two implementations of this protocol:
/// - URLSession.shared for production
/// - 
public protocol Session {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: Session {}

// MARK: - Stubs

/// A Session whose dataTask method returns Data passed through the initializer.
public class SessionStub: Session {
    public var data: Data
    public var response: HTTPURLResponse
    public var error: Error?

    /// Creates a session whose dataTask method returns the arguments of this method.
    /// - Param error: Passing a non nil value will throw during the execution of `SessionStub.data(for:)`.
    public init(data: Data, response: HTTPURLResponse, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }

    public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error {
            throw error
        } else {
            return (data, response)
        }
    }
}

/**
 SessionStub subclass that adds factory methods that create SessionStub instances that return JSON.

 Usage:
 ```
 let url = URL(string: "https://example.com")!
 let data = "{ ... a json response ... }".data(using: .utf8)
 let sessionStub = JSONSessionStub.success(data: data, url: url)

 let client = WeatherClient(session: sessionStub)
 ```
 */
public final class JSONSessionStub: SessionStub {
    /// Returns a success (200) session with nil error.
    public static func success(data: Data, url: URL) -> JSONSessionStub? {
        httpURLResponse(statusCode: 200, url: url).flatMap {
            JSONSessionStub(data: data, response: $0, error: nil)
        }
    }

    /// Returns a failure session with nil data.
    public static func failure(error: Error, statusCode: Int, url: URL) -> JSONSessionStub? {
        httpURLResponse(statusCode: statusCode, url: url).flatMap {
            JSONSessionStub(data: Data(), response: $0, error: error)
        }
    }

    private static func httpURLResponse(statusCode: Int, url: URL) -> HTTPURLResponse? {
        HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: "HTTP/2",
            headerFields: ["content-type": "application/json; charset=utf-8"]
        )
    }
}
