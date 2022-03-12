import Foundation

enum HTTPError: Error {
    
    case badServerResponse
    
    var code: Int {
        switch self {
        case .badServerResponse: return NSURLErrorBadServerResponse
        }
    }
    
    var description: String {
        switch self {
        case .badServerResponse: return "500 Server Error"
        }
    }
}
