import Foundation

protocol DescribeViewProtocol: AnyObject {
    func updateView(with model: Crypto)
}

protocol DescribePresenterProtocol {
    init(VC: DescribeViewProtocol, model: Crypto)
    
    func getData()
}
