//
//  DraggableView.swift
//  swipeswift
//
//  Created by Daniel Warner on 12/29/15.
//  Copyright © 2015 Daniel Warner. All rights reserved.
//

import Foundation
import UIKit

protocol DraggableViewDelegate {
    
    func cardSwipedLeft(card: UIView)
    func cardSwipedRight(card: UIView)
}

class DraggableView: UIView{
    
    var xFromCenter: CGFloat!
    var yFromCenter: CGFloat!
    var originalPoint: CGPoint!
    var delegate: DrugDetailVC!
    var information: UILabel!
    let ACTION_MARGIN: CGFloat = 120
    let SCALE_STRENGTH: CGFloat = 4
    let SCALE_MAX: CGFloat = 0.93
    let ROTATION_MAX: CGFloat = 1
    let ROTATION_STRENGTH: CGFloat = 320
    let ROTATION_ANGLE: CGFloat = CGFloat(M_PI / 8.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        start()
    }

    
    func start() {
        
        self.setupView()
        self.backgroundColor = UIColor.white
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action:#selector(DraggableView.beingDragged))
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    func setupView() {
        self.layer.cornerRadius = 4;
        self.layer.shadowRadius = 3;
        self.layer.shadowOpacity = 0.2;
        self.layer.shadowOffset = CGSize(width: 1, height: 1);
    }
    
    @objc func beingDragged(gestureRecognizer: UIPanGestureRecognizer) {
        
        xFromCenter = gestureRecognizer.translation(in: self).x
        yFromCenter = gestureRecognizer.translation(in: self).y
        
        switch(gestureRecognizer.state) {
        case .began:
            originalPoint = self.center
            
        case .changed:
            let rotationStrength: CGFloat = min(xFromCenter / ROTATION_STRENGTH, ROTATION_MAX)
            let rotationAngle = CGFloat(ROTATION_ANGLE * rotationStrength)
            let scale = max(CGFloat(1 - fabsf(Float(rotationStrength))) / SCALE_STRENGTH, SCALE_MAX)
            
            self.center = CGPoint(x: originalPoint.x + xFromCenter, y: originalPoint.y + yFromCenter)
            let transform: CGAffineTransform = CGAffineTransform(rotationAngle: rotationAngle)
            let scaleTransform: CGAffineTransform = transform.scaledBy(x: scale, y: scale)
            
            self.transform = scaleTransform
            
        case .ended:
            self.afterSwipeAction()
            
        default:
            break
        }
    }
    
    func afterSwipeAction() {
        if xFromCenter > ACTION_MARGIN {
            self.rightAction()
        } else if xFromCenter < -ACTION_MARGIN {
            self.leftAction()
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.center = self.originalPoint
                self.transform = CGAffineTransform(rotationAngle: 0)
            })
        }
    }
    
    func rightAction() {
        let finishPoint: CGPoint = CGPoint(x: 500, y: 2*yFromCenter + self.originalPoint.y)
        UIView.animate(withDuration: 0.3, animations: {
            self.center = finishPoint
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        delegate.cardSwipedRight(card: self)
    }
    
    func leftAction() {
        let finishPoint: CGPoint = CGPoint(x: -500, y: 2*yFromCenter + self.originalPoint.y)
        UIView.animate(withDuration: 0.3, animations: {
            self.center = finishPoint
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        delegate.cardSwipedLeft(card: self)
    }
}
