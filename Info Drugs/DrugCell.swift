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
        let drugName = drug.name!
        
        if(drugName == "Metanfetamina" || drugName == "Methamphetamine") {
            nameLbl.text = "Meth"
        } else {
            nameLbl.text = drugName
        }
        
        
        
        if drugName == "Cocaine" {
            
            thumbImg.image = UIImage(named: "Cocaina")
            
        } else if drugName == "Heroine" {
            
            thumbImg.image = UIImage(named: "Heroina")
            
        } else if drugName == "Ketamine" {
            
            thumbImg.image = UIImage(named: "Ketamina")
            
        } else if drugName == "Methamphetamine" {
            
            thumbImg.image = UIImage(named: "Metanfetamina")
            
        } else if drugName == "Solvents" {
            
            thumbImg.image = UIImage(named: "Solventes")
            
        } else if drugName == "Tobacco" {
            
            thumbImg.image = UIImage(named: "Tabaco")
            
        } else {
            thumbImg.image = UIImage(named: "\(drugName)")
        }
        
    }
    
}
