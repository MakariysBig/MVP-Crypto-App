import Foundation

final class DescribePresenter: DescribePresenterProtocol {
    
    //MARK: - Properties
    
    weak var VC: DescribeViewProtocol?
    private let model: Crypto
    
    //MARK: - Initialise
    
    init(VC: DescribeViewProtocol, model: Crypto) {
        self.VC = VC
        self.model = model
    }
    
    //MARK: - Methods
    
    func getData() {
        VC?.updateView(with: model)
    }
}
