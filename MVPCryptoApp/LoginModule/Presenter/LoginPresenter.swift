import Foundation

final class LoginPresenter: LoginPresenterProtocol {
  
    private weak var VC: LoginViewProtocol?
    
    init(VC: LoginViewProtocol) {
        self.VC = VC
    }
    
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
}
