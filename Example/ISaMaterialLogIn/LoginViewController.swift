//
//  ViewController.swift
//  ISaMaterialLogIn
//
//  Created by FraDeliro on 11/28/2016.
//  Copyright (c) 2016 FraDeliro. All rights reserved.
//

import UIKit
import ISaMaterialLogIn
import Material

class LoginViewController: ISaLogInController {
    
    //MARK: - Outlets & Variables
     var textFieldsArray = [UITextField]()
    
    //MARK: - Page lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Stack View
        if #available(iOS 9.0, *) {
            self.dynamicViewsWidthAnchor = 200
            self.dynamicViewsHeightAnchor = 30
            textFieldsArray = [self.baseTextField(placeholder: "Name"), self.baseTextField(placeholder: "Surname")]
            self.setLoginViews(views: textFieldsArray, inStackView: self.loginStackView())
            self.loginTitleTopAnchor = 100
            self.loginTitleWidthAnchor = 300
            self.loginTitleHeightAnchor = 70
            self.setLoginTitle(views: [self.titleLoginLabel()], inStackView: self.loginStackView())
        } else {
            // Fallback on earlier versions
        }
        
        self.isaLoginButton.addTarget(self, action: #selector(LoginViewController.logInAction), for: .touchUpInside)
        self.showSignUpButton.addTarget(self, action: #selector(LoginViewController.presentSignUpController), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //self.isaBottomLoginButtonConstraint.constant = 200
    }
    
    //MARK: - Custom Accessors
    func loginStackView() -> UIStackView {
        let stackView   = UIStackView()
        stackView.axis  = UILayoutConstraintAxis.vertical
        stackView.distribution  = UIStackViewDistribution.equalSpacing
        stackView.alignment = UIStackViewAlignment.center
        stackView.spacing   = 10.0
        return stackView
    }
    
    func baseTextField(placeholder: String) -> UITextField{
        let textField = UITextField()
        textField.backgroundColor = Color.white
        textField.placeholder = placeholder
        textField.placeHolderColor = Color.deepOrange.base
        textField.tintColor = Color.deepOrange.base
        textField.textColor = Color.deepOrange.base
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        return textField
    }
    
    func titleLoginLabel() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.backgroundColor = Color.clear
        titleLabel.textColor = Color.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.text = "ISA MATERIAL LOGIN"
        titleLabel.textAlignment = .center
        return titleLabel
    }

    //MARK: - Actions
    func logInAction() {
        self.isaStartLoginAnimation(self)
        self.perform(#selector(LoginViewController.checkFieldsEmpty), with: self, afterDelay: 2.0)
    }
    
    func checkFieldsEmpty() {
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Info: All fields are required!"])
        do {
            try self.checkEmptyData(fields: textFieldsArray, error: error)
            let home = UIViewController()
            home.view.backgroundColor = Color.lightBlue.darken1
            let successLabel = UILabel(frame: home.view.bounds)
            successLabel.text = "Login Success\r\rWelcome Home!"
            successLabel.textColor = Color.white
            successLabel.numberOfLines = 0
            successLabel.textAlignment = .center
            home.view.addSubview(successLabel)
            self.isaLoginSuccessfully(showNew: home)
        } catch let error as NSError {
            print(error)
            self.isaLoginError()
            self.showErrorAlert(error.localizedDescription)
        }
    }
    
    func showErrorAlert(_ message: String) {
        let alertController = UIAlertController(title: "ISA MATERIAL LOGIN\r", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        alertController.addAction(cancelAction)
        if self.presentedViewController != alertController {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func presentSignUpController() {
       let signUpVC = SignUpViewController()
       self.showSignUp(controller: signUpVC)
    }
}

