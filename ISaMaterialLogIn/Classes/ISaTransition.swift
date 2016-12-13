//
//  ISaTransition.swift
//  Pods
//
//  Created by Francesco on 01/12/16.
//
//

import Foundation
import UIKit

open class ISaMaterialTransition: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    open weak var viewAnimated: UIView?
    open var startFrame = CGRect()
    open var defaultBackgroundColor: UIColor?
    open var isBack = false
    open var transitionDuration : TimeInterval = 0.5
    
    convenience public init(viewAnimated: UIView) {
        self.init()
        self.viewAnimated = viewAnimated
    }
    
    //MARK - UIViewControllerAnimatedTransitioning
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.transitionDuration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let viewAnimated = viewAnimated, let superview = viewAnimated.superview {
            // Get the frame rect in the screen coordinates
            self.startFrame = superview.convert(viewAnimated.frame, to: nil)
            self.defaultBackgroundColor = viewAnimated.backgroundColor
        }
        // Use if the transitionContext.containerView is not fullscreen
        let startFrame = transitionContext.containerView.superview?.convert(self.startFrame, to: transitionContext.containerView) ?? self.startFrame
        
        let viewAnimatedForTransition = UIView(frame: startFrame)
        transitionContext.containerView.addSubview(viewAnimatedForTransition)
        
        viewAnimatedForTransition.clipsToBounds = true
        viewAnimatedForTransition.layer.cornerRadius = viewAnimatedForTransition.frame.height / 2.0
        viewAnimatedForTransition.backgroundColor = self.defaultBackgroundColor
        
        
        let presentedController: UIViewController
        
        if !self.isBack {
            presentedController = transitionContext.viewController(forKey: .to)!
            presentedController.view.layer.opacity = 0
        }
        else {
            presentedController = transitionContext.viewController(forKey: .from)!
        }
        
        presentedController.view.frame = transitionContext.containerView.bounds
        transitionContext.containerView.addSubview(presentedController.view)
        
        
        let size = max(transitionContext.containerView.frame.height, transitionContext.containerView.frame.width) * 1.2
        let scaleFactor = size / viewAnimatedForTransition.frame.width
        let finalTransform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        
        
        if self.isBack {
            viewAnimatedForTransition.transform = finalTransform
            viewAnimatedForTransition.center = transitionContext.containerView.center
            viewAnimatedForTransition.backgroundColor = presentedController.view.backgroundColor
            
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext) * 0.7, animations: {
                presentedController.view.layer.opacity = 0
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + self.transitionDuration(using: transitionContext) * 0.32) {
                UIView.transition(with: viewAnimatedForTransition,
                                  duration: self.transitionDuration(using: transitionContext) * 0.58,
                                  options: [],
                                  animations: {
                                    viewAnimatedForTransition.transform = CGAffineTransform.identity
                                    viewAnimatedForTransition.backgroundColor = self.defaultBackgroundColor
                                    viewAnimatedForTransition.frame = startFrame
                },
                                  completion: { (_) in
                                    viewAnimatedForTransition.removeFromSuperview()
                                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
            }
        }
        else {
            UIView.transition(with: viewAnimatedForTransition,
                              duration: self.transitionDuration(using: transitionContext) * 0.7,
                              options: [],
                              animations: {
                                viewAnimatedForTransition.transform = finalTransform
                                viewAnimatedForTransition.center = transitionContext.containerView.center
                                viewAnimatedForTransition.backgroundColor = presentedController.view.backgroundColor
            },
                              completion: { (_) in
            })
            
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext) * 0.42,
                           delay: self.transitionDuration(using: transitionContext) * 0.58,
                           animations: {
                            presentedController.view.layer.opacity = 1
            },
                           completion: { (_) in
                            viewAnimatedForTransition.removeFromSuperview()
                            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
    
    // MARK - UIViewControllerTransitioningDelegate
    
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isBack = false
        return self
    }
    
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isBack = true
        return self
    }
    
}
