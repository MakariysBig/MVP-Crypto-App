import Foundation

protocol RepositoryProtocol {
    func getCrypto(pair: String, completion: @escaping (Result< CryptoModel, Error >) -> Void)
}

final class NetworkManager: RepositoryProtocol {
    private let networkEngine: NetworkEngine

    init(networkEngine: NetworkEngine = NetworkEngine()) {
        self.networkEngine = networkEngine
    }
    
    func getCrypto(pair: String, completion: @escaping (Result< CryptoModel, Error >) -> Void) {
        networkEngine.request(endpoint: CryptoEndpoint.getData(pair: pair), completion: completion)
    }
}
