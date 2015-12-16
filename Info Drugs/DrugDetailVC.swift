//
//  DrugDetailVC.swift
//  Info Drugs
//
//  Created by Daniel Warner on 12/15/15.
//  Copyright © 2015 Daniel Warner. All rights reserved.
//

import UIKit

class DrugDetailVC: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var definitionTitle: UILabel!
    @IBOutlet weak var definitionText: UILabel!
    @IBOutlet weak var effectsTitle: UILabel!
    @IBOutlet weak var risksTitle: UILabel!
    @IBOutlet weak var addictiveTitle: UILabel!
    @IBOutlet weak var legalTitle: UILabel!
    @IBOutlet weak var damageReduceTitle: UILabel!
    
    private var _drug: Drug!
    
    var drug: Drug {
        get {
            return _drug
        }
        set {
            _drug = newValue
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x>0 {
            scrollView.contentOffset.x = 0
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = _drug.name
        self.view.clipsToBounds = true;
        //scrollView.contentSize = CGSizeMake(320,758)
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
