import UIKit

final class DescribeViewController: UIViewController {
    
    //MARK: - Properties
    
    private let repository = Repository()
    private let crypto: Crypto
    private let index: Int
    
    private var rootView: DescribeView {
        view as! DescribeView
    }
    
    //MARK: - Initialise
    
    init(crypto: Crypto, index: Int) {
        self.crypto = crypto
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func loadView() {
        view = DescribeView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Private methods
    
    private func setup() {
        rootView.updateView(model: crypto)
    }
}
