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
     var textFieldsArray = [ErrorTextField]()
    
    //MARK: - Page lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Stack View
        if #available(iOS 9.0, *) {
            self.dynamicViewsWidthAnchor = 200
            self.dynamicViewsHeightAnchor = 30
            textFieldsArray = [self.baseTextField(placeholder: "Name",errorMessage: "Name field cannot be empty!"), self.baseTextField(placeholder: "Surname", errorMessage:"Surname field cannot be empty!")]
            self.setLoginSignUpViews(views: textFieldsArray, inStackView: self.loginStackView())
            self.viewTitleTopAnchor = 100
            self.viewTitleWidthAnchor = 300
            self.viewTitleHeightAnchor = 70
            self.setLoginSignUpViewControllerTitle(views: [self.titleLoginLabel()], inStackView: self.loginStackView())
        } else {
            // Fallback on earlier versions
        }
        
        self.isaLoginButton.addTarget(self, action: #selector(LoginViewController.logInAction), for: .touchUpInside)
        self.showSignUpButton.addTarget(self, action: #selector(LoginViewController.presentSignUpController), for: .touchUpInside)
        self.dismissKeyboardOnTap = true
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
        stackView.spacing   = 50.0
        return stackView
    }
    
    func baseTextField(placeholder: String, errorMessage: String) -> ErrorTextField {
        let textField = ErrorTextField()
        textField.errorMessage = errorMessage
        textField.backgroundColor = Color.clear
        textField.placeholder = placeholder
        textField.placeholderActiveColor = Color.white
        textField.placeholderNormalColor = Color.white
        textField.dividerActiveColor = Color.white
        textField.dividerNormalColor = Color.white
        textField.detailColor = Color.red.accent2
        textField.textColor = Color.white
        textField.isClearIconButtonEnabled = true
        textField.textAlignment = .left
        textField.borderStyle = .none
        textField.spellCheckingType = .no
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
        self.startLoginAnimation()
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
            self.isaLoginSignUpSuccessfully(showNew: home)
        } catch let error as NSError {
            print(error)
            self.isaLoginSignUpError(self.isaLoginButton, oldTitle: "Login")
            Commons.shared.showErrorAlert(error.localizedDescription, onController: self)
        }
    }
    
    func presentSignUpController() {
       let signUpVC = SignUpViewController()
       self.showSignUp(controller: signUpVC)
    }
}

