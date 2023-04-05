import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    
    //MARK: - Internal properties
    
    var presenter: LoginPresenterProtocol?
    
    //MARK: - Private properties
    
    private let userNameTextfield: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter your name"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        field.leftViewMode = .always
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 1
        field.tag = 0
        return field
    }()
    
    private let passwordTextfield: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter your password"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        field.leftViewMode = .always
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 1
        field.tag = 1
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.layer.cornerRadius = 10
        return button
    }()
    
    //MARK: - Livecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupDelegate()
    }
    
    //MARK: - Override methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: - Private methods
    
    private func setupLayout() {
        title = "Login"
        view.backgroundColor = .systemBackground
        view.addSubview(userNameTextfield)
        view.addSubview(passwordTextfield)
        view.addSubview(loginButton)
        
        userNameTextfield.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            $0.left.right.equalToSuperview().inset(14)
            $0.height.equalTo(50)
        }
        
        passwordTextfield.snp.makeConstraints {
            $0.top.equalTo(userNameTextfield.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(14)
            $0.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextfield.snp.bottom).offset(50)
            $0.left.right.equalToSuperview().inset(14)
            $0.height.equalTo(50)
        }
    }
    
    private func setupDelegate() {
        userNameTextfield.delegate = self
        passwordTextfield.delegate = self
        loginButton.addTarget(self, action: #selector(goToMainScreen), for: .touchUpInside)
    }
    
    //MARK: - Actions
    
    @objc private func goToMainScreen() {
        let userName = userNameTextfield.text
        let password = passwordTextfield.text
        
        if presenter?.checkData(userName: userName, password: password) == true {
            presenter?.goToCryptoModel()
        }
    }
}

//MARK: - Extension: UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            passwordTextfield.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

//MARK: - Extension: LoginViewProtocol

extension LoginViewController: LoginViewProtocol {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionCopy = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(actionCopy)
        self.present(alert, animated: true, completion: nil)
    }
}
