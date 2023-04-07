import UIKit

final class ModuleBuilder: ModuleBuilderProtocol {
    func createDescribeModule(with model: Crypto, router: MainRouterProtocol) -> UIViewController {
        let VC = DescribeViewController()
        let presenter = DescribePresenter(VC: VC, model: model)
        VC.presenter = presenter
        
        return VC
    }
    
    func createCryptoModule(router: MainRouterProtocol) -> UIViewController {
        let VC = CryptoViewController()
        let networkManager = NetworkManager()
        let presenter = CryptoPresenter(VC: VC, networkManager: networkManager, router: router)
        VC.presenter = presenter
        
        return VC
    }
    
    func createLoginModule(router: MainRouterProtocol) -> UIViewController {
        let VC = LoginViewController()
        let presenter = LoginPresenter(VC: VC, router: router)
        VC.presenter = presenter
        
        return VC
    }
}
