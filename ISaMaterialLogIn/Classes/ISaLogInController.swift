//
//  ISaLogInController.swift
//  Pods
//
//  Created by Francesco on 28/11/16.
//
//

import UIKit

extension UIViewController {
    /**
     A convenience property that provides access to the ToolbarController.
     This is the recommended method of accessing the ToolbarController
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
}

open class ISaLogInController: UIViewController {
    
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

    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
