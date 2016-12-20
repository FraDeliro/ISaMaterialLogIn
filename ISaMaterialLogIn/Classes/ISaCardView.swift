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
    @IBInspectable override public var cornerRadius: CGFloat {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable override public var shadowRadius: CGFloat {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable override public var shadowColor: UIColor? {
        didSet {
            layer.shadowColor = shadowColor?.cgColor
        }
    }
    @IBInspectable override public var shadowOpacity: Float {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    @IBInspectable public var shadowOffsetSize: CGSize = CGSize(width: 2, height: 1) {
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
