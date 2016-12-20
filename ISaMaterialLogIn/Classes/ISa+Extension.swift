//
//  ISA+Extension.swift
//  Pods
//
//  Created by Francesco on 13/12/16.
//
//

import Foundation
import UIKit

extension UIViewController {
    /**
     A convenience property that provides access to the ISaLogInController.
     This is the recommended method of accessing the ISaLogInController
     through child UIViewControllers.
     */
    public var iSaLogInController: ISaLogInController? {
        var viewController: UIViewController? = self
        while nil != viewController {
            if viewController is ISaLogInController {
                return viewController as? ISaLogInController
            }
            viewController = viewController?.parent
        }
        return nil
    }
    
    public var iSaSignUpViewController: ISaSignUpViewController? {
        var viewController: UIViewController? = self
        while nil != viewController {
            if viewController is ISaSignUpViewController {
                return viewController as? ISaSignUpViewController
            }
            viewController = viewController?.parent
        }
        return nil
    }
}

public extension UITextField {
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }
}
