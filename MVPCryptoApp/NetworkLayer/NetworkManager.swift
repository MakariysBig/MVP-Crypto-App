import Foundation

protocol NetworkProtocol {
    func getCrypto(pair: String, completion: @escaping (Result< CryptoModel, Error >) -> Void)
}

final class NetworkManager: NetworkProtocol {
    private let networkEngine: NetworkEngine

    init(networkEngine: NetworkEngine = NetworkEngine()) {
        self.networkEngine = networkEngine
    }
    
    func getCrypto(pair: String, completion: @escaping (Result< CryptoModel, Error >) -> Void) {
        networkEngine.request(endpoint: CryptoEndpoint.getData(pair: pair), completion: completion)
    }
}
