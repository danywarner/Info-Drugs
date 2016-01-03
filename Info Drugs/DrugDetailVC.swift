//
//  DrugDetailVC.swift
//  Info Drugs
//
//  Created by Daniel Warner on 12/15/15.
//  Copyright © 2015 Daniel Warner. All rights reserved.
//

import UIKit

class DrugDetailVC: UIViewController {

    @IBOutlet weak var drugLabelBottom: NSLayoutConstraint!
    @IBOutlet weak var drugLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var topBarHeight: NSLayoutConstraint!
    @IBOutlet weak var segmentedControlTop: NSLayoutConstraint!
    @IBOutlet weak var backButtonBottom: NSLayoutConstraint!
    
    @IBOutlet weak var drugNameLabel: UILabel!
   

    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    let MAX_BUFFER_SIZE = 2
    let CARD_HEIGHT:CGFloat = 520
    let CARD_WIDTH:CGFloat = 290
    
    var language = ""
    var infoCards: Array<DraggableView> = []
    var infoTitles: Array<UILabel> = []
    var infoTexts: Array<UILabel> = []
    var definitionTitle: UILabel = UILabel()
    var risksTitle: UILabel = UILabel()
    var addictiveTitle: UILabel = UILabel()
    var damageReduceTitle: UILabel = UILabel()
    
    var definitionText: UILabel = UILabel()
    var risksText: UILabel = UILabel()
    var addictiveText: UILabel = UILabel()
    var damageReduceText: UILabel = UILabel()
    
    private var _drug: Drug!
    private var _previousOrientationIsPortrait = true
    
    var drug: Drug {
        get {
            return _drug
        }
        set {
            _drug = newValue
        }
    }
    
