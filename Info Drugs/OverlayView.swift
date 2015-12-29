//
//  OverlayView.swift
//  swipeswift
//
//  Created by Daniel Warner on 12/29/15.
//  Copyright © 2015 Daniel Warner. All rights reserved.
//

import Foundation
import UIKit

class OverlayView: UIView {
    
    enum CGOverlayViewMode: Int {
        case GGOverlayViewModeLeft, GGOverlayViewModeRight
    }
    
    private var _mode: CGOverlayViewMode!
    private var imageView: UIImageView!
    
    var mode: CGOverlayViewMode {
        get {
            return _mode
        }
        
        set {
            _mode = newValue
            if _mode == CGOverlayViewMode.GGOverlayViewModeLeft {
                imageView.image = UIImage(named: "noButton")
            } else {
                imageView.image = UIImage(named: "yesButton")
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRectMake(50, 50, 100, 100);
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(image: UIImage(named: "noButton"))
        self.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}