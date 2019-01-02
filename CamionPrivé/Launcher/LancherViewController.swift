//
//  LancherViewController.swift
//  CamionPrivé
//
//  Created by Forest Cab
//  Copyright © 2018 Administrateur. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import CoreTelephony
import CRToast
import SCLAlertView
import SVProgressHUD

//choix camion
var IDCAMION = "-2"
var ListeIdCamion:[String] = []
var ListeMatriculeCamion:[String] = []
var ListeModeleCamion:[String] = []
var ListeMarqueCamion:[String] = []
var ListeVolumeCamion:[String] = []

var HaveCamion = 1
//image profil
var img = UIImage(named: "ic_photoc")


var IMMAT = String()
var MODEL = String()
var MARQUE = String()
var PHOTOFACE = String()
var PHOTOCOTE = String()
var PHOTOCARTEGRISSE = String()
var PHOTOASSURRANCE = String()
var EXpir_assurance = String()
var VolumeTotale = 0

var LastStatusGlobal = String()


class LancherViewController: UIViewController, NVActivityIndicatorViewable {
    
    var window: UIWindow?
    var timertestConnexion: Timer? = nil
    var xview = CGFloat()
    var yview = CGFloat()
    var toast = 0
    var options:[NSObject:AnyObject] = [:]
    var activityInd = NVActivityIndicatorView(frame: CGRect())
    
    
    
    
    @IBOutlet weak var viewIND: UIView!
    @IBOutlet weak var ic_loadingG: UIImageView!
    
    
    //*************************************************************************
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        print("ViewWillApear")
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("didLoad")
        xview = view.center.x
        yview = view.center.y
     
       
            
