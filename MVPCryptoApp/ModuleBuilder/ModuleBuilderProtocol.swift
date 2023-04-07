import UIKit

protocol ModuleBuilderProtocol {
    func createCryptoModule(router: MainRouterProtocol) -> UIViewController
    func createLoginModule(router: MainRouterProtocol) -> UIViewController
    func createDescribeModule(with model: Crypto, router: MainRouterProtocol) -> UIViewController
}
