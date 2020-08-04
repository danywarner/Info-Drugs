//
//  DrugCell.swift
//  Info Drugs
//
//  Created by Daniel Warner on 12/15/15.
//  Copyright © 2015 Daniel Warner. All rights reserved.
//

import UIKit

final class DrugCell: UICollectionViewCell {
    
    @IBOutlet private weak var thumbImg: UIImageView!
    @IBOutlet private weak var nameLbl: UILabel!
    
    func configureCell(drugName: String) {
        configureLabel(drugName: drugName)
        configureImage(drugName: drugName)
    }
    
    private func configureLabel(drugName: String) {
       if(drugName == "Metanfetamina" || drugName == "Methamphetamine") {
           nameLbl.text = "Meth"
       } else {
           nameLbl.text = drugName
       }
    }
    
    private func configureImage(drugName: String) {
        switch drugName {
        case "Cocaine":
            thumbImg.image = UIImage(named: "Cocaina")
        case "Heroine":
            thumbImg.image = UIImage(named: "Heroina")
        case "Ketamine":
            thumbImg.image = UIImage(named: "Ketamina")
        case "Methamphetamine":
            thumbImg.image = UIImage(named: "Metanfetamina")
        case "Solvents":
            thumbImg.image = UIImage(named: "Solventes")
        case "Tobacco":
            thumbImg.image = UIImage(named: "Tabaco")
        default:
            thumbImg.image = UIImage(named: "\(drugName)")
        }
    }
}
