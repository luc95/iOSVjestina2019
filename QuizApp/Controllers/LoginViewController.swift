//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Luc on 17/05/2019.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var quizzAppLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var centerAlignUsername: NSLayoutConstraint!
    @IBOutlet weak var centerAlignPassword: NSLayoutConstraint!
    @IBOutlet weak var centerAlignLogin: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let viewWidth = view.bounds.width
        
        // viewWillApear
        usernameTextField.center.x -= viewWidth
        passwordTextField.center.x -= viewWidth
        loginButton.center.x -= viewWidth
        
        self.quizzAppLabel.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        animateIn()
    }
    
    private func animateIn() {
        let viewWidth = view.bounds.width
        
        UIView.animate(withDuration: 0.9, animations: {
            self.quizzAppLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { _ in }
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            self.usernameTextField.center.x += viewWidth
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseOut, animations: {
            self.passwordTextField.center.x += viewWidth
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.4, options: .curveEaseOut, animations: {
            self.loginButton.center.x += viewWidth
        }, completion: nil)
    }
    
    public func animateOut() {
        let viewHeight = view.bounds.height
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            self.quizzAppLabel.center.y -= viewHeight
            self.quizzAppLabel.alpha = 0.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseOut, animations: {
            self.usernameTextField.center.y -= viewHeight
            self.usernameTextField.alpha = 0.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.4, options: .curveEaseOut, animations: {
            self.passwordTextField.center.y -= viewHeight
            self.passwordTextField.alpha = 0.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.6, options: .curveEaseOut, animations: {
            self.loginButton.center.y -= viewHeight
            self.loginButton.alpha = 0.0
        }) { _ in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.navigateToTabBarViewController()
        }
    }

    @IBAction func login(_ sender: Any) {
        LoginService().login(
            username: usernameTextField.text ?? "",
            password: passwordTextField.text ?? "",
            completion: { (credentials) in
                DispatchQueue.main.async {
                    if let credentials = credentials {
                        LoginUtils.loginUser(credentials: credentials)
                        self.animateOut()
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
