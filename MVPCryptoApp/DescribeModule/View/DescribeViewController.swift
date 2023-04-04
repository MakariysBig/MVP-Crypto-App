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
    
    private let changes1Label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let allTimeHighLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let rankInWordLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cryptoNameLabel, rankInWordLabel, allTimeHighLabel, cryptoAmountLabel, changes1Label, changes24Label])
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
    
    private func changeStringColor(mainString: String, value: Double) -> NSMutableAttributedString {
        let sign = value >= 0 ? "+" : ""
        let string = String(format: "\(sign)%.2f", value)
        let mainString = mainString
        
        let attributedString = NSMutableAttributedString(string: mainString + string + "%")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: value >= 0 ? UIColor.systemGreen : UIColor.systemRed,
                                      range: NSRange(location: mainString.count , length: string.count + 1))
        return attributedString
    }
}

//MARK: - Extension: DescribeViewProtocol

extension DescribeViewController: DescribeViewProtocol {
    func updateView(with model: Crypto) {
        let price = model.marketData.priceUsd
        let changes24 = model.marketData.percentChangeUsdLast24Hours
        let changes1 = model.marketData.percentChangeUsdLast1Hour
        
        cryptoNameLabel.text   = model.name + "(\(model.symbol))"
        rankInWordLabel.text   = "Rank in the world - №" + String(model.marketcap.rank)
        allTimeHighLabel.text  = "All time high:" + String(format: " %.2f$", model.allTimeHigh.price)
        cryptoAmountLabel.text = "Price: " + String(format: "%.2f", price) + "$"

        changes24Label.attributedText = changeStringColor(mainString: "24h changes: ", value: changes24)
        changes1Label.attributedText = changeStringColor(mainString: "1h changes: ", value: changes1)
    }
}
