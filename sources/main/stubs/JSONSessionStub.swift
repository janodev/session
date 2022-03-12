import Foundation

/// A SessionStub subclass whose response is "application/json; charset=utf-8".
/// See https://github.com/janodev/session/wiki#usage-example
public final class JSONSessionStub: SessionStub
{
    /// Returns a success (200) session with nil error.
    public static func success(data: Data, url: URL) -> JSONSessionStub? {
        httpURLResponse(statusCode: 200, url: url).flatMap {
            JSONSessionStub(data: data, response: $0, error: nil)
        }
    }
    
    /// Returns a failure session with nil data.
    public static func failure(error: Error, statusCode: Int, url: URL) -> JSONSessionStub? {
        httpURLResponse(statusCode: statusCode, url: url).flatMap {
            JSONSessionStub(data: nil, response: $0, error: error)
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
