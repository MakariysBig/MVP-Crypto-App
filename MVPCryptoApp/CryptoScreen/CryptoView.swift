import UIKit
import SnapKit

final class CryptoView: UIView {
    
    //MARK: - Properties
    
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.register(CryptoCustomTableViewCell.self, forCellReuseIdentifier: CryptoCustomTableViewCell.identifier)
        view.rowHeight = 60
//        view.separatorInset = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 14)
        view.tableHeaderView = UIView()
        return view
    }()

    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.isHidden = true
        spinner.color = .label
        return spinner
    }()
    
    //MARK: - Initialise

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Add subview
    
    private func setup() {
        backgroundColor = .systemBackground
        addSubview(tableView)
        tableView.addSubview(spinner)
        updateConstraintsIfNeeded()
    }
    
    //MARK: - Set constraints
    
    override func updateConstraints() {
        super.updateConstraints()
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.left.right.bottom.equalToSuperview()
        }
        
        spinner.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(40)
        }
    }
}

