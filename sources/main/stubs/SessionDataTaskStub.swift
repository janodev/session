import Foundation

/// A SessionDataTask that runs a stubbed closure when resume() is invoked.
public final class SessionDataTaskStub: SessionDataTask {
    
    private let completionHandler: () -> Void
    
    public init(completionHandler: @escaping () -> Void) {
        self.completionHandler = completionHandler
    }
    
    public func resume() {
        completionHandler()
    }
}
