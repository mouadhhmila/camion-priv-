//
//  ConnexionViewController.swift
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
import UIKit
import Alamofire
import MessageUI
import Foundation
import NVActivityIndicatorView
import SkyFloatingLabelTextField
import SCLAlertView



//**********************************************************************************************
//**********************************************************************************************


var names = "Pablo"
var firstname = String()
var Email = String()
var Tel = String()
var Addressss = String()
var PARTENAINE = String()


var CodePays = String()
var PhotoDRV = String()
var Villee = String()
var CodePostalee = String()
var Payss = String()

var NumIdentit = String()
var ImagIdentit = String()
var DatePermis = String()
var ImagePermis = String()
var DPAE = String()
var User_ID = String()
var ID = String()

var PHOTOPROFIL = String()

var token = String()

//**********************************************************************************************
//**********************************************************************************************



class ConnexionViewController: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate, NVActivityIndicatorViewable {
    
    
    var xview = CGFloat()
    var yview = CGFloat()
    
    var keyboardToolbar = UIToolbar()
    

    
    
    
    @IBOutlet weak var buttonConnex: UIButton!
    
    
    @IBOutlet weak var textemail: SkyFloatingLabelTextField!
    @IBOutlet weak var textmdp: SkyFloatingLabelTextField!
    
    @IBOutlet weak var buttObl: UIButton!
    @IBOutlet weak var Connextxtbar: UILabel!
    
    
    @IBOutlet weak var bottomHeight: NSLayoutConstraint!
    
