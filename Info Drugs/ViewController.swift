//
//  ViewController.swift
//  Info Drugs
//
//  Created by Daniel Warner on 12/15/15.
//  Copyright © 2015 Daniel Warner. All rights reserved.
//

import UIKit
import Firebase
import CoreData
import Flurry_iOS_SDK


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var drugLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var topBarHeight: NSLayoutConstraint!
    
    @IBOutlet weak var drugLabelBottom: NSLayoutConstraint!
    
    @IBOutlet weak var appNameLabel: UILabel!
    
    var drugs = [Drug]()
    var filteredDrugs = [Drug]()
    var inSearchMode = false
    var preferredLanguages : NSLocale!
    var pre = NSLocale.preferredLanguages()[0]
    var previousOrientationIsPortrait = true
    var lang = ""
    var versions = [Version]();
    var currentDataVersion = 0
    var onlineDataVersion = 0
    private var transitionManager = TransitionManager()
    
    override func viewDidLoad() {
        
        lang = (pre as NSString).substringToIndex(2)
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        fetchAndSetResults()
        fetchVersion()
        checkDataVersion()
        if versions.count > 0 {
            let currentVersion = versions.last
            currentDataVersion = Int(currentVersion!.versionNumber!)
        }
        
       
        collection.reloadData()
        
        let flurryKey = Keys.FlurryKey
        Flurry.startSession(flurryKey);
    }
    
    
    func checkDataVersion() {
        DataService.ds.REF_DATA_VERSION.observeEventType(.Value, withBlock: { snapshot in
            let onlineVersion = snapshot.value as! Int
            self.onlineDataVersion = onlineVersion
            
            if (self.onlineDataVersion > self.currentDataVersion) {
                
                self.deleteStoredDrugs()
                self.downloadData()
                self.createVersion(self.onlineDataVersion)
            } else {
                
                self.fetchAndSetResults()
                self.collection.reloadData()
            }
        })
    }
    
    func createVersion(versionNumber: Int) {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let entity = NSEntityDescription.entityForName("Version", inManagedObjectContext: context)!
        let version = Version(entity: entity, insertIntoManagedObjectContext: context)
        
        version.versionNumber = versionNumber
        context.insertObject(version)
        
        do {
            try context.save()
        } catch {
            print("Could not save Version in context")
        }
    }
    
    func downloadData() {
        
        if lang == "es" {
            
            //print(lang)
            self.appNameLabel.text = "Info Drogas"
            DataService.ds.REF_ES_DRUGS.observeEventType(.Value, withBlock: { snapshot in
                
                self.drugs = []
                if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                    
                    for snap in snapshots {
                        
                        if let drugDict = snap.value as? Dictionary<String, AnyObject> {
                            let key = snap.key
                            self.createDrug(key, dictionary: drugDict)
                            
                            
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
                            self.createDrug(key, dictionary: drugDict)
                            
                            
                        }
                    }
                }
                self.collection.reloadData()
            })
        }

    }
    
    func createDrug(name: String, dictionary: Dictionary<String, AnyObject>) {
        
        var _description = [String]()
        var _effects = [String]()
        var _risks = [String]()
        var _addictive = [String]()
        //var _legal = [String]()
        var _riskAvoiding = [String]()
        var _mixes = [String]()
        
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let entity = NSEntityDescription.entityForName("Drug", inManagedObjectContext: context)!
        let drug = Drug(entity: entity, insertIntoManagedObjectContext: context)
        
        drug.name = name
        
        if let effects = dictionary["effects"] as? [String] {
            for effect in effects {
                _effects.append(effect)
            }
            drug.effects = _effects
        }
        
        if let definitionArr = dictionary["definition"] as? [String] {
            for definition in definitionArr {
                _description.append(definition)
            }
            drug.drugDescription = _description
        }
        
        if let risks = dictionary["risks"] as? [String] {
            for risk in risks {
                _risks.append(risk)
            }
            drug.risks = _risks
        }
        
        if let addictiveText = dictionary["addictive"] as? [String] {
            for addictive in addictiveText {
                _addictive.append(addictive)
            }
            drug.addictive = _addictive
        }
        
        if let damageReduceOptions = dictionary["damageReduce"] as? [String] {
            for damageReduce in damageReduceOptions {
                _riskAvoiding.append(damageReduce)
            }
            drug.riskAvoiding = _riskAvoiding
        }
        
        if let mixes = dictionary["mixes"] as? [String] {
            for mix in mixes {
                _mixes.append(mix)
            }
            drug.mixes = _mixes
        }
        
        drugs.append(drug)
        context.insertObject(drug)
        
        do {
            try context.save()
        } catch {
            print("Could not save Application in context")
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DrugCell", forIndexPath: indexPath) as? DrugCell {
            
            let drug: Drug!
            drug = drugs[indexPath.row]
            
            //print(drug.name)
            cell.configureCell(drug)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func fetchVersion() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest1 = NSFetchRequest(entityName: "Version")
        
        
        do {
            let results = try context.executeFetchRequest(fetchRequest1)
            self.versions = results as! [Version]
            
            
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func deleteStoredDrugs() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Drug")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.executeRequest(deleteRequest)
        } catch let error as NSError {
           print(error.debugDescription)
        }
    }
    
    func fetchAndSetResults() {
        
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest1 = NSFetchRequest(entityName: "Drug")
        
        
        do {
            let results = try context.executeFetchRequest(fetchRequest1)
            self.drugs = results as! [Drug]
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var drug: Drug!
        drug = drugs[indexPath.row]
        
        
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
    
//    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        // Override point for customization after application launch.
//        let flurryKey = Keys.FlurryKey
//        print(flurryKey)
//        Flurry.startSession(flurryKey);// development
//        return true;
//    }
    
    
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DrugDetailVC" {
            if let detailsVC = segue.destinationViewController as? DrugDetailVC {
                if let drug = sender as? Drug {
                    detailsVC.drug = drug
                    detailsVC.previousOrientationIsPortrait = self.previousOrientationIsPortrait
                    detailsVC.language = lang
                    
                }
            detailsVC.transitioningDelegate = self.transitionManager
            }
        }
    }
}

