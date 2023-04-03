import UIKit

protocol Builder {
    static func createCryptoModule() -> UIViewController
    static func createLoginModule() -> UIViewController
    static func createDescribeModule(with model: Crypto) -> UIViewController
}

final class ModuleBuilder: Builder {
    static func createDescribeModule(with model: Crypto) -> UIViewController {
        let VC = DescribeViewController()
        let presenter = DescribePresenter(VC: VC, model: model)
        VC.presenter = presenter
        
        return VC
    }
    
    static func createCryptoModule() -> UIViewController {
        let VC = CryptoViewController()
        let model = [Crypto]()
        let networkManager = NetworkManager()
        let presenter = CryptoPresenter(VC: VC, networkManager: networkManager, model: model)
        VC.presenter = presenter
        
        return VC
    }
    
    static func createLoginModule() -> UIViewController {
        let VC = LoginViewController()
        let presenter = LoginPresenter(VC: VC)
        VC.presenter = presenter
        
        return VC
    }
}
