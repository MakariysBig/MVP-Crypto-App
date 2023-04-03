import Foundation

protocol CryptoViewProtocol: AnyObject {
    func updateView(with model: [Crypto])
    func updateButtonImage(with state: SortState)
    func showAlert(title: String, message: String)
}

protocol CryptoPresenterProtocol {
    init(VC: CryptoViewProtocol, networkManager: NetworkProtocol, model: [Crypto])
    
    func getData()
    func logOut()
    func sortData()
}
