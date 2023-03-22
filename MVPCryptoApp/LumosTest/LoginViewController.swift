import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    
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
    
    deinit {
        print("deinit vc")
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
    
    private func changeBorderColor() {
        if userNameTextfield.text != "1234" {
            userNameTextfield.layer.borderWidth = 1
            userNameTextfield.layer.borderColor = UIColor.systemRed.cgColor
        } else {
            userNameTextfield.layer.borderColor = UIColor.black.cgColor
        }
        
        if passwordTextfield.text != "1234" {
            passwordTextfield.layer.borderWidth = 1
            passwordTextfield.layer.borderColor = UIColor.systemRed.cgColor
        } else {
            passwordTextfield.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionCopy = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(actionCopy)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Actions
    
    @objc private func goToMainScreen() {
        
        if userNameTextfield.text == "1234",
           passwordTextfield.text == "1234" {
            UserDefaultsManager.userIsLogin = true
            let vc = UINavigationController(rootViewController: NewsViewController())
            vc.modalTransitionStyle = .flipHorizontal
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        } else {
//            changeBorderColor()
            showAlert(title: "Please fill all the fields!!!", message: "Login: 1234\nPassword: 1234")
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
