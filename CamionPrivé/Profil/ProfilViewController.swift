//
//  ProfilViewController.swift
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
import CoreLocation
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire
import UserNotifications
import JTMaterialTransition
import AMWaveTransition
import NVActivityIndicatorView
import SCLAlertView


//**********************************************************************************************
//**********************************************************************************************

var timerTest3 = Timer()


var timerTestAPP = Timer()
var timerTestAPP2 = Timer()



var timerTestinCC: Timer? = nil
var timerTestinPC: Timer? = nil
var timerTestinD: Timer? = nil
var timerTestinA: Timer? = nil
var timerTestinR: Timer? = nil

var timerTestinBp: Timer? = nil

var timerTestinBm: Timer? = nil
var timerTestinVp: Timer? = nil
var timerTestinVm: Timer? = nil
var timerTestinV: Timer? = nil
var timerTestinVR: Timer? = nil
var timerTestinBR: Timer? = nil

var heightviewbar = 0.0
var inC = 0
var inP = 0
var inD = 0
var inA = 0

var height = 0
//**********************************************************************************************
//**********************************************************************************************


class ProfilViewController: UIViewController, UNUserNotificationCenterDelegate, UINavigationControllerDelegate, NVActivityIndicatorViewable {
    
    var time = 0
    let localNotification: UILocalNotification = UILocalNotification() // 1
    private var notification: NSObjectProtocol?
    
   
    var transition1: JTMaterialTransition?


    var xview = CGFloat()
    var yview = CGFloat()
    
    let longitude = CLLocation()
    let lattitude = CLLocation()
    
    
    @IBOutlet weak var buttmodifP: UIButton!
    @IBOutlet weak var txtNomChauffeur: UILabel!
    @IBOutlet weak var imgProfil: UIImageView!
    @IBOutlet weak var txtNomCamion: UILabel!
    @IBOutlet weak var buttupimgprofil: UIButton!
    @IBOutlet weak var viewinsprof: UIView!
    @IBOutlet weak var labstatis: UILabel!
    @IBOutlet weak var labcours: UILabel!
    @IBOutlet weak var labnote: UILabel!
    @IBOutlet weak var labannee: UILabel!
    @IBOutlet weak var txtnbrcourse: UILabel!
    @IBOutlet weak var txtnote: UILabel!
    @IBOutlet weak var txtannee: UILabel!
    @IBOutlet weak var viewimgprofl: UIView!
    
    
    //**********************************************************************************************
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
     
