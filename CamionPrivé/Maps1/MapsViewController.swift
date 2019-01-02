////
//  MapsViewController.swift
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
import CoreLocation
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire
import GGLAnalytics
import Google
import UserNotifications
import AVFoundation
import JTMaterialTransition
import AMPopTip
import NVActivityIndicatorView
import MMLoadingButton
import SCLAlertView
import MediaPlayer
import AudioToolbox
import Foundation




var set_ON =  0
var set_OFF_HL = 0


var BackProfil = 0


var StatutGlobal:Bool = false
var statutLO:Bool = true
var statutLOProfil:Bool = true




//Déclaration des bagages course
var nonClient = " "
var prenomClient = " "
var adressdep = " "
var adressdes = " "
var volume = "0"
var NUMTEL = " "
var NUMFACTURE = " "
var TARIF = " "
var lngDepart = 2.352265
var latDepart = 48.859045
var lngArrive = 12.32
var latArrive = 13.45

var S_A_Aide = 0
var EtageDep = 0
var Etagedest = 0
var Ascenseurdep = 0
var Ascenseurdest = 0
var MSG = " "

//Déclaration des timers
var timerTest1: Timer? = nil
var timerTestVerifAccepter: Timer? = nil
var timerAudio: Timer? = nil

var timerTestbacktitle = Timer()

var refuser = 0
var statut = 0
var deconnectstatut = 1
var verifacept = 0
var deconnexion = 0
var update = 0
var UPDATE = 0


var player: AVAudioPlayer?
var playernot: AVAudioPlayer?

var Profil_vc : ProfilViewController = ProfilViewController()
var Compte_vc : CompteChauffeurViewController = CompteChauffeurViewController()
var Aide_vc : AideViewController = AideViewController()
var Revenu_vc : CalendarRevenuViewController = CalendarRevenuViewController()
var ChoixCamion_vc : CollectionViewController = CollectionViewController()

class MapsViewController: UIViewController, GMSMapViewDelegate , CLLocationManagerDelegate, UNUserNotificationCenterDelegate, NVActivityIndicatorViewable {
    
    var EnterButtonPrinc = 0
    var chrono30munite = 15
    var timerTestchrono1: Timer? = nil
    
    var signalZoom = 1
    //var menu_vc : MenuViewController = MenuViewController()
    
    
    var time = 0
    
    let polyline = GMSPolyline()
    var path = GMSPath()
    
    let longitude = CLLocation()
    let lattitude = CLLocation()
    var locationManager = CLLocationManager()
    
    var mapBearing:CLLocationDirection = CLLocationDirection()
    var  lastDriverAngleFromNorth:CLLocationDirection = CLLocationDirection()
    var marker = GMSMarker()
    
    
    var markerinfowin1 = GMSMarker()
    
    let localNotification: UILocalNotification = UILocalNotification()
    
    var execute:Bool = false
    
    
    var SetOff = 0
    
    var rr:CGFloat = 50
    var rrBound: CGFloat = 0
    var height2:CGFloat = 0
    
    var heightviewbar = 0.0
    var transition: JTMaterialTransition?
    var transition1: JTMaterialTransition?
    var transition2: JTMaterialTransition?

    var window: UIWindow?
    var tapedbuttacepte = 0
    var actt = NVActivityIndicatorView(frame: CGRect.zero)
    
    let popTip = PopTip()
    var vmBoundheight = 0.0
    var vmBoundwidth = 0.0
    var vmBoundx = 0.0
    var vmBoundy = 0.0

    
    var xview = CGFloat()
    var yview = CGFloat()
    //********************************************************************************************************
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    @IBOutlet weak var vm: UIView!
    
    @IBOutlet weak var LO: CustomSwitch!
    
    @IBOutlet weak var buttMV: UIButton!
    @IBOutlet weak var mapv: GMSMapView!
    @IBOutlet weak var viewRaduis: GMSMapView!
    @IBOutlet weak var viewBar: UIView!
    @IBOutlet weak var viewDemandecourse: UIView!
    @IBOutlet weak var viewAlpha: UIView!
    @IBOutlet weak var txtNomClient: UILabel!
    @IBOutlet weak var label1Minute: UILabel!
    @IBOutlet weak var accepterrr: MMLoadingButton!
    @IBOutlet weak var viewSurLO: UIView!
    @IBOutlet weak var viewinmap: UIView!
    @IBOutlet weak var viewinbutonaccept: UIView!
    @IBOutlet weak var buttmylocation: UIButton!
    @IBOutlet weak var labseconde: UILabel!
    
    
    @IBOutlet weak var viewprincipbutton: UIView!
    
    
    @IBOutlet weak var txtbar: UILabel!
    @IBOutlet weak var buttdeconnec: UIButton!
    @IBOutlet weak var buttrevrnu: UIButton!
    @IBOutlet weak var buttaide: UIButton!
    @IBOutlet weak var buttCompte: UIButton!
    
    @IBOutlet weak var buttSviewprinbut: UIButton!
    
    @IBOutlet weak var VIEWPRCB: UIView!
    
    @IBOutlet weak var view_rev: UIView!
    @IBOutlet weak var view_aid: UIView!
    @IBOutlet weak var view_prf: UIView!
    
    
    @IBOutlet weak var viewenligne: UIView!
    @IBOutlet weak var viewhorsligne: UIView!
    
    @IBOutlet weak var buttback: UIButton!
    
    
    @IBOutlet weak var imgexterne: UIImageView!
    @IBOutlet weak var imginterne: UIImageView!
    
    @IBOutlet weak var labenlignein: UILabel!
    @IBOutlet weak var labhorsligne: UILabel!
    //********************************************************************************************************
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    @IBAction func buttmylocationn(_ sender: Any) {
        mapv.animate(toLocation: CLLocationCoordinate2D(latitude: x.coordinate.latitude, longitude: x.coordinate.longitude))
        let camera = GMSCameraPosition.camera(withLatitude: (x.coordinate.latitude), longitude: (x.coordinate.longitude), zoom: 11)
        do {
            // Set the map style by passing the URL of the local file. Make sure style.json is present in your project
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                self.mapv.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                print("Unable to find style.json")
            }
        } catch {
            // print("The style definition could not be loaded: \(error)")
        }
        
        
        self.mapv.camera = camera

        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         print("tawtaw")
        if(StatutGlobal == true){
            locationManager.stopUpdatingHeading()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("000000000000")
        DispatchQueue.global(qos: .userInitiated).async {
            // Do long running task here
            // Bounce back to the main thread to update the UI
            DispatchQueue.main.async {
                self.xview = self.view.center.x
                self.yview = self.view.center.y
                
                self.buttSviewprinbut.layer.cornerRadius = self.buttSviewprinbut.frame.size.height / 2
                
                
                
                self.viewprincipbutton.layer.cornerRadius = self.viewprincipbutton.frame.size.height / 2
                self.viewprincipbutton.layer.masksToBounds = true
                
                
                self.buttSviewprinbut.layer.shadowColor = UIColor.black.cgColor
                self.buttSviewprinbut.layer.shadowOffset = .zero
                self.buttSviewprinbut.layer.shadowOpacity = 0.4
                
                
                //self.menu_vc.view.frame = CGRect(x: 0, y: 0, width: self.mapv.bounds.size.width, height: self.mapv.bounds.size.height)
            }}
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        
        
        
        
        //closeMenu()
        
        let UIScreenheight = UIScreen.main.nativeBounds.height
        print("UIScreenheghit", UIScreenheight)
        
        rrBound = viewRaduis.frame.size.width
        heightviewbar = Double(viewBar.frame.height)
        
        print("appear maps")
        
        vmBoundheight = Double(viewRaduis.bounds.size.height)
        vmBoundwidth = Double(viewRaduis.bounds.size.width)
        vmBoundx = Double(viewRaduis.bounds.origin.x)
        vmBoundy = Double(viewRaduis.bounds.origin.y)
        
        let height1 = viewDemandecourse.frame.origin.y
        height2 = label1Minute.frame.size.height
        rr =  height1 + height2
        print("rr in appear", rr)
        
        
       
    }
    func fetch(_ completion: () -> Void) {
       print("hh")
        completion()
    }
  
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signalZoom = 1
        buttback.isHidden = true
        lOGIN = 1
        
