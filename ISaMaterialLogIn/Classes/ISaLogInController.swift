//
//  ISaLogInController.swift
//  Pods
//
//  Created by Francesco on 28/11/16.
//
//

import UIKit

open class ISaLogInController: ISaModelViewController {
    private let NibName: String = "ISaLogInController"

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
        self.loadViewFromNib(NibName, controllerClass: ISaLogInController.self)
        // Do any additional setup after loading the view.
        self.isaLoginButton.setTitle(loginButtonTitle, for: .normal)
        //check if it's needed to dismiss the keyboard
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setLoginButtonAnimatedView()
    }
    
    private func setLoginButtonAnimatedView() {
        let animatedView = UIButton(frame: CGRect(x: (UIScreen.main.bounds.width/2) - (self.isaLoginButton.frame.size.height/2) , y: self.isaLoginButton.frame.origin.y, width: self.isaLoginButton.frame.size.height, height: self.isaLoginButton.frame.size.height))
        animatedView.backgroundColor = UIColor.white
        animatedView.alpha = 0.0
        animatedView.layer.cornerRadius = 22.0
        self.addAnimatedButton(animatedView)
    }

    // MARK: - Actions
    public func startLoginAnimation() {
         self.isaCircleView = ISaCircleLoader(frame: CGRect(x: (UIScreen.main.bounds.width/2) - (self.isaLoginButton.frame.size.height/2) , y: self.isaLoginButton.frame.origin.y, width: self.isaLoginButton.frame.size.height, height: self.isaLoginButton.frame.size.height))
         self.isaStartLoginSignUpAnimation(self.isaLoginButton)
    }
}
