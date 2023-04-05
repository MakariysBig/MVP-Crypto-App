import Foundation

protocol LoginViewProtocol: AnyObject {
    func showAlert(title: String, message: String)
}

protocol LoginPresenterProtocol {
    init(VC: LoginViewProtocol, router: MainRouterProtocol)
    
    func checkData(userName: String?, password: String?) -> Bool
    func goToCryptoModel()
}
