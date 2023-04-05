import Foundation

final class LoginPresenter: LoginPresenterProtocol {
    
    //MARK: - Properties
    
    private weak var VC: LoginViewProtocol?
    private let router: MainRouterProtocol?
    
    //MARK: - Initialise
    
    init(VC: LoginViewProtocol, router: MainRouterProtocol) {
        self.VC = VC
        self.router = router
    }
    
    //MARK: - Methods
    
    func checkData(userName: String?, password: String?) -> Bool {
        if userName == "1234",
           password == "1234" {
            UserDefaultsManager.userIsLogin = true
            return true
        } else {
            VC?.showAlert(title: "Please fill all the fields!!!", message: "Login: 1234\nPassword: 1234")
            return false
        }
    }
    
    func goToCryptoModel() {
        router?.initialCryptoViewController()
    }
}
