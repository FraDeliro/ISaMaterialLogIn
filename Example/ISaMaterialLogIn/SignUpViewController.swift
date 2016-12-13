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

class SignUpViewController: ISaSignUpViewController {

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
            textFieldsArray = [self.baseTextField(placeholder: "Name"), self.baseTextField(placeholder: "Surname"),self.baseTextField(placeholder: "Email"),self.baseTextField(placeholder: "Password")]
            self.setSignUpViews(views: textFieldsArray, inStackView: self.signUpStackView())
            self.signUpTitleTopAnchor = 100
            self.signUpTitleWidthAnchor = 300
            self.signUpTitleHeightAnchor = 70
            self.setSignUpTitle(views: [self.titleLoginLabel()], inStackView: self.signUpStackView())
        } else {
            // Fallback on earlier versions
        }
        
        self.isaSignUpButton.addTarget(self, action: #selector(SignUpViewController.signUpAction), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //self.isaBottomSignUpButtonConstraint.constant = 200
    }
    
    //MARK: - Custom Accessors
    func signUpStackView() -> UIStackView {
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
        textField.placeHolderColor = Color.green.darken3
        textField.tintColor = Color.green.darken3
        textField.textColor = Color.green.darken3
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
    func signUpAction() {
        self.isaStartSignUpAnimation(self)
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
            self.isaSignUpSuccessfully(showNew: home)
        } catch let error as NSError {
            print(error)
            self.isaSignUpError()
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

}