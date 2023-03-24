import UIKit

final class CryptoViewController: UIViewController {
    
    //MARK: - Internal properties
    
    var presenter: CryptoPresenterProtocol?

    //MARK: - Private properties
    
    private var cryptoArray = [Crypto]()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.register(CryptoCustomTableViewCell.self, forCellReuseIdentifier: CryptoCustomTableViewCell.identifier)
        view.rowHeight = 60
        view.tableHeaderView = UIView()
        return view
    }()

    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.isHidden = true
        spinner.color = .label
        return spinner
    }()
                
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setup()
    }
    
    //MARK: - Methods
    
    private func setup() {
        title = "Crypto info"
        configureNavBar()
        setupDelegate()
        startSpinner()
        presenter?.getData()
    }
    
    private func configureNavBar() {
        let image = UIImage(systemName: "rectangle.righthalf.inset.filled.arrow.right")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(logOutButton))
    }
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func startSpinner() {
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    private func stopSpinner() {
        spinner.isHidden = true
        spinner.stopAnimating()
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.addSubview(spinner)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.bottom.equalToSuperview()
        }
        
        spinner.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(40)
        }
    }
    
    //MARK: - Actions
    
    @objc private func logOutButton() {
        presenter?.logOut()
        let vc = UINavigationController(rootViewController: ModuleBuilder.createLoginModule())
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true)
    }
}

//MARK: - Extension: UITableViewDelegate & UITableViewDataSource

extension CryptoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cryptoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoCustomTableViewCell.identifier, for: indexPath) as? CryptoCustomTableViewCell else { return UITableViewCell() }
       
        cell.backgroundColor = .clear
        cell.selectionStyle = .blue
        cell.updateCell(model: cryptoArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ModuleBuilder.createDescribeModule(with: cryptoArray[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extension: CryptoViewProtocol

extension CryptoViewController: CryptoViewProtocol {
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let actionCopy = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(actionCopy)
            self.present(alert, animated: true, completion: nil)
            self.stopSpinner()
        }
    }
    
    func updateView(with model: [Crypto]) {
        self.stopSpinner()
        self.cryptoArray = model
        self.tableView.reloadData()
    }
}
