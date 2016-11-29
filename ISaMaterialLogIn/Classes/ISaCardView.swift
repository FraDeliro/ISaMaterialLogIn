//
//  IsaCardView.swift
//  Pods
//
//  Created by Francesco on 16/11/16.
//
//

import Foundation
import UIKit

@IBDesignable
public class ISaCardView: UIView {
    
    //MARK: - Outlets & Variables
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable var shadowColor: UIColor? = UIColor.black {
        didSet {
            layer.shadowColor = shadowColor?.cgColor
        }
    }
    @IBInspectable var shadowOpacity: Float = 0.5 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    @IBInspectable var shadowOffsetSize: CGSize = CGSize(width: 2, height: 1) {
        didSet {
            layer.shadowOffset = shadowOffsetSize
        }
    }
   
    override init(frame: CGRect) {
      super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowPath = shadowPath.cgPath
    }
    
}
