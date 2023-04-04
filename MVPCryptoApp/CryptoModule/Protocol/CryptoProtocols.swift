import Foundation

protocol CryptoViewProtocol: AnyObject {
    func updateView()
    func updateButtonImage(with state: SortState)
    func networkError(with error: Error)
}

protocol CryptoPresenterProtocol {
    init(VC: CryptoViewProtocol, networkManager: NetworkProtocol, model: [Crypto])
    
    func getData()
    func logOut()
    func sortData()
    func getArrayCount() -> Int
    func getModel(with index: Int) -> Crypto
}
