import UIKit

final class DescribeView: UIView {
    
    //MARK: - Properties
    
    private let cryptoNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.numberOfLines = 0
        return label
    }()
    
    private let cryptoAmountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
    
    //MARK: - Initialise
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Update view
    
    func updateView(model: Crypto) {
        let price = String(format: "%.2f", model.marketData.priceUsd)
        let changes24 = model.marketData.percentChangeUsdLast24Hours
        cryptoNameLabel.text = model.name + "(\(model.symbol))"
        cryptoAmountLabel.text = "Price: " + price + "$"
        if changes24 >= 0 {
            changes24Label.text = "24h changes: +" + String(format: "%.2f", changes24) + "%"
        } else {
            changes24Label.text = "24h changes: " + String(format: "%.2f", changes24) + "%"
        }
    }
    
    //MARK: - Add subviews
    
    private func setup() {
        backgroundColor = .systemBackground
        addSubview(mainStack)
        setNeedsUpdateConstraints()
    }
    
    //MARK: - Set constraints
    
    override func updateConstraints() {
        super.updateConstraints()
        
        mainStack.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.lessThanOrEqualTo(-10)
        }
    }
}
