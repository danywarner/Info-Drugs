//
//  TransitionManager.swift
//  pruebaRappi
//
//  Created by Daniel Warner on 2/4/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//

import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate  {
    
    var presenting = false
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView()
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        
        let offScreenRight = CGAffineTransformMakeTranslation(container!.frame.width, 0)
        let offScreenLeft = CGAffineTransformMakeTranslation(-container!.frame.width, 0)
        
        if (self.presenting){
            toView.transform = offScreenRight
        }
        else {
            toView.transform = offScreenLeft
        }
        
        container!.addSubview(toView)
        container!.addSubview(fromView)
        
        let duration = self.transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.1, options: UIViewAnimationOptions(), animations: {
            if (self.presenting){
                fromView.transform = offScreenLeft
            }
            else {
                fromView.transform = offScreenRight
            }
            
            toView.transform = CGAffineTransformIdentity
            
            }, completion: { finished in
                
                transitionContext.completeTransition(true)
                
        })
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.7
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
    
}
