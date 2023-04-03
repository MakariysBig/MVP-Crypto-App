import Foundation

final class DescribePresenter: DescribePresenterProtocol {
    
    weak var VC: DescribeViewProtocol?
    private let model: Crypto
    
    init(VC: DescribeViewProtocol, model: Crypto) {
        self.VC = VC
        self.model = model
    }
    
    func getData() {
        VC?.updateView(with: model)
    }
}
