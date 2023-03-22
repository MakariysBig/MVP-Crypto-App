import UIKit

final class NewsViewController: UIViewController {
    
    //MARK: - Properties
    private let dispatchGroup = DispatchGroup()
    private var cryptoArray = [Crypto]()
    private var rootView: NewsView {
        view as! NewsView
    }
        
    private let repository = Repository()
    
    //MARK: - Livecycle
    
    override func loadView() {
        view = NewsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Methods
    
    private func setup() {
        title = "Crypto info"
        configureNavBar()
        setupDelegate()
        startSpinner()
        getData()
    }
    
    private func configureNavBar() {
        let image = UIImage(systemName: "rectangle.righthalf.inset.filled.arrow.right")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(logOutButton))
    }
    
    private func getData() {
        dispatchGroup.enter()
        repository.getCrypto(pair: NameOfCrypto.btc.rawValue) { result in
            switch result {
            case .success(let data):
                self.cryptoArray.append(data.data)
                print(data.data)
                self.dispatchGroup.leave()
            case .failure(let failure):
                print("Error lesson: \(failure)")
                self.stopSpinner()
            }
        }
        dispatchGroup.enter()
        repository.getCrypto(pair: NameOfCrypto.eth.rawValue) { result in
            switch result {
            case .success(let data):
                self.cryptoArray.append(data.data)
                print(data.data)
                self.dispatchGroup.leave()
            case .failure(let failure):
                print("Error lesson: \(failure)")
                self.stopSpinner()
            }
        }

        dispatchGroup.notify(queue: .main) {
            self.rootView.tableView.reloadData()
            self.stopSpinner()
        }
    }
    
    private func setupDelegate() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }
    
    private func startSpinner() {
        rootView.spinner.isHidden = false
        rootView.spinner.startAnimating()
    }
    
    private func stopSpinner() {
        rootView.spinner.isHidden = true
        rootView.spinner.stopAnimating()
    }
    
    //MARK: - Actions
    
    @objc private func logOutButton() {
        UserDefaultsManager.userIsLogin = false
        let vc = UINavigationController(rootViewController: LoginViewController())
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true)
    }
}

//MARK: - Extension: UITableViewDelegate & UITableViewDataSource

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cryptoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCustomTableViewCell.identifier, for: indexPath) as? NewsCustomTableViewCell else { return UITableViewCell() }
       
        cell.backgroundColor = .clear
        cell.selectionStyle = .blue
        cell.updateCell(model: cryptoArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DescribeViewController(crypto: cryptoArray[indexPath.row], index: indexPath.row)
        navigationController?.pushViewController(vc, animated: true)
    }
}
