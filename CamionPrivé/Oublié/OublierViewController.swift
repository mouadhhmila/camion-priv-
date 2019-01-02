//
//  OublierViewController.swift
//  CamionPrivé
//
//  Created by Forest Cab on 07/09/2018.
//  Copyright © 2018 Administrateur. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SkyFloatingLabelTextField
import SCLAlertView

var mail_renisialise = " "

class OublierViewController: UIViewController, NVActivityIndicatorViewable {
    
    var xview = CGFloat()
    var yview = CGFloat()
    
    @IBOutlet weak var txtemail: SkyFloatingLabelTextField!
    @IBOutlet weak var buttonrechrch: UIButton!
    
    
    @IBOutlet weak var txt1: UILabel!
    @IBOutlet weak var txt2: UILabel!
    

    
    
    
    
    
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
    @IBAction func buttonaback(_ sender: Any) {
        
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "idConnection") as! ConnexionViewController
        self.present(myVC, animated: false, completion: nil)
        
    }
    
    @IBAction func buttonrechercher(_ sender: Any) {
        
        
        let activityInd = NVActivityIndicatorView(frame: CGRect(x: xview - 25, y: yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
        view.addSubview(activityInd)
        startAnimating(message: "Recherche...", type: NVActivityIndicatorType.ballRotateChase)

        
        
        if validateEmail(enteredEmail: txtemail.text!){
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
              
                 self.rechercher()
            }
        }
        
        if !validateEmail(enteredEmail: txtemail.text!){
            if txtemail.text == ""{
                DispatchQueue.main.async {
                    self.stopAnimating()
                    self.txtemail.textColor = UIColor.red
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
                    DispatchQueue.main.async {
                        self.txtemail.textColor = UIColor.white
                    }
                    alertView.dismiss(animated: true, completion: nil)
                }
                
                alertView.showError("ERREUR", subTitle: "Entrer une adresse e-mail.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "cancel64"))
            }else{
            DispatchQueue.main.async {
                self.stopAnimating()
                self.txtemail.textColor = UIColor.red
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
            DispatchQueue.main.async {
                self.txtemail.textColor = UIColor.white
            }
            alertView.dismiss(animated: true, completion: nil)
        }
        
        alertView.showError("ERREUR", subTitle: "Entrer une adresse e-mail valide.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "cancel64"))
        }
        }
        
    }
            
            
    
        
    
    
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    
    func rechercher(){
        SendApi_rechercher()
        }
    
    func SendApi_rechercher()
    {
        
        let email1 = txtemail.text
        mail_renisialise = email1!
        
        let postString = ["email":email1] as! [String : String]
        
        let url = NSURL(string: "\(weburl)/api/getcodereset")
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
                     
                        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "idcoderecu") as! CodeViewController
                        self.present(myVC, animated: false, completion: nil)
                
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
                        
                        alertView.showError("ERREUR", subTitle: "Votre email n'existe pas.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "cancel64"))
                        
                        
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
            
            txtemail.attributedPlaceholder = NSAttributedString(string: "Votre adresse e-mail", attributes:attributes)
            
             txt1.font = txt1.font.withSize(23)
             txt2.font = txt2.font.withSize(9)
            buttonrechrch.titleLabel?.font = buttonrechrch.titleLabel?.font.withSize(15)
            
            return
        //.iPhones_5_5s_5c_SE
        case 1334:
            print("iPhones_6_6s_7_8")
            let attributes = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName : UIFont(name: "Roboto-Light", size: 16)! // Note the !
            ]
            
            txtemail.attributedPlaceholder = NSAttributedString(string: "Votre adresse e-mail", attributes:attributes)
            
           
            return
        //.iPhones_6_6s_7_8
        case 1920, 2208:
            print("iPhones_6Plus_6sPlus_7Plus_8Plus")
           
            
            let attributes = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName : UIFont(name: "Roboto-Light", size: 16)! // Note the !
            ]
            
            txtemail.attributedPlaceholder = NSAttributedString(string: "Votre adresse e-mail", attributes:attributes)
            
            
            txt1.font = txt1.font.withSize(27)
            txt2.font = txt2.font.withSize(12)
            buttonrechrch.titleLabel?.font = buttonrechrch.titleLabel?.font.withSize(19)
            return
        //.iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            print("iPhoneX")
            
            let attributes = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName : UIFont(name: "Roboto-Light", size: 16)! // Note the !
            ]
            
            txtemail.attributedPlaceholder = NSAttributedString(string: "Votre adresse e-mail", attributes:attributes)
            
           
            
            return
        //.iPhoneX
        default:
            print("ipade")
            
            
            return
            //.unknown
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
