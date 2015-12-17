//
//  DrugDetailVC.swift
//  Info Drugs
//
//  Created by Daniel Warner on 12/15/15.
//  Copyright © 2015 Daniel Warner. All rights reserved.
//

import UIKit

class DrugDetailVC: UIViewController {

    @IBOutlet weak var drugPhotoHeight: NSLayoutConstraint!
    @IBOutlet weak var drugNameLabel: UILabel!
    @IBOutlet weak var drugPhoto: UIImageView!
    
    @IBOutlet weak var definitionTitle: UILabel!
    @IBOutlet weak var definitionText: UILabel!
    
    @IBOutlet weak var risksTitle: UILabel!
    @IBOutlet weak var risksText: UILabel!
    
    @IBOutlet weak var addictiveTitle: UILabel!
    @IBOutlet weak var addictiveText: UILabel!
    
    @IBOutlet weak var damageReduceTitle: UILabel!
    @IBOutlet weak var damageReduceText: UILabel!
    
    
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
        drugNameLabel.text = _drug.name
        definitionText.text = decomposeStringArray(_drug.description!)
        risksText.text = decomposeStringArray(_drug.risks!)
        addictiveText.text = decomposeStringArray(_drug.addictive!)
        damageReduceText.text = decomposeStringArray(_drug.riskAvoiding!)

        self.view.clipsToBounds = true

        
        //scrollView.contentSize = CGSizeMake(320,758)
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func segmentedControlActionChanged(sender: UISegmentedControl) {

        switch(sender.selectedSegmentIndex) {
            
        case 0:
            drugPhotoHeight.constant = 128
            definitionTitle.text = "¿Qué es?"
            definitionText.text = decomposeStringArray(_drug.description!)
            toggleTextLabels()
            
            
        case 1:
            drugPhotoHeight.constant = 0
            definitionTitle.text = "Efectos:"
            definitionText.text = decomposeStringArray(_drug.effects!)
            toggleTextLabels()
            
        case 2:
            drugPhotoHeight.constant = 0
            definitionTitle.text = "Mezclas comunes:"
            definitionText.text = decomposeStringArray(_drug.mixes!)
            toggleTextLabels()
        default:
            break
        }
    }
    
    func toggleTextLabels() {
        toggleLabel(risksTitle)
        toggleLabel(risksText)
        toggleLabel(addictiveTitle)
        toggleLabel(addictiveText)
        toggleLabel(damageReduceTitle)
        toggleLabel(damageReduceText)
    }
    
    func toggleLabel(label: UILabel) {
        
        if label.hidden == true && definitionTitle.text == "¿Qué es?" {
            label.hidden = false
        } else {
            label.hidden = true
        }
    }
    
    func decomposeStringArray(array: [String]) -> String {
        var fullText = ""
        for paragraph in array {
            fullText += paragraph
            fullText += "\n\n"
        }
        return fullText
    }
}
