import Foundation

final class CryptoPresenter: CryptoPresenterProtocol {
    
    //MARK: - Private properties
    
    private let dispatchGroup = DispatchGroup()
    private let networkManager = NetworkManager()
    
    private var modelArray: [Crypto]
    private weak var VC: CryptoViewProtocol?
    
    //MARK: - Initialise
    
    init(VC: CryptoViewProtocol, model: [Crypto]) {
        self.VC = VC
        self.modelArray = model
    }
    
    //MARK: - Internal methods
    
    func logOut() {
        UserDefaultsManager.userIsLogin = false
    }
    
    func getData() {
        for cryptoName in NameOfCrypto.allCases {
            self.dispatchGroup.enter()
            networkManager.getCrypto(pair: cryptoName.rawValue) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    self.modelArray.append(data.data)
                    self.dispatchGroup.leave()
                case .failure(_):
                    self.VC?.showAlert(title: "Network Error", message: "Bad internet connection")
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.VC?.updateView(with: self.modelArray)
        }
    }
}
