import Foundation

protocol CryptoViewProtocol: AnyObject {
    func updateView(with model: [Crypto])
    func showAlert(title: String, message: String)
}

protocol CryptoPresenterProtocol {
    init(VC: CryptoViewProtocol, model: [Crypto])
    
    func getData()
    func logOut()
}
