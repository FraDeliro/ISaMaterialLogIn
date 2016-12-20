//
//  ISaSignUpViewController.swift
//  Pods
//
//  Created by Francesco on 13/12/16.
//
//

import UIKit

open class ISaSignUpViewController: ISaModelViewController {
    private let NibName: String = "ISaSignUpViewController"
    
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
        self.loadViewFromNib(NibName, controllerClass: ISaSignUpViewController.self)
        // Do any additional setup after loading the view.
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setSignUpButtonAnimatedView()
    }
    
    //MARK: - Custom Accessors
    private func setSignUpButtonAnimatedView() {
        let animatedView = UIButton(frame: CGRect(x: (UIScreen.main.bounds.width/2) - (self.isaSignUpButton.frame.size.height/2) , y: self.isaSignUpButton.frame.origin.y, width: self.isaSignUpButton.frame.size.height, height: self.isaSignUpButton.frame.size.height))
        animatedView.backgroundColor = UIColor.white
        animatedView.alpha = 0.0
        animatedView.layer.cornerRadius = 22.0
        self.addAnimatedButton(animatedView)
    }

    // MARK: - Actions
    public func startSignUpAnimation() {
        self.isaCircleView = ISaCircleLoader(frame: CGRect(x: (UIScreen.main.bounds.width/2) - (self.isaSignUpButton.frame.size.height/2) , y: self.isaSignUpButton.frame.origin.y, width: self.isaSignUpButton.frame.size.height, height: self.isaSignUpButton.frame.size.height))
        self.isaStartLoginSignUpAnimation(self.isaSignUpButton)
    }

    // MARK: - IBActions
    @IBAction func dismissSignUp() {
      self.dismiss(animated: true, completion: nil)
    }
}
