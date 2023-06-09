import UIKit
import SnapKit

final class CryptoCustomTableViewCell: UITableViewCell {
    
    //MARK: - Cell identifier
    
    static let identifier = "CryptoCustomTableViewCell"
    
    //MARK: - Properties

    private let cryptoName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    private let changesLabel: UILabel = {
        let label = UILabel()
        label.text = "24h changes:"
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return label
    }()
    
    private let changesValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return label
    }()
    
    private let cryptoAmount: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    private lazy var topStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cryptoName, cryptoAmount])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 5
        return stack
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [changesLabel, changesValue])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 5
        return stack
    }()
    
    //MARK: - Initialise
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cryptoName.text   = nil
        cryptoAmount.text = nil
        changesValue.text = nil
    }
    
    //MARK: - Update cell
    
    func updateCell(model: Crypto) {
        let percent = model.marketData.percentChangeUsdLast24Hours
        let amount = model.marketData.priceUsd
        
        cryptoName.text = model.name + "(\(model.symbol)) ="
        cryptoAmount.text = String(format: "%.2f", amount) + "$"
        
        if percent >= 0 {
            changesValue.text = "+" + String(format: "%.2f", percent) + "%"
            changesValue.textColor = .systemGreen
        } else {
            changesValue.text = String(format: "%.2f", percent) + "%"
            changesValue.textColor = .systemRed
        }
    }
    
    //MARK: - Add subviews
    
    private func setup() {
        backgroundColor = .clear
        selectionStyle  = .blue
        contentView.addSubview(topStackView)
        contentView.addSubview(bottomStackView)
        updateConstraintsIfNeeded()
    }
    
    //MARK: - Set constrains
    
    override func updateConstraints() {
        super.updateConstraints()
        
        topStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(14)
            $0.right.lessThanOrEqualTo(self.snp.right).inset(10)
        }
        
        bottomStackView.snp.makeConstraints {
            $0.top.equalTo(topStackView.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(14)
            $0.right.lessThanOrEqualTo(self.snp.right).inset(10)
        }
    }
}
