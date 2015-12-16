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
        
        nameLbl.text = self.drug.name.capitalizedString
        thumbImg.image = UIImage(named: "\(drug.name)")
    }
    
}
