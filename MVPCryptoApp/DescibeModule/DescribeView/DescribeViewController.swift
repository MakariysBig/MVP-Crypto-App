import UIKit
import SnapKit

final class DescribeViewController: UIViewController {
    
    //MARK: - Internal properties
    
    var presenter: DescribePresenterProtocol?
    
    //MARK: - Private properties
    
    private let cryptoNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        return label
    }()
    
    private let cryptoAmountLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let changes24Label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cryptoNameLabel, cryptoAmountLabel, changes24Label])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.spacing = 5
        return stack
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        presenter?.getData()
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemBackground
        view.addSubview(mainStack)
        
        mainStack.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.lessThanOrEqualTo(-10)
        }
    }
}

//MARK: - Extension: DescribeViewProtocol

extension DescribeViewController: DescribeViewProtocol {
    func updateView(with model: Crypto) {
        let price = model.marketData.priceUsd
        let changes24 = model.marketData.percentChangeUsdLast24Hours
        
        cryptoNameLabel.text = model.name + "(\(model.symbol))"
        
        if let price = price {
            cryptoAmountLabel.text = "Price: " + String(format: "%.2f", price) + "$"
        } else {
            cryptoAmountLabel.text = "n/d"
        }
        
        guard let changes24 = changes24 else {
            return changes24Label.text = "n/d"
        }
        
        if changes24 >= 0 {
            changes24Label.text = "24h changes: +" + String(format: "%.2f", changes24) + "%"
        } else {
            changes24Label.text = "24h changes: " + String(format: "%.2f", changes24) + "%"
        }
    }
}
