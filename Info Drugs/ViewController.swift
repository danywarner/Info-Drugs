//
//  ViewController.swift
//  Info Drugs
//
//  Created by Daniel Warner on 12/15/15.
//  Copyright © 2015 Daniel Warner. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var drugs = [Drug]()
    var filteredDrugs = [Drug]()
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
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
            
            let drug: Drug!
            
            if inSearchMode {
                drug = filteredDrugs[indexPath.row]
            } else {
               drug = drugs[indexPath.row]
            }
            
            cell.configureCell(drug)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
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

}

