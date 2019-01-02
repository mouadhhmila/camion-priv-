//
//  CompteChauffeurViewController.swift
//  CamionPrivé
//
//  Created by Forest Cab
//  Copyright © 2018 Administrateur. All rights reserved.
//
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
//

import UIKit
import Alamofire
import NVActivityIndicatorView
import CountryPicker
import SCLAlertView
import JTMaterialTransition



//**********************************************************************************************



class CompteChauffeurViewController: UIViewController{
   

    
    var PRENOM = String()
    var NOM = String()
    var EMAIL = String()
    var NUMTEL = String()
    var CODEPAYS = String()
    var ADRESSE = String()
    var VILLE = String()
    var CODEPOSTAL = String()
    var PAYS = String()
    
    
   
    
    @IBOutlet weak var viewendediting: UIView!
    
    @IBOutlet weak var imgProfil: UIImageView!
    
    
    
    @IBOutlet weak var labelPrenom: UILabel!
    @IBOutlet weak var txtPrenom: UILabel!
    
    @IBOutlet weak var labelNom: UILabel!
    @IBOutlet weak var txtNom: UILabel!
    
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    
    @IBOutlet weak var labelNumtel: UILabel!
    @IBOutlet weak var txtNum: UILabel!
    @IBOutlet weak var txtCodePays: UILabel!
    
    @IBOutlet weak var labelAdress: UILabel!
    @IBOutlet weak var txtAdress: UILabel!
    
    @IBOutlet weak var labelVille: UILabel!
    @IBOutlet weak var txtVille: UILabel!
    
    @IBOutlet weak var labelCodePostal: UILabel!
    @IBOutlet weak var txtCodePostal: UILabel!
    
    @IBOutlet weak var labelPays: UILabel!
    @IBOutlet weak var txtPays: UILabel!
    
    
    
    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v3: UIView!
    @IBOutlet weak var v4: UIView!
    @IBOutlet weak var v5: UIView!
    @IBOutlet weak var v6: UIView!
    @IBOutlet weak var v7: UIView!
    
    @IBOutlet weak var viewimgprofl: UIView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("**¥¥¥¥¥¥¥¥ffffffffffff")
        
        DispatchQueue.global(qos: .userInitiated).async {
           DispatchQueue.main.async {
                
                self.viewimgprofl.layer.cornerRadius = self.viewimgprofl.frame.height / 2
                self.imgProfil.image = img
           
            }}
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global(qos: .userInitiated).async {
           DispatchQueue.main.async {
                
                
               self.UIDevice()
            
                
            
                self.view.backgroundColor = UIColor.black
                
            
                self.v1.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
                self.v2.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
                self.v3.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
                self.v4.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
                self.v5.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
                self.v6.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
                self.v7.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
                
                

            }}
        
        
        
        

        txtNom.text! = firstname
        txtPrenom.text! = names
        
        txtEmail.text! = Email
        txtNum.text! = Tel
        txtAdress.text! = Addressss
        txtCodePays.text! = CodePays
        
        txtVille.text! = Villee
        txtCodePostal.text! = CodePostalee
        txtPays.text! = Payss
        
        
      
        
        
    }
    
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func UIDevice() {
        
        
        
        switch UIScreen.main.nativeBounds.height {
        case 960:
            print("iPhone4")
            
            

          
            return
        //.iPhone4
        case 1136:
            print("iPhones_5_5s_5c_SE")
            
          
         
            labelPrenom.font = labelPrenom.font.withSize(16)
            txtPrenom.font = txtPrenom.font.withSize(16)
            labelNom.font = labelNom.font.withSize(16)
            txtNom.font = txtNom.font.withSize(16)
            labelEmail.font = labelEmail.font.withSize(16)
            txtEmail.font = txtEmail.font.withSize(16)
            labelNumtel.font = labelNumtel.font.withSize(16)
            txtNum.font = txtNum.font.withSize(16)
            txtCodePays.font = txtCodePays.font.withSize(16)
            labelAdress.font = labelAdress.font.withSize(16)
            txtAdress.font = txtAdress.font.withSize(16)
            labelVille.font = labelVille.font.withSize(16)
            txtVille.font = txtVille.font.withSize(16)
            
            labelCodePostal.font = labelCodePostal.font.withSize(16)
            txtCodePostal.font = txtCodePostal.font.withSize(16)
            
            labelPays.font = labelPays.font.withSize(16)
            txtPays.font = txtPays.font.withSize(16)
            
        
            return
        //.iPhones_5_5s_5c_SE
        case 1334:
            print("iPhones_6_6s_7_8")
            
            return
        //.iPhones_6_6s_7_8
        case 1920, 2208:
            print("iPhones_6Plus_6sPlus_7Plus_8Plus")
            
      
            
            labelPrenom.font = labelPrenom.font.withSize(20)
            txtPrenom.font = txtPrenom.font.withSize(20)
            labelNom.font = labelNom.font.withSize(20)
            txtNom.font = txtNom.font.withSize(20)
            labelEmail.font = labelEmail.font.withSize(20)
            txtEmail.font = txtEmail.font.withSize(20)
            labelNumtel.font = labelNumtel.font.withSize(20)
            txtNum.font = txtNum.font.withSize(20)
            txtCodePays.font = txtCodePays.font.withSize(20)
            labelAdress.font = labelAdress.font.withSize(20)
            txtAdress.font = txtAdress.font.withSize(20)
            labelVille.font = labelVille.font.withSize(20)
            txtVille.font = txtVille.font.withSize(20)
            
            labelCodePostal.font = labelCodePostal.font.withSize(20)
            txtCodePostal.font = txtCodePostal.font.withSize(20)
            
            labelPays.font = labelPays.font.withSize(20)
            txtPays.font = txtPays.font.withSize(20)
            
        
            
            return
        //.iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            print("iPhoneX")
            return
        //.iPhoneX
        default:
            print("ipade")
            
            
            return
            //.unknown
        }
        
    }
    
}

extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
