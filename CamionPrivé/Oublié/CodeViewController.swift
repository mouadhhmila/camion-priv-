//
//  CodeViewController.swift
//  CamionPrivé
//
//  Created by Forest Cab on 07/09/2018.
//  Copyright © 2018 Administrateur. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SCLAlertView

class CodeViewController: UIViewController, NVActivityIndicatorViewable {

    var xview = CGFloat()
    var yview = CGFloat()
    
    var tapcontinu = 0
    @IBOutlet weak var txt1: UILabel!
    @IBOutlet weak var txt2: UILabel!
    @IBOutlet weak var txt3: UILabel!
    @IBOutlet weak var buttcdNRecu: UIButton!
    @IBOutlet weak var buttContinu: UIButton!
    
    
    @IBOutlet weak var first: UITextField!
    @IBOutlet weak var second: UITextField!
    @IBOutlet weak var third: UITextField!
    @IBOutlet weak var forth: UITextField!
    @IBOutlet weak var fifth: UITextField!
    @IBOutlet weak var sixth: UITextField!
    @IBOutlet weak var viewhid: UIView!
    @IBOutlet weak var viewhid2: UIView!
    
    @IBOutlet weak var buttsupprimtxt: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        xview = view.center.x
        yview = view.center.y
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttsupprimtxt.isHidden = true
        UIDevice()

