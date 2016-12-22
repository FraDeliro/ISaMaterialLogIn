//
//  Commons.swift
//  ISaMaterialLogIn
//
//  Created by Francesco on 20/12/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class Commons: NSObject {
    static let shared = Commons()
    
    
    override init() {
        super.init()
    }
    
    func showErrorAlert(_ message: String, onController: UIViewController) {
        let alertController = UIAlertController(title: "ISA MATERIAL LOGIN\r", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        alertController.addAction(cancelAction)
        if onController.presentedViewController != alertController {
            onController.present(alertController, animated: true, completion: nil)
        }
    }
}
