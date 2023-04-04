import Foundation

final class CryptoPresenter: CryptoPresenterProtocol {
    //MARK: - Private properties
    
    private let dispatchGroup = DispatchGroup()
    
    private weak var VC: CryptoViewProtocol?
    private var networkManager: NetworkProtocol?
    private var cryptoArray: [Crypto]
    private var sortState: SortState?

    //MARK: - Initialise
    
    init(VC: CryptoViewProtocol, networkManager: NetworkProtocol, model: [Crypto]) {
        self.VC = VC
        self.cryptoArray = model
        self.networkManager = networkManager
    }
    
    //MARK: - Internal methods
    
    func logOut() {
        UserDefaultsManager.userIsLogin = false
    }
    
    func getArrayCount() -> Int {
        cryptoArray.count
    }
    
    func getModel(with index: Int) -> Crypto {
        return cryptoArray[index]
    }
    
    func sortData() {
        if sortState == .up {
            sortState = .down
            cryptoArray = cryptoArray.sorted { firstValue, secondValue in
                let firstValue = firstValue.marketData.priceUsd
                let secondValue = secondValue.marketData.priceUsd
                return Double(firstValue ?? 0.0) > Double(secondValue ?? 0.0)
            }
        } else {
            sortState = .up
            cryptoArray = cryptoArray.sorted { firstValue, secondValue in
                let firstValue = firstValue.marketData.priceUsd
                let secondValue = secondValue.marketData.priceUsd
                return Double(firstValue ?? 0.0) < Double(secondValue ?? 0.0)
            }
        }
        VC?.updateButtonImage(with: sortState ?? .down)
        VC?.updateView(with: cryptoArray)
    }
    
    func getData() {
        for cryptoName in NameOfCrypto.allCases {
            self.dispatchGroup.enter()
            networkManager?.getCrypto(pair: cryptoName.rawValue) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    self.cryptoArray.append(data.data)
                    self.dispatchGroup.leave()
                case .failure(let error):
                    self.VC?.networkError(with: error)
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.VC?.updateView(with: self.cryptoArray)
        }
    }
}
