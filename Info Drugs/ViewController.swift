//
//  ViewController.swift
//  Info Drugs
//
//  Created by Daniel Warner on 12/15/15.
//  Copyright © 2015 Daniel Warner. All rights reserved.
//

import UIKit
import Firebase
import Flurry_iOS_SDK


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var drugLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var topBarHeight: NSLayoutConstraint!
    
    @IBOutlet weak var drugLabelBottom: NSLayoutConstraint!
    
    @IBOutlet weak var appNameLabel: UILabel!
    
   // @IBOutlet weak var searchBar: UISearchBar!
    
    var drugs = [Drug]()
    var filteredDrugs = [Drug]()
    var inSearchMode = false
    var preferredLanguages : NSLocale!
    var pre = NSLocale.preferredLanguages()[0]
    var previousOrientationIsPortrait = true
    var lang = ""
    
    override func viewDidLoad() {
        
        print("language: \(pre)")
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
       // searchBar.delegate = self
       // searchBar.returnKeyType = UIReturnKeyType.Done
        
        lang = (pre as NSString).substringToIndex(2)
        if lang == "es" {
            
            print(lang)
            self.appNameLabel.text = "Info Drogas"
            DataService.ds.REF_ES_DRUGS.observeEventType(.Value, withBlock: { snapshot in
                //print(snapshot.value)
                
                self.drugs = []
                if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                    
                    for snap in snapshots {
                        
                       // print("SNAP: \(snap)")
                        
                        if let drugDict = snap.value as? Dictionary<String, AnyObject> {
                            let key = snap.key
                            let drug = Drug(drugName: key, dictionary: drugDict)
                            self.drugs.append(drug)
                            
                        }
                        
                    }
                    
                    
                }
              self.collection.reloadData()
            })
        } else {
            DataService.ds.REF_EN_DRUGS.observeEventType(.Value, withBlock: { snapshot in
                //print(snapshot.value)
                
                self.drugs = []
                if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                    
                    for snap in snapshots {
                        
                        // print("SNAP: \(snap)")
                        
                        if let drugDict = snap.value as? Dictionary<String, AnyObject> {
                            let key = snap.key
                            let drug = Drug(drugName: key, dictionary: drugDict)
                            self.drugs.append(drug)
                            
                        }
                        
                    }
                    
                    
                }
                self.collection.reloadData()
            })
        }
        collection.reloadData()
        
        //createInitialDrugs()
        
        //rotated()
       // NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
//    func organizeDrugs() {
//        let organizedStringsArray = ["Alcohol", "2C-B", "Cannabis", "DMT", "Cocaina", "Crack", "Heroina", "Ketamina", "LSD", "MDMA", "Metanfetamina", "NBOMe", "Psilocybe", "Solventes", "Tabaco"]
//        var organizedDrugsArray = []
//        
//        for var x = 0 ; x < organizedStringsArray.count ; x++ {
//            let oDrug = drugs.sort
//        }
//    }
//    
//    override func viewDidAppear(animated: Bool) {
//        rotated()
//    }
    
//    func rotated()
//    {
//        
//        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
//        {
//            setPortraitConstraints()
//            
//        } else if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
//        {
//            setLandscapeConstraints()
//            
//        } else if previousOrientationIsPortrait == true {
//            
//            setPortraitConstraints()
//            
//        } else if previousOrientationIsPortrait == false {
//            
//            setLandscapeConstraints()
//        }
//    }
    
    func setPortraitConstraints() {
        topBarHeight.constant = 45
        drugLabelHeight.constant = 30
        drugLabelBottom.constant = 0
        previousOrientationIsPortrait = true
    }
    
    func setLandscapeConstraints() {
        topBarHeight.constant = 25
        drugLabelHeight.constant = 20
        drugLabelBottom.constant = 3
        previousOrientationIsPortrait = false
    }
    
    func createInitialDrugs() {
        let drugsArray = ["Heroina", "Ketamina", "Metanfetamina", "NBOMe", "Alcohol", "Benzodiazepinas", "Cannabis", "Cocaina", "Crack", "DMT", "Inhalantes", "LSD", "MDMA", "Tabaco"]
        
        for drugName in drugsArray {
            let tempDrug = Drug(name: drugName)
            drugs.append(tempDrug)
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DrugCell", forIndexPath: indexPath) as? DrugCell {
            
            let drug: Drug!
            
            if inSearchMode {
                drug = filteredDrugs[indexPath.row]
            } else {
               drug = drugs[indexPath.row]
            }
            //print(drug.name)
            cell.configureCell(drug)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var drug: Drug!
        
        if inSearchMode {
            drug = filteredDrugs[indexPath.row]
        } else {
            drug = drugs[indexPath.row]
        }
        
        performSegueWithIdentifier("DrugDetailVC", sender: drug)
    }
    
    

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredDrugs.count
        }
        return drugs.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(85, 85)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let flurryKey = Keys.FlurryKey
        Flurry.startSession(flurryKey);// development
        return true;
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            filteredDrugs = drugs.filter({$0.name.lowercaseString.rangeOfString(lower) != nil})
            collection.reloadData()
        }
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DrugDetailVC" {
            if let detailsVC = segue.destinationViewController as? DrugDetailVC {
                if let drug = sender as? Drug {
                    detailsVC.drug = drug
                    detailsVC.previousOrientationIsPortrait = self.previousOrientationIsPortrait
                    detailsVC.language = lang
                }
            }
        }
    }
}

