import Foundation

protocol Endpoint {
    var scheme: String { get }
    var baseURl: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: String { get }
}
//MARK: - News Endpoint

enum CryptoEndpoint: Endpoint {
    case getData(pair: String)
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }

    var baseURl: String {
        switch self {
        default:
            return "data.messari.io"
        }
    }

    var path: String {
        switch self {
        case .getData(let pair):
            return "/api/v1/assets/\(pair)/metrics"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getData:
            return []
        }
    }

    var method: String {
        switch self {
        case .getData:
            return "GET"
        }
    }
}
