//
//  ISA+Extension.swift
//  Pods
//
//  Created by Francesco on 13/12/16.
//
//

import Foundation
import UIKit

public extension ISaModelViewController {
    /**
     A convenience property that provides access to the ISaLogInController.
     This is the recommended method of accessing the ISaLogInController
     through child UIViewControllers.
     */
    var iSaLogInController: ISaLogInController? {
        var viewController: UIViewController? = self
        while nil != viewController {
            if viewController is ISaLogInController {
                return viewController as? ISaLogInController
            }
            viewController = viewController?.parent
        }
        return nil
    }

    var iSaSignUpViewController: ISaSignUpViewController? {
        var viewController: UIViewController? = self
        while nil != viewController {
            if viewController is ISaSignUpViewController {
                return viewController as? ISaSignUpViewController
            }
            viewController = viewController?.parent
        }
        return nil
    }

    private struct Utils {
        static var scrollView: UIScrollView?
        static var activeField: UITextField?
        static var stackView: UIStackView?
    }

    var scrollView: UIScrollView? {

        get {
            return (objc_getAssociatedObject(self, &Utils.scrollView) as? UIScrollView)
        }
        set {
            if let unwrappedValue = newValue {
                objc_setAssociatedObject(self, &Utils.scrollView, unwrappedValue as UIScrollView?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    var activeField: UITextField? {
        get {
            return (objc_getAssociatedObject(self, &Utils.activeField) as? UITextField)
        }
        set {
            if let unwrappedValue = newValue {
                objc_setAssociatedObject(self, &Utils.activeField, unwrappedValue as UITextField?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    var stackView: UIStackView? {

        get {
            return (objc_getAssociatedObject(self, &Utils.stackView) as? UIStackView)
        }
        set {
            if let unwrappedValue = newValue {
                objc_setAssociatedObject(self, &Utils.stackView, unwrappedValue as UIStackView?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    func registerForKeyboardNotifications() {
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }

    func deregisterFromKeyboardNotifications() {
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }

    func keyboardWasShown(notification: NSNotification) {
        if let activeField = self.activeField, let scrollView = self.scrollView, let stackView = self.stackView, let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            //detect if Active TextField is below keyboard
            var aRect = self.view.frame
            aRect.size.height -= keyboardSize.height
            var textFieldRect = activeField.frame
            textFieldRect.origin.y = (stackView.frame.origin.y + stackView.spacing + activeField.frame.origin.y + activeField.frame.size.height)
            if (!aRect.contains(textFieldRect.origin)) {
                 let newY = (scrollView.frame.size.height - (textFieldRect.origin.y + textFieldRect.size.height + stackView.spacing))
                 scrollView.transform = CGAffineTransform(translationX: 0.0, y: -newY)
            }
        }
    }

    func keyboardWillBeHidden(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: self.scrollView?.contentInset.top ?? 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        self.scrollView?.contentInset = contentInsets
        self.scrollView?.scrollIndicatorInsets = contentInsets
        self.scrollView?.transform = .identity
    }
}

public extension UITextField {
    private struct ErrorString {
        static var errorMessage: String?
    }


    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSForegroundColorAttributeName: newValue!])
        }
    }

    var errorMessage: String? {
        get {
            return objc_getAssociatedObject(self, &ErrorString.errorMessage) as? String
        }
        set {
            if let unwrappedValue = newValue {
                objc_setAssociatedObject(self, &ErrorString.errorMessage, unwrappedValue as String?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
