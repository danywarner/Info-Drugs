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
    var effectsCards: Array<DraggableView> = []
    var mixesCards: Array<DraggableView> = []
    var infoTitles: Array<UILabel> = []
    var effectsTitles: Array<UILabel> = []
    var mixesTitles: Array<UILabel> = []
    var infoTexts: Array<UILabel> = []
    var effectsTextArray: Array<UILabel> = []
    var mixesTextArray: Array<UILabel> = []
    var definitionTitle: UILabel = UILabel()
    var risksTitle1: UILabel = UILabel()
    var risksTitle2: UILabel = UILabel()
    var addictiveTitle: UILabel = UILabel()
    var damageReduceTitle1: UILabel = UILabel()
    var damageReduceTitle2: UILabel = UILabel()
    
    var definitionText: UILabel = UILabel()
    var risksText: UILabel = UILabel()
    var risksText1: UILabel = UILabel()
    var risksText2: UILabel = UILabel()
    var addictiveText: UILabel = UILabel()
    var damageReduceText: UILabel = UILabel()
    var damageReduceText1: UILabel = UILabel()
    var damageReduceText2: UILabel = UILabel()
    
    var effectsTitle1: UILabel = UILabel()
    var effectsTitle2: UILabel = UILabel()
    var effectsText: UILabel = UILabel()
    var effectsText1: UILabel = UILabel()
    var effectsText2: UILabel = UILabel()
    
    var paragraphsArray: Array<String> = []
    
    var mixesTitle1: UILabel = UILabel()
    var mixesTitle2: UILabel = UILabel()
    var mixesTitle3: UILabel = UILabel()
    var mixesTitle4: UILabel = UILabel()
    var mixesText: UILabel = UILabel()
    var mixesText1: UILabel = UILabel()
    var mixesTextx2: UILabel = UILabel()
    var mixesTextx3: UILabel = UILabel()
    var mixesTextx4: UILabel = UILabel()
    
    var screenWidth: CGFloat = 0.0
    private var _drug: Drug!
    private var _previousOrientationIsPortrait = true
    var selectedSegment = 1
    
    var infoConstraints: Array<NSLayoutConstraint> = []
    var draggableViewSize: CGRect = CGRect()
    
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
        screenWidth = self.view.frame.size.width
        drugNameLabel.text = _drug.name
        setInfoTitles()
        setInfoTexts()
        draggableViewSize = CGRectMake((self.view.frame.size.width - CARD_WIDTH)/2, (self.view.frame.size.height - CARD_HEIGHT)/2, CARD_WIDTH, CARD_HEIGHT)
        //        let image = UIImage(named: "\(drug.name)Photo")
        //        drugPhoto.image = image
        
        loadInfoCards()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        if screenWidth == 375.0 { //iPhone 6
            width = 325.0
        }
        else if screenWidth == 320.0 { //iPhone 5
            width = 270.0
            
        } else if screenWidth == 414.0 { //iPhone 6+
            width = 364.0
        }
        //The current font size is 16, so 8.0 is the size to divide into.
        let charsInLine = lroundf(width/8.0)
        let lines = Int((text.characters.count))/charsInLine
        return lines
    }
    
    
    func setInfoTitles() {
        if language == "es" {
            
            definitionTitle.text = "¿Qué es?"
            risksTitle1.text = "Riesgos: "
            risksTitle2.text = "Riesgos: "
            addictiveTitle.text = "¿Es Adictivo?"
            damageReduceTitle1.text = "Reducción de daños: "
            damageReduceTitle2.text = "Reducción de daños: "
            
            effectsTitle1.text = "Efectos:"
            effectsTitle2.text = "Efectos:"
            
            mixesTitle1.text = "Mezclas comunes:"
            mixesTitle2.text = "Mezclas comunes:"
            mixesTitle3.text = "Mezclas comunes:"
            mixesTitle4.text = "Mezclas comunes:"
            
        } else if language == "en" {
            
            definitionTitle.text = "What is it?"
            risksTitle1.text = "Risks: "
            risksTitle2.text = "Risks: "
            addictiveTitle.text = "Is It Addictive?"
            damageReduceTitle1.text = "Damage Reduce: "
            damageReduceTitle2.text = "Damage Reduce: "
            
            effectsTitle1.text = "Effects:"
            effectsTitle2.text = "Effects:"
            
            mixesTitle1.text = "Common Mixes:"
            mixesTitle2.text = "Common Mixes:"
            mixesTitle3.text = "Common Mixes:"
            mixesTitle4.text = "Common Mixes:"
        }
        
        infoTitles.append(definitionTitle)
        infoTitles.append(risksTitle1)
        infoTitles.append(risksTitle2)
        infoTitles.append(addictiveTitle)
        infoTitles.append(damageReduceTitle1)
        infoTitles.append(damageReduceTitle2)
        
        effectsTitles.append(effectsTitle1)
        effectsTitles.append(effectsTitle2)
        
        mixesTitles.append(mixesTitle1)
        mixesTitles.append(mixesTitle2)
        mixesTitles.append(mixesTitle3)
        mixesTitles.append(mixesTitle4)
    }
    
    func setInfoTexts() {
        definitionText.text = decomposeStringArray(_drug.description!)
        risksText.text = decomposeStringArray(_drug.risks!)
        addictiveText.text = decomposeStringArray(_drug.addictive!)
        damageReduceText.text = decomposeStringArray(_drug.riskAvoiding!)
        
        infoTexts.append(definitionText)
        
        
        paragraphsArray = []
        if linesInUILabel(risksText.text!) > 23 {
            let paragraphsNumber = paragraphsInText(risksText.text!)
            
            risksText1.text = paragraphsArray[0]+"\n\n"
            risksText2.text = ""
            for var k = 1 ; k < paragraphsNumber ; k++ {
                
                if linesInUILabel(risksText1.text!+paragraphsArray[k]) < 23 {
                    risksText1.text? += paragraphsArray[k] + "\n\n"
                    
                } else {
                    risksText2.text? += paragraphsArray[k] + "\n\n"
                }
                
            }
            infoTexts.append(risksText1)
            infoTexts.append(risksText2)
        } else {
            infoTexts.append(risksText)
        }
        
        infoTexts.append(addictiveText)
        
        paragraphsArray = []
        if linesInUILabel(damageReduceText.text!) > 23 {
            let paragraphsNumber = paragraphsInText(damageReduceText.text!)
            
            damageReduceText1.text = paragraphsArray[0]+"\n\n"
            damageReduceText2.text = ""
            for var k = 1 ; k < paragraphsNumber ; k++ {
                
                if linesInUILabel(damageReduceText1.text!+paragraphsArray[k]) < 23 {
                    damageReduceText1.text? += paragraphsArray[k] + "\n\n"
                    
                } else {
                    damageReduceText2.text? += paragraphsArray[k] + "\n\n"
                }
                
            }
            infoTexts.append(damageReduceText1)
            infoTexts.append(damageReduceText2)
        } else {
            infoTexts.append(damageReduceText)
        }
        
        effectsText.text = decomposeStringArray(_drug.effects!)
        
        mixesText.text = decomposeStringArray(_drug.mixes!)
    }
    
    func loadInfoCards() {
        for var i=0 ; i < infoTexts.count ; i++ {
            
            let draggableView = DraggableView(frame: draggableViewSize)
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
    
    func loadMixesCards() {
        paragraphsArray = []
        
        if linesInUILabel(mixesText.text!) > 24 {
            let paragraphsNumber = paragraphsInText(mixesText.text!)
            
            mixesText1.text = paragraphsArray[0]+"\n\n"
            mixesTextx2.text = ""
            mixesTextx3.text = ""
            mixesTextx4.text = ""
            
            for var k = 1 ; k < paragraphsNumber ; k++ {
                if linesInUILabel(mixesText1.text!+paragraphsArray[k]) < 24 {
                    mixesText1.text? += paragraphsArray[k] + "\n\n"
                    
                } else if linesInUILabel(mixesTextx2.text!+paragraphsArray[k]) < 24 {
                    mixesTextx2.text? += paragraphsArray[k] + "\n\n"
                } else if linesInUILabel(mixesTextx3.text!+paragraphsArray[k]) < 24 {
                    mixesTextx3.text? += paragraphsArray[k] + "\n\n"
                } else {
                    mixesTextx4.text? += paragraphsArray[k] + "\n\n"
                }
            }
            mixesTextArray.append(mixesText1)
            mixesTextArray.append(mixesTextx2)
            if mixesTextx3.text != "" {
                mixesTextArray.append(mixesTextx3)
            }
            if mixesTextx4.text != "" {
                mixesTextArray.append(mixesTextx4)
            }
            
            
            for var i = 0 ; i < mixesTextArray.count ; i++ {
                let draggableView = DraggableView(frame: draggableViewSize)
                draggableView.delegate = self
                mixesCards.append(draggableView)
                draggableView.addSubview(mixesTitles[i])
                draggableView.addSubview(mixesTextArray[i])
                if i == 0 {
                    view.addSubview(mixesCards[i])
                    setTitleConstraints(mixesTitles[i], draggableView: mixesCards[i])
                    setInfoConstraints(mixesTextArray[i], draggableView: mixesCards[i])
                } else {
                    view.insertSubview(mixesCards[i], belowSubview: mixesCards[i-1])
                    setTitleConstraints(mixesTitles[i], draggableView: mixesCards[i])
                    setInfoConstraints(mixesTextArray[i], draggableView: mixesCards[i])
                }
                setCardConstraints(mixesCards[i])
            }
            
            
        } else {
            let draggableView = DraggableView(frame: draggableViewSize)
            draggableView.delegate = self
            mixesCards.append(draggableView)
            draggableView.addSubview(mixesTitle1)
            draggableView.addSubview(mixesText)
            view.addSubview(mixesCards[0])
            setTitleConstraints(mixesTitle1, draggableView: mixesCards[0])
            setInfoConstraints(mixesText, draggableView: mixesCards[0])
            setCardConstraints(mixesCards[0])
        }

    }
    
    func loadEffectsCards() {
            paragraphsArray = []
        
        if linesInUILabel(effectsText.text!) > 22 {
            let paragraphsNumber = paragraphsInText(effectsText.text!)
            
            effectsText1.text = paragraphsArray[0]+"\n\n"
            effectsText2.text = ""
            
            for var k = 1 ; k < paragraphsNumber ; k++ {
                if linesInUILabel(effectsText1.text!+paragraphsArray[k]) < 22 {
                    effectsText1.text? += paragraphsArray[k] + "\n\n"
                    
                } else {
                    effectsText2.text? += paragraphsArray[k] + "\n\n"
                }
            }
            effectsTextArray.append(effectsText1)
            effectsTextArray.append(effectsText2)
            
            for var i = 0 ; i < 2 ; i++ {
                let draggableView = DraggableView(frame: draggableViewSize)
                draggableView.delegate = self
                effectsCards.append(draggableView)
                draggableView.addSubview(effectsTitles[i])
                draggableView.addSubview(effectsTextArray[i])
                if i == 0 {
                    view.addSubview(effectsCards[i])
                    setTitleConstraints(effectsTitles[i], draggableView: effectsCards[i])
                    setInfoConstraints(effectsTextArray[i], draggableView: effectsCards[i])
                } else {
                    view.insertSubview(effectsCards[i], belowSubview: effectsCards[i-1])
                    setTitleConstraints(effectsTitles[i], draggableView: effectsCards[i])
                    setInfoConstraints(effectsTextArray[i], draggableView: effectsCards[i])
                }
                setCardConstraints(effectsCards[i])
            }
            
            
        } else {
            let draggableView = DraggableView(frame: draggableViewSize)
            draggableView.delegate = self
            effectsCards.append(draggableView)
            draggableView.addSubview(effectsTitle1)
            draggableView.addSubview(effectsText)
            view.addSubview(effectsCards[0])
            setTitleConstraints(effectsTitle1, draggableView: effectsCards[0])
            setInfoConstraints(effectsText, draggableView: effectsCards[0])
            setCardConstraints(effectsCards[0])
        }
        
    }
    
    func paragraphsInText(text: String) -> Int {
        paragraphsArray = text.characters.split{$0 == "\n"}.map(String.init)
        return paragraphsArray.count
    }
 
    func setTitleConstraints(title: UILabel,draggableView: DraggableView) {
        
        title.textColor = UIColor.redColor()
        title.font = UIFont(name: "HelveticaNeue", size: CGFloat(22))
        
        title.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = NSLayoutConstraint(item: title, attribute: .Leading, relatedBy: .Equal, toItem: draggableView, attribute: .Leading, multiplier: 1, constant: 5)
        
        let topConstraint = NSLayoutConstraint(item: title, attribute: .Top, relatedBy: .Equal, toItem: draggableView, attribute: .Top, multiplier: 1, constant: 10)
        
        if selectedSegment == 1 {
            infoConstraints.append(leadingConstraint)
            infoConstraints.append(topConstraint)
        }
        
        view.addConstraints([leadingConstraint,topConstraint])
        
    }
    
    func removeInfoConstraints() {
        for var i = 0 ; i < infoConstraints.count ; i++ {
            view.removeConstraint(infoConstraints[i])
        }
        
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
        setInfoTitles()
        setInfoTexts()
        switch(sender.selectedSegmentIndex) {
            
        case 0:
            
            if(selectedSegment == 2) {
                removeEffectsCards()
                removeEffectsTitles()
                removeEffectsTexts()
            } else if (selectedSegment == 3) {
                removeMixesCards()
                removeMixesTitles()
                removeMixesTexts()
            }
            selectedSegment = 1
            loadInfoCards()
            
        case 1:
            
            if selectedSegment == 1 {
                removeInfoCards()
                removeInfoTitles()
                removeInfoTexts()
                
            } else if (selectedSegment == 3) {
                removeMixesCards()
                removeMixesTitles()
                removeMixesTexts()
            }
            selectedSegment = 2
            loadEffectsCards()
            
        case 2:
            if selectedSegment == 1 {
                removeInfoCards()
                removeInfoTitles()
                removeInfoTexts()
            } else if(selectedSegment == 2) {
                removeEffectsCards()
                removeEffectsTitles()
                removeEffectsTexts()
            }
            selectedSegment = 3
            loadMixesCards()
            
        default:
            break
        }
    }
    
    func removeInfoCards() {
        for var i = infoCards.count - 1 ; i >= 0 ; i-- {
            infoCards[i].removeFromSuperview()
            infoCards.removeAtIndex(i)
        }
    }
    
    func removeInfoTitles() {
        for var i = infoTitles.count - 1 ; i >= 0 ; i-- {
            infoTitles.removeAtIndex(i)
        }
    }
    
    func removeInfoTexts() {
        for var i = infoTexts.count - 1 ; i >= 0 ; i-- {
            infoTexts.removeAtIndex(i)
        }
    }
    
    func removeEffectsCards() {
        for var i = effectsCards.count - 1 ; i >= 0 ; i-- {
            effectsCards[i].removeFromSuperview()
            effectsCards.removeAtIndex(i)
        }
    }
    
    func removeEffectsTitles() {
        for var i = effectsTitles.count - 1 ; i >= 0 ; i-- {
            effectsTitles.removeAtIndex(i)
        }
    }
    
    func removeEffectsTexts() {
        for var i = effectsTextArray.count - 1 ; i >= 0 ; i-- {
            effectsTextArray.removeAtIndex(i)
        }
    }
    
    func removeMixesCards() {
        for var i = mixesCards.count - 1 ; i >= 0 ; i-- {
            mixesCards[i].removeFromSuperview()
            mixesCards.removeAtIndex(i)
        }
    }
    
    func removeMixesTitles() {
        for var i = mixesTitles.count - 1 ; i >= 0 ; i-- {
            mixesTitles.removeAtIndex(i)
        }
    }
    
    func removeMixesTexts() {
        for var i = mixesTextArray.count - 1 ; i >= 0 ; i-- {
            mixesTextArray.removeAtIndex(i)
        }
    }
    
    
    func cardSwipedLeft(card: UIView){
        if(selectedSegment == 1) {
            infoCards.removeAtIndex(0)
        } else if (selectedSegment == 2) {
            effectsCards.removeAtIndex(0)
        } else if (selectedSegment == 3) {
            mixesCards.removeAtIndex(0)
        }
        
    }
    
    func cardSwipedRight(card: UIView){
        if(selectedSegment == 1) {
            infoCards.removeAtIndex(0)
        } else if (selectedSegment == 2) {
            effectsCards.removeAtIndex(0)
        } else if (selectedSegment == 3) {
            mixesCards.removeAtIndex(0)
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
