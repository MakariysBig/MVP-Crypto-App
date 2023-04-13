import Foundation

//MARK: - View

protocol CryptoViewProtocol: AnyObject {
    func updateView()
    func updateButtonImage(with state: SortState)
    func networkError(with error: String)
}

//MARK: - Presenter

protocol CryptoPresenterProtocol {
    init(VC: CryptoViewProtocol, networkManager: NetworkProtocol, router: MainRouterProtocol)
    
    func getData()
    func logOut()
    func sortData()
    func getArrayCount() -> Int
    func getModel(with index: Int) -> Crypto
    func showDetailModule(model: Crypto)
}
