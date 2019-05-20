//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Luc on 17/05/2019.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @IBAction func login(_ sender: Any) {
        LoginService().login(
            username: usernameTextField.text ?? "",
            password: passwordTextField.text ?? "",
            completion: { (credentials) in
                DispatchQueue.main.async {
                    if let credentials = credentials {
                        LoginUtils.loginUser(credentials: credentials)
                    } else {
                        self.errorLabel.isHidden = false
                    }
                }
            })
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = getKeyboardHeight(notification: notification) {
            let overlap = keyboardHeight - getLoginButtonBottomConstraint()
            if overlap > 0 && view.frame.origin.y == 0 {
                self.view.frame.origin.y -= overlap
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    private func getKeyboardHeight(notification: NSNotification) -> CGFloat? {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            return keyboardHeight
        }
        return nil
    }
    
    private func getLoginButtonBottomConstraint() -> CGFloat {
        return view.frame.size.height - (loginButton.frame.size.height + loginButton.frame.origin.y)
    }

}
