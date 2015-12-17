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
        definitionText.text = decomposeStringArray(_drug.description!)
        self.view.clipsToBounds = true
        
        
        
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
            definitionText.text = decomposeStringArray(getDefinitionText())
            risksTitle.hidden = false
            risksText.hidden = false
            addictiveTitle.hidden = false
            addictiveText.hidden = false
            damageReduceTitle.hidden = false
            damageReduceText.hidden = false
            
        case 1:
            drugPhotoHeight.constant = 0
            definitionTitle.text = "Efectos:"
            definitionText.text = decomposeStringArray(getDrugEffects())
            risksTitle.hidden = true
            risksText.hidden = true
            addictiveTitle.hidden = true
            addictiveText.hidden = true
            damageReduceTitle.hidden = true
            damageReduceText.hidden = true
            
        case 2:
            drugPhotoHeight.constant = 0
            definitionTitle.text = "Mezclas comunes:"
            definitionText.text = decomposeStringArray(getMixesText())
            risksTitle.hidden = true
            risksText.hidden = true
            addictiveTitle.hidden = true
            addictiveText.hidden = true
            damageReduceTitle.hidden = true
            damageReduceText.hidden = true
        default:
            break
        }
        
        
        
    }
    
    func decomposeStringArray(array: [String]) -> String {
        print("Size: \(array.count)")
        var fullText = ""
        for paragraph in array {
            fullText += paragraph
            fullText += "\n\n"
        }
        print("FULL TEXT: \(fullText)")
        return fullText
    }
    
    
    func getDefinitionText() -> [String] {
        let def = ["El LSD es el psicodélico más potente que se ha descubierto, ya que en cantidades muy pequeñas puede provocar efectos muy intensos. Este grupo de sustancias también son erróneamente llamadas alucinógenos.","Sus presentaciones son diversas, siendo las más comunes las planillas de papel secante que se cortan en pequeños cuadritos, los micropuntos o disoluciones líquidas de diferentes concentraciones. Por lo general se ingiere oralmente pero se puede absorber a través de la piel por lo que se debe manejar con cuidado."]
        return def
    }

    
    func getDrugEffects() -> [String] {
        let eff = ["Los efectos del LSD producen una serie de alteraciones sensoriales a las que muchas veces se les llama viaje debido a que la experiencia parece transportate a otros lugares. Esta puede separarse en cuatro etapas:","El inicio: Alrededor de 30 minutos después de ingerirlo se empiezan a sentir algunas alteraciones, los colores parecen más brillantes, los sonidos se perciben diferentes y el cuerpo puede presentar diversas sensaciones extrañas como hormigueos y temblores.","La subida: A lo largo de las primeras 2 horas después de ingerirlo, los efectos se intensifican y se presentan distorsiones visuales, diferentes visiones, patrones geométricos y un gran cambio en la manera de pensar. Dependiendo de la dosis se puede complicar la interacción con otras personas o el mantener conciencia acerca de lo que está pasando a tu alrededor.","El clímax: Dependiendo de la dosis este estado puede ser una extensión del anterior (si la dosis no es muy grande) o puede volverse una experiencia profunda de introspección y visualizaciones mentales muy intensas.\n Puede ser incómodo o incluso aterrador para personas no experimentadas por lo que es importante que si buscas experimentar o estás probando un nuevo material utilices solo media dosis.", "La bajada: Los efectos se van reduciendo poco a poco después de entre 6 y 8 horas y se mantiene un cierto grado de alteración que no desaparece hasta que duermes. Es muy importante dormir bien después de un viaje de LSD puesto que esto le permite al cerebro normalizar sus funciones." ]
        return eff
    }
    
    func getMixesText() -> [String] {
        let mix = ["Debido a los potentes efectos de las sustancias enteógenas, no se recomienda mezclarlas con otras sustancias. Es menos arriesgado mantenerse únicamente en el estado del LSD, sin embargo en el contexto recreativo es común mezclarla con otras drogas. Aquí te comentamos lo que puede suceder.","Cannabis: Es una mezcla muy común. Los efectos enteógenos del LSD pueden alargarse o revivir al consumir marihuana. Sin embargo la intensificación del efecto te puede generar un desgaste innecesario y puede afectar aún más tu percepción a amenazar la estabilidad de tu viaje, por lo que no se recomienda consumir dosis altas.","Éxtasis y Anfetaminas: La mezcla con MDMA puede dar un toque más empatógeno, de vínculo con otras personas, al viaje de LSD o más brillante a la experiencia del MDMA. Se le conoce popularmente como “Candy Flip”. Se recomienda utilizar dosis muy bajas de MDMA y tener en cuenta las precauciones de ambas sustancias por separado.","Cocaína: Consumir estimulantes disminuye el efecto psicodélico del LSD. Si tomas mucho de cualquiera de las dos sustancias es posible provocar una mala experiencia de ansiedad o nerviosismo.\nHeroína y otros opiáceos: Los opiáceos en general eliminan el efecto del LSD. En caso de seguir consumiéndolos el efecto psicodélico llega a desaparecer a riesgo de caer en una sobredosis de heroína. Recuerda que los opiáceos son sumamente adictivos por lo que se debe tener suma precaución con la interacción o el uso de los mismos.","Tabaco: Algunxs usuarixs encuentran relajante y placentero fumar durante la experiencia en LSD, pero otros lo llegan a encontrar sumamente desagradable aún siendo fumadores cotidianos. Esto depende de la persona y el momento, sin embargo, no hay mucha interacción entre las sustancias.","Alcohol: Mezclar LSD con alcohol suele enturbiar la experiencia, volviéndola más pesada e incontrolable, a veces generando situaciones peligrosas. Recomendamos abstenerse de combinar estas dos sustancias."]
        return mix
    }
}
