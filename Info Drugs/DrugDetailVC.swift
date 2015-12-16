//
//  DrugDetailVC.swift
//  Info Drugs
//
//  Created by Daniel Warner on 12/15/15.
//  Copyright © 2015 Daniel Warner. All rights reserved.
//

import UIKit

class DrugDetailVC: UIViewController {

    @IBOutlet weak var drugPhotoHeight: NSLayoutConstraint!
    @IBOutlet weak var drugNameLabel: UILabel!
    @IBOutlet weak var drugPhoto: UIImageView!
    
    @IBOutlet weak var definitionTitle: UILabel!
    @IBOutlet weak var definitionText: UILabel!
    
    @IBOutlet weak var risksTitle: UILabel!
    @IBOutlet weak var risksText: UILabel!
    
    @IBOutlet weak var addictiveTitle: UILabel!
    @IBOutlet weak var addictiveText: UILabel!
    
    @IBOutlet weak var damageReduceTitle: UILabel!
    @IBOutlet weak var damageReduceText: UILabel!
    
    
    private var _drug: Drug!
    
    var drug: Drug {
        get {
            return _drug
        }
        set {
            _drug = newValue
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x>0 {
            scrollView.contentOffset.x = 0
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        drugNameLabel.text = _drug.name
        self.view.clipsToBounds = true;
        //scrollView.contentSize = CGSizeMake(320,758)
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func segmentedControlActionChanged(sender: UISegmentedControl) {

        switch(sender.selectedSegmentIndex) {
            
        case 0:
            drugPhotoHeight.constant = 128
            definitionTitle.text = "¿Qué es?"
            definitionText.text = getDefinitionText()
            risksTitle.hidden = false
            risksText.hidden = false
            addictiveTitle.hidden = false
            addictiveText.hidden = false
            damageReduceTitle.hidden = false
            damageReduceText.hidden = false
            break
        case 1:
            drugPhotoHeight.constant = 0
            definitionTitle.text = "Efectos"
            definitionText.text = getDrugEffects()
            risksTitle.hidden = true
            risksText.hidden = true
            addictiveTitle.hidden = true
            addictiveText.hidden = true
            damageReduceTitle.hidden = true
            damageReduceText.hidden = true
            break
        case 2:
            break
        default:
            break
        }
        
        
        
    }
    
    func getDefinitionText() -> String {
        return "El LSD es el psicodélico más potente que se ha descubierto, ya que en cantidades muy pequeñas puede provocar efectos muy intensos. Este grupo de sustancias también son erróneamente llamadas alucinógenos.\nSus presentaciones son diversas, siendo las más comunes las planillas de papel secante que se cortan en pequeños cuadritos, los micropuntos o disoluciones líquidas de diferentes concentraciones. Por lo general se ingiere oralmente pero se puede absorber a través de la piel por lo que se debe manejar con cuidado."
    }

    
    func getDrugEffects() -> String {
        return "Los efectos del LSD producen una serie de alteraciones sensoriales a las que muchas veces se les llama viaje debido a que la experiencia parece transportate a otros lugares. Esta puede separarse en cuatro etapas:\n El inicio: Alrededor de 30 minutos después de ingerirlo se empiezan a sentir algunas alteraciones, los colores parecen más brillantes, los sonidos se perciben diferentes y el cuerpo puede presentar diversas sensaciones extrañas como hormigueos y temblores.\n La subida: A lo largo de las primeras 2 horas después de ingerirlo, los efectos se intensifican y se presentan distorsiones visuales, diferentes visiones, patrones geométricos y un gran cambio en la manera de pensar. Dependiendo de la dosis se puede complicar la interacción con otras personas o el mantener conciencia acerca de lo que está pasando a tu alrededor.\n El clímax: Dependiendo de la dosis este estado puede ser una extensión del anterior (si la dosis no es muy grande) o puede volverse una experiencia profunda de introspección y visualizaciones mentales muy intensas.\n Puede ser incómodo o incluso aterrador para personas no experimentadas por lo que es importante que si buscas experimentar o estás probando un nuevo material utilices solo media dosis.\n La bajada: Los efectos se van reduciendo poco a poco después de entre 6 y 8 horas y se mantiene un cierto grado de alteración que no desaparece hasta que duermes. Es muy importante dormir bien después de un viaje de LSD puesto que esto le permite al cerebro normalizar sus funciones."
    }
}
