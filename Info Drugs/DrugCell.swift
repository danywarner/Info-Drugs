//
//  DrugCell.swift
//  Info Drugs
//
//  Created by Daniel Warner on 12/15/15.
//  Copyright © 2015 Daniel Warner. All rights reserved.
//

import UIKit

class DrugCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var drug: Drug!
    
    func configureCell(drug: Drug) {
        
        self.drug = drug
        
        if(drug.name == "Metanfetamina" || drug.name == "Methamphetamine") {
            nameLbl.text = "Meth"
        } else {
            nameLbl.text = self.drug.name
        }
        
        
        
        if drug.name == "Cocaine" {
            
            thumbImg.image = UIImage(named: "Cocaina")
            
        } else if drug.name == "Heroine" {
            
            thumbImg.image = UIImage(named: "Heroina")
            
        } else if drug.name == "Ketamine" {
            
            thumbImg.image = UIImage(named: "Ketamina")
            
        } else if drug.name == "Methamphetamine" {
            
            thumbImg.image = UIImage(named: "Metanfetamina")
            
        } else if drug.name == "Solvents" {
            
            thumbImg.image = UIImage(named: "Solventes")
            
        } else if drug.name == "Tobacco" {
            
            thumbImg.image = UIImage(named: "Tabaco")
            
        } else {
            thumbImg.image = UIImage(named: "\(drug.name)")
        }
        
    }
    
}
