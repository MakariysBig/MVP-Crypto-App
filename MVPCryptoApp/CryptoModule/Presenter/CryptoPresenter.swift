import Foundation

final class CryptoPresenter: CryptoPresenterProtocol {
    //MARK: - Private properties
    
    private let dispatchGroup = DispatchGroup()
    
    private weak var VC: CryptoViewProtocol?
    private var networkManager: NetworkProtocol?
    private var modelArray: [Crypto]
    private var sortState: SortState?

    //MARK: - Initialise
    
    init(VC: CryptoViewProtocol, networkManager: NetworkProtocol, model: [Crypto]) {
        self.VC = VC
        self.modelArray = model
        self.networkManager = networkManager
    }
    
    //MARK: - Internal methods
    
    func logOut() {
        UserDefaultsManager.userIsLogin = false
    }
    
    func sortData() {
        if sortState == .up {
            sortState = .down
            modelArray = modelArray.sorted { firstValue, secondValue in
                let firstValue = firstValue.marketData.priceUsd
                let secondValue = secondValue.marketData.priceUsd
                return Double(firstValue ?? 0.0) > Double(secondValue ?? 0.0)
            }
        } else {
            sortState = .up
            modelArray = modelArray.sorted { firstValue, secondValue in
                let firstValue = firstValue.marketData.priceUsd
                let secondValue = secondValue.marketData.priceUsd
                return Double(firstValue ?? 0.0) < Double(secondValue ?? 0.0)
            }
        }
        VC?.updateButtonImage(with: sortState ?? .down)
        VC?.updateView(with: modelArray)
    }
    
    func getData() {
        for cryptoName in NameOfCrypto.allCases {
            self.dispatchGroup.enter()
            networkManager?.getCrypto(pair: cryptoName.rawValue) { [weak self] result in
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
