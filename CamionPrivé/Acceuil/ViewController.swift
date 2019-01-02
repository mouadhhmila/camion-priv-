//  CamionPrivé
//
//  Created by Forest Cab
//  Copyright © 2018 Administrateur. All rights reserved.
//--------------------------------------------------------------------------------------------
//----------------------------------IIIIIIII--------IIIIIIII----------------------------------
//----------------------------------IIII-IIII------IIII-IIII----------------------------------
//----------------------------------IIII--IIII----IIII--IIII----------------------------------
//----------------------------------IIII---IIII--IIII---IIII----------------------------------
//----------------------------------IIII----------------IIII----------------------------------
//----------------------------------IIII----------------IIII----------------------------------
//----------------------------------IIII----------------IIII----------------------------------
//----------------------------------IIII----------------IIII----------------------------------
//--------------------------------------------------------------------------------------------

import UIKit





class ViewController: UIViewController{


    @IBOutlet weak var buttconnexion: UIButton!

    @IBOutlet weak var labcamion: UILabel!
    @IBOutlet weak var labprivé: UILabel!
    @IBOutlet weak var labchauffeur: UILabel!
    
    
    //*****************************************************************************************************


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.UIDevice()
        }
        
        self.buttconnexion.isHidden = true
        
        UIApplication.shared.statusBarStyle = .lightContent

        
        
        buttconnexion.layer.shadowColor = UIColor.init(red: 177/255, green: 182/255, blue: 186/255, alpha: 1).cgColor
        buttconnexion.layer.shadowOpacity = 0.4
        buttconnexion.layer.shadowOffset = .zero
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.buttconnexion.isHidden = false
        }
        
    }
    
    @IBAction func buttonConnexion(_ sender: Any) {
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "idConnection") as! ConnexionViewController
        
        self.present(myVC, animated: false, completion: nil)
    }


    //************************************************************************************************

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   //******************************************************************************************************
    func UIDevice() {



        switch UIScreen.main.nativeBounds.height {
        case 960:
            print("iPhone4")
            
            return
        //.iPhone4
        case 1136:
            print("iPhones_5_5s_5c_SE")
            buttconnexion.titleLabel?.font = buttconnexion.titleLabel?.font.withSize(15)
            
            labcamion.font = labcamion.font.withSize(30)
            labprivé.font = labprivé.font.withSize(30)
            labchauffeur.font = labchauffeur.font.withSize(20)


            return
        //.iPhones_5_5s_5c_SE
        case 1334:
            print("iPhones_6_6s_7_8")
            return
        //.iPhones_6_6s_7_8
        case 1920, 2208:
            print("iPhones_6Plus_6sPlus_7Plus_8Plus")
            buttconnexion.titleLabel?.font = buttconnexion.titleLabel?.font.withSize(19)
            
            labcamion.font = labcamion.font.withSize(34)
            labprivé.font = labprivé.font.withSize(34)
            labchauffeur.font = labchauffeur.font.withSize(24)
            
            
            return
        //.iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            print("mmmm iPhoneX")
            
            buttconnexion.titleLabel?.font = buttconnexion.titleLabel?.font.withSize(17)
            
            
            return
        //.iPhoneX
        default:
            print("ipade")
            //***************
            
            return
            //.unknown
        }

    }


}


