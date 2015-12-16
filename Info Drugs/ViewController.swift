//
//  ViewController.swift
//  Info Drugs
//
//  Created by Daniel Warner on 12/15/15.
//  Copyright © 2015 Daniel Warner. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collection: UICollectionView!
    
    var drugs = [Drug]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        
        createInitialDrugs()
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
            
            let drug = drugs[indexPath.row]
            cell.configureCell(drug)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
        
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drugs.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        return CGSizeMake(105, 105)
    }

}