    var previousOrientationIsPortrait: Bool {
        get {
            return _previousOrientationIsPortrait
        }
        set {
            _previousOrientationIsPortrait = newValue
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
        setInfoTitles()
        setInfoTexts()
        
        //        let image = UIImage(named: "\(drug.name)Photo")
        //        drugPhoto.image = image
        
        rotated()
        loadInfoCards()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //lines()
    }
    
    func lines() {
        var lineCount = 0;
        let textSize = CGSizeMake(definitionText.frame.size.width, CGFloat(Float.infinity));
        let rHeight = lroundf(Float(definitionText.sizeThatFits(textSize).height))
        let charSize = lroundf(Float(definitionText.font.lineHeight));
        print(textSize)
        print(rHeight)
        print(charSize)
        lineCount = (rHeight/charSize)-2
        print("No of lines \(lineCount)")
    }
    
    func linesInUILabel(text: String) -> Int {
        var width: Float = 0.0
        let screenWidth = self.view.frame.size.width
        if screenWidth == 375.0 {
            width = 325.0
        }
        else if screenWidth == 320.0 {
            width = 270.0
            
        } else if screenWidth == 414.0 {
            width = 364.0
        }
        let charsInLine = lroundf(width/8.0)
        let lines = Int((text.characters.count))/charsInLine
        return lines
    }
    
    
    func setInfoTitles() {
        if language == "es" {
            
            definitionTitle.text = "¿Qué es?"
            risksTitle.text = "Riesgos: "
            addictiveTitle.text = "¿Es Adictivo?"
            damageReduceTitle.text = "Reducción de daños: "
            
        } else if language == "en" {
            
            definitionTitle.text = "What is it?"
            risksTitle.text = "Risks: "
            addictiveTitle.text = "Is It Addictive?"
            damageReduceTitle.text = "Damage Reduce: "
        }
        
        infoTitles.append(definitionTitle)
        infoTitles.append(risksTitle)
        infoTitles.append(addictiveTitle)
        infoTitles.append(damageReduceTitle)
    }
    
    func setInfoTexts() {
        definitionText.text = decomposeStringArray(_drug.description!)
        risksText.text = decomposeStringArray(_drug.risks!)
        addictiveText.text = decomposeStringArray(_drug.addictive!)
        damageReduceText.text = decomposeStringArray(_drug.riskAvoiding!)
        
        infoTexts.append(definitionText)
        infoTexts.append(risksText)
        infoTexts.append(addictiveText)
        infoTexts.append(damageReduceText)
        
        linesInUILabel(definitionText.text!)
    }
    
    
    

    
    func numberOfLinesInLabel(yourString: String, labelWidth: CGFloat, labelHeight: CGFloat, font: UIFont) -> Int {
        print(yourString)
        print(labelHeight)
        print(labelWidth)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = labelHeight
        paragraphStyle.maximumLineHeight = labelHeight
        paragraphStyle.lineBreakMode = .ByWordWrapping
        
        let attributes: [String: AnyObject] = [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle]
        
        let constrain = CGSizeMake(labelWidth, CGFloat(Float.infinity))
        
        let size = yourString.sizeWithAttributes(attributes)
        let stringWidth = size.width
        print(stringWidth)
        print(constrain.width)
        let numberOfLines = ceil(Double(stringWidth/constrain.width))
        
        return Int(numberOfLines)
    }
    
    func loadInfoCards() {
        for var i=0 ; i < infoTitles.count ; i++ {
            let size = CGRectMake((self.view.frame.size.width - CARD_WIDTH)/2, (self.view.frame.size.height - CARD_HEIGHT)/2, CARD_WIDTH, CARD_HEIGHT)
            let draggableView = DraggableView(frame: size)
            draggableView.delegate = self
            infoCards.append(draggableView)
            draggableView.addSubview(infoTitles[i])
            draggableView.addSubview(infoTexts[i])
            if i == 0 {
                
                view.addSubview(infoCards[i])
                setTitleConstraints(infoTitles[i], draggableView: infoCards[i])
                setInfoConstraints(infoTexts[i], draggableView: infoCards[i])
            } else {
                
                    view.insertSubview(infoCards[i], belowSubview: infoCards[i-1])
                    setTitleConstraints(infoTitles[i], draggableView: infoCards[i])
                setInfoConstraints(infoTexts[i], draggableView: infoCards[i])
                
            }
            setCardConstraints(infoCards[i])
            
        }
    }
 
    
    
    func setTitleConstraints(title: UILabel,draggableView: DraggableView) {
        
        title.textColor = UIColor.redColor()
        title.font = UIFont(name: "HelveticaNeue", size: CGFloat(22))
        
        title.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = NSLayoutConstraint(item: title, attribute: .Leading, relatedBy: .Equal, toItem: draggableView, attribute: .Leading, multiplier: 1, constant: 5)
        
        let topConstraint = NSLayoutConstraint(item: title, attribute: .Top, relatedBy: .Equal, toItem: draggableView, attribute: .Top, multiplier: 1, constant: 10)
        
        view.addConstraints([leadingConstraint,topConstraint])
    }
    
    func setInfoConstraints(text: UILabel,draggableView: DraggableView) {
        
        text.textColor = UIColor.blackColor()
        text.font = UIFont(name: "HelveticaNeue", size: CGFloat(14))
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = NSLayoutConstraint(item: text, attribute: .Leading, relatedBy: .Equal, toItem: draggableView, attribute: .Leading, multiplier: 1, constant: 5)
        
        let topConstraint = NSLayoutConstraint(item: text, attribute: .Top, relatedBy: .Equal, toItem: draggableView, attribute: .Top, multiplier: 1, constant: 40)
        
        let trailingConstraint = NSLayoutConstraint(item: text, attribute: .Trailing, relatedBy: .Equal, toItem: draggableView, attribute: .Trailing, multiplier: 1, constant: -5)
        
        view.addConstraints([leadingConstraint,topConstraint,trailingConstraint])
    }
    
    func setCardConstraints(draggableView: DraggableView) {
        
        draggableView.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = NSLayoutConstraint(item: draggableView, attribute: .Leading, relatedBy: .Equal, toItem: segmentedControl, attribute: .Leading, multiplier: 1, constant: 0)
        
        let trailingConstraint = NSLayoutConstraint(item: draggableView, attribute: .Trailing, relatedBy: .Equal, toItem: segmentedControl, attribute: .Trailing, multiplier: 1, constant: 0)
        
        let topConstraint = NSLayoutConstraint(item: draggableView, attribute: .Top, relatedBy: .Equal, toItem: segmentedControl, attribute: .Bottom, multiplier: 1, constant: 25)
        
        let bottomConstraint = NSLayoutConstraint(item: draggableView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: -20)

         view.addConstraints([leadingConstraint,trailingConstraint,topConstraint,bottomConstraint])
    }
    
    func rotated()
    {
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {
            setPortraitConstraints()
            
        } else if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {
            setLandscapeConstraints()
            
        } else if previousOrientationIsPortrait == true {
            
            setPortraitConstraints()
            
        } else if previousOrientationIsPortrait == false {
            
            setLandscapeConstraints()
        }
    }
    
    func setPortraitConstraints() {
        //drugPhotoHeight.constant = 128
        segmentedControlTop.constant = 25
        topBarHeight.constant = 45
        drugLabelHeight.constant = 30
        drugLabelBottom.constant = 0
        backButtonBottom.constant = 4
        _previousOrientationIsPortrait = true
    }
    
    func setLandscapeConstraints() {
        //drugPhotoHeight.constant = 0
        segmentedControlTop.constant = 5
        topBarHeight.constant = 25
        drugLabelHeight.constant = 20
        drugLabelBottom.constant = 3
        backButtonBottom.constant = 3
        _previousOrientationIsPortrait = false
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func segmentedControlActionChanged(sender: UISegmentedControl) {

        switch(sender.selectedSegmentIndex) {
            
        case 0:
            
            setInfoTitles()
            setInfoTexts()
            loadInfoCards()
           // updatePhotoHeight()
//            definitionTitle.text = "¿Qué es?"
//            definitionText.text = decomposeStringArray(_drug.description!)
           // toggleTextLabels()
            
            
        case 1:
            removeInfoCards()
            removeInfoTitles()
            removeInfoTexts()
//            drugPhotoHeight.constant = 0
            
            
            
        case 2:
//            drugPhotoHeight.constant = 0
//            definitionTitle.text = "Mezclas comunes:"
//            definitionText.text = decomposeStringArray(_drug.mixes!)
            //toggleTextLabels()
            updateViewConstraints()
            
        default:
            break
        }
    }
    
    func removeInfoCards() {
        for var i = infoCards.count - 1 ; i >= 0 ; i-- {
            infoCards[i].removeFromSuperview()
        }
    }
    
    func removeInfoTitles() {
        for var i = infoTitles.count - 1 ; i >= 0 ; i-- {
            infoTitles.removeAtIndex(i)
        }
    }
    
    func removeInfoTexts() {
        for var i = infoCards.count - 1 ; i >= 0 ; i-- {
            infoCards.removeAtIndex(i)
        }
    }
    
//    func updatePhotoHeight() {
//        if _previousOrientationIsPortrait == true {
//            
//            drugPhotoHeight.constant = 128
//        } else {
//            drugPhotoHeight.constant = 0
//        }
//    }
    
//    func toggleTextLabels() {
//        toggleLabel(risksTitle)
//        toggleLabel(risksText)
//        toggleLabel(addictiveTitle)
//        toggleLabel(addictiveText)
//        toggleLabel(damageReduceTitle)
//        toggleLabel(damageReduceText)
//    }
    
//    func toggleLabel(label: UILabel) {
//        
//        if label.hidden == true && definitionTitle.text == "¿Qué es?" {
//            label.hidden = false
//        } else {
//            label.hidden = true
//        }
//    }
    
    func cardSwipedLeft(card: UIView){
        infoCards.removeAtIndex(0)
    }
    
    func cardSwipedRight(card: UIView){
        infoCards.removeAtIndex(0)
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
