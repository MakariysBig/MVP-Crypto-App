import Foundation

protocol LoginViewProtocol: AnyObject {
    func showAlert(title: String, message: String)
}

protocol LoginPresenterProtocol {
    func checkData(userName: String?, password: String?) -> Bool
}
