import UIKit

final class MainRouter: MainRouterProtocol {
    
    //MARK: - Properties
    
    var navigationController: UINavigationController?
    var moduleBuilder: ModuleBuilderProtocol?
    
    //MARK: - Initialise
    
    init(navigationController: UINavigationController, moduleBuilder: ModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    
    //MARK: - Methods
    
    func initialCryptoViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = moduleBuilder?.createCryptoModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func initialLoginViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = moduleBuilder?.createLoginModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetail(model: Crypto) {
        if let navigationController = navigationController {
            guard let describeViewController = moduleBuilder?.createDescribeModule(with: model, router: self) else { return }
            navigationController.pushViewController(describeViewController, animated: true)
        }
    }
}