        xview = view.center.x
        yview = view.center.y
        
        
        
            }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("**¥¥¥¥¥¥¥¥ffffffffffff")
        DispatchQueue.global(qos: .userInitiated).async {
            
            DispatchQueue.main.async {
                self.UIDevice()
                self.viewimgprofl.layer.cornerRadius = self.viewimgprofl.frame.height / 2
                
                self.viewinsprof.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
                
                let startDate = "\(DEBUT_TRV)"
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let formatedStartDate = dateFormatter.date(from: startDate)
                let currentDate = Date()
                let components = Set<Calendar.Component>([.day, .month, .year])
                let differenceOfDate = Calendar.current.dateComponents(components, from: formatedStartDate!, to: currentDate)
                
                print("difference_years", differenceOfDate)
                let years = differenceOfDate.year
                let mounth = differenceOfDate.month
                
                print(years as Any)
                print(mounth as Any)
                let x = Float(mounth!)/Float(12)
                
                
                let somm = Float(x) + Float(years!)
                
                let x1 = String(format: "%.1f", somm)
                self.txtannee.text = "\(x1)"
                
                
                self.txtnbrcourse.text = "\(LabNbrCourseYears)"
            
                self.txtnote.text =  "\(LabNoteYears)"
                if(PhotoDRV == ""){
                    self.imgProfil.image = UIImage(named: "ic_photoc")
                }else{
                self.getimage()
                }
                
            }}
    }
    //**********************************************************************************************
    func getimage(){
        
        print("hh", PhotoDRV)
        let URL_IMAGE = URL(string: "\(PhotoDRV)")
        
        let session = URLSession(configuration: .default)
       
        let getImageFromUrl = session.dataTask(with: URL_IMAGE!) { (data, response, error) in
            
            
            //if there is any error
            if let e = error {
                //displaying the message
                print("Error Occurred: \(e)")
                //self.cercle.stopAnimating()
                
            } else {
                //in case of now error, checking wheather the response is nil or not
                if (response as? HTTPURLResponse) != nil {
                    print(response as Any)
                    //checking if the response contains an image
                    
                    if  let imageData = data {
                        
                        print(imageData)
                        
                            let image = UIImage(data: imageData)
                        
                                DispatchQueue.main.async {
                                    
                                    img = image
                                    self.imgProfil.image = image
                                    print("-+-+-+-+---+--")
                                    
                                    
                                }
                        
                    } else {
                        print("Image file is currupted")
                    }
                } else {
                    print("No response from server")
                }
            }
        }
        
        //starting the download task
        getImageFromUrl.resume()
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DispatchQueue.global(qos: .userInitiated).async {
           
            DispatchQueue.main.async {
                self.UIDevice()
                self.stopAnimating()
                
                BackProfil = 0
                Compte_vc = self.storyboard?.instantiateViewController(withIdentifier: "idCompteChauffeur") as! CompteChauffeurViewController

                
            }}
        
    
        EnLigneMaps = 0
        EnLigneRevenu = 0
        
        //////////////////
        
        txtNomChauffeur.text! = names + " " + firstname
        txtNomCamion.text! = MARQUE + " " + MODEL + "-" + IMMAT
       
        
        ////////////////
        
     
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        } else {
            // Fallback on earlier versions
        }
        
        self.transition1 = JTMaterialTransition(animatedView: self.imgProfil!)
        
        
    }
    
    func addviewSurLO(){
    }
    
    
    func dismissCompte(){
        print("bbbbbbb")
        Compte_vc.view.removeFromSuperview()
    }
    
    //**********************************************************************************************
  
    //**********************************************************************************************
    
    
    
    @IBAction func buttimgmodifProfil(_ sender: Any) {
        
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
            let activityInd = NVActivityIndicatorView(frame: CGRect(x: xview - 25, y: yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
            
            NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
            NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
            view.addSubview(activityInd)
            
            
            self.startAnimating(message: "", type: NVActivityIndicatorType.ballRotateChase)
            getdetailinprofil()
        case .online(.wiFi):
            print("Connected via WiFi")
            let activityInd = NVActivityIndicatorView(frame: CGRect(x: xview - 25, y: yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
            
            NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
            NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
            view.addSubview(activityInd)
            
            
            self.startAnimating(message: "", type: NVActivityIndicatorType.ballRotateChase)
            getdetailinprofil()
        }
        
        
    }
    
    

    
    //**********************************************************************************************
    
    //**********************************************************************************************
    
    
    //**********************************************************************************************
    
    
    //**********************************************************************************************
    
    //**********************************************************************************************
    
    
    @IBAction func buttModifierProfil(_ sender: Any) {
        
        
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
            
            let activityInd = NVActivityIndicatorView(frame: CGRect(x: xview - 25, y: yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
            
            NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
            NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
            view.addSubview(activityInd)
            
            
            self.startAnimating(message: "", type: NVActivityIndicatorType.ballRotateChase)
            getdetailinprofil()
            
            
        case .online(.wiFi):
            print("Connected via WiFi")
            
            
            let activityInd = NVActivityIndicatorView(frame: CGRect(x: xview - 25, y: yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
            
            NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
            NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
            view.addSubview(activityInd)
            
            
            self.startAnimating(message: "", type: NVActivityIndicatorType.ballRotateChase)
            getdetailinprofil()
            
            
         
        }
        
    }
    //**********************************************************************************************
    

    
    //**********************************************************************************************
    
    

    //**********************************************************************************************
    
    

    //**********************************************************************************************

    //**********************************************************************************************
    

    
    //**********************************************************************************************
    
    
  
   
   
    func getdetailinprofil()
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
                
                print(error?.localizedDescription as Any)
                print("error in get detail ")
                
                
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
                return
            }
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                
                if let message = json["message"] {
                    let Attributmsg = message as! String
                    if(Attributmsg == "Unauthenticated."){
                        
                    
                    print("4 get detail")
                    self.view.makeToast("  /+/*-*+/*-*+ server error, go to connectionView  ", duration: 4.0, position: .bottom, style:nil)
                    print("*****", message)
                    keychain.clear()
                    let defaults = UserDefaults.standard
                    let dictionary = defaults.dictionaryRepresentation()
                    dictionary.keys.forEach { key in
                        defaults.removeObject(forKey: key)
                    }
                    
                    
                    DispatchQueue.main.async{
                        UserDefaults.standard.set(true, forKey: "lauchedBefore")
                        ///**************  default *************************************************************************************************************************
                        
                        deconnexion = 1
                        
                        if(timerTestAPP.isValid){
                            timerTestAPP.invalidate()
                        }
                        if(timerTestAPP2.isValid){
                            
                            timerTestAPP2.invalidate()
                        }
                        
                        if (timerTest3.isValid) {
                            timerTest3.invalidate()
                            
                        }
                        deconnectstatut = 1
                        StatutGlobal = false
                        //update = 1
                        VolumeTotale = 0
                        
                        
                    }
                    DispatchQueue.main.async{
                        lOGIN = 0
                        
                        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "idConnection") as! ConnexionViewController
                        self.stopAnimating()
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
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                        }
                    }
                }
                else if let jsonnn = json["success"]{
                    print("fichier json", jsonnn)
                    
                   
                    
                    let dict:NSDictionary = json["success"] as! NSDictionary
                    
                    
                    
                    
                    let lastname = dict["lastname"]
                    
                    let resultlastname = self.checkNull(obj: lastname as AnyObject)
                    if(resultlastname == true){
                        print("lastname is nil")
                    }
                    else{
                        print("lastname:", lastname!)
                        names = lastname as! String
                        
                        
                        
                    }
                    
                    let FirstName = dict["name"]
                    
                    let resultFirstName = self.checkNull(obj: FirstName as AnyObject)
                    if(resultFirstName == true){
                        print("FirstName is nil")
                    }
                    else{
                        print("FirstName:", FirstName!)
                        firstname = FirstName as! String
                        
                        
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
                    
                 
                    
                    
                    DispatchQueue.main.async{

                        self.stopAnimating()
                        BackProfil = 1
                        self.view.addSubview(Compte_vc.view)
                        
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
    
    
    
    
    
    
    //**********************************************************************************************
    
    
    func sendLocalNotif_Profil() {
        localNotification.alertAction = "Demande d'une course" // 2
        localNotification.alertBody = "Demande d'une course: vous avez une minute pour accépter le course" // 3
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 0) as Date // 4
        localNotification.category = "status" // 5
        localNotification.userInfo = [ "cause": "inactiveMembership"] // 6
        localNotification.soundName = "default"
        localNotification.shouldGroupAccessibilityChildren = true
        localNotification.applicationIconBadgeNumber = nbr
        UIApplication.shared.scheduleLocalNotification(localNotification)
        
    }
    
    
    //****************
    //**********************************************************************************************
    
    //**********************************************************************************************
 
    //**********************************************************************************************
    
    //**********************************************************************************************
    //**********************************************************************************************
    
    func UIDevice() {
        
        
        switch UIScreen.main.nativeBounds.height {
        case 960:
            
            
            print("iPhone4")
           
          
            
            return
        //.iPhone4
        case 1136:
            print("iPhones_5_5s_5c_SE")
            
          
            
            txtNomChauffeur.font = txtNomChauffeur.font.withSize(17)
            txtNomCamion.font = txtNomCamion.font.withSize(17)
         
            buttmodifP.titleLabel?.font = UIFont(name: Fontraleway, size: 15)
          
         print("device_did_appear")
            
            labstatis.font = labstatis.font.withSize(12)
            labcours.font = labcours.font.withSize(14)
            labnote.font = labnote.font.withSize(14)
            labannee.font = labannee.font.withSize(14)
            
            txtnbrcourse.font = txtnbrcourse.font.withSize(36)
            txtnote.font = txtnote.font.withSize(36)
            txtannee.font = txtannee.font.withSize(36)
            
            return
        //.iPhones_5_5s_5c_SE
        case 1334:
            print("iPhones_6_6s_7_8")
            height = Int(43.5)
           print("device_did_appear")
            
            return
        //.iPhones_6_6s_7_8
        case 1920, 2208:
            print("iPhones_6Plus_6sPlus_7Plus_8Plus")
           
           
            
            labstatis.font = labstatis.font.withSize(15)
            labcours.font = labcours.font.withSize(18)
            labnote.font = labnote.font.withSize(18)
            labannee.font = labannee.font.withSize(18)
            
            txtnbrcourse.font = txtnbrcourse.font.withSize(42)
            txtnote.font = txtnote.font.withSize(42)
            txtannee.font = txtannee.font.withSize(42)
            
           
            
            txtNomChauffeur.font = txtNomChauffeur.font.withSize(20)
            txtNomCamion.font = txtNomCamion.font.withSize(20)
      
            buttmodifP.titleLabel?.font = UIFont(name: Fontraleway, size: 23)
          
           
            return
        //.iPhones_6Plus_6sPlus_7Plus_8Plus
        
        case 2436:
            print("iphone x")
          
            txtNomChauffeur.font = txtNomChauffeur.font.withSize(18)
            txtNomCamion.font = txtNomCamion.font.withSize(18)
          
            
            
            return
        default:
            print("unknown")
            print("iPade")
            
        
            
            return
            //.unknown
        }
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
}
