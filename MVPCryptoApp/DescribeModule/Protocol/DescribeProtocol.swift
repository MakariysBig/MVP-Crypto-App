import Foundation

//MARK: - View

protocol DescribeViewProtocol: AnyObject {
    func updateView(with model: Crypto)
}

//MARK: - Presenter

protocol DescribePresenterProtocol {
    init(VC: DescribeViewProtocol, model: Crypto)
    
    func getData()
}
