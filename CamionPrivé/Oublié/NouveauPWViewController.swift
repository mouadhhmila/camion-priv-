//
//  NouveauPWViewController.swift
//  CamionPrivé
//
//  Created by Forest Cab on 07/09/2018.
//  Copyright © 2018 Administrateur. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SkyFloatingLabelTextField
import SCLAlertView


class NouveauPWViewController: UIViewController, NVActivityIndicatorViewable {

    
    var xview = CGFloat()
    var yview = CGFloat()
    
    
    
    @IBOutlet weak var txt1: UILabel!
    @IBOutlet weak var buttvalidd: UIButton!
    @IBOutlet weak var txtemail: SkyFloatingLabelTextField!
    @IBOutlet weak var nouveaumail: SkyFloatingLabelTextField!
    
    @IBOutlet weak var veullez: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        xview = view.center.x
        yview = view.center.y
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         UIDevice()
        
        
       
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ConnexionViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard() {
        
        view.endEditing(true)
        print("dismis key")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttback(_ sender: Any) {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "idcoderecu") as! CodeViewController
        self.present(myVC, animated: false, completion: nil)
    }
    
    @IBAction func buttvalider(_ sender: Any) {
        let activityInd = NVActivityIndicatorView(frame: CGRect(x: xview - 25, y: yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
        view.addSubview(activityInd)
        startAnimating(message: "Validation...", type: NVActivityIndicatorType.ballRotateChase)

        
        if txtemail.text == nouveaumail.text  {
            if validationMotdePasse(entredPassword: txtemail.text!) {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.valider()
                }
            }else{
                
                if txtemail.text == ""{
                    DispatchQueue.main.async {
                        self.stopAnimating()
                    }
                    let appearance1 = SCLAlertView.SCLAppearance(
                        kCircleIconHeight: 45.0,
                        kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                        kTextFont: UIFont(name: "Roboto", size: 13)!,
                        kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                        showCloseButton: false
                    )
                    
                    // Initialize SCLAlertView using custom Appearance
                    let alertView = SCLAlertView(appearance: appearance1)
                    alertView.addButton("OK"){
                        
                        alertView.dismiss(animated: true, completion: nil)
                    }
                    
                    alertView.showError("ERREUR", subTitle: "Entrer un nouveau mot de passe.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "cancel64"))
                }else{
                DispatchQueue.main.async {
                    self.stopAnimating()
                }
                let appearance1 = SCLAlertView.SCLAppearance(
                    kCircleIconHeight: 45.0,
                    kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                    kTextFont: UIFont(name: "Roboto", size: 13)!,
                    kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                    showCloseButton: false
                )
                
                // Initialize SCLAlertView using custom Appearance
                let alertView = SCLAlertView(appearance: appearance1)
                alertView.addButton("OK"){
                    
                    alertView.dismiss(animated: true, completion: nil)
                }
                
                alertView.showError("ERREUR", subTitle: "Essayer de saisir un mot de passe correcte.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "cancel64"))
                
                
                }
                
            }
        }else{
            DispatchQueue.main.async {
                self.stopAnimating()
            }
            let appearance1 = SCLAlertView.SCLAppearance(
                kCircleIconHeight: 45.0,
                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                kTextFont: UIFont(name: "Roboto", size: 13)!,
                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                showCloseButton: false
            )
            
            // Initialize SCLAlertView using custom Appearance
            let alertView = SCLAlertView(appearance: appearance1)
            alertView.addButton("OK"){
                
                alertView.dismiss(animated: true, completion: nil)
            }
            
            alertView.showError("ERREUR", subTitle: "Essayer de saisir à nouveau le mot de passe.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "cancel64"))
        }
       
    }
    
    func valider(){
       SendApi_valide()
    }
    
    
    func SendApi_valide()
    {
        
        let email1 = mail_renisialise
        let motdepass = txtemail.text
        let nouveaupassword = nouveaumail.text
        
        let postString = ["email":email1, "password":motdepass, "c_password":nouveaupassword]
        
        let url = NSURL(string: "\(weburl)/api/resetpassword")
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            
            
            
            
            
            if error != nil
            {
                print("problème seveur")
                
                DispatchQueue.main.async {
                    let status = Reach().connectionStatus()
                    switch status {
                    case .unknown, .offline:
                        print("Not connected")
                        DispatchQueue.main.async {
                            self.stopAnimating()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
                            alertView.addButton("OK"){
                                alertView.dismiss(animated: true, completion: nil)
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                        
                        
                    case .online(.wwan):
                        print("Connected via WWAN")
                        DispatchQueue.main.async {
                            self.stopAnimating()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
                            alertView.addButton("OK"){
                                alertView.dismiss(animated: true, completion: nil)
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                        
                    case .online(.wiFi):
                        print("Connected via WiFi")
                        
                        DispatchQueue.main.async {
                            self.stopAnimating()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
                            alertView.addButton("OK"){
                                alertView.dismiss(animated: true, completion: nil)
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                        
                    }
                    
                }
                print("hhhhhhh", error as Any)
                
                return
            }
            
            do
            {
                let json1  = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
                print("é&é&é&é&é \(json1) *&é&é&&é&")

                let success = json1[0] as! String
                if (success == "success"){
                    
                    
                    DispatchQueue.main.async {
                        
                        
                        
                        self.stopAnimating()
                        
                        let appearance1 = SCLAlertView.SCLAppearance(
                            kCircleIconHeight: 45.0,
                            kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                            kTextFont: UIFont(name: "Roboto", size: 13)!,
                            kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                            showCloseButton: false
                        )
                        
                        // Initialize SCLAlertView using custom Appearance
                        let alertView = SCLAlertView(appearance: appearance1)
                        alertView.addButton("OK"){
                            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "idConnection") as! ConnexionViewController
                            self.present(myVC, animated: false, completion: nil)
                        }
                        
                        alertView.showError("Success", subTitle: "Votre mot de passe a été réinitialisé avec succès", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "check"))
                        
                        
                        
                        
                    }
                    
                }else {
                    DispatchQueue.main.async {
                        self.stopAnimating()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                        let appearance1 = SCLAlertView.SCLAppearance(
                            kCircleIconHeight: 45.0,
                            kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                            kTextFont: UIFont(name: "Roboto", size: 13)!,
                            kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                            showCloseButton: false
                        )
                        
                        // Initialize SCLAlertView using custom Appearance
                        let alertView = SCLAlertView(appearance: appearance1)
                        alertView.addButton("OK"){
                            alertView.dismiss(animated: true, completion: nil)
                        }
                        
                        alertView.showError("ERREUR", subTitle: "Vérifier votre mot de passe.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "cancel64"))
                        
                        
                    }
                }
                
                
            }
            catch let error as NSError
            {
                print(error)
                DispatchQueue.main.async {
                    let status = Reach().connectionStatus()
                    switch status {
                    case .unknown, .offline:
                        print("Not connected")
                        DispatchQueue.main.async {
                            self.stopAnimating()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
                            alertView.addButton("OK"){
                                alertView.dismiss(animated: true, completion: nil)
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                        
                        
                    case .online(.wwan):
                        print("Connected via WWAN")
                        DispatchQueue.main.async {
                            self.stopAnimating()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
                            alertView.addButton("OK"){
                                alertView.dismiss(animated: true, completion: nil)
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                        
                    case .online(.wiFi):
                        print("Connected via WiFi")
                        
                        DispatchQueue.main.async {
                            self.stopAnimating()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
                            alertView.addButton("OK"){
                                alertView.dismiss(animated: true, completion: nil)
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                        
                    }
                    
                }
            }
        }
        task.resume()
    }
    
    
    func checkNull(obj : AnyObject?) -> Bool {
        if obj is NSNull {
            return true
        } else {
            return false
        }
    }
    
        func validationMotdePasse(entredPassword:String) -> Bool{
            let passwordFormat = "[A-Z0-9a-z._%+-@]{6,25}"
            let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordFormat)
            return passwordPredicate.evaluate(with: entredPassword)
            
            
        }
    
    func UIDevice() {
        
        
        switch UIScreen.main.nativeBounds.height {
        case 960:
            print("iPhone4, iphone 4s")
            
            
            return
        //.iPhone4
        case 1136:
            print("iPhones_5_5s_5c_SE")
            
            
            let attributes = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName : UIFont(name: "Roboto-Light", size: 15)! // Note the !
            ]
            
            txtemail.attributedPlaceholder = NSAttributedString(string: "Nouveau mot de passe", attributes:attributes)
            let attributes1 = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName : UIFont(name: "Roboto-Light", size: 15)! // Note the !
            ]
            
            nouveaumail.attributedPlaceholder = NSAttributedString(string: "Saisir à nouveau", attributes:attributes1)
            
            txt1.font = txt1.font.withSize(23)
            veullez.font = veullez.font.withSize(9)
            buttvalidd.titleLabel?.font = buttvalidd.titleLabel?.font.withSize(15)
            
            return
        //.iPhones_5_5s_5c_SE
        case 1334:
            print("iPhones_6_6s_7_8")
           
            let attributes = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName : UIFont(name: "Roboto-Light", size: 16)! // Note the !
            ]
            
            txtemail.attributedPlaceholder = NSAttributedString(string: "Nouveau mot de passe", attributes:attributes)
            let attributes1 = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName : UIFont(name: "Roboto-Light", size: 16)! // Note the !
            ]
            
            nouveaumail.attributedPlaceholder = NSAttributedString(string: "Saisir à nouveau", attributes:attributes1)
          
            
            return
        //.iPhones_6_6s_7_8
        case 1920, 2208:
            print("iPhones_6Plus_6sPlus_7Plus_8Plus")
            let attributes = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName : UIFont(name: "Roboto-Light", size: 16)! // Note the !
            ]
            
            txtemail.attributedPlaceholder = NSAttributedString(string: "Nouveau mot de passe", attributes:attributes)
            let attributes1 = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName : UIFont(name: "Roboto-Light", size: 16)! // Note the !
            ]
            
            nouveaumail.attributedPlaceholder = NSAttributedString(string: "Saisir à nouveau", attributes:attributes1)
            
            txt1.font = txt1.font.withSize(27)
            veullez.font = veullez.font.withSize(12)
            buttvalidd.titleLabel?.font = buttvalidd.titleLabel?.font.withSize(19)
           
            return
        //.iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            print("iPhoneX")
            
            let attributes = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName : UIFont(name: "Roboto-Light", size: 16)! // Note the !
            ]
            
            txtemail.attributedPlaceholder = NSAttributedString(string: "Nouveau mot de passe", attributes:attributes)
            let attributes1 = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName : UIFont(name: "Roboto-Light", size: 16)! // Note the !
            ]
            
            nouveaumail.attributedPlaceholder = NSAttributedString(string: "Saisir à nouveau", attributes:attributes1)
            
           
            
            
            
            return
        //.iPhoneX
        default:
            print("ipade")
            
            
            return
            //.unknown
        }
        
    }

}
