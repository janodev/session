import Foundation

/// A Session whose dataTask method returns stubbed data.
/// See https://github.com/janodev/session/wiki#usage-example
public class SessionStub: Session
{
    public var data: Data?
    public var response: HTTPURLResponse?
    public var error: Error?
        
    /// Creates a session whose dataTask method returns the arguments of this method.
    public init(data: Data?, response: HTTPURLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    // MARK: - Session
    
    public func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> SessionDataTask {
        SessionDataTaskStub(completionHandler: { completionHandler(self.data, self.response, self.error) })
    }
}
