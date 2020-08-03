//
//  ViewController.swift
//  Info Drugs
//
//  Created by Daniel Warner on 12/15/15.
//  Copyright © 2015 Daniel Warner. All rights reserved.
//

import UIKit
import FirebaseDatabase
import CoreData
import Flurry_iOS_SDK
import SwiftOverlays


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var drugLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var topBarHeight: NSLayoutConstraint!
    
    @IBOutlet weak var drugLabelBottom: NSLayoutConstraint!
    
    @IBOutlet weak var appNameLabel: UILabel!
    
    var drugs = [Drug]()
    var filteredDrugs = [Drug]()
    var inSearchMode = false
    var previousOrientationIsPortrait = true
    var versions = [Version]();
    var currentDataVersion = 0
    var onlineDataVersion = 0
    private var transitionManager = TransitionManager()
    
    override func viewDidLoad() {
        
        let flurryKey = "Keys.FlurryKey" //todo dww
        //dispatch_async(dispatch_get_global_queue(DispatchQueue.GlobalQueuePriority.background, 0)) {
            Flurry.startSession(flurryKey);
        //}
        
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        self.fetchAndSetResults()
        fetchVersion()
        checkDataVersion()
        if versions.count > 0 {
            let currentVersion = versions.last
            currentDataVersion = Int(currentVersion!.versionNumber!)
        }
        
       
        collection.reloadData()
        
        
    }
    
    
    func checkDataVersion() {
        DataService.ds.REF_DATA_VERSION.observe(.value, with: { snapshot in
            let onlineVersion = snapshot.value as! Int
            self.onlineDataVersion = onlineVersion
            
            if (self.onlineDataVersion > self.currentDataVersion) {
                //dispatch_async(dispatch_get_global_queue(DispatchQueue.GlobalQueuePriority.background, 0)) {
                    self.deleteStoredDrugs()
                    self.downloadData()
                //}
                self.createVersion(versionNumber: self.onlineDataVersion)
            } else {
                
                self.fetchAndSetResults()
                self.collection.reloadData()
            }
        })
    }
    
    func createVersion(versionNumber: Int) {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Version", in: context)!
        let version = Version(entity: entity, insertInto: context)
        
        version.versionNumber = NSNumber(value: versionNumber)
        context.insert(version)
        
        do {
            try context.save()
        } catch {
            print("Could not save Version in context")
        }
    }
    
    func downloadData() {
        
        //dispatch_async(dispatch_get_main_queue()) {
            self.showWaitOverlayWithText(NSLocalizedString("descargando info.", comment: "descargando info."))
        //}
        DataService.ds.REF_DRUGS.observe(.value, with: { snapshot in
            
            self.drugs = []
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                
                for snap in snapshots {
                    
                    if let drugDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        self.createDrug(name: key, dictionary: drugDict)
                    }
                }
            }
            self.collection.reloadData()
            self.removeAllOverlays()
        })
    }
    
    func createDrug(name: String, dictionary: Dictionary<String, AnyObject>) {
        
        var _description = [String]()
        var _effects = [String]()
        var _risks = [String]()
        var _addictive = [String]()
        //var _legal = [String]()
        var _riskAvoiding = [String]()
        var _mixes = [String]()
        
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Drug", in: context)!
        let drug = Drug(entity: entity, insertInto: context)
        
        drug.name = name
        
        if let effects = dictionary["effects"] as? [String] {
            for effect in effects {
                _effects.append(effect)
            }
            drug.effects = _effects as NSObject
        }
        
        if let definitionArr = dictionary["definition"] as? [String] {
            for definition in definitionArr {
                _description.append(definition)
            }
            drug.drugDescription = _description as NSObject
        }
        
        if let risks = dictionary["risks"] as? [String] {
            for risk in risks {
                _risks.append(risk)
            }
            drug.risks = _risks as NSObject
        }
        
        if let addictiveText = dictionary["addictive"] as? [String] {
            for addictive in addictiveText {
                _addictive.append(addictive)
            }
            drug.addictive = _addictive as NSObject
        }
        
        if let damageReduceOptions = dictionary["damageReduce"] as? [String] {
            for damageReduce in damageReduceOptions {
                _riskAvoiding.append(damageReduce)
            }
            drug.riskAvoiding = _riskAvoiding as NSObject
        }
        
        if let mixes = dictionary["mixes"] as? [String] {
            for mix in mixes {
                _mixes.append(mix)
            }
            drug.mixes = _mixes as NSObject
        }
        
        drugs.append(drug)
        context.insert(drug)
        
        do {
            try context.save()
        } catch {
            print("Could not save Application in context")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DrugCell", for: indexPath) as? DrugCell {
            let drug: Drug!
            drug = drugs[indexPath.row]
            cell.configureCell(drug: drug)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func fetchVersion() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Version")
        
        do {
            let results = try context.fetch(fetchRequest1)
            self.versions = results as! [Version]
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func deleteStoredDrugs() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Drug")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
           print(error.debugDescription)
        }
    }
    
    func fetchAndSetResults() {
        
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Drug")
        
        do {
            let results = try context.fetch(fetchRequest1)
            self.drugs = results as! [Drug]
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var drug: Drug!
        drug = drugs[indexPath.row]
        performSegue(withIdentifier: "DrugDetailVC", sender: drug)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredDrugs.count
        }
        return drugs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 85, height: 85)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DrugDetailVC" {
            if let detailsVC = segue.destination as? DrugDetailVC {
                if let drug = sender as? Drug {
                    detailsVC.drug = drug
                }
            detailsVC.transitioningDelegate = self.transitionManager
            }
        }
    }
}

