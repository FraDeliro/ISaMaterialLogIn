//
//  ISaModelViewController.swift
//  Pods
//
//  Created by Francesco on 20/12/16.
//
//

import UIKit
import Material

open class ISaModelViewController: UIViewController {
    
    //MARK: - Outlets & Variables
    
    //Commons
    var transition: ISaMaterialTransition = ISaMaterialTransition(viewAnimated: UIView())
    public var isaCircleView: ISaCircleLoader?
    public var dynamicViewsHeightAnchor: CGFloat = 0
    public var dynamicViewsWidthAnchor: CGFloat = 0
    public var dismissKeyboardOnTap: Bool = false
    public var viewTitleHeightAnchor: CGFloat = 0
    public var viewTitleWidthAnchor: CGFloat = 0
    public var viewTitleTopAnchor: CGFloat = 0
    @IBOutlet var widthButtonConstraint: NSLayoutConstraint!
    
    // Login
    @IBOutlet public var isaBottomLoginButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak public var isaLoginButton : UIButton!
    @IBOutlet weak public var showSignUpButton : UIButton!
    public var loginButtonTitle: String = "Login"
    
    //Sign Up
    @IBOutlet public var isaBottomSignUpButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak public var isaSignUpButton : UIButton!
    @IBOutlet weak public var isaDismissSignUpButton : UIButton!
    public var signUpButtonTitle: String = "Signup"
    
    //MARK: - Page lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.dismissKeyboardOnTap {
            let gestureRecognizer : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(ISaModelViewController.dismissKeyboard))
            self.view.addGestureRecognizer(gestureRecognizer)
        }
    }
   
    //MARK: - Custom Accessors
    public func loadViewFromNib(_ NibName: String, controllerClass: AnyClass) {
        self.view = Bundle.init(for: controllerClass).loadNibNamed(NibName, owner: self, options: nil)?[0] as? UIView
    }
    
    @available(iOS 9.0, *)
    public func setLoginSignUpViews(views: [UIView], inStackView stackView: UIStackView) {
        for view in views {
            view.heightAnchor.constraint(equalToConstant: dynamicViewsHeightAnchor).isActive = true
            view.widthAnchor.constraint(equalToConstant: dynamicViewsWidthAnchor).isActive = true
            stackView.addArrangedSubview(view)
        }
        stackView.backgroundColor = UIColor.white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        //Constraints
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    @available(iOS 9.0, *)
    public func setLoginSignUpViewControllerTitle(views: [UIView], inStackView stackView: UIStackView) {
        for view in views {
            view.heightAnchor.constraint(equalToConstant: viewTitleHeightAnchor).isActive = true
            view.widthAnchor.constraint(equalToConstant: viewTitleWidthAnchor).isActive = true
            stackView.addArrangedSubview(view)
        }
        stackView.backgroundColor = UIColor.white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        //Constraints
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: viewTitleTopAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    public func addAnimatedButton(_ animatedView: UIButton) {
        self.view.addSubview(animatedView)
        transition = ISaMaterialTransition(viewAnimated: animatedView)
    }
    
    // MARK: - Actions
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    public func isaStartLoginSignUpAnimation(_ sender: UIButton) {
        let condition:Bool = (self.isaCircleView != nil)
        precondition(condition, "#To call this function directly you need to implement the isaCircleView!")
        
        UIView.animate(withDuration: 0.1, delay: 0.5, options: [.curveLinear], animations: {
            sender.setTitle("", for: .normal)
            sender.transform = .init(scaleX: 0.1, y: 1.0)
        }) { (completion) in
            //start loading view
            sender.alpha = 0.0
            if let circleView = self.isaCircleView {
                self.view.addSubview(circleView)
            }
        }
    }
    
    public func checkEmptyData(fields: [ErrorTextField], error: NSError) throws {
        fields.forEach { (field) in
            field.isErrorRevealed = true
            field.detail = field.errorMessage
        }
        
        for field in fields {
            guard field.text?.isEmpty == true else {
                field.isErrorRevealed = false
                field.detail = ""
                continue
            }
            throw error
        }
    }
    
    public func isaLoginSignUpSuccessfully(showNew controller: UIViewController) {
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = transition
        self.present(controller, animated: true, completion: nil)
    }
    
    public func isaLoginSignUpError(_ sender: UIButton, oldTitle: String) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveLinear], animations: {
            self.isaCircleView?.removeFromSuperview()
            self.isaCircleView = nil
        }) { (completion) in
            sender.transform = .identity
            sender.alpha = 1.0
            sender.setTitle(oldTitle, for: .normal)
        }
    }
    
    public func showSignUp(controller: UIViewController) {
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = transition
        self.present(controller, animated: true, completion: nil)
    }
}
