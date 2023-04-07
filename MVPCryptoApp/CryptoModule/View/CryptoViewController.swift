import UIKit

final class CryptoViewController: UIViewController {
    
    //MARK: - Internal properties
    
    var presenter: CryptoPresenterProtocol?
    
    //MARK: - Private properties
        
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
    
    private let sortButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "arrow.down")
        button.setTitle("Sort", for: .normal)
        button.setImage(image, for: .normal)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setup()
    }
    
    //MARK: - Private methods
    
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: sortButton)
        sortButton.addTarget(self, action: #selector(sortData), for: .touchUpInside)
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
    
    //MARK: - Setup layout
    
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
    }
    
    @objc private func sortData() {
        presenter?.sortData()
    }
}

//MARK: - Extension: UITableViewDelegate & UITableViewDataSource

extension CryptoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getArrayCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoCustomTableViewCell.identifier, for: indexPath) as? CryptoCustomTableViewCell else { return UITableViewCell() }
        let model = presenter?.getModel(with: indexPath.row)
        if let model = model  {
            cell.updateCell(model: model)
        }
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .blue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = presenter?.getModel(with: indexPath.row)
        if let model = model  {
            presenter?.showDetailModule(model: model)
        }
    }
}

// MARK: - Extension: CryptoViewProtocol

extension CryptoViewController: CryptoViewProtocol {
    func updateButtonImage(with state: SortState) {
        if state == .up {
            sortButton.setImage( UIImage(systemName: "arrow.down"), for: .normal)
        } else {
            sortButton.setImage( UIImage(systemName: "arrow.up"), for: .normal)
        }
        tableView.reloadData()
    }
    
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let actionCopy = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(actionCopy)
            self.present(alert, animated: true, completion: nil)
            self.stopSpinner()
        }
    }
    
    func updateView() {
        self.stopSpinner()
        self.tableView.reloadData()
    }
    
    func networkError(with error: Error) {
        self.stopSpinner()
        self.showAlert(title: "We have a problem", message: "\(error.localizedDescription)")
    }
}
