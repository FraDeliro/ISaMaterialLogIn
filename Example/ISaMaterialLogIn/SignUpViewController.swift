//
//  SignUpViewController.swift
//  ISaMaterialLogIn
//
//  Created by Francesco on 13/12/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import ISaMaterialLogIn
import Material

class SignUpViewController: ISaSignUpViewController, UITextFieldDelegate {

    //MARK: - Outlets & Variables
    var textFieldsArray = [ErrorTextField]()
    
    //MARK: - Page lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //register for keyboard notification
        self.registerForKeyboardNotifications()
        self.scrollView = self.isaScrollView
    
        //Stack View
        if #available(iOS 9.0, *) {
            self.dynamicViewsWidthAnchor = 200
            self.dynamicViewsHeightAnchor = 30
            textFieldsArray = [self.baseTextField(placeholder: "Name",errorMessage: "Name field cannot be empty!"), self.baseTextField(placeholder: "Surname",errorMessage: "Surname field cannot be empty!"),self.baseTextField(placeholder: "Email",errorMessage: "Email field cannot be empty!"),self.baseTextField(placeholder: "Password",errorMessage: "Password field cannot be empty!")]
            self.setLoginSignUpViews(views: textFieldsArray, inStackView: self.signUpStackView())
            self.viewTitleTopAnchor = 100
            self.viewTitleWidthAnchor = 300
            self.viewTitleHeightAnchor = 70
            self.setLoginSignUpViewControllerTitle(views: [self.titleLoginLabel()], inStackView: self.signUpStackView())
        } else {
            // Fallback on earlier versions
        }
        
        self.isaDismissSignUpButton.setImage(Icon.cm.close, for: .normal)
        self.isaSignUpButton.addTarget(self, action: #selector(SignUpViewController.signUpAction), for: .touchUpInside)
        self.dismissKeyboardOnTap = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //self.isaBottomSignUpButtonConstraint.constant = 200
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.deregisterFromKeyboardNotifications()
    }
    
    //MARK: - TextField Delegate
    func textFieldDidBeginEditing(_ textField: UITextField){
        self.activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        self.activeField = nil
    }
    
    //MARK: - Custom Accessors
    func signUpStackView() -> UIStackView {
        let stackView   = UIStackView()
        stackView.axis  = UILayoutConstraintAxis.vertical
        stackView.distribution  = UIStackViewDistribution.equalSpacing
        stackView.alignment = UIStackViewAlignment.center
        stackView.spacing   = 50.0
        self.stackView = stackView
        return self.stackView!
    }
    
    func baseTextField(placeholder: String, errorMessage: String) -> ErrorTextField {
        let textField = ErrorTextField()
        textField.delegate = self
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
    func signUpAction() {
        self.startSignUpAnimation()
        self.perform(#selector(SignUpViewController.checkFieldsEmpty), with: self, afterDelay: 2.0)
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
            self.isaLoginSignUpError(self.isaSignUpButton, oldTitle: "Signup")
            Commons.shared.showErrorAlert(error.localizedDescription, onController: self)
        }
    }
}