        options = [
            kCRToastTextKey as NSObject : "Aucune connexion" as AnyObject,
            kCRToastBackgroundColorKey as NSObject : UIColor.init(red: 03/255, green: 150/255, blue: 255/255, alpha: 1),
            kCRToastTextColorKey as NSObject: UIColor.red,
            kCRToastTextMaxNumberOfLinesKey as NSObject: 2 as AnyObject,
            kCRToastTimeIntervalKey as NSObject: 50 as AnyObject,
            kCRToastUnderStatusBarKey as NSObject : NSNumber(value: false),
            kCRToastTextAlignmentKey as NSObject : NSTextAlignment.center.rawValue as AnyObject,
            //options[kCRToastImageKey] = UIImage(named: "ic_whatever") as AnyObject?

            kCRToastAnimationInTypeKey as NSObject : CRToastAnimationType.gravity.rawValue as AnyObject,
            kCRToastAnimationOutTypeKey as NSObject : CRToastAnimationType.gravity.rawValue as AnyObject,

            kCRToastAnimationInDirectionKey as NSObject : CRToastAnimationDirection.left.rawValue as AnyObject,
            kCRToastAnimationOutDirectionKey as NSObject : CRToastAnimationDirection.right.rawValue as AnyObject
        ]
           
        
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                                let TOKEN = keychain.get("MyTokenDriver")
                                //print("hello",TOKEN)
                                if (TOKEN?.isEmpty == false){

                                    print("Internet connection OK")
                                    let status = Reach().connectionStatus()
                                    switch status {
                                    case .unknown, .offline:
                                        print("Not connected")
                                        
                                        self.get()
                                        CRToastManager.showNotification(options: self.options, completionBlock: { () -> Void in
                                            print("done!")
                                        })
                                        
                                    case .online(.wwan):
                                        print("Connected via WWAN")
                                        
                                        self.toast = 1
                                        
                                        
                                        self.get()
                                    case .online(.wiFi):
                                        print("Connected via WiFi")
                                        
                                        self.toast = 1
                                       
                                       
                                       self.get()
                                    }
                                     
                                        
                                 
                                }else{
                                    let status = Reach().connectionStatus()
                                    switch status {
                                    case .unknown, .offline:
                                        print("Not connected")
                                        
                                        CRToastManager.showNotification(options: self.options, completionBlock: { () -> Void in
                                            print("done!")
                                        })
                                        self.repeatTestConnexion()
                                    case .online(.wwan):
                                        print("Connected via WWAN")
                                        
                                        
                                        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "idHome") as! ViewController
                                        
                                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                                    self.present(myVC, animated: false, completion: nil)
                                        }
                                        
                                        
                                    case .online(.wiFi):
                                        print("Connected via WiFi")
                                        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "idHome") as! ViewController
                                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                                    self.present(myVC, animated: false, completion: nil)
                                            
                                            

                                        }
                                       
                                    }
                                    
                                    
                                }
                                
                            }
            
           
        
    }
    func repeatTestConnexion(){
    timertestConnexion = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(LancherViewController.testConnexion), userInfo: nil, repeats: true)
    }
    func testConnexion(){
    //if Reachability.isConnectedToNetwork() == true {
        
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            print("Not connected")
            
           /* CRToastManager.showNotification(options: options, completionBlock: { () -> Void in
                print("done!")
            })*/
        case .online(.wwan):
            print("Connected via WWAN")
            timertestConnexion?.invalidate()
            CRToastManager.dismissAllNotifications(true)
            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "idHome") as! ViewController
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.present(myVC, animated: false, completion: nil)
            }
            
        case .online(.wiFi):
            print("Connected via WiFi")
            timertestConnexion?.invalidate()
            CRToastManager.dismissAllNotifications(true)
            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "idHome") as! ViewController
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.present(myVC, animated: false, completion: nil)
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

        NotificationCenter.default.addObserver(self, selector: #selector(LancherViewController.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()
   

        
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.byValue = 2 * CGFloat.pi
        rotation.duration = 1
        rotation.repeatCount = Float.greatestFiniteMagnitude // forever
        
        ic_loadingG.layer.add(rotation, forKey: "myAnimation")
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground(_:)), name: .UIApplicationWillEnterForeground, object: nil)

        
    }
    func networkStatusChanged(_ notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo
        print(userInfo!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func willEnterForeground(_ notification: NSNotification!) {
        print("hi")
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.byValue = 2 * CGFloat.pi
        rotation.duration = 1
        rotation.repeatCount = Float.greatestFiniteMagnitude // forever
        
        ic_loadingG.layer.add(rotation, forKey: "myAnimation")
    }
    
    deinit {
        // make sure to remove the observer when this view controller is dismissed/deallocated
        
        NotificationCenter.default.removeObserver(self)
    }
    
   
    
    func get()
    {
        print("******** oloooooooooooooo Detaillls ***********")
        
        
        let tok = "\(token)"
        print("aaa", tok)
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
                
                print("rrrr", error?.localizedDescription as Any)
                print("error in get detail ")
                
                if(self.toast == 1){
                    self.toast = 0
               
                }
                
                DispatchQueue.main.async {
                    self.ic_loadingG.isHidden = true
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
                    self.get()
                    self.ic_loadingG.isHidden = false
                }
                    
                alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                }
                    return
            }
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                print(json)
                
                if let message = json["message"] {
                    print("4 get detail")
                    
                    print("*****", message)
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
              self.get()
                    }
                    
                }
                else{
                    
                    //print("fichier json", json)
                    
                    if let laststatus = json["status"]{
                        
                        let resultlaststatus = self.checkNull(obj: laststatus as AnyObject)
                        if(resultlaststatus == true){
                            print("laststatus is nil")
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
                        
                        ///**************  default *************************************************************************************************************************
                        
                        
                        let namee = keychain.get("LastnameDriver")
                        
                        if(namee?.isEmpty == false){
                            keychain.set(namee!, forKey: "LastnameDriver")
                            print("set name")
                        }
                        ///**************  default *************************************************************************************************************************
                        
                    }
                    
                    let FirstName = dict["name"]
                    
                    let resultFirstName = self.checkNull(obj: FirstName as AnyObject)
                    if(resultFirstName == true){
                        print("FirstName is nil")
                    }
                    else{
                        print("FirstName:", FirstName!)
                        firstname = FirstName as! String
                        ///**************  default *************************************************************************************************************************
                        let fname = keychain.get("NameDriver")
                        
                        if(fname?.isEmpty == false){
                            keychain.set(fname!, forKey: "NameDriver")
                            print("set firstname")
                        }
                        ///**************  default *************************************************************************************************************************
                        
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
                    let photoprofile = dict["avatar"]
                    
                    let resultphotoprofile = self.checkNull(obj: photoprofile as AnyObject)
                    if(resultphotoprofile == true){
                        print("photoprofile is nil")
                    }
                    else{
                        print("photoprofile:", photoprofile!)
                        PhotoDRV = photoprofile as! String
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
                    
                    let imagepermis = driverr["imgpermis"]
                    
                    let resultimagepermis = self.checkNull(obj: imagepermis as AnyObject)
                    if(resultimagepermis == true){
                        print("imagepermis is nil")
                    }
                    else{
                        print("imagepermis:", imagepermis!)
                        ImagePermis = imagepermis as! String
                    }
                    let dpae = driverr["dpae"]
                    
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
                    let user_id = driverr["user_id"]
                    
                    let resultuser_id = self.checkNull(obj: user_id as AnyObject)
                    if(resultuser_id == true){
                        print("user_id is nil")
                    }
                    else{
                        print("user_id:", user_id!)
                        
                        let useridd = user_id as! Int
                        User_ID = String(useridd)
                    }
                    
                    //-*-*-*-*-*--*-*-*--*--*
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
                    
                    
                    
                        DispatchQueue.global(qos: .userInitiated).async {
                            DispatchQueue.main.async {
                                
                                
                                
                                if(StatutGlobal == true){
                                    self.getDocCamion()
                                    
                                }else {

                                  let myVC = self.storyboard?.instantiateViewController(withIdentifier: "idMaps") as! MapsViewController
                               self.present(myVC, animated: false, completion: nil)
                                    
                                }
                            }}
                    
                    
                    CRToastManager.dismissNotification(true)
                    
                }
            }
            catch let error as NSError
            {
                print(error.localizedDescription)
            
            }
        }
        task.resume()
        
    }
    
    //**********************************************************************************************
    func sendrevoked()
    {
        print("******** revoked ***********")
        
        
        let tok = "\(token)"
        print("aaa", tok)
        //let profil = 3
        let url = NSURL(string: "\(weburl)/api/driver/logout")
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
                DispatchQueue.main.async {
                    //self.activityInd.stopAnimating()
                    self.ic_loadingG.isHidden = true
                }
                DispatchQueue.global(qos: .userInitiated).async {
                    // Do long running task here
                    // Bounce back to the main thread to update the UI
                    DispatchQueue.main.async {
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
                            //self.activityInd.startAnimating()
                            self.ic_loadingG.isHidden = false
                            self.sendrevoked()
                        }
                        
                        alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                    
                        
                    }}
                
                return
            }
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                print(json)
                
                if let logout = json["logout"]{
                    print(logout)
                    DispatchQueue.global(qos: .userInitiated).async {
                        // Do long running task here
                        // Bounce back to the main thread to update the UI
                        DispatchQueue.main.async {
                           // SVProgressHUD.show()
                            
                            
                            AppDelegate().renitialize()
                            UPDATE = 0
                            keychain.clear()
                            let defaults = UserDefaults.standard
                            let dictionary = defaults.dictionaryRepresentation()
                            dictionary.keys.forEach { key in
                                defaults.removeObject(forKey: key)
                            }

                            UserDefaults.standard.set(true, forKey: "lauchedBefore")
                            ///**************  default **************************************************************************************************************

                           // self.activityInd.stopAnimating()
                            self.ic_loadingG.isHidden = true
                            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "idHome") as! ViewController
                            self.present(myVC, animated: false, completion: nil)
                            
                            
                            
                            
                            
                        }}
                }else {
                    DispatchQueue.main.async {
                        //self.activityInd.stopAnimating()
                        self.ic_loadingG.isHidden = true
                    }
                    DispatchQueue.global(qos: .userInitiated).async {
                        // Do long running task here
                        // Bounce back to the main thread to update the UI
                        DispatchQueue.main.async {
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
                                //self.activityInd.startAnimating()
                                self.ic_loadingG.isHidden = false
                                self.sendrevoked()
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }}
                }
                
            }
            catch let error as NSError
            {
                
                print(error.localizedDescription)
                
            }
        }
        task.resume()
        
    }
    //**********************************************************************************************
    
    
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
                    self.ic_loadingG.isHidden = true
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
                        self.getDocCamion()
                        self.ic_loadingG.isHidden = false
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
                                
                                CRToastManager.dismissAllNotifications(true)
                                
                                self.ic_loadingG.isHidden = true
                               
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
                                        self.ic_loadingG.isHidden = false
                                        self.getDocCamion()
                                    }
                                    alertView.addButton("DECONNEXION"){
                                        self.ic_loadingG.isHidden = false
                                         self.sendrevoked()
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
                            self.ic_loadingG.isHidden = true
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
                                self.ic_loadingG.isHidden = false
                                self.getDocCamion()
                            }
                            alertView.addButton("DECONNEXION"){
                                self.ic_loadingG.isHidden = false
                                self.sendrevoked()
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
                                CRToastManager.dismissAllNotifications(true)
                                print("aallez")
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                                    
                                    let InVoyage = keychain.get("InVoyage")
                                    
                                    if(InVoyage?.isEmpty == false){
                                       
                                        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "idMaps2") as! Maps2ViewController
                                        self.present(myVC, animated: false, completion: nil)
                                        
                                    }else{
                                        print("<<////</</</</</<//</<</")
                                        
                                        
                                            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "idMaps") as! MapsViewController
                                            self.present(myVC, animated: false, completion: nil)
                                        
                                    }
                                    
                                    
                                    
                                }
                                
                                
                               
                            }}
                      
                        
                    }
                }else{
                    DispatchQueue.main.async {
                        self.ic_loadingG.isHidden = true
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
                            self.getDocCamion()
                            self.ic_loadingG.isHidden = false
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
    
    
    
    func checkNull(obj : AnyObject?) -> Bool {
        if obj is NSNull {
            return true
        } else {
            return false
        }
    }
   

}