        // Do any additional setup after loading the view.
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ConnexionViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)
        viewhid.isHidden = true
        first.delegate = self
        second.delegate = self
        third.delegate = self
        forth.delegate = self
        fifth.delegate = self
        sixth.delegate = self
        
        
        first.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        second.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        third.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        forth.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        fifth.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        sixth.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
    
    }
    
    @IBAction func buttcodenonrecu(_ sender: Any) {
        let activityInd = NVActivityIndicatorView(frame: CGRect(x: xview - 25, y: yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
        view.addSubview(activityInd)
        
        startAnimating(message: "Chargement...", type: NVActivityIndicatorType.ballRotateChase)

        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            
            self.SendApi_rechercher()
            
            
        }
        
    }
    func SendApi_rechercher()
    {
        
        let email1 = mail_renisialise
        
        
        let postString = ["email":email1]
        
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
                            self.view.endEditing(true)
                            self.viewhid.isHidden = true
                            self.first.text = ""
                            self.second.text = ""
                            self.third.text = ""
                            self.forth.text = ""
                            self.fifth.text = ""
                            self.sixth.text = ""
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
                            self.view.endEditing(true)
                            self.viewhid.isHidden = true
                            self.first.text = ""
                            self.second.text = ""
                            self.third.text = ""
                            self.forth.text = ""
                            self.fifth.text = ""
                            self.sixth.text = ""
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
                            self.view.endEditing(true)
                            self.viewhid.isHidden = true
                            self.first.text = ""
                            self.second.text = ""
                            self.third.text = ""
                            self.forth.text = ""
                            self.fifth.text = ""
                            self.sixth.text = ""
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
                        self.view.endEditing(true)
                        self.viewhid.isHidden = true
                        self.first.text = ""
                        self.second.text = ""
                        self.third.text = ""
                        self.forth.text = ""
                        self.fifth.text = ""
                        self.sixth.text = ""
                        
                    }
                    
                }else {
                    DispatchQueue.main.async {
                        self.stopAnimating()
                        self.view.endEditing(true)
                        self.viewhid.isHidden = true
                        self.first.text = ""
                        self.second.text = ""
                        self.third.text = ""
                        self.forth.text = ""
                        self.fifth.text = ""
                        self.sixth.text = ""
                        
                        
                   
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
                        
                        alertView.showError("ERREUR", subTitle: "Vérifier votre email.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "cancel64"))
                        
                        
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
    
    
    @IBAction func buttsupprim(_ sender: Any) {
        self.view.endEditing(true)
        self.viewhid.isHidden = true
        self.first.text = ""
        self.second.text = ""
        self.third.text = ""
        self.forth.text = ""
        self.fifth.text = ""
        self.sixth.text = ""
        buttsupprimtxt.isHidden = true
    }
    
    func textFieldDidChange(textField: UITextField){
        
        let text = textField.text
        
        if (text?.utf16.count == 1)||(text?.utf16.count == 2){
            switch textField{
            case first:
                viewhid.isHidden = false
                buttsupprimtxt.isHidden = false

                second.becomeFirstResponder()
            case second:
                third.becomeFirstResponder()
            case third:
                forth.becomeFirstResponder()
            case forth:
                fifth.becomeFirstResponder()
            case fifth:
                sixth.becomeFirstResponder()
            case sixth:
                sixth.resignFirstResponder()
            default:
                break
            }
        }else{
            
        }
    }
    func dismissKeyboard() {
        
        view.endEditing(true)
        print("dismis key")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttcontinuer(_ sender: Any) {
        let activityInd = NVActivityIndicatorView(frame: CGRect(x: xview - 25, y: yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
        view.addSubview(activityInd)
        
        startAnimating(message: "Vérification...", type: NVActivityIndicatorType.ballRotateChase)

        
        if let text = sixth.text, text.isEmpty
        {
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
            
            alertView.showError("ERREUR", subTitle: "Saisir le code de sécurité.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "cancel64"))
            
        }else{
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.continuer()
            }
        }
        
        
       
    }
    
    @IBAction func buttback(_ sender: Any) {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "idOublié") as! OublierViewController
        self.present(myVC, animated: false, completion: nil)
    }
    func continuer(){
        SendApi_Continue()
    }
    func SendApi_Continue()
    {
        
        let email1 = mail_renisialise
        let code1 = first.text! + second.text! + third.text! + forth.text! + fifth.text! + sixth.text!
        print("fffff", code1)
        let postString = ["email":email1, "code":code1]
        
        let url = NSURL(string: "\(weburl)/api/verifcode")
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
                        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "idnouveaupw") as! NouveauPWViewController
                        self.present(myVC, animated: false, completion: nil)
                        
                    }
                    
                }else {
                    DispatchQueue.main.async {
                        self.stopAnimating()
                        self.tapcontinu = self.tapcontinu + 1
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
                            if(self.tapcontinu == 3){
                                let myVC = self.storyboard?.instantiateViewController(withIdentifier: "idOublié") as! OublierViewController
                                self.present(myVC, animated: false, completion: nil)
                            }else{
                            alertView.dismiss(animated: true, completion: nil)
                            }
                        }
                        
                        alertView.showError("ERREUR", subTitle: "Vérifier votre code de sécurité", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "cancel64"))
                        
                        
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
    
    func UIDevice(){
    
    
    switch UIScreen.main.nativeBounds.height {
    case 960:
    print("iPhone4, iphone 4s")
    
    
    return
    //.iPhone4
    case 1136:
    print("iPhones_5_5s_5c_SE")
    
    
    txt1.font = txt1.font.withSize(23)
    txt2.font = txt2.font.withSize(13)
    txt3.font = txt3.font.withSize(9)
    buttContinu.titleLabel?.font = buttContinu.titleLabel?.font.withSize(15)
    buttcdNRecu.titleLabel?.font = buttcdNRecu.titleLabel?.font.withSize(13)
    
    
    return
    //.iPhones_5_5s_5c_SE
    case 1334:
    print("iPhones_6_6s_7_8")
    
    
    return
    //.iPhones_6_6s_7_8
    case 1920, 2208:
    print("iPhones_6Plus_6sPlus_7Plus_8Plus")
  
   
    txt1.font = txt1.font.withSize(27)
    txt2.font = txt2.font.withSize(17)
    txt3.font = txt3.font.withSize(12)
    buttContinu.titleLabel?.font = buttContinu.titleLabel?.font.withSize(19)
    buttcdNRecu.titleLabel?.font = buttcdNRecu.titleLabel?.font.withSize(17)
    
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
extension CodeViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
}