        UIApplication.shared.statusBarStyle = .lightContent
        UIApplication.shared.isIdleTimerDisabled = true
        
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                
                NUMFACTURE = " "
                self.stopAnimating()
            }}

        
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            DispatchQueue.main.async {
                self.UIDevice()
                
        if (StatutGlobal == true){
           
            
                self.LO.thumbTintColor = UIColor.white
            
                statutLO = true
                print("hhhhhhhhhhhhhhhhh")
                self.LO.isOn = true
                self.refresh1()
            
            
                EnLigneMaps = 1
            self.viewenligne.isHidden = false
            self.viewhorsligne.isHidden = true

            
           
        }else{
            self.LO.isOn = false
            self.LO.thumbTintColor = .white
            
            EnLigneMaps = 0
            
            self.viewenligne.isHidden = true
            self.viewhorsligne.isHidden = false
            
        }
                
                //Autoriser Camion Privé chauffeur à accéder a votre position
            }}
      
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        if(StatutGlobal == true){
        if #available(iOS 9.0, *) {
            locationManager.allowsBackgroundLocationUpdates = true
        } else {
            // Fallback on earlier versions
        }
        }else{
            if #available(iOS 9.0, *) {
                locationManager.allowsBackgroundLocationUpdates = false
            } else {
                // Fallback on earlier versions
            }
        }
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.stopUpdatingHeading()
        locationManager.startUpdatingHeading()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        

            DispatchQueue.global(qos: .userInitiated).async {
                
                DispatchQueue.main.async {
                    
                    if(UPDATE == 0){
                        //if(StatutGlobal == true){
                    self.locationManager.startUpdatingLocation()
                            UPDATE = 1
                        //}
                      
                    }else {
                        //UPDATE = 0
                        print("fff")
                    }
                }}
        
       mapv.isMyLocationEnabled = true
       //mapv.settings.myLocationButton = true
        
        ///////////////////
        
        EnLigneProfil = 0
        EnLigneRevenu = 0
        refuser = 0
        accepter = 0
        
        //////////////////
        
        deconnexion = 0
        
        mapv.settings.rotateGestures = false
        
        Profil_vc = self.storyboard?.instantiateViewController(withIdentifier: "idProfil") as! ProfilViewController
        //
        Aide_vc = self.storyboard?.instantiateViewController(withIdentifier: "idAide") as! AideViewController
        Revenu_vc = self.storyboard?.instantiateViewController(withIdentifier: "idCalendar") as! CalendarRevenuViewController
        ChoixCamion_vc = self.storyboard?.instantiateViewController(withIdentifier: "idcollection") as! CollectionViewController
        
        
        //////////////////////
        
        viewAlpha.isHidden = true
        
        
        do{
            playernot = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "ios_notification", ofType: "mp3")!))
            playernot?.prepareToPlay()
            
            let audioSesion1 = AVAudioSession.sharedInstance()
            do{
                try audioSesion1.setCategory(AVAudioSessionCategoryPlayback)
            }
            catch{
                
            }
            
        }
        catch{
            print(error)
        }
        
        
        self.transition = JTMaterialTransition(animatedView: self.buttCompte!)
        self.transition1 = JTMaterialTransition(animatedView: self.buttaide!)
        self.transition2 = JTMaterialTransition(animatedView: self.buttrevrnu!)
        

        
        ///////////////////////////////////
        
            
        
                if(LastStatusGlobal == "2") || (LastStatusGlobal == "1"){
                    print("update == 0 in deconncti 111")
                    LastStatusGlobal = String()
                    AppDelegate().refreshLocationAPP()
                }
                
                if(LastStatusGlobal == "<null>"){
                    print("update == 0 in deconncti 222")
                    send1Status()
                }
        
        
            
        
        
        viewSurLO.isHidden = true
        let tapviewSurLO: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.addviewSurLO))
        LO.addGestureRecognizer(tapviewSurLO)
        
        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        mapv.padding = padding
        
       
        
        buttmylocation.layer.cornerRadius = buttmylocation.frame.height / 2
        buttmylocation.layer.masksToBounds = true
        
        

        
        
        buttrevrnu.layer.shadowColor = UIColor.black.cgColor
        buttrevrnu.layer.shadowOffset = .zero
        buttrevrnu.layer.shadowOpacity = 0.5
        
        buttaide.layer.shadowColor = UIColor.black.cgColor
        buttaide.layer.shadowOffset = .zero
        buttaide.layer.shadowOpacity = 0.5
        
        buttCompte.layer.shadowColor = UIColor.black.cgColor
        buttCompte.layer.shadowOffset = .zero
        buttCompte.layer.shadowOpacity = 0.5
        
        viewprincipbutton.layer.shadowColor = UIColor.black.cgColor
        viewprincipbutton.layer.shadowOffset = .zero
        viewprincipbutton.layer.shadowOpacity = 0.5


      
        
        accepterrr.layer.shadowColor = UIColor.init(red: 177/255, green: 182/255, blue: 186/255, alpha: 1).cgColor
        accepterrr.layer.shadowOpacity = 0.5
        accepterrr.layer.shadowOffset = .zero
        
        viewRaduis.layer.shadowColor = UIColor.init(red: 177/255, green: 182/255, blue: 186/255, alpha: 1).cgColor
        viewRaduis.layer.shadowOpacity = 0.8
        viewRaduis.layer.shadowOffset = .zero
        
        LO.layer.shadowColor = UIColor.init(red: 0/255, green: 41/255, blue: 69/255, alpha: 1).cgColor
        LO.layer.shadowOpacity = 0.5
        LO.layer.shadowOffset = .zero
       
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground(_:)), name: .UIApplicationWillEnterForeground, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: .UIApplicationWillResignActive, object: nil)


    }
    
    @objc func willResignActive(_ notification: Notification) {
        print("hello mouadh")
        if(StatutGlobal == true){
            if #available(iOS 9.0, *) {
                self.locationManager.allowsBackgroundLocationUpdates = true
            } else {
                // Fallback on earlier versions
            }
        }else{
            if #available(iOS 9.0, *) {
                self.locationManager.allowsBackgroundLocationUpdates = false
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    func willEnterForeground(_ notification: NSNotification!) {
        
        if(viewAlpha.isHidden == false){
        print("hiMaps")
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.byValue = -2 * CGFloat.pi
        rotation.duration = 4
        rotation.repeatCount = Float.greatestFiniteMagnitude // forever
        
        imgexterne.layer.add(rotation, forKey: "myAnimation")
        
        
        let rotation1 = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation1.byValue = 2 * CGFloat.pi
        rotation1.duration = 2
        rotation1.repeatCount = Float.greatestFiniteMagnitude // forever
        
        imginterne.layer.add(rotation1, forKey: "myAnimation")
        
        }
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            
            let ac = UIAlertController(title: "Saved!", message: "The screenshot has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func imageIsNullOrNot(imageName : UIImage)-> Bool
    {
        
        let size = CGSize(width: 0, height: 0)
        if (imageName.size.width == size.width)
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    
    func Selected_Camion(){
        let appearance1 = SCLAlertView.SCLAppearance(
            kCircleIconHeight: 100.0,
            kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
            kTextFont: UIFont(name: "Roboto", size: 13)!,
            kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
            showCloseButton: false
        )
        
       
        // Initialize SCLAlertView using custom Appearance
        let alertView = SCLAlertView(appearance: appearance1)
        
        // Creat the subview
        let subview = UIView(frame: CGRect(x: 0, y: 0, width: 216, height: 70))

        subview.backgroundColor = UIColor.red
        alertView.customSubview = subview
        
        
        alertView.addButton("SÉLECTIONNEZ"){
            alertView.dismiss(animated: true, completion: nil)
        }
        
        alertView.showError("", subTitle: "", colorStyle: 0x96ccef, circleIconImage: UIImage(named: "ic_aide60x60"))
        
        
        
        
        
    }
    
    func playSound1() {
      
    }
    
    func send1Status(){
        
        let statutdriver = "2"
        let tok = "\(token)"
        
        
        
        let postString = ["status":statutdriver]
        
        let url = NSURL(string: "\(weburl)/api/driver/updateStatus")
        let request = NSMutableURLRequest(url: url! as URL)
        
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            if error != nil
            {
                DispatchQueue.global(qos: .userInitiated).async {
                    
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
                            self.send1Status()
                        }
                        
                        alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                        
                        
                        
                    }}
                return
            }
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                print("fichier json", json)
                if let status = json["status"]{
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            print(status)
                            LastStatusGlobal = String()
                            AppDelegate().refreshLocationAPP()
                            
                        }}
                }else {
                    DispatchQueue.global(qos: .userInitiated).async {
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
                                self.send1Status()
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }}
                }
                
            }
            catch let error as NSError
            {
                print(error)
            }
        }
        task.resume()
        
        
    }
    
    func addviewSurLO(){
        viewSurLO.isHidden = false
    }
    
    //**********************************************************************************************
    //**********************************************************************************************
    
    
    func playSound(){
    
        
        do {
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                // play audio even in silent mode
            } catch {
                print("could not play in silent mode")
            }
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "newtone", ofType: "mp3")!))
            
            
//            let volumeView = MPVolumeView()
//            if let view = volumeView.subviews.first as? UISlider{
//                view.value = 1
//
//            }
            player?.currentTime = 0
            player?.play()
            
        } catch {
            print("could not play sound")
        }
        
        
        
    }
    
    func replay(){
        DispatchQueue.global(qos: .userInitiated).async {
            // Do long running task here
            // Bounce back to the main thread to update the UI
            DispatchQueue.main.async {
                self.playSound()
            }}
        
    }
    //**********************************************************************************************
    
    
    
    func refresh1() {
        timerTest1 = nil
        timerTest1 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MapsViewController.show1), userInfo: nil, repeats: true)
        print("**** +++- -----  lllllllll")
    }
    
    func show1(){
        if set_ON == 0 {
        print("in maps *")
        self.change_LO()
        if(UIApplication.shared.applicationState == .active){
        if  (notif == 1) || (notifBC == 1) || (IDDriverRequest != -1){
            
            if (closeMaps == 0){
                
                timerTest1?.invalidate()
                EnLigneMaps = 0
                print("***** maps en ligne", EnLigneMaps)
                
                
                notif = 0
                notifBC = 0
                time = 0
                print(time)
               
                DispatchQueue.main.async {
                    if(BackProfil == 1){
                        
                        ProfilViewController().dismissCompte()
                    }
                    
                    
                    
                    self.view_rev.backgroundColor = UIColor.init(red: 5/255, green: 150/255, blue: 253/255, alpha: 1)
                    self.view_aid.backgroundColor = UIColor.init(red: 5/255, green: 150/255, blue: 253/255, alpha: 1)
                    self.view_prf.backgroundColor = UIColor.init(red: 5/255, green: 150/255, blue: 253/255, alpha: 1)
                    
                    
                    Profil_vc.view.removeFromSuperview()
                    Revenu_vc.view.removeFromSuperview()
                    if(self.EnterButtonPrinc == 1){
                        Aide_vc.view.removeFromSuperview()
                    }
                    self.EnterButtonPrinc = 0
                    
                    //Mapv.dismiss(animated: true, completion: nil)
                    self.LO.isHidden = false
                    self.viewSurLO.isHidden = true
                    self.buttback.isHidden = true
                    self.buttmylocation.isHidden = false
                    self.viewenligne.isHidden = false
                    self.viewhorsligne.isHidden = true
               
                    self.showPageDemandeCourse()
                }
                
                if(playerDelegate?.isPlaying)!{
                    print("******SoundBG")
                }else{
                    DispatchQueue.global(qos: .userInitiated).async {
                        // Do long running task here
                        // Bounce back to the main thread to update the UI
                        DispatchQueue.main.async {
                            self.playSound()
                    print("SoundFG******")
                        }}

                }
               
            }
        }
        }
        }
    }
    
    
    
    //**********************************************************************************************
    
    
    func sendLocalNotif() {
        localNotification.alertAction = "Demande d'une course" // 2
        localNotification.alertBody = ("vous avez une course de M./.Mr \(nonClient) \(prenomClient) du \(adressdep) à \(adressdes)") // 3
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 0) as Date // 4
        localNotification.category = "status" // 5
        localNotification.userInfo = [ "cause": "inactiveMembership"] // 6
       // localNotification.soundName = "default"
        localNotification.shouldGroupAccessibilityChildren = true
        
        localNotification.applicationIconBadgeNumber = 1
        
        UIApplication.shared.scheduleLocalNotification(localNotification)
        
    }
    
    //********************************************************************************************************
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    @IBAction func buttonLO(_ sender: CustomSwitch) {
        
        if (sender.isOn == true)
        {
            if(SetOff == 0){
            IDDriverRequest = -1
            
            //update = 1
            time = 0
            
            
            self.view.addSubview(ChoixCamion_vc.view)
                
            self.viewSurLO.isHidden = true
            self.viewenligne.isHidden = false
            self.viewhorsligne.isHidden = true
                set_ON = 1
           refresh1()
            
            ChoixCamion_vc.buttselectionner.backgroundColor = UIColor.init(red: 150/255, green: 204/255, blue: 238/255, alpha: 1)
            ChoixCamion_vc.buttselectionner.isUserInteractionEnabled = false
            ChoixCamion_vc.labcamion.text = "Choisir un camion"
            ChoixCamion_vc.txtmodele.text = "--"
            ChoixCamion_vc.txtvolume.text = "--"
                if #available(iOS 9.0, *) {
                    self.locationManager.allowsBackgroundLocationUpdates = true
                } else {
                    // Fallback on earlier versions
                }
                //self.locationManager.startUpdatingLocation()
                
            }else{
                SetOff = 0
                self.viewSurLO.isHidden = true
                self.viewenligne.isHidden = false
                self.viewhorsligne.isHidden = true
            }
            
            
        } else {
            print(",,,,,,,,")
            
            if(set_OFF_HL == 0){
                sendStatutHL()
            }else{
                set_OFF_HL = 0
            }
            
            //buttmylocation.isHidden = false
        }
        
    }
    
    //********************************************************************************************************
    
   
    
    func change_LO(){
        DispatchQueue.main.async {
        if(StatutGlobal == false){
            
            self.LO.thumbTintColor = .white
            self.LO.setOn(on: false, animated: true)
            self.LO.isOn = false
            
            self.time = 0
            print(self.time)
            AppDelegate().refreshLocationAPP()
            
            timerTest1?.invalidate()
            EnLigneMaps = 0
            self.viewSurLO.isHidden = true
            self.viewenligne.isHidden = true
            self.viewhorsligne.isHidden = false
            
            if #available(iOS 9.0, *) {
                self.locationManager.allowsBackgroundLocationUpdates = false
            } else {
                // Fallback on earlier versions
            }
            
            
        }
        }
    }
    
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 70))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 6
        
        let lbl1 = UILabel(frame: CGRect.init(x: 8, y: 8, width: view.frame.size.width - 16, height: 15))
        lbl1.text = "Hi there!"
        view.addSubview(lbl1)
        
        let lbl2 = UILabel(frame: CGRect.init(x: lbl1.frame.origin.x, y: lbl1.frame.origin.y + lbl1.frame.size.height + 3, width: view.frame.size.width - 16, height: 15))
        lbl2.text = "I am a custom info window."
        //lbl2.font = UIFont.systemFont(ofSize: 14, weight: .light)
        view.addSubview(lbl2)
        
        return view
    }
    //********************************************************************************************************
    
   
  
    @IBAction func buttBack(_ sender: Any) {
        if(BackProfil == 0){
            
            self.view_rev.backgroundColor = UIColor.init(red: 5/255, green: 150/255, blue: 253/255, alpha: 1)
            self.view_aid.backgroundColor = UIColor.init(red: 5/255, green: 150/255, blue: 253/255, alpha: 1)
            self.view_prf.backgroundColor = UIColor.init(red: 5/255, green: 150/255, blue: 253/255, alpha: 1)
            
            //self.Profil_vc.dismiss(animated: false, completion: nil)
            Profil_vc.view.removeFromSuperview()
            Revenu_vc.view.removeFromSuperview()
             if(EnterButtonPrinc == 1){
            Aide_vc.view.removeFromSuperview()
            }
            EnterButtonPrinc = 0
            //Mapv.dismiss(animated: true, completion: nil)
            LO.isHidden = false
            viewSurLO.isHidden = true
            buttback.isHidden = true
            buttmylocation.isHidden = false
            if(StatutGlobal == true){
            viewenligne.isHidden = false
                viewhorsligne.isHidden = true
            }else{
                viewhorsligne.isHidden = false
            }
        }else {
            
            buttback.titleLabel?.text = "< Map       "
            BackProfil = 0
            
           ProfilViewController().dismissCompte()
            refreshchangebacktitle()
        }
        
      
    }
    
    func refreshchangebacktitle() {
       
            timerTestbacktitle = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(MapsViewController.back), userInfo: nil, repeats: true)
        
        
    }
    
    func back(){
        
            
        
                if(BackProfil == 1){
                    DispatchQueue.global(qos: .userInitiated).async {
                        
                        DispatchQueue.main.async {
                self.buttback.titleLabel?.text = "<Profil"
                            
                    print("fff")
                    timerTestbacktitle.invalidate()
                        }}
                }
        
    }
    
    
   
    
    @IBAction func buttonCompte(_ sender: Any) {
       

        let activityInd = NVActivityIndicatorView(frame: CGRect(x: self.xview - 25, y: self.yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
        self.view.addSubview(activityInd)
        
        
        self.startAnimating(message: "", type: NVActivityIndicatorType.ballRotateChase)
        
        let today = Date()
        let formattertoday = DateFormatter()
        formattertoday.dateFormat = "yyyy-MM-dd"
        let resulttoday = formattertoday.string(from: today)
        
        get_Statistique(start: DEBUT_TRV, end: resulttoday)
        
      
        
        
    }
    
    @IBAction func buttAid(_ sender: Any) {
        
                        let activityInd = NVActivityIndicatorView(frame: CGRect(x: self.xview - 25, y: self.yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
        
                        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
                        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
                        self.view.addSubview(activityInd)
        
        
                        self.startAnimating(message: "", type: NVActivityIndicatorType.ballRotateChase)
        
        self.getquestionAide()
    }
    
    @IBAction func buttRV(_ sender: Any) {
        

//        let activityInd = NVActivityIndicatorView(frame: CGRect(x: self.xview - 25, y: self.yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
//
//        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
//        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
//        self.view.addSubview(activityInd)
//
//
//        self.startAnimating(message: "", type: NVActivityIndicatorType.ballRotateChase)
//
//        let today = Date()
//        let formattertoday = DateFormatter()
//        formattertoday.dateFormat = "yyyy-MM-dd"
//        let resulttoday = formattertoday.string(from: today)
        
        
        //self.getRevenuYears(start: DEBUT_TRV, end: resulttoday)
        
        self.view_rev.backgroundColor = UIColor.init(red: 4/255, green: 97/255, blue: 164/255, alpha: 1)
        
        self.view_aid.backgroundColor = UIColor.init(red: 5/255, green: 150/255, blue: 253/255, alpha: 1)
        self.view_prf.backgroundColor = UIColor.init(red: 5/255, green: 150/255, blue: 253/255, alpha: 1)
        
        if(BackProfil == 1){
            
            ProfilViewController().dismissCompte()
        }
        BackProfil = 0
        self.mapv.addSubview(Revenu_vc.view)
        self.LO.isHidden = true
        self.viewSurLO.isHidden = true
        self.buttback.isHidden = false
        self.buttmylocation.isHidden = true
        self.viewenligne.isHidden = true
        self.viewhorsligne.isHidden = true
        self.buttback.titleLabel?.text = "< Map       "
        
        Profil_vc.view.removeFromSuperview()
        if (self.EnterButtonPrinc == 0){
            
        }else{
            Aide_vc.view.removeFromSuperview()
        }
    }
    
    

    
   
    func getquestionAide()
    {
        
        let tok = "\(token)"
        
        let url = NSURL(string: "\(weburl)/api/driver/GetSubject")
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        // request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            print("******** oloooooooooooooo FAQ ***********")
            
            
            if error != nil
            {
                
                print("rrrr", error?.localizedDescription as Any)
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
                    
                    alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
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
                else{
                    
                    
                    
                    labeles.removeAll()
                    quest.removeAll()
                    repons.removeAll()
                    
                    if let FAQ = json["success"] as? [[String: Any]]{
                        
                        if(FAQ.count > 0){
                            
                            DispatchQueue.main.async {
                                for i in 0 ..< FAQ.count {
                                    let sujet = FAQ[i]["sujet"]
                                    let resultsujet = self.checkNull(obj: sujet as AnyObject)
                                    if(resultsujet == true){
                                        print("sujet is nil")
                                    }
                                    else{
                                        print("sujet:", sujet!)
                                       let strg_sujet = sujet as! String
                                        labeles.append(strg_sujet)
                                    }
                                    //////
                                    if let QuestRep = FAQ[i]["quest_rep"] as? [[String: Any]]{
                                        DispatchQueue.main.async {
                                                quest.append([])
                                                 repons.append([])
                                            for j in 0 ..< QuestRep.count {
                                                let questhelp = QuestRep[j]["questhelp"]
                                                let resultquesthelp = self.checkNull(obj: questhelp as AnyObject)
                                                if(resultquesthelp == true){
                                                    print("questhelp is nil")
                                                }
                                                else{
                                                    //print("questhelp:", questhelp!)
                                                    let strg_questhelp = questhelp as! String
                                                    quest[i].append(strg_questhelp)
                                                    allquest.append(strg_questhelp)
                                                }
                                                ///////
                                                let rephelp = QuestRep[j]["rephelp"]
                                                let resultrephelp = self.checkNull(obj: rephelp as AnyObject)
                                                if(resultrephelp == true){
                                                    print("rephelp is nil")
                                                }
                                                else{
                                                    //print("rephelp:", rephelp!)
                                                    let strg_rephelp = rephelp as! String
                                                    repons[i].append(strg_rephelp)
                                                    allrep.append(strg_rephelp)
                                                }
                                                //////
                                            }
                                            
                                        }}
                                    
                                    //////
                                    DispatchQueue.main.async {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                                        self.stopAnimating()
                                        self.view_aid.backgroundColor = UIColor.init(red: 4/255, green: 97/255, blue: 164/255, alpha: 1)
                                        self.view_rev.backgroundColor = UIColor.init(red: 5/255, green: 150/255, blue: 253/255, alpha: 1)
                                        self.view_prf.backgroundColor = UIColor.init(red: 5/255, green: 150/255, blue: 253/255, alpha: 1)
                                            self.EnterButtonPrinc = 1
                                        if(BackProfil == 1){
                                            ProfilViewController().dismissCompte()
                                        }
                                        BackProfil = 0
                                        self.mapv.addSubview(Aide_vc.view)
                                        self.LO.isHidden = true
                                        self.viewSurLO.isHidden = true
                                        self.buttback.isHidden = false
                                        self.buttmylocation.isHidden = true
                                        self.viewenligne.isHidden = true
                                            self.viewhorsligne.isHidden = true
                                        self.buttback.titleLabel?.text = "< Map       "
                                    }
                                    }
                                }
                                print("****", quest, "****")
                                print("€€€€", repons, "€€€€")
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
                                alertView.addButton("OK"){
                                    alertView.dismiss(animated: true, completion: nil)
                                    
                                }
                                
                                alertView.showNotice("NOTICE", subTitle: "Aucun sujet", colorStyle: 0x002c4c)
                            }
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
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                        }
                        
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
    
    func getRevenuYears(start: String, end: String)
    {
        
        let tok = "\(token)"
        
        
        let postString = ["start":"\(start) 00:00", "end":"\(end) 23:59"] as [String : Any]
        
        let url = NSURL(string: "\(weburl)/api/driver/GetRevenu")
        let request = NSMutableURLRequest(url: url! as URL)
        
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            print("€€€€€€€€€€ (Revenu Years) start = \(start) end:\(end)  €€€€€€€€")
            
            
            
            
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
                            alertView.addButton("Réessayer"){
                                let today = Date()
                                let formattertoday = DateFormatter()
                                formattertoday.dateFormat = "yyyy-MM-dd"
                                let resulttoday = formattertoday.string(from: today)
                                self.getRevenuYears(start: DEBUT_TRV, end: resulttoday)
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
                            alertView.addButton("Réessayer"){
                                let today = Date()
                                let formattertoday = DateFormatter()
                                formattertoday.dateFormat = "yyyy-MM-dd"
                                let resulttoday = formattertoday.string(from: today)
                                self.getRevenuYears(start: DEBUT_TRV, end: resulttoday)                            }
                            
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
                            alertView.addButton("Réessayer"){
                                let today = Date()
                                let formattertoday = DateFormatter()
                                formattertoday.dateFormat = "yyyy-MM-dd"
                                let resulttoday = formattertoday.string(from: today)
                                self.getRevenuYears(start: DEBUT_TRV, end: resulttoday)                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                        
                        
                    }
                    
                }
                
                
                
                return
            }
            
            do
            {
                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                    print("Json **€€ \(json) €€** Json")
                    if let Dict0 = json["success"]{
                        
                        let Dict1 : NSArray = Dict0 as! NSArray
                        
                        let Dict:NSDictionary = Dict1[0] as! NSDictionary
                        
                        
                        DispatchQueue.main.async {
                            
                            if let prixtot = Dict["brut"]{
                                
                                let ns_prix = prixtot as! Int
                                //                                let int_prix = Float(ns_prix)
                                //                                let double_prix = Double(int_prix)
                                //                                let x = String(format: "%.0f", double_prix)
                                
                                LabEuroYears = "\(ns_prix)"
                                
                            }else{
                                print("prix tot n'existe pas")
                                LabEuroYears = "--"
                            }
                            
                            if let courset = Dict["all_course"]{
                                
                                LabNbrCourseYears = "\(courset)"
                                
                                
                            }else{
                                print("courset n'existe pas")
                                LabNbrCourseYears = "--"
                            }
                            
                            
                            
                            if let notet = Dict["note"]{
                                let int_notey = notet as! Float
                                let float_notey = Float(int_notey)
                                let x = String(format: "%.1f", float_notey)
                                LabNoteYears = "\(x)"
                                
                                
                            }else{
                                print("notet n'existe pas")
                                LabNoteYears = "--"
                            }
                            
                            
                            
                        }
                        DispatchQueue.main.async {
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                                self.stopAnimating()
                                
                                self.view_rev.backgroundColor = UIColor.init(red: 4/255, green: 97/255, blue: 164/255, alpha: 1)
                                
                                self.view_aid.backgroundColor = UIColor.init(red: 5/255, green: 150/255, blue: 253/255, alpha: 1)
                                self.view_prf.backgroundColor = UIColor.init(red: 5/255, green: 150/255, blue: 253/255, alpha: 1)
                                
                                if(BackProfil == 1){
                                    
                                    ProfilViewController().dismissCompte()
                                }
                                BackProfil = 0
                                self.mapv.addSubview(Revenu_vc.view)
                                self.LO.isHidden = true
                                self.viewSurLO.isHidden = true
                                self.buttback.isHidden = false
                                self.buttmylocation.isHidden = true
                                self.viewenligne.isHidden = true
                                self.viewhorsligne.isHidden = true
                                self.buttback.titleLabel?.text = "< Map       "
                                
                                Profil_vc.view.removeFromSuperview()
                                if (self.EnterButtonPrinc == 0){
                                    
                                }else{
                                    Aide_vc.view.removeFromSuperview()
                                }
                                //Aide_vc.view.removeFromSuperview()
                                
                                
                            }}
                        
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
                            alertView.addButton("Réessayer"){
                                let today = Date()
                                let formattertoday = DateFormatter()
                                formattertoday.dateFormat = "yyyy-MM-dd"
                                let resulttoday = formattertoday.string(from: today)
                                self.getRevenuYears(start: DEBUT_TRV, end: resulttoday)                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
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
                        alertView.addButton("Réessayer"){
                            let today = Date()
                            let formattertoday = DateFormatter()
                            formattertoday.dateFormat = "yyyy-MM-dd"
                            let resulttoday = formattertoday.string(from: today)
                            self.getRevenuYears(start: DEBUT_TRV, end: resulttoday)                        }
                        
                        alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                        
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
                            alertView.addButton("Réessayer"){
                                let today = Date()
                                let formattertoday = DateFormatter()
                                formattertoday.dateFormat = "yyyy-MM-dd"
                                let resulttoday = formattertoday.string(from: today)
                                self.getRevenuYears(start: DEBUT_TRV, end: resulttoday)                            }
                            
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
                            alertView.addButton("Réessayer"){
                                let today = Date()
                                let formattertoday = DateFormatter()
                                formattertoday.dateFormat = "yyyy-MM-dd"
                                let resulttoday = formattertoday.string(from: today)
                                self.getRevenuYears(start: DEBUT_TRV, end: resulttoday)                            }
                            
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
                            alertView.addButton("Réessayer"){
                                let today = Date()
                                let formattertoday = DateFormatter()
                                formattertoday.dateFormat = "yyyy-MM-dd"
                                let resulttoday = formattertoday.string(from: today)
                                self.getRevenuYears(start: DEBUT_TRV, end: resulttoday)                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                        
                        
                    }
                    
                }
            }
        }
        task.resume()
    }
    
    
    func get_Statistique(start: String, end: String)
    {
        
        let tok = "\(token)"
        
        
        let postString = ["start":"\(start) 00:00", "end":"\(end) 23:59"] as [String : Any]
        
        let url = NSURL(string: "\(weburl)/api/driver/GetRevenu")
        let request = NSMutableURLRequest(url: url! as URL)
        
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            print("€€€€€€€€€€ (Revenu Years) start = \(start) end:\(end)  €€€€€€€€")
            
            
            
            
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
                            alertView.addButton("Réessayer"){
                               alertView.dismiss(animated: false, completion: nil)
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
                            alertView.addButton("Réessayer"){
                               alertView.dismiss(animated: false, completion: nil)               }
                            
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
                            alertView.addButton("Réessayer"){
                                alertView.dismiss(animated: false, completion: nil)                             }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                        
                        
                    }
                    
                }
                
                
                
                return
            }
            
            do
            {
                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                    print("Json **€€ \(json) €€** Json")
                    if let Dict0 = json["success"]{
                        
                        let Dict1 : NSArray = Dict0 as! NSArray
                        
                        let Dict:NSDictionary = Dict1[0] as! NSDictionary
                        
                        
                        DispatchQueue.main.async {
                            
                           
                            
                            if let courset = Dict["all_course"]{
                                
                                LabNbrCourseYears = "\(courset)"
                                
                                
                            }else{
                                print("courset n'existe pas")
                                LabNbrCourseYears = "--"
                            }
                            
                            
                            
                            if let notet = Dict["note"]{
                                let int_notey = notet as! Float
                                let float_notey = Float(int_notey)
                                let x = String(format: "%.1f", float_notey)
                                LabNoteYears = "\(x)"
                                
                                
                            }else{
                                print("notet n'existe pas")
                                LabNoteYears = "--"
                            }
                            
                            
                            
                        }
                        DispatchQueue.main.async {
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                                self.stopAnimating()
                                
                                self.view_prf.backgroundColor = UIColor.init(red: 4/255, green: 97/255, blue: 164/255, alpha: 1)
                                
                                self.view_rev.backgroundColor = UIColor.init(red: 5/255, green: 150/255, blue: 253/255, alpha: 1)
                                self.view_aid.backgroundColor = UIColor.init(red: 5/255, green: 150/255, blue: 253/255, alpha: 1)
                                
                                self.LO.isHidden = true
                                self.viewSurLO.isHidden = true
                                self.buttback.isHidden = false
                                
                                self.mapv.addSubview(Profil_vc.view)
                                
                                if(BackProfil == 1){
                                    
                                    ProfilViewController().dismissCompte()
                                }else{
                                    if (self.EnterButtonPrinc == 0){
                                        print("666")
                                    }else{
                                        print("777")
                                        Aide_vc.view.removeFromSuperview()
                                    }
                                }
                                BackProfil = 0
                                self.buttmylocation.isHidden = true
                                self.viewenligne.isHidden = true
                                self.viewhorsligne.isHidden = true
                                
                                self.buttback.titleLabel?.text = "< Map       "
                                
                                if(timerTestbacktitle.isValid){
                                    
                                }else{
                                    self.refreshchangebacktitle()
                                }
                                Profil_vc.txtNomChauffeur.text = names + " " + firstname
                                Profil_vc.txtNomCamion.text = MARQUE + " " + MODEL + "-" + IMMAT
                                
                                Revenu_vc.view.removeFromSuperview()
                                
                                
                            }}
                        
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
                            alertView.addButton("Réessayer"){
                                alertView.dismiss(animated: false, completion: nil)                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
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
                        alertView.addButton("Réessayer"){
                            alertView.dismiss(animated: false, completion: nil)                        }
                        
                        alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                        
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
                            alertView.addButton("Réessayer"){
                                alertView.dismiss(animated: false, completion: nil)                          }
                            
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
                            alertView.addButton("Réessayer"){
                                alertView.dismiss(animated: false, completion: nil)                           }
                            
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
                            alertView.addButton("Réessayer"){
                               alertView.dismiss(animated: false, completion: nil)                            }
                            
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
    //********************************************************************************************************
    
    
    @IBAction func buttonMenu(_ sender: Any) {
        if(VolumeTotale != 0){

        if AppDelegate.menu_bool{
            //showMenu()
            let appearance1 = SCLAlertView.SCLAppearance(
                kCircleIconHeight: 45.0,
                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                kTextFont: UIFont(name: "Roboto", size: 13)!,
                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                showCloseButton: false
            )
           
            let alertView = SCLAlertView(appearance: appearance1)
            alertView.addButton("OK"){
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.showNotice("NOTICE", subTitle: "Vous n'avez aucune course en cours.", colorStyle: 0x002c4c)
          
            
            
        }else{
            //closeMenu()
            let appearance1 = SCLAlertView.SCLAppearance(
                kCircleIconHeight: 45.0,
                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                kTextFont: UIFont(name: "Roboto", size: 13)!,
                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                showCloseButton: false
            )
            
            let alertView = SCLAlertView(appearance: appearance1)
            alertView.addButton("OK"){
                alertView.dismiss(animated: true, completion: nil)
            }
            alertView.showNotice("NOTICE", subTitle: "Vous n'avez aucune course en cours.", colorStyle: 0x002c4c)
            
            
        }
        }else{
            print("en attente camion")
        }
        
        
    }
    
    //********************************************************************************************************
    
    
    @IBAction func buttAccepter(_ sender: MMLoadingButton) {
        timerTestVerifAccepter?.invalidate()
        actt = NVActivityIndicatorView(frame: viewinbutonaccept.bounds, type: NVActivityIndicatorType.ballClipRotate, color: UIColor.white)
        viewinbutonaccept.addSubview(actt)
        
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            DispatchQueue.main.async {
                self.timerTestchrono1?.invalidate()

                self.viewinbutonaccept.isHidden = false
                self.actt.startAnimating()
                self.accepterrr.startLoading()
                
                
            }}

        
        tapedbuttacepte = 1
        timerAudio?.invalidate()
        player?.stop()
        playerDelegate?.stop()
        
        
        locationManager.stopUpdatingHeading()
        
        
        time = 0
        print(time)
        
        SendAccepte(AttributAccepteRefuse: 3)
        
    }
    func SendAccepte(AttributAccepteRefuse: Int)
    {
        
        let DriverRequestID = IDDriverRequest
        let tok = "\(token)"
        
        
        
        let postString = ["acceptRefuse":"\(AttributAccepteRefuse)", "DriverRequestId":"\(DriverRequestID)"] as [String : Any]
        
        let url = NSURL(string: "\(weburl)/api/driver/acceptRefuseRace")
        let request = NSMutableURLRequest(url: url! as URL)
        
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            print("**********///// SEND ACCEPTE = \(AttributAccepteRefuse) IDRqs:\(DriverRequestID)////*************")
            
            
            
            
            if error != nil
            {
                DispatchQueue.main.async {
                    let status = Reach().connectionStatus()
                    switch status {
                    case .unknown, .offline:
                        print("Not connected")
                        DispatchQueue.main.async {
                            self.actt.stopAnimating()
                            self.accepterrr.stopLoading(false, completed: nil)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){

                            if(self.viewAlpha.isHidden == false){
                           
                                
                                let appearance1 = SCLAlertView.SCLAppearance(
                                    kCircleIconHeight: 45.0,
                                    kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                    kTextFont: UIFont(name: "Roboto", size: 13)!,
                                    kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                    showCloseButton: false
                                )
                                
                                let alertView = SCLAlertView(appearance: appearance1)
                                alertView.addButton("ACCEPTER"){
                                    self.SendAccepte(AttributAccepteRefuse: 3)
                                }
                                alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                            }}
                        
                        
                    case .online(.wwan):
                        print("Connected via WWAN")
                        DispatchQueue.main.async {
                            self.actt.stopAnimating()
                            self.accepterrr.stopLoading(false, completed: nil)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                             if(self.viewAlpha.isHidden == false){
                           
                                let appearance1 = SCLAlertView.SCLAppearance(
                                    kCircleIconHeight: 45.0,
                                    kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                    kTextFont: UIFont(name: "Roboto", size: 13)!,
                                    kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                    showCloseButton: false
                                )
                                
                                let alertView = SCLAlertView(appearance: appearance1)
                                alertView.addButton("ACCEPTER"){
                                    self.SendAccepte(AttributAccepteRefuse: 3)
                                }
                                alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue, essayer à nouveau", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                            }}
                        
                    case .online(.wiFi):
                        print("Connected via WiFi")
                        
                        DispatchQueue.main.async {
                            self.actt.stopAnimating()
                            self.accepterrr.stopLoading(false, completed: nil)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                             if(self.viewAlpha.isHidden == false){
                                let appearance1 = SCLAlertView.SCLAppearance(
                                    kCircleIconHeight: 45.0,
                                    kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                    kTextFont: UIFont(name: "Roboto", size: 13)!,
                                    kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                    showCloseButton: false
                                )
                                
                                let alertView = SCLAlertView(appearance: appearance1)
                                alertView.addButton("ACCEPTER"){
                                    self.SendAccepte(AttributAccepteRefuse: 3)
                                }
                                alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue, essayer à nouveau", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                            }}
                        
                    }
                    
                }
                return
            }
            
            do
            {
                if  let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                
                print("************* \(json) *************")
                    
                    
                if let Result = json["status"]{
                let result = Result as! NSNumber
                //0 course effectue a autre driver
                if(self.tapedbuttacepte == 1){
                if(result == 0){
                    DispatchQueue.global(qos: .userInitiated).async {
                        // Do long running task here
                        // Bounce back to the main thread to update the UI
                        DispatchQueue.main.async {
                            
                            print("/////  cette course effectuer a un autre chauffeur ////")
                            self.window = UIWindow(frame: UIScreen.main.bounds)
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            
                            let initialViewController = storyboard.instantiateViewController(withIdentifier: "idMaps")
                            
                            self.window?.rootViewController = initialViewController
                            self.window?.makeKeyAndVisible()
                            IDDriverRequest = -1
                
                        }}
                }
                else{
                    DispatchQueue.global(qos: .userInitiated).async {
                        // Do long running task here
                        // Bounce back to the main thread to update the UI
                        DispatchQueue.main.async {
                            NUMFACTURE = " "
                            
                            if let bondeCommande = json["boncommande"]{
                                
                                
                                NUMFACTURE = String(describing: bondeCommande)
                                
                            }else{
                                print("bon de commande n'existe pas")
                            }
                            
                            self.locationManager.stopUpdatingHeading()
                            
                            self.window = UIWindow(frame: UIScreen.main.bounds)
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            
                            let initialViewController = storyboard.instantiateViewController(withIdentifier: "idMaps2")
                            
                            self.window?.rootViewController = initialViewController
                            self.window?.makeKeyAndVisible()
                        }}
                }
                
                }
                
                }else {
                    let appearance1 = SCLAlertView.SCLAppearance(
                        kCircleIconHeight: 45.0,
                        kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                        kTextFont: UIFont(name: "Roboto", size: 13)!,
                        kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                        showCloseButton: false
                    )
                    
                    let alertView = SCLAlertView(appearance: appearance1)
                    alertView.addButton("ACCEPTER"){
                        self.SendAccepte(AttributAccepteRefuse: 3)
                    }
                    alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue, essayer à nouveau", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                }
                
                
                
                
                
                
                self.tapedbuttacepte = 0
                
                }else{
                    let appearance1 = SCLAlertView.SCLAppearance(
                        kCircleIconHeight: 45.0,
                        kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                        kTextFont: UIFont(name: "Roboto", size: 13)!,
                        kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                        showCloseButton: false
                    )
                    
                    let alertView = SCLAlertView(appearance: appearance1)
                    alertView.addButton("ACCEPTER"){
                        self.SendAccepte(AttributAccepteRefuse: 3)
                    }
                    alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue, essayer à nouveau", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                    
                     }
                
                
            }
            catch let error as NSError
            {
                print(error)
            }
        }
        task.resume()
    }
    
    func SendRefusetoMaster(AttributAccepteRefuse: Int)
    {
        
        let DriverRequestID = IDDriverRequest
        let tok = "\(token)"
        
        
        
        let postString = ["acceptRefuse":"\(AttributAccepteRefuse)", "DriverRequestId":"\(DriverRequestID)"] as [String : Any]
        
        let url = NSURL(string: "\(weburl)/api/driver/acceptRefuseRacetomaster")
        let request = NSMutableURLRequest(url: url! as URL)
        
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            print("**********///// SEND  REFUSE to master = \(AttributAccepteRefuse) IDRqs:\(DriverRequestID)////*************")
            
            
            
            
            if error != nil
            {
                DispatchQueue.main.async {
                    let status = Reach().connectionStatus()
                    switch status {
                    case .unknown, .offline:
                        print("Not connected")
                        
                      
                        self.SendRefusetoMaster(AttributAccepteRefuse: 6)
                        
                        
                    case .online(.wwan):
                        print("Connected via WWAN")
                        
                       
                        self.SendRefusetoMaster(AttributAccepteRefuse: 6)
                        
                    case .online(.wiFi):
                        print("Connected via WiFi")
                        
                        
                     
                        self.SendRefusetoMaster(AttributAccepteRefuse: 6)
                        
                    }
                    
                }
                
                return
            }
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                print("************* \(json) *************")
                if let Result = json["status"] {
                    
                    let result = Result as! NSNumber
                    //0 course effectue a autre driver
                    if(result == 0){
                        
                    }
                    else{
                        
                    }
                    
                    
                    print("***** +++ ------**********  hhhhhhhhhh")
                    DispatchQueue.global(qos: .userInitiated).async {
                        // Do long running task here
                        // Bounce back to the main thread to update the UI
                        DispatchQueue.main.async {
                            IDDriverRequest = -1
                            self.refresh1()
                            frommaster = "0"
                        }}
                    
                    
                }else {
                    self.SendRefusetoMaster(AttributAccepteRefuse: 6)
                    
                }
                
                
                
                
                
            }
            catch let error as NSError
            {
                print(error)
            }
        }
        task.resume()
    }
    
    func SendRefuse(AttributAccepteRefuse: Int)
    {
        
        let DriverRequestID = IDDriverRequest
        let tok = "\(token)"
        
        
        
        let postString = ["acceptRefuse":"\(AttributAccepteRefuse)", "DriverRequestId":"\(DriverRequestID)"] as [String : Any]
        
        let url = NSURL(string: "\(weburl)/api/driver/acceptRefuseRace")
        let request = NSMutableURLRequest(url: url! as URL)
        
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            print("**********///// SEND  REFUSE = \(AttributAccepteRefuse) IDRqs:\(DriverRequestID)////*************")
            
            
            
            
            if error != nil
            {
                DispatchQueue.main.async {
                    let status = Reach().connectionStatus()
                    switch status {
                    case .unknown, .offline:
                        print("Not connected")
                        
                        
                        self.SendRefuse(AttributAccepteRefuse: 4)
                        
                        
                    case .online(.wwan):
                        print("Connected via WWAN")
                        
                        
                        self.SendRefuse(AttributAccepteRefuse: 4)
                        
                    case .online(.wiFi):
                        print("Connected via WiFi")
                        
                      
                        self.SendRefuse(AttributAccepteRefuse: 4)

 }
 
                }
                
                return
            }
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                print("************* \(json) *************")
                if let Result = json["status"] {
                    
                    let result = Result as! NSNumber
                    if(result == 0){
                        
                    }
                    else{
                        
                    }
                    
                    
                    print("***** +++ ------**********  hhhhhhhhhh")
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            IDDriverRequest = -1
                    self.refresh1()
                        }}
                    
                    
                }else {
                    self.SendRefuse(AttributAccepteRefuse: 4)
                    
                }
               
                
            }
            catch let error as NSError
            {
                print(error)
            }
        }
        task.resume()
    }
    //********************************************************************************************************
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newSize.width, height: newSize.height))  )
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    //********************************************************************************************************
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
            x = locations.last!
            print("---------- update x location in maps -----------")
            
            
            if(signalZoom == 1){
                signalZoom = 0
                
                let camera = GMSCameraPosition.camera(withLatitude: (x.coordinate.latitude), longitude: (x.coordinate.longitude), zoom: 11)
                do {
                    // Set the map style by passing the URL of the local file. Make sure style.json is present in your project
                    if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                        mapv.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                    } else {
                        print("Unable to find style.json")
                    }
                } catch {
                    print("The style definition could not be loaded: \(error)")
                }
                
                
                self.mapv.camera = camera
                
                
            }
        
        
        
    }
    
    //********************************************************************************************************
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading heading: CLHeading) {
        if(x.coordinate.latitude != 0.0) && (x.coordinate.longitude != 0.0){
        if(signalZoom == 1){
            signalZoom = 0
            let camera = GMSCameraPosition.camera(withLatitude: (x.coordinate.latitude), longitude: (x.coordinate.longitude), zoom: 11)
            do {
                // Set the map style by passing the URL of the local file. Make sure style.json is present in your project
                if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                    mapv.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                } else {
                    print("Unable to find style.json")
                }
            } catch {
                //print("The style definition could not be loaded: \(error)")
            }
            
            
            self.mapv.camera = camera
            
        }
        }
 
     
        checkorio()
        
    }
    func checkorio(){
        switch UIApplication.shared.statusBarOrientation {
        case .portrait:
            print("face")
            break
        case .portraitUpsideDown:
            print("down")
            break
        case .landscapeLeft:
            print("left")
            break
        case .landscapeRight:
            print("right")
            break
        case .unknown:
            //default
            break
        }
    }
    
    func mapView(_ mapView:GMSMapView, didChange position: GMSCameraPosition)  {
        
        mapBearing = position.bearing
        marker.rotation = lastDriverAngleFromNorth - mapBearing
    }
    //********************************************************************************************************
    
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        mapv.isMyLocationEnabled = true
        let camera = GMSCameraPosition.camera(withLatitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!, zoom: 11)
        self.mapv.animate(to: camera)
        
        
    }
    
    //********************************************************************************************************
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        mapv.isMyLocationEnabled = true
        
        if (gesture) {
            mapView.selectedMarker = nil
        }
    }
    
    //********************************************************************************************************
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapv.isMyLocationEnabled = true
        print("tap Marker")
        return false
    }
    
    //********************************************************************************************************
    
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("COORDINATE \(coordinate)") // when you tapped coordinate
    }
    
    //********************************************************************************************************
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        mapv.isMyLocationEnabled = true
        mapv.selectedMarker = nil
        return false
    }
    
    //********************************************************************************************************
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error to get location : \(error)")
    }
    
    //********************************************************************************************************
    
    
    //********************************************************************************************************
    
    //********************************************************************************************************
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    //********************************************************************************************************
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func delay(seconds: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            closure()
        }
    }
    
    func UIDevice() {
        
        
        
        switch UIScreen.main.nativeBounds.height {
        case 960:
            

            print("iPhone4")
            return
        //.iPhone4
        case 1136:
            print("iPhones_5_5s_5c_SE")
            
            
            self.LO.thumbSize = CGSize(width: 18, height: 18)
            
            labenlignein.font = labenlignein.font.withSize(6)
            labhorsligne.font = labhorsligne.font.withSize(6)
            
            txtNomClient.font = txtNomClient.font.withSize(16)
            label1Minute.font = label1Minute.font.withSize(16)
            labseconde.font = labseconde.font.withSize(16)
            
            accepterrr.titleLabel?.font = accepterrr.titleLabel?.font.withSize(15)
            txtbar.font = txtbar.font.withSize(17)
            buttdeconnec.titleLabel?.font = buttdeconnec.titleLabel?.font.withSize(13)
            buttback.titleLabel?.font = buttback.titleLabel?.font.withSize(13)
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                DispatchQueue.main.async {
                    self.imgexterne.frame = CGRect(x: 0, y: 0, width: 190, height: 190)
                    self.imgexterne.center = self.viewRaduis.center
                    self.imginterne.frame = CGRect(x: 0, y: 0, width: 170, height: 170)
                    self.imginterne.center = self.viewRaduis.center
                    
                }}
            
            
            
            
            return
        //.iPhones_5_5s_5c_SE
        case 1334:
            print("iPhones_6_6s_7_8")
            
            self.LO.thumbSize = CGSize(width: 20, height: 20)
            
            
            return
        //.iPhones_6_6s_7_8
        case 1920, 2208:
            print("iPhones_6Plus_6sPlus_7Plus_8Plus")
            
            buttback.titleLabel?.font = buttback.titleLabel?.font.withSize(16)
           
            self.LO.thumbSize = CGSize(width: 23, height: 23)

            

            txtNomClient.font = txtNomClient.font.withSize(20)
            label1Minute.font = label1Minute.font.withSize(20)
            labseconde.font = labseconde.font.withSize(20)

            accepterrr.titleLabel?.font = accepterrr.titleLabel?.font.withSize(19)
            
            txtbar.font = txtbar.font.withSize(21)
            buttdeconnec.titleLabel?.font = buttdeconnec.titleLabel?.font.withSize(15)

            labenlignein.font = labenlignein.font.withSize(9)
            labhorsligne.font = labhorsligne.font.withSize(9)

                DispatchQueue.main.async {
                    self.imgexterne.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
                    self.imgexterne.center = self.viewRaduis.center
                    self.imginterne.frame = CGRect(x: 0, y: 0, width: 225, height: 225)
                    self.imginterne.center = self.viewRaduis.center

                }
            
            return
            
        case 2436:
            print("iphone x")
            
            self.LO.thumbSize = CGSize(width: 21, height: 21)
            
            let heightContraintsLO = NSLayoutConstraint(item: self.LO, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self.viewBar, attribute: NSLayoutAttribute.height, multiplier: 0.30, constant: 0)
            NSLayoutConstraint.activate([heightContraintsLO])
            print("hhhh", LO.frame.size.height)
            
            
             txtNomClient.font = labenlignein.font.withSize(18)
            

            return
            
        default:
            print("unknown")
            print("iPade")
            
            
            return
            //.unknown
        }
        
    }
    
    
    func showPageDemandeCourse() {
        
        chrono30munite = 15
        
        buttmylocation.isHidden = true
        buttMV.isHidden = true
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
        self.txtNomClient.text = "\(nonClient) \(prenomClient)".uppercased()
            }}
        
        
        viewAlpha.isHidden = false
        viewAlpha.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.addSubview(viewAlpha)
        

        viewRaduis.layer.cornerRadius = viewRaduis.frame.width / 2.0
        viewRaduis.layer.masksToBounds = true
        
       
        let Camera = GMSCameraPosition.camera(withLatitude: latDepart, longitude: lngDepart, zoom: 12)//7)
        
        do {
            // Set the map style by passing the URL of the local file. Make sure style.json is present in your project
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                viewRaduis.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                print("Unable to find style.json")
            }
        } catch {
            print("The style definition could not be loaded: \(error)")
        }
        self.viewRaduis.camera = Camera
        viewRaduis.clear()
       
                                            
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.byValue = -2 * CGFloat.pi
        rotation.duration = 4
        rotation.repeatCount = Float.greatestFiniteMagnitude // forever
        
        imgexterne.layer.add(rotation, forKey: "myAnimation")
        
        
        let rotation1 = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation1.byValue = 2 * CGFloat.pi
        rotation1.duration = 2
        rotation1.repeatCount = Float.greatestFiniteMagnitude // forever
        
        imginterne.layer.add(rotation1, forKey: "myAnimation")
        
        
        let pos = CLLocationCoordinate2D(latitude: latDepart, longitude: lngDepart)
        let marker = GMSMarker(position: pos)
        
        marker.title = adressdep
        marker.icon = UIImage(named: "ic_pt_depart1")
        marker.map = viewRaduis
        
        
        var duration: CFTimeInterval = 15
        
        duration = CFTimeInterval(15 - XIntervale)
        
        chrono30munite = Int(duration)
        
        DispatchQueue.main.async {
            self.label1Minute.text = "\(self.chrono30munite)"
        }
        
        self.refreshchrono1mun()
        XIntervale = 0
        
        viewinbutonaccept.isHidden = true
        self.VerifAccepter()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration ) {
            
            if(self.tapedbuttacepte == 0){
                
            self.viewAlpha.isHidden = true
            self.buttCompte.isHidden = false
            self.txtbar.isHidden = false
                
            self.VIEWPRCB.isHidden = false
            self.buttmylocation.isHidden = false
          
            self.buttMV.isHidden = false
            self.LO.isHidden = false
                
                
            
            if (accepter == 0){
                if(timerTest1?.isValid == false){
                timerTestVerifAccepter?.invalidate()
                print("&@@&@&@&@&@&@&@&&@&@&@&@  refuse Course &@&@&&@&&@&@&@&@")
                volume = "0"
                
                EnLigneMaps = 1
                refuser = 1
                notif = 0
                    notifBC = 0
                timerAudio?.invalidate()
                player?.stop()
                playerDelegate?.stop()
                    if(IDDriverRequest != -1){
                        if(frommaster == "1"){
                            self.SendRefusetoMaster(AttributAccepteRefuse: 6)
                        }else {
                            self.SendRefuse(AttributAccepteRefuse: 4)
                        }
                    
                    }else {
                        print("iddriverquest = -1")
                    }
                    
                }else{
                    print("not refuse last course")
                }
                
            }
            
        }}
            }
    
    
    func refreshchrono1mun(){
        timerTestchrono1 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MapsViewController.chrono), userInfo: nil, repeats: true)

    }
    func chrono(){
        if(chrono30munite < 1){
            timerTestchrono1?.invalidate()
            DispatchQueue.global(qos: .userInitiated).async {
                
                DispatchQueue.main.async {
                    self.label1Minute.text = " "
                }}
        }else{
            chrono30munite = chrono30munite - 1
            DispatchQueue.global(qos: .userInitiated).async {
                
                DispatchQueue.main.async {
                    self.label1Minute.text = "\(self.chrono30munite)"
                }}
        }
       
        
    }
    //********************************************************************************************************
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func VerifAccepter(){
        timerTestVerifAccepter = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MapsViewController.verif), userInfo: nil, repeats: true)
        
    }
    func verif(){
        if(accepter == 1){
            refuser = 0
            notif = 0
            
            timerTestVerifAccepter?.invalidate()
        }
        
        
            if(playerDelegate?.isPlaying)! && !(timerRunTime?.isValid)!{
                 AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                print("111")
            }else {
                print("3333")
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        
        
    }
    
    //**********************************************************************************************
    
    
    
    
    
    
    
    //********************************************************************************************************
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func sendStatut()
    {
        
        let statutdriver = "\(statut)"
        let tok = "\(token)"
     
        
        
        let postString = ["status":statutdriver]
        
        let url = NSURL(string: "\(weburl)/api/driver/updateStatus")
        let request = NSMutableURLRequest(url: url! as URL)
        
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            if error != nil
            {
               
                return
            }
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                print("fichier json", json)
                
                
                           }
            catch let error as NSError
            {
                print(error)
            }
        }
        task.resume()
        

    }
    
    
    
    func sendStatutHL()
    {
        
        let statutdriver = "2"
        let tok = "\(token)"
        
        
        
        let postString = ["status":statutdriver]
        
        let url = NSURL(string: "\(weburl)/api/driver/updateStatus")
        let request = NSMutableURLRequest(url: url! as URL)
        
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            if error != nil
            {
                DispatchQueue.global(qos: .userInitiated).async {
                    // Do long running task here
                    // Bounce back to the main thread to update the UI
                    DispatchQueue.main.async {
                       
                        self.SetOff = 1
                        self.LO.setOn(on: true, animated: true)
                        self.LO.isOn = true
                        self.LO.thumbTintColor = UIColor.white//init(red: 33/255, green: 255/255, blue: 09/255, alpha: 255)
                        self.viewSurLO.isHidden = true
                        
                        let appearance1 = SCLAlertView.SCLAppearance(
                            kCircleIconHeight: 45.0,
                            kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                            kTextFont: UIFont(name: "Roboto", size: 13)!,
                            kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                            showCloseButton: false
                        )
                        
                        // Initialize SCLAlertView using custom Appearance
                        let alertView = SCLAlertView(appearance: appearance1)
//                        alertView.addButton("OK"){
//                            alertView.dismiss(animated: true, completion: nil)
//                        }
                        
                        alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", duration: 2, colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                        
                    }}
                return
            }
            
            do
            {
                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                
                print("fichier json", json)
                    IDCAMION = "-2"
                    ListeIdCamion.removeAll()
                    ListeMatriculeCamion.removeAll()
                    ListeModeleCamion.removeAll()
                    ListeMarqueCamion.removeAll()
                    ListeVolumeCamion.removeAll()
                    print("liste id camion", ListeIdCamion)
                    
                    
                    
                if let status = json["status"]{
                    print(status)
                    DispatchQueue.global(qos: .userInitiated).async {
                        
                        DispatchQueue.main.async {
                            
                            
                            StatutGlobal = false
                            
                            self.LO.thumbTintColor = .white
                            self.time = 0
                            print(self.time)
                            AppDelegate().refreshLocationAPP()
                            
                            timerTest1?.invalidate()
                            EnLigneMaps = 0
                            self.viewSurLO.isHidden = true
                            self.viewenligne.isHidden = true
                            self.viewhorsligne.isHidden = false
                            if #available(iOS 9.0, *) {
                                self.locationManager.allowsBackgroundLocationUpdates = false
                            } else {
                                // Fallback on earlier versions
                            }
                            //self.locationManager.stopUpdatingLocation()
                        }}
                }else {
                    DispatchQueue.global(qos: .userInitiated).async {
                        
                        DispatchQueue.main.async {
                            

                            self.SetOff = 1
                            self.LO.setOn(on: true, animated: true)
                            self.LO.isOn = true
                            self.LO.thumbTintColor = UIColor.white
                            self.viewSurLO.isHidden = true
                            
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
//                            alertView.addButton("OK"){
//                                alertView.dismiss(animated: true, completion: nil)
//                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", duration: 2, colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }}
                }
                }else {
                    DispatchQueue.global(qos: .userInitiated).async {
                        
                        DispatchQueue.main.async {
                            
                                self.SetOff = 1
                                self.LO.setOn(on: true, animated: true)
                                self.LO.isOn = true
                                self.LO.thumbTintColor = UIColor.white
                                self.viewSurLO.isHidden = true
                            
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
//                            alertView.addButton("OK"){
//                                alertView.dismiss(animated: true, completion: nil)
//                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", duration: 2, colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }}
                }
            }
            catch let error as NSError
            {
                print(error)
            }
        }
        task.resume()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func buttdecconx(_ sender: Any) {
        DispatchQueue.global(qos: .userInitiated).async {
            
            DispatchQueue.main.async {
        self.stopAnimating()
            }}
        let appearance1 = SCLAlertView.SCLAppearance(
            kCircleIconHeight: 32.0,
            
            kTitleFont: UIFont(name: "Roboto-Bold", size: 14)!,
            kTextFont: UIFont(name: "Roboto-Light", size: 13)!,
            kButtonFont: UIFont(name: "Roboto-Light", size: 15)!,
            showCloseButton: false,
            showCircularIcon: true
            
        )
        
        // Initialize SCLAlertView using custom Appearance
        let alertView = SCLAlertView(appearance: appearance1)
        
        
        
        alertView.addButton("OUI", backgroundColor:UIColor.clear){
            let activityInd = NVActivityIndicatorView(frame: CGRect(x: self.xview - 25, y: self.yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
            
            NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
            NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
            NVActivityIndicatorView.DEFAULT_BLOCKER_MESSAGE_FONT = UIFont(name: Fontraleway, size: 18)!
            self.view.addSubview(activityInd)
            
            
            self.startAnimating(message: "Déconnexion...", type: NVActivityIndicatorType.ballRotateChase)
            
            
            if(timerTestAPP.isValid){
                timerTestAPP.invalidate()
            }
            if(timerTestAPP2.isValid){
                
                timerTestAPP2.invalidate()
            }
            
            if (timerTest3.isValid) {
                timerTest3.invalidate()
                
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
                
               self.sendlastStatus()
                
            }
        }
        
        alertView.addButton("NON", backgroundColor:UIColor.clear){
            alertView.dismiss(animated: true, completion: nil)
        }
        
        let color = UIColor(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
        
        // read colors to CGFloats and convert and position to proper bit positions in UInt32
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0.3
        var colorAsUInt : UInt32 = 0
        if color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            
            
            
            colorAsUInt += UInt32(red * 255.0) << 16 +
                UInt32(green * 255.0) << 8 +
                UInt32(blue * 255.0)
            
        }
        
        
        alertView.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        alertView.showError("Déconnexion ?", subTitle: "Souhaitez-vous vraiment vous déconnecter?", circleIconImage: UIImage(named: "logout"))
    }
    
    
   
    
    
    func sendlastStatus(){
        
        let statutdriver = "2"
        let tok = "\(token)"
        
        
        
        let postString = ["status":statutdriver]
        
        let url = NSURL(string: "\(weburl)/api/driver/updateStatus")
        let request = NSMutableURLRequest(url: url! as URL)
        
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            if error != nil
            {
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
                            self.sendlastStatus()
                        }
                        
                        alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                        
                    }}
                return
            }
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                print("fichier json", json)
                if let status = json["status"]{
                    print(status)
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            
                            self.sendrevoked()
                            
                        }}
                }else {
                    DispatchQueue.global(qos: .userInitiated).async {
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
                                self.sendlastStatus()
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }}
                }
                
            }
            catch let error as NSError
            {
                print(error)
            }
        }
        task.resume()
        
        
    }
    func sendrevoked()
    {
        print("******** revoked ***********")
        
        
        let tok = "\(token)"
        let url = NSURL(string: "\(weburl)/api/driver/logout")
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            if error != nil
            {
                
                DispatchQueue.global(qos: .userInitiated).async {
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
                       
                        DispatchQueue.main.async {
                            
                            keychain.clear()
                            let defaults = UserDefaults.standard
                            let dictionary = defaults.dictionaryRepresentation()
                            dictionary.keys.forEach { key in
                                defaults.removeObject(forKey: key)
                            }
                            
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
                            
                            timerTest1?.invalidate()
                            
                            deconnectstatut = 1
                            StatutGlobal = false
                            update = 0
                            VolumeTotale = 0
                            lOGIN = 0
                            self.locationManager.stopUpdatingLocation()
                            self.locationManager.stopUpdatingLocation()
                            self.locationManager.stopUpdatingHeading()
                            AppDelegate().renitialize()
                            UPDATE = 0
                            
                            
                            
                            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "idHome") as! ViewController
                            self.present(myVC, animated: false, completion: nil)
                            self.stopAnimating()
                            
                        }}
                }else {
                    DispatchQueue.global(qos: .userInitiated).async {
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
    
    //********************************************************************************************************
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
}


