//
//  ISaLogInController.swift
//  Pods
//
//  Created by Francesco on 28/11/16.
//
//

import UIKit

open class ISaLogInController: UIViewController {
    private let NibName: String = "ISaLogInController"

    @IBOutlet var widthButtonConstraint: NSLayoutConstraint!
    @IBOutlet public var isaBottomLoginButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak public var isaLoginButton : UIButton!
    @IBOutlet weak public var showSignUpButton : UIButton!
    
    var transition: ISaMaterialTransition = ISaMaterialTransition(viewAnimated: UIView())
    public var dynamicViewsHeightAnchor: CGFloat = 0
    public var dynamicViewsWidthAnchor: CGFloat = 0
    public var loginTitleHeightAnchor: CGFloat = 0
    public var loginTitleWidthAnchor: CGFloat = 0
    public var loginTitleTopAnchor: CGFloat = 0
    public var loginButtonTitle: String = "Login"
    private var isaCircleView: ISaCircleLoader?
    
    /**
     An initializer that initializes the object with a NSCoder object.
     - Parameter aDecoder: A NSCoder instance.
     */
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
     An initializer that initializes the object with an Optional nib and bundle.
     - Parameter nibNameOrNil: An Optional String for the nib.
     - Parameter bundle: An Optional NSBundle where the nib is located.
     */
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    /// An initializer that accepts no parameters.
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    //MARK: - Page lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
      // Do any additional setup after loading the view.
        self.loadViewFromNib()
        self.isaLoginButton.setTitle(loginButtonTitle, for: .normal)
        let gestureRecognizer : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(ISaLogInController.dismissKeyboard))
        self.view.addGestureRecognizer(gestureRecognizer)
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let animatedView = UIButton(frame: CGRect(x: (UIScreen.main.bounds.width/2) - (self.isaLoginButton.frame.size.height/2) , y: self.isaLoginButton.frame.origin.y, width: self.isaLoginButton.frame.size.height, height: self.isaLoginButton.frame.size.height))
        animatedView.backgroundColor = UIColor.white
        animatedView.alpha = 0.0
        animatedView.layer.cornerRadius = 22.0
        self.view.addSubview(animatedView)
        transition = ISaMaterialTransition(viewAnimated: animatedView)
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    private func loadViewFromNib() {
        self.view = Bundle.init(for: ISaLogInController.self).loadNibNamed(NibName, owner: self, options: nil)?[0] as? UIView
    }

    // MARK: - Actions
    public func isaStartLoginAnimation(_ sender: Any) {
        UIView.animate(withDuration: 0.1, delay: 0.5, options: [.curveLinear], animations: {
            self.isaLoginButton.setTitle("", for: .normal)
            self.isaLoginButton.transform = .init(scaleX: 0.1, y: 1.0)
        }) { (completion) in
            //start loading view
            self.isaLoginButton.alpha = 0.0
            self.isaCircleView = ISaCircleLoader(frame: CGRect(x: (UIScreen.main.bounds.width/2) - (self.isaLoginButton.frame.size.height/2) , y: self.isaLoginButton.frame.origin.y, width: self.isaLoginButton.frame.size.height, height: self.isaLoginButton.frame.size.height))
            self.view.addSubview(self.isaCircleView!)
        }
    }
    
    public func checkEmptyData(fields: [UITextField], error: NSError) throws {
        for field in fields {
            guard field.text?.isEmpty == true else {
                continue
            }
            throw error
        }
    }
    
    //MARK: - Custom Accessors
    public func isaLoginSuccessfully(showNew controller: UIViewController) {
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = transition
        self.present(controller, animated: true, completion: nil)
    }
    
    public func isaLoginError() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveLinear], animations: {
            self.isaCircleView?.removeFromSuperview()
            self.isaCircleView = nil
        }) { (completion) in
            self.isaLoginButton.transform = .identity
            self.isaLoginButton.alpha = 1.0
            self.isaLoginButton.setTitle(self.loginButtonTitle, for: .normal)
        }
    }
    
    @available(iOS 9.0, *)
    public func setLoginViews(views: [UIView], inStackView stackView: UIStackView) {
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
    public func setLoginTitle(views: [UIView], inStackView stackView: UIStackView) {
        for view in views {
            view.heightAnchor.constraint(equalToConstant: loginTitleHeightAnchor).isActive = true
            view.widthAnchor.constraint(equalToConstant: loginTitleWidthAnchor).isActive = true
            stackView.addArrangedSubview(view)
        }
        stackView.backgroundColor = UIColor.white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        //Constraints
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: loginTitleTopAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    public func showSignUp(controller: UIViewController) {
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = transition
        self.present(controller, animated: true, completion: nil)
    }
}