    //*************************************************************************************************
   
   
    @IBAction func buttonConnexion(_ sender: Any) {
        
     
        view.endEditing(true)
        
        let activityInd = NVActivityIndicatorView(frame: CGRect(x: xview - 25, y: yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
        view.addSubview(activityInd)
        
       
        
        if validateEmail(enteredEmail: textemail.text!) && validationMotdePasse(entredPassword: textmdp.text!) {
           
            
            
                print("Internet connection OK ")
                
            
            let status = Reach().connectionStatus()
            switch status {
            case .unknown, .offline:
                print("Not connected")
                
              
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
               
            case .online(.wwan):
                print("Connected via WWAN")
                NVActivityIndicatorView.DEFAULT_BLOCKER_MESSAGE_FONT = UIFont(name: Fontraleway, size: 18)!
                startAnimating(message: "Chargement...", type: NVActivityIndicatorType.ballRotateChase)
                
                
                send()
            case .online(.wiFi):
                print("Connected via WiFi")
                NVActivityIndicatorView.DEFAULT_BLOCKER_MESSAGE_FONT = UIFont(name: Fontraleway, size: 18)!
                startAnimating(message: "Chargement...", type: NVActivityIndicatorType.ballRotateChase)
                
               
                send()
            }
            
            
            
        }
        
        if !validateEmail(enteredEmail: textemail.text!) && validationMotdePasse(entredPassword: textmdp.text!) {
            
            if textemail.text == "" {
            DispatchQueue.global(qos: .userInitiated).async {
                
                DispatchQueue.main.async {
            self.textemail.textColor = UIColor.red
                }}
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
                    self.textemail.textColor = UIColor.white
                }
                alertView.dismiss(animated: true, completion: nil)
            }
            
            alertView.showError("ERREUR", subTitle: "Entrez une adresse e-mail.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "cancel64"))
            }else{
                DispatchQueue.global(qos: .userInitiated).async {
                    
                    DispatchQueue.main.async {
                        self.textemail.textColor = UIColor.red
                    }}
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
                        self.textemail.textColor = UIColor.white
                    }
                    alertView.dismiss(animated: true, completion: nil)
                }
                
                alertView.showError("ERREUR", subTitle: "Entrez une adresse e-mail valide.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "cancel64"))
            }
        }
        
        if validateEmail(enteredEmail: textemail.text!) && !validationMotdePasse(entredPassword: textmdp.text!){
            if textmdp.text == ""{
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
            
            alertView.showError("ERREUR", subTitle: "Entrer le mot de passe.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "cancel64"))
            }else{
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
                
                alertView.showError("ERREUR", subTitle: "Mot de passe incorrect, essayez à nouveau.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "cancel64"))
            }
        }
        if !validationMotdePasse(entredPassword: textmdp.text!) && !validateEmail(enteredEmail: textemail.text!) {
            if textemail.text == "" && textmdp.text == ""{
                DispatchQueue.main.async {
                    self.textemail.textColor = UIColor.red
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
                        self.textemail.textColor = UIColor.white
                    }
                    alertView.dismiss(animated: true, completion: nil)
                }
                alertView.showError("ERREUR", subTitle: "Entrez l'adresse e-mail et le mot de passe du votre compte.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "cancel64"))
            }else{
            DispatchQueue.main.async {
                self.textemail.textColor = UIColor.red
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
                    self.textemail.textColor = UIColor.white
                }
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.showError("ERREUR", subTitle: "Entrez une adresse e-mail valide.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "cancel64"))
            
            }
        }
        
        
    }
    //********************************************************************************************************
    
    
    //********************************************************************************************************
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        print(result)
    }
    //********************************************************************************************************
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    
    //********************************************************************************************************
    
    func send(){
        let email : String = self.textemail.text!
        let password : String = self.textmdp.text!
        
        let postString = ["email":email, "password": password]
        var request = URLRequest(url:URL(string:"\(weburl)/api/driverlogin")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application-idValue", forHTTPHeaderField: "secret-key")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        let session = URLSession.shared
        //Post
        session.dataTask(with: request){data, response, err in
            //Guard: ws there error ?
            
            
            if err != nil
            {
               // print(error?.localizedDescription as Any)
                
              //  DispatchQueue.global(qos: .userInitiated).async {
                    // Do long running task here
                    // Bounce back to the main thread to update the UI
                    DispatchQueue.main.async {
                self.stopAnimating()
                print("aaaaaaaaaa")
                        print(err as Any)
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
                
            }
            //Guard: check was any data returned?
            guard let data = data else{
                print("no data return")
                return
            }
            //Convert Json to Object
            let parseResult: [String:AnyObject]!
            
            do{
                print("hhhhhh")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    NVActivityIndicatorPresenter.sharedInstance.setMessage("Authentification...")
                }
                parseResult = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String:AnyObject]
                if let error = parseResult["error"]{
                    print("result error: \(error)")
                    DispatchQueue.main.async {
                        self.stopAnimating()
                        print("aaaaaaaaaa")
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
                        
                        alertView.showError("ERREUR", subTitle: "\(error).", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "cancel64"))
                    }
                    
                }else if let message = parseResult["message"]{
                    print(message)
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
                    
                    alertView.showError("ERREUR", subTitle: "Échec d'authentification.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "cancel64"))
                }else{
                    
                    print("***** parseResult Loigin  ****   \(parseResult)")
                    
                    let tokenDict: NSDictionary = parseResult["success"] as! NSDictionary
                    
                    
                    let accessToken: String = tokenDict["token"] as! String
                    
                    token = accessToken
                    
                    
                    
                    self.get()
                }
            } catch {
                print("Could not parse data as Json )")
                self.stopAnimating()
                
                return
            }
            //Check jsonDictionary
            guard let jsonArray = parseResult["success"] as? [String:AnyObject] else{
                
                print("jsonDictionary error")
                return
                    
                
                
            }
            //check jsonArray and switch to LoginViewController
            if(jsonArray.count == 0 ){
                print("jsonArray not found")
                return
            }
            else {
                
                print("hhhhhh")
                
              
            }
            }.resume()
    }
    //********************************************************************************************************
    
    func checkNull(obj : AnyObject?) -> Bool {
        if obj is NSNull {
            return true
        } else {
            return false
        }
    }
    
    //////
    func get()
    {
        print("******** oloooooooooooooo Detaillls ***********")
        
        
        let tok = "\(token)"
        //let profil = 3
        let url = NSURL(string: "\(weburl)/api/driver/details")
        //let postString = ["profile":profil]
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        // request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            if error != nil
            {
                print(error?.localizedDescription as Any)
                return
            }
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    NVActivityIndicatorPresenter.sharedInstance.setMessage("Authentification...")
                }
                
                
                print("fichier json", json)
                
                
                if let laststatus = json["status"]{
                    
                    let resultlaststatus = self.checkNull(obj: laststatus as AnyObject)
                    if(resultlaststatus == true){
                        print("laststatus is nil")
                        LastStatusGlobal = "<null>"
                    }
                    else{
                        print("laststatus:", laststatus)
                        
                        let LASTSTATUS = String(describing: laststatus)
                        LastStatusGlobal = LASTSTATUS
                        if(LASTSTATUS) == "2"{
                            StatutGlobal = false
                        }else{
                            //status 3 et 1
                            StatutGlobal = true
                        }
                    }
                    
                }
                
                
                let dict:NSDictionary = json["success"] as! NSDictionary
                
                let lastname = dict["lastname"]
                
                let resultlastname = self.checkNull(obj: lastname as AnyObject)
                if(resultlastname == true){
                    print("lastname is nil")
                }
                else{
                    
                    print("lastname:", lastname!)
                    names = lastname as! String
                    keychain.set(names, forKey: "LastnameDriver")
                    
                }
                
                let FirstName = dict["name"]
                
                let resultFirstName = self.checkNull(obj: FirstName as AnyObject)
                if(resultFirstName == true){
                    print("FirstName is nil")
                }
                else{
                    print("FirstName:", FirstName!)
                    firstname = FirstName as! String
                    keychain.set(firstname, forKey: "NameDriver")
                }
                let email = dict["email"]
                
                let resultemail = self.checkNull(obj: email as AnyObject)
                if(resultemail == true){
                    print("email is nil")
                }
                else{
                    print("email:", email!)
                    Email = email as! String
                }
                let numtel = dict["numtel"]
                
                let resultnumtel = self.checkNull(obj: numtel as AnyObject)
                if(resultnumtel == true){
                    print("numtel is nil")
                }
                else{
                    print("numtel:", numtel!)
                    Tel = numtel as! String
                }
                let codepays = dict["codepays"]
                
                let resultcodepays = self.checkNull(obj: codepays as AnyObject)
                if(resultcodepays == true){
                    print("codepays is nil")
                }
                else{
                    print("codepays:", codepays!)
                    CodePays = codepays as! String
                }
                
                let datecreation = dict["created_at"]
                
                let resultdatecreation = self.checkNull(obj: datecreation as AnyObject)
                if(resultdatecreation == true){
                    print("datecreation is nil")
                }
                else{
                    print("datecreation:", datecreation!)
                    
                    let dateDEB = datecreation as! String
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let formatter2 = DateFormatter()
                    formatter2.dateFormat = "yyyy-MM-dd"
                    let resurlDEBUTdat = formatter.date(from: dateDEB)
                    DEBUT_TRV = "\(formatter2.string(from: resurlDEBUTdat!))"
                    print(DEBUT_TRV)
                }
                
                
                let photoprofile = dict["photoprofile"]
                
                let resultphotoprofile = self.checkNull(obj: photoprofile as AnyObject)
                if(resultphotoprofile == true){
                    print("photoprofile is nil")
                }
                else{
                    print("photoprofile:", photoprofile!)
                    PhotoDRV = photoprofile as! String
                }
                let adressID = dict["adresse"]
                
                let resultadressID = self.checkNull(obj: adressID as AnyObject)
                if(resultadressID == true){
                    print("adr is nil")
                }
                else{
                    print("adressID:", adressID!)
                    Addressss = adressID as! String
                }
                let ville = dict["ville"]
                
                let resultville = self.checkNull(obj: ville as AnyObject)
                if(resultville == true){
                    print("ville is nil")
                }
                else{
                    print("ville:", ville!)
                    Villee = ville as! String
                }
                let CP = dict["cp"]
                
                let resultCP = self.checkNull(obj: CP as AnyObject)
                if(resultCP == true){
                    print("CP is nil")
                }
                else{
                    print("cP:", CP!)
                    let CodeP = CP as! String
                    CodePostalee = CodeP
                }
                let NOMP = dict["pays"]
                
                let resultNP = self.checkNull(obj: NOMP as AnyObject)
                if(resultNP == true){
                    print("NP is nil")
                }
                else{
                    print("NP:", NOMP!)
                    Payss = NOMP as! String
                }
                
                
                
                let numIdentité = dict["identite"]
                
                let resultnumIdentité = self.checkNull(obj: numIdentité as AnyObject)
                if(resultnumIdentité == true){
                    print("numIdentité is nil")
                }
                else{
                    print("numIdentité:", numIdentité!)
                    NumIdentit = numIdentité as! String
                }
                let imageIdentité = dict["image_identite"]
                
                let resultimageIdentité = self.checkNull(obj: imageIdentité as AnyObject)
                if(resultimageIdentité == true){
                    print("imageIdentité is nil")
                }
                else{
                    print("imageIdentité:", imageIdentité!)
                    ImagIdentit = imageIdentité as! String
                }
                let driverr = dict["driver"] as! NSDictionary

                let datepermis = driverr["date_permis"]
                
                let resultdatepermis = self.checkNull(obj: datepermis as AnyObject)
                if(resultdatepermis == true){
                    print("datepermis is nil")
                }
                else{
                    print("datepermis:", datepermis!)
                    DatePermis = datepermis as! String
                }
                let imagepermis = dict["permisdrv"]
                
                let resultimagepermis = self.checkNull(obj: imagepermis as AnyObject)
                if(resultimagepermis == true){
                    print("imagepermis is nil")
                }
                else{
                    print("imagepermis:", imagepermis!)
                    ImagePermis = imagepermis as! String
                }
                let dpae = dict["dpae"]
                
                let resultdpae = self.checkNull(obj: dpae as AnyObject)
                if(resultdpae == true){
                    print("dpae is nil")
                }
                else{
                    print("dpae:", dpae!)
                    DPAE = dpae as! String
                }
                let id = dict["id"]
                
                let resultid = self.checkNull(obj: id as AnyObject)
                if(resultid == true){
                    print("id is nil")
                }
                else{
                    print("id:", id!)
                    let idd = id as! Int
                    ID = String(idd)
                }
                let user_id = dict["user_id"]
                
                let resultuser_id = self.checkNull(obj: user_id as AnyObject)
                if(resultuser_id == true){
                    print("user_id is nil")
                }
                else{
                    print("user_id:", user_id!)
                    
                    let useridd = user_id as! Int
                    User_ID = String(useridd)
                }
                
                
                
                
                //-**-**-*-*-*--*--*--*
                let partenn = driverr["partner"] as! NSDictionary
                let parten = partenn["raissoc"]
                
                
                let resultparten = self.checkNull(obj: parten as AnyObject)
                if(resultparten == true){
                    print("partenaire is nil")
                }
                else{
                    print("partenaire:", parten!)
                    
                    let partenair = parten as! String
                    PARTENAINE = partenair
                }
                //-*-*-*--**-*--*-*-
                
                
                
                
                    DispatchQueue.global(qos: .userInitiated).async {
                        
                        DispatchQueue.main.async {
                            if let notification = json["notification"] as? NSDictionary {
                                
                                let total = notification["DriverRequestId"]
                                let resulttotal = self.checkNull(obj: total as AnyObject)
                                
                                if(resulttotal == true){
                                   print("course vide")
                                }
                                else{
                                    
                                    
                                    if(IDDriverRequest == -1){
                                        
                                        
                                        let idRequest = notification["DriverRequestId"] as! NSNumber
                                        IDDriverRequest = Int(idRequest)
                                        print("vous avez une course")
                                        let LngDepart = notification["depy"] as! NSNumber
                                        lngDepart = Double(LngDepart)
                                        let LatDepart = notification["depx"] as! NSNumber
                                        latDepart = Double(LatDepart)
                                        let LngArrive = notification["arrivy"] as! NSNumber
                                        lngArrive = Double(LngArrive)
                                        let LatArrive = notification["arrivx"] as! NSNumber
                                        latArrive = Double(LatArrive)
                                        
                                        
                                        if let numeroclient = notification["numtel"] as? String{
                                            NUMTEL = numeroclient
                                        }
                                        
                                        if let nomC = notification["name"] as? String{
                                            nonClient = nomC
                                        }
                                        
                                        if let prenC = notification["lastname"] as? String{
                                            prenomClient = prenC
                                        }
                                        if let adrDP = notification["adrdep"] as? String{
                                            adressdep = adrDP
                                        }
                                        if let adrDS = notification["adrarriv"] as? String{
                                            adressdes = adrDS
                                        }
                                        
                                        if let imgclient = notification["avatar"]{
                                            
                                            
                                            IMGCLIENT = String(describing: imgclient)
                                            
                                        }else{
                                            print("avatar n'existe pas")
                                        }
                                        
                                        if let tarif = notification["tarif"]{
                                            
                                            TARIF = String(describing: tarif)
                                            
                                        }else{
                                            print("tarif n'existe pas")
                                        }
                                        if let volummm = notification["volume"]{
                                            
                                            
                                            volume = String(describing: volummm)
                                            
                                        }else{
                                            print("volume n'existe pas")
                                        }
                                        
                                        
                                        NUMFACTURE = " "
                                        
                                        if let bondeCommande = notification["boncommande"]{
                                            
                                            
                                            NUMFACTURE = String(describing: bondeCommande)
                                            
                                        }else{
                                            print("bon de commande n'existe pas")
                                        }
                                        
                                        
                                        
                                        S_A_Aide = 0
                                        EtageDep = 0
                                        Etagedest = 0
                                        Ascenseurdep = 0
                                        Ascenseurdest = 0
                                        MSG = " "
                                        //bon de commande
                                        if let s_a_aide = notification["aide"]{
                                            
                                            S_A_Aide = s_a_aide as! Int
                                            if(S_A_Aide == 0){
                                                print("sans aide")
                                            }else {
                                                if let etagedep = notification["etage1"]{
                                                    
                                                    EtageDep = etagedep as! Int
                                                    
                                                }else{
                                                    print("etagedep n'existe pas")
                                                }
                                                
                                                if let etagedest = notification["etage2"]{
                                                    
                                                    Etagedest = etagedest as! Int
                                                    
                                                }else{
                                                    print("etagedest n'existe pas")
                                                }
                                                
                                                if let ascensdep = notification["ascenseur1"]{
                                                    
                                                    Ascenseurdep = ascensdep as! Int
                                                    
                                                }else{
                                                    print("ascensdep n'existe pas")
                                                }
                                                
                                                if let ascensdest = notification["ascenseur2"]{
                                                    
                                                    Ascenseurdest = ascensdest as! Int
                                                    
                                                }else{
                                                    print("ascensdest n'existe pas")
                                                }
                                                
                                                
                                            }
                                            
                                            
                                            
                                            
                                            
                                            
                                        }else{
                                            print("s_a_aide n'existe pas")
                                        }
                                        
                                        if let msgcommantaire = notification["message"]{
                                            
                                            MSG = String(describing: msgcommantaire)
                                            
                                        }else{
                                            print("msgcommantaire n'existe pas")
                                        }
                                        
                                        
                                        
                                        
                                        
                                        
                                        //- Début parsing liste des objets
                                        DataBagage.removeAll()
                                        DataNbrBagage.removeAll()
                                        
                                        if let listeobj = notification["list_object"] as? [[String: Any]]{
                                            
                                            for i in 0 ..< listeobj.count {
                                                
                                                let nomobj = listeobj[i]["nombagage"]
                                                let resultnomobj = self.checkNull(obj: nomobj as AnyObject)
                                                if(resultnomobj == true){
                                                    print("nomobj is nil")
                                                }
                                                else{
                                                    print("nomobj:", nomobj!)
                                                    
                                                    let Nomobj = nomobj as! String
                                                    DataBagage.append(Nomobj)
                                                }
                                                ///
                                                let qte_obj = listeobj[i]["quantite"]
                                                let resultqte_obj = self.checkNull(obj: qte_obj as AnyObject)
                                                if(resultqte_obj == true){
                                                    print("qte_obj is nil")
                                                }
                                                else{
                                                    print("qte_obj:", qte_obj!)
                                                    
                                                    let Qte_obj = qte_obj as! String
                                                    DataNbrBagage.append(Qte_obj)
                                                }
                                                
                                                
                                                
                                            }
                                        }else {
                                            print("no ste bagage")
                                            
                                        }
                                        
                                        
                                        print("dep x:", latDepart)
                                        print("dep y:", lngDepart)
                                        print("arr x:", LatArrive)
                                        print("arr y:", lngArrive)
                                        
                                        self.getDocCamion()
                                        
                                    }else {
                                        print("2 eme notification")
                                        print(IDDriverRequest)
                                    }
                                    
                                    
                                }
                            }else{
                                keychain.set(token, forKey: "MyTokenDriver")
                                print("keychen cbon")
                                
                             self.stopAnimating()
                            
                                update = 0
                            
                              let myVC = self.storyboard?.instantiateViewController(withIdentifier: "idMaps") as! MapsViewController
                              self.present(myVC, animated: false, completion: nil)
                            }
                        }}
                
                
            }
            catch let error as NSError
            {
                print(error)
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
                
                alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))           }
        }
        task.resume()
        
    }
    
    
    
    
    func getDocCamion()
    {
        
        print("******** get document camion ***********")
        
        
        let tok = "\(token)"
        let url = NSURL(string: "\(weburl)/api/driver/getCamion")
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        // request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            if error != nil
            {
                print("1")
                print(error?.localizedDescription as Any)
                
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
                    alertView.addButton("RÉESSAYER"){
                        self.startAnimating(message: "Authentification...", type: NVActivityIndicatorType.ballRotateChase)
                        self.getDocCamion()
                    }
                    
                    alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                }
            }
            
            do
            {
                if let data = data{
                    
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    
                    
                    
                    print("1 get doc c /***/*/*/*/*/*/*/**/**/***/***/*/*/*/*/*/*/*/*")
                    print("fichier json", json)
                    if let Exeption = json["exeption"] {
                        print("2 get doc c")
                        print(Exeption)
                        HaveCamion = 0
                        DispatchQueue.global(qos: .userInitiated).async {
                            DispatchQueue.main.async {
                                
                                
                                self.stopAnimating()
                                
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
                                    alertView.addButton("RÉESSAYER"){
                                        self.startAnimating(message: "Authentification...", type: NVActivityIndicatorType.ballRotateChase)
                                        self.getDocCamion()
                                    }
                                    
                                    
                                    alertView.showError("ERREUR", subTitle: "Contacter votre partenaire, probléme d'affectation du camion.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "cancel64"))
                                    
                                    // lab11.text = "\(Exeption)"
                                    
                                    
                                }
                                
                            }}
                    }
                    else if let message = json["message"] {
                        print("3 get doc c")
                        print(message)
                        
                        let Attributmsg = message as! String
                        if(Attributmsg == "Unauthenticated."){
                            
                            keychain.clear()
                            let defaults = UserDefaults.standard
                            let dictionary = defaults.dictionaryRepresentation()
                            dictionary.keys.forEach { key in
                                defaults.removeObject(forKey: key)
                            }
                            
                            
                            DispatchQueue.main.async{
                                UserDefaults.standard.set(true, forKey: "lauchedBefore")
                            }
                            
                            
                            DispatchQueue.main.async{
                                
                                let myVC = self.storyboard?.instantiateViewController(withIdentifier: "idConnection") as! ConnexionViewController
                                
                                self.present(myVC, animated: false, completion: nil)
                            }
                            
                        }else {
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
                            alertView.addButton("RÉESSAYER"){
                                self.startAnimating(message: "Authentification...", type: NVActivityIndicatorType.ballRotateChase)
                                self.getDocCamion()
                            }
                            
                            
                            alertView.showError("ERREUR", subTitle: "Contacter votre partenaire, probléme serveur.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "cancel64"))
                            
                        }
                        
                        
                    }
                    else{
                        
                        
                        let succesful : NSArray = json["success"] as! NSArray
                        
                        
                        //print(succesful)
                        
                        let dict:NSDictionary = succesful[0] as! NSDictionary
                        
                        
                        
                        let MARQ = dict["marq"]
                        
                        let resultmarq = self.checkNull(obj: MARQ as AnyObject)
                        if(resultmarq == true){
                            print("marq is nil")
                        }
                        else{
                            
                            print("marq:", MARQ!)
                            MARQUE = MARQ as! String
                            
                            
                        }
                        
                        
                        
                        let Model = dict["model"]
                        
                        let resultModel = self.checkNull(obj: Model as AnyObject)
                        if(resultModel == true){
                            print("Model is nil")
                            
                            
                        }
                        else{
                            print("Model:", Model!)
                            MODEL = Model as! String
                            
                            
                        }
                        
                        
                        
                        let Immat = dict["immat"]
                        
                        let resultimmat = self.checkNull(obj: Immat as AnyObject)
                        if(resultimmat == true){
                            print("Immat is nil")
                            
                            
                        }
                        else{
                            print("Immat:", Immat!)
                            IMMAT = "  \((Immat as? String)!)   "
                            
                            
                            
                        }
                        
                        let Photoface = dict["photoface"]
                        
                        let resultphotoface = self.checkNull(obj: Photoface as AnyObject)
                        if(resultphotoface == true){
                            print("photoface is nil")
                            
                            
                        }
                        else{
                            print("Photoface:", Photoface!)
                            PHOTOFACE = (Photoface as? String)!
                            
                            
                            
                        }
                        
                        let Photocot = dict["photocot"]
                        
                        let resultPhotocot = self.checkNull(obj: Photocot as AnyObject)
                        if(resultPhotocot == true){
                            print("Photocot is nil")
                            
                            
                        }
                        else{
                            print("Photocot:", Photocot!)
                            PHOTOCOTE = (Photocot as? String)!
                            
                            
                            
                        }
                        
                        
                        let Photocartegrisse = dict["cartegrise"]
                        
                        let resultPhotocartegrisse = self.checkNull(obj: Photocartegrisse as AnyObject)
                        if(resultPhotocartegrisse == true){
                            print("Photocartegrisse is nil")
                            
                            
                        }
                        else{
                            print("Photocartegrisse:", Photocartegrisse!)
                            PHOTOCARTEGRISSE = (Photocartegrisse as? String)!
                            
                            
                            
                        }
                        
                        
                        let Photoassurance = dict["assurance"]
                        
                        let resultPhotoassurance = self.checkNull(obj: Photoassurance as AnyObject)
                        if(resultPhotoassurance == true){
                            print("assurance is nil")
                            
                            
                        }
                        else{
                            print("assurance:", Photoassurance!)
                            PHOTOASSURRANCE = (Photoassurance as? String)!
                            
                            
                            
                        }
                        
                        
                        let Expir_assurance = dict["expir_assurance"]
                        
                        let resultExpir_assurance = self.checkNull(obj: Expir_assurance as AnyObject)
                        if(resultExpir_assurance == true){
                            print("Expir_assurance is nil")
                            
                            
                        }
                        else{
                            print("Expir_assurance:", Expir_assurance!)
                            EXpir_assurance = (Expir_assurance as? String)!
                            
                            
                            
                        }
                        
                        let volumetotale = dict["volume"]
                        
                        let resultvolumetotale = self.checkNull(obj: volumetotale as AnyObject)
                        if(resultvolumetotale == true){
                            print("volumetotale is nil")
                            
                            
                        }
                        else{
                            print("volumetotale:", volumetotale!)
                            VolumeTotale = (volumetotale as? Int)!
                            
                            
                            
                        }
                        DispatchQueue.global(qos: .userInitiated).async {
                            // Do long running task here
                            // Bounce back to the main thread to update the UI
                            DispatchQueue.main.async {
                                print("aallez")
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                                    
                                    keychain.set(token, forKey: "MyTokenDriver")
                                    print("keychen cbon")
                                    
                                   self.stopAnimating()
                                        
                                        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "idMaps2") as! Maps2ViewController
                                        self.present(myVC, animated: false, completion: nil)
                                        
                                    
                                    
                                    
                                    
                                }
                                
                                
                                
                            }}
                        
                        
                    }
                }else{
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
                        alertView.addButton("RÉESSAYER"){
                            self.startAnimating(message: "Authentification...", type: NVActivityIndicatorType.ballRotateChase)
                            self.getDocCamion()
                        }
                        
                        alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                    }
                    
                }
                
            }
            catch let error as NSError
            {
                
                
                print(error.localizedDescription)
                
            }
            
        }
        task.resume()
        
    }
    
   
    
    
    @IBAction func buttonOublié(_ sender: Any) {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "idOublié") as! OublierViewController
        
        self.present(myVC, animated: false, completion: nil)

    }
    
    //*************************************************************************************************
 
        
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        xview = view.center.x
        yview = view.center.y
      
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        UIDevice()
        
        
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        NotificationCenter.default.addObserver(self, selector: #selector(ConnexionViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ConnexionViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ConnexionViewController.keyboardWillChangeFrame(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ConnexionViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        


    }
    
  
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(_ notification:Notification) {
        adjustingHeight(true, notification: notification)
    }
    
    func keyboardWillHide(_ notification:Notification) {
        adjustingHeight(false, notification: notification)
    }
    
    func keyboardWillChangeFrame(_ notification: Notification) {
        adjustingHeight(false, notification: notification)
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////
    func adjustingHeight(_ show:Bool, notification:Notification) {
        
        var userInfo = (notification as NSNotification).userInfo!
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let changeInHeight = (keyboardFrame.height ) * (show ? 1 : 0)
        self.bottomHeight.constant = changeInHeight
        
        
        UIView.animate(withDuration: animationDurarion, animations: { () -> Void in
            self.view.layoutIfNeeded()
            
            
            
        })
    }
    
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
           
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                
                
                self.bottomHeight.constant = 0.0
                
                
                print("je suis passe par ici ")
            } else {
                
                self.bottomHeight?.constant = endFrame?.size.height ?? 0.0
                
                
                print("je suis passe par ici ,,,, ")
            }
                    }}
    
    
    func dismissKeyboard() {
       
        view.endEditing(true)
        print("dismis key")
        
        
    }
    
    //***********************************************************************************************
   
    
    
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    
    //********************************************************************************************************
    func validationMotdePasse(entredPassword:String) -> Bool{
        let passwordFormat = "[A-Z0-9a-z._%+-@]{6,25}"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: entredPassword)
        
        
    }
    //********************************************************************************************************
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //****************************************************************************************************
    func UIDevice() {
        
        
        switch UIScreen.main.nativeBounds.height {
        case 960:
            print("iPhone4, iphone 4s")

            
            return
        //.iPhone4
        case 1136:
            print("iPhones_5_5s_5c_SE")
            
            textemail.font = textemail.font?.withSize(15)
            textmdp.font = textmdp.font?.withSize(15)
            
            buttObl.titleLabel?.font = buttObl.titleLabel?.font.withSize(11)
            
            Connextxtbar.font = Connextxtbar.font?.withSize(23)
            
            buttonConnex.titleLabel?.font = buttonConnex.titleLabel?.font.withSize(15)
            
            let attributes = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName : UIFont(name: "Roboto-Light", size: 15)! // Note the !
            ]
            
            textemail.attributedPlaceholder = NSAttributedString(string: "Votre adresse e-mail", attributes:attributes)
            
            let attributes1 = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName : UIFont(name: "Roboto-Light", size: 15)! // Note the !
            ]
            
            textmdp.attributedPlaceholder = NSAttributedString(string: "Votre mot de passe", attributes:attributes1)
          
            return
        //.iPhones_5_5s_5c_SE
        case 1334:
            print("iPhones_6_6s_7_8")
            let attributes = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName : UIFont(name: "Roboto-Light", size: 16)! // Note the !
            ]
            
            textemail.attributedPlaceholder = NSAttributedString(string: "Votre adresse e-mail", attributes:attributes)
            
            let attributes1 = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName : UIFont(name: "Roboto-Light", size: 16)! // Note the !
            ]
            
            textmdp.attributedPlaceholder = NSAttributedString(string: "Votre mot de passe", attributes:attributes1)
            return
        //.iPhones_6_6s_7_8
        case 1920, 2208:
            print("iPhones_6Plus_6sPlus_7Plus_8Plus")
            textemail.font = textemail.font?.withSize(18)
            textmdp.font = textmdp.font?.withSize(18)
            buttObl.titleLabel?.font = buttObl.titleLabel?.font.withSize(15)
            Connextxtbar.font = Connextxtbar.font?.withSize(27)
            
            buttonConnex.titleLabel?.font = buttonConnex.titleLabel?.font.withSize(19)
            
            
            let attributes = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName : UIFont(name: "Roboto-Light", size: 16)! // Note the !
            ]
            
            textemail.attributedPlaceholder = NSAttributedString(string: "Votre adresse e-mail", attributes:attributes)
            
            let attributes1 = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName : UIFont(name: "Roboto-Light", size: 16)! // Note the !
            ]
            
            textmdp.attributedPlaceholder = NSAttributedString(string: "Votre mot de passe", attributes:attributes1)
            
            
            return
        //.iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            print("iPhoneX")
            buttonConnex.titleLabel?.font = buttonConnex.titleLabel?.font.withSize(17)
            
            let attributes = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName : UIFont(name: "Roboto-Light", size: 16)! // Note the !
            ]
            
            textemail.attributedPlaceholder = NSAttributedString(string: "Votre adresse e-mail", attributes:attributes)
            
            let attributes1 = [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName : UIFont(name: "Roboto-Light", size: 16)! // Note the !
            ]
            
            textmdp.attributedPlaceholder = NSAttributedString(string: "Votre mot de passe", attributes:attributes1)
            
            return
        //.iPhoneX
        default:
            print("ipade")

            
            return
            //.unknown
        }
        
    }
    
    
    
}


