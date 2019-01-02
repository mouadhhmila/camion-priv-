//
//  Maps2ViewController.swift
//  CamionPrivé
//
//  Created by Forest Cab
//  Copyright © 2018 Administrateur. All rights reserved.
////---------------------------------------------------------------------------------------
//----------------------------------|     \-------/     |----------------------------------
//----------------------------------|  |\  \-----/  /|  |----------------------------------
//----------------------------------|  |-\  \---/  /-|  |----------------------------------
//----------------------------------|  |--\  \-/  /--|  |----------------------------------
//----------------------------------|  |-------------|  |----------------------------------
//----------------------------------|  |-------------|  |----------------------------------
//----------------------------------|  |-------------|  |----------------------------------
//----------------------------------|  |-------------|  |----------------------------------
//-----------------------------------------------------------------------------------------



import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire
import MapKit
import PopoverSwift
import AMPopTip
import SCLAlertView
import NVActivityIndicatorView



var IMGCLIENT = String()
var SIZEBUTT = 17
var statutInMaps2 = true
var TermineCourse = 0
var opentel = 0


var imagesign = UIImage()
var menu_vc : MenuViewController = MenuViewController()

class Maps2ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, SlideButtonDelegate, NVActivityIndicatorViewable, SwiftSignatureViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let picker = UIImagePickerController()
    var image_camera = UIImage()
    
    var chrono = 60
    var cameraview = 0
    var press = 0
    var time = 0
    var i: UInt = 0
    var timer: Timer!
    var animationPolyline = GMSPolyline()
    var animationPath = GMSMutablePath()
    let polyline = GMSPolyline()
    var marker = GMSMarker()
    var path = GMSPath()
    var pathA = 0
    var inRoad = 0
    var timerZoom: Timer? = nil
    var timerArrival: Timer? = nil
    var timerDestinal: Timer? = nil
    var timerTestchrono: Timer? = nil
    var timerTestchrono2: Timer? = nil
    var cancelDrowPath = 0
    var locationManager = CLLocationManager()
    var pathslat:Double = 0.0
    var pathslong:Double = 0.0
    var latitude: CLLocationDegrees = 1
    var longitude: CLLocationDegrees = 0
    
    var marker1 = GMSMarker()
    var mark = GMSMarker()
    var mapBearing:CLLocationDirection = CLLocationDirection()
    var  lastDriverAngleFromNorth:CLLocationDirection = CLLocationDirection()
    var locationDepart = CLLocation(latitude: latDepart, longitude: lngDepart)
    var locationDestination = CLLocation(latitude: latArrive, longitude: lngArrive)
    var pos = CLLocationCoordinate2DMake(latDepart, lngDepart)
    var degrees = Float()
    var heightviewbar = 0.0
    var heightviewClient = 0.0
    
    let customView2 = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
    var timesroute = " "
    var latwaze = 0.0
    var lngwaze = 0.0
    var arrowVc = 0
    var heightviewContacter = CGFloat()
    var heightbuttcontacter = CGFloat()
    var yviewcontacter = CGFloat()
    var xviewcontacter = CGFloat()
    var xview = CGFloat()
    var yview = CGFloat()
    var alertcontacter = SCLAlertView()
    
    
    @IBOutlet weak var txtNC: UILabel!
    @IBOutlet weak var txtAdressDEp: UILabel!
    @IBOutlet weak var labdestin: UILabel!
    @IBOutlet weak var txtMinute: UILabel!
    @IBOutlet weak var viewBar: UIView!
    @IBOutlet weak var viewBaradress: UIView!
    @IBOutlet var mapv: GMSMapView!
    @IBOutlet weak var viewhid: UIView!
    @IBOutlet weak var buttArrive: UIButton!
    @IBOutlet weak var aaaaa: MMSlidingButton!
    @IBOutlet weak var txtdepdep: UILabel!
    @IBOutlet weak var txtdesdep: UILabel!
    @IBOutlet weak var viewCLIENT: UIView!
    @IBOutlet weak var labelClient: UILabel!
    @IBOutlet weak var viewCientR: ViewClient!
    @IBOutlet weak var buttwaze: UIButton!
    @IBOutlet weak var viewwaze: UIView!
    @IBOutlet weak var buttContact: UIButton!
    @IBOutlet weak var viewcontact: UIView!
    @IBOutlet weak var buttwaze2: UIButton!
    @IBOutlet weak var buttcontact2: UIButton!
    @IBOutlet weak var viewwaze2: UIView!
    @IBOutlet weak var viewcontact2: UIView!
    @IBOutlet weak var buttCommencer: UIButton!
    @IBOutlet weak var txtminuteCourse: UILabel!
    @IBOutlet weak var txtbar: UILabel!
    @IBOutlet weak var viewinfo: UIView!
    @IBOutlet weak var buttarrowright: UIButton!
    @IBOutlet weak var viewentreAC: UIView!
    @IBOutlet weak var viewgliss: UIView!
    @IBOutlet weak var buttvidsign: UIButton!
    @IBOutlet weak var txtNomClient: UILabel!
    @IBOutlet weak var txtveuillezsign: UILabel!
    @IBOutlet weak var labvotrecourse: UILabel!
    @IBOutlet weak var labvotreclientEntreAC: UILabel!
    @IBOutlet weak var viewsuraaaaa: UIView!
    @IBOutlet weak var viewsign: SwiftSignatureView!
    
    
    
    
    @IBAction func buttarrowrght(_ sender: Any) {
        self.viewinfo.isHidden = true
        self.viewgliss.isHidden = false
        }
    
    
    @IBAction func didTapClear() {
        viewsign.clear()
        self.viewsuraaaaa.isHidden = false
        
    }
    
    public func swiftSignatureViewDidTapInside(_ view: SwiftSignatureView) {
        print("Did tap inside")
    }
    
    public func swiftSignatureViewDidPanInside(_ view: SwiftSignatureView) {
        print("Did pan inside")
        
        self.viewsuraaaaa.isHidden = true
    }
    
    
 
    
    @IBAction func buttContacterr(_ sender: Any) {
        
        if(NUMTEL == " "){
            
            let appearance1 = SCLAlertView.SCLAppearance(
                kCircleIconHeight: 45.0,
                kTitleFont: UIFont(name: Fontraleway, size: 23)!,
                kTextFont: UIFont(name: Fontraleway, size: 20)!,
                kButtonFont: UIFont(name: Fontraleway, size: 20)!,
                showCloseButton: false
            )
            let alert = SCLAlertView(appearance: appearance1)
            
            alert.addButton("OK"){
                alert.dismiss(animated: true, completion: nil)
            }
            alert.showNotice("NOTICE", subTitle: "Vous n'avez pas le numéro du client.", colorStyle: 0x002c4c)
            
            
            
        }else {
      
        let appearance1 = SCLAlertView.SCLAppearance(
            kCircleIconHeight: 60.0,
            kTitleFont: UIFont(name: Fontraleway, size: 23)!,
            kTextFont: UIFont(name: Fontraleway, size: 20)!,
            kButtonFont: UIFont(name: Fontraleway, size: 20)!,
            
            showCloseButton: false
        )
        alertcontacter = SCLAlertView(appearance: appearance1)
        
        // Creat the subview
        let subview = UIView(frame: CGRect(x: 0, y: 0, width: 216, height: 50))
       
        // Add textfield 1
        let lab11 = UILabel(frame: CGRect(x: 0, y: 15, width: 216, height: 25))
        lab11.text = "\(NUMTEL)"
        lab11.textAlignment = NSTextAlignment.center
       // lab11.numberOfLines = 2
        lab11.isUserInteractionEnabled = false
        
        subview.addSubview(lab11)
        
        alertcontacter.customSubview = subview
        
        
        alertcontacter.addButton("Oui") {
            print("calling")
            self.makeAPhoneCall()
        }
        alertcontacter.addButton("Non"){
            self.alertcontacter.dismiss(animated: true, completion: nil)
        }
        alertcontacter.showInfo("Appeler", subTitle: "", colorStyle: 0x0396FF, circleIconImage: UIImage(named: "phone-flat"))
        
        let tapdismissalert: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissalert))
        view.addGestureRecognizer(tapdismissalert)
    }
    }
    
    func dismissalert(){
        alertcontacter.hideView()
    }
    func makeAPhoneCall()  {
       
        let link:String = "TEL://"
        let url:NSURL = NSURL(string: link)!
 
       if UIApplication.shared.canOpenURL(url as URL) {
 
         UIApplication.shared.openURL(NSURL(string: "TEL://\(NUMTEL)")! as URL)
         UIApplication.shared.isIdleTimerDisabled = true
 
         opentel = 1
       print(opentel)
        
 } else {
 
 }

    }
    
    @IBAction func buttCommencerr(_ sender: Any) {
        let activityInd = NVActivityIndicatorView(frame: CGRect(x: xview - 25, y: yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
        view.addSubview(activityInd)
        
        
        self.startAnimating(message: "", type: NVActivityIndicatorType.ballRotateChase)
        SendApi_Commencer(AttributCommencer: 5)
    }
    @IBAction func buttwaze(_ sender: Any) {
        
        let latitude:Double = latwaze
        let longitude:Double = lngwaze
        
        var link:String = "waze://"
        let url:NSURL = NSURL(string: link)!
        
        if UIApplication.shared.canOpenURL(url as URL) {
            
            let urlStr:NSString = NSString(format: "waze://?ll=%f,%f&navigate=yes",latitude, longitude)
            
            UIApplication.shared.openURL(NSURL(string: urlStr as String)! as URL)
            UIApplication.shared.isIdleTimerDisabled = true
            
            
        } else {
            link = "http://itunes.apple.com/us/app/id323229106"
            UIApplication.shared.openURL(NSURL(string: link)! as URL)
            UIApplication.shared.isIdleTimerDisabled = true
        }

    }
    
    @IBAction func buttwaze22(_ sender: Any) {
        let latitude:Double = latwaze
        let longitude:Double = lngwaze
        
        var link:String = "waze://"
        let url:NSURL = NSURL(string: link)!
        
        if UIApplication.shared.canOpenURL(url as URL) {
            
            let urlStr:NSString = NSString(format: "waze://?ll=%f,%f&navigate=yes",latitude, longitude)
            
            UIApplication.shared.openURL(NSURL(string: urlStr as String)! as URL)
            UIApplication.shared.isIdleTimerDisabled = true
            
            
        } else {
            link = "http://itunes.apple.com/us/app/id323229106"
            UIApplication.shared.openURL(NSURL(string: link)! as URL)
            UIApplication.shared.isIdleTimerDisabled = true
        }
    }
    @IBAction func buttcontacter22(_ sender: Any) {
        if(NUMTEL == " "){
            
            let appearance1 = SCLAlertView.SCLAppearance(
                kCircleIconHeight: 45.0,
                kTitleFont: UIFont(name: Fontraleway, size: 23)!,
                kTextFont: UIFont(name: Fontraleway, size: 20)!,
                kButtonFont: UIFont(name: Fontraleway, size: 20)!,
                showCloseButton: false
            )
            let alert = SCLAlertView(appearance: appearance1)
            
            alert.addButton("OK"){
                alert.dismiss(animated: true, completion: nil)
            }
            alert.showNotice("NOTICE", subTitle: "Vous n'avez pas le numéro du client.", colorStyle: 0x002c4c)
            
            
            
        }else {
            
            let appearance1 = SCLAlertView.SCLAppearance(
                kCircleIconHeight: 60.0,
                kTitleFont: UIFont(name: Fontraleway, size: 23)!,
                kTextFont: UIFont(name: Fontraleway, size: 20)!,
                kButtonFont: UIFont(name: Fontraleway, size: 20)!,
                
                showCloseButton: false
            )
            alertcontacter = SCLAlertView(appearance: appearance1)
            
            // Creat the subview
            let subview = UIView(frame: CGRect(x: 0, y: 0, width: 216, height: 50))
            
            // Add textfield 1
            let lab11 = UILabel(frame: CGRect(x: 0, y: 15, width: 216, height: 25))
            lab11.text = "\(NUMTEL)"
            lab11.textAlignment = NSTextAlignment.center
            // lab11.numberOfLines = 2
            lab11.isUserInteractionEnabled = false
            
            subview.addSubview(lab11)
            
            alertcontacter.customSubview = subview
            
            
            alertcontacter.addButton("Oui") {
                print("calling")
                self.makeAPhoneCall()
            }
            alertcontacter.addButton("Non"){
                self.alertcontacter.dismiss(animated: true, completion: nil)
            }
            alertcontacter.showInfo("Appeler", subTitle: "", colorStyle: 0x0396FF, circleIconImage: UIImage(named: "phone-flat"))
            
            let tapdismissalert: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissalert))
            view.addGestureRecognizer(tapdismissalert)
        }
    }
    
    @IBAction func buttonMenu(_ sender: Any) {
        if AppDelegate.menu_bool{
            showMenu()
            press = 1
        }else{
            closeMenu()
            press = 1
        }
        
    }
    
    //********************************************************************************************************

    
    //********************************************************************************************************
    
    @IBAction func buttDep(_ sender: Any) {
        let activityInd = NVActivityIndicatorView(frame: CGRect(x: xview - 25, y: yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
        view.addSubview(activityInd)
        
        
        self.startAnimating(message: "", type: NVActivityIndicatorType.ballRotateChase)
        SendApi_Arrive(AttributArrive: 4)
      
        
    }

    func SendApi_Arrive(AttributArrive: Int)
    {
        
        let DriverRequestID = IDDriverRequest
        let tok = "\(token)"
        
        
        let postString = ["status":"\(AttributArrive)", "DriverRequestId":"\(DriverRequestID)"] as [String : Any]
        
        let url = NSURL(string: "\(weburl)/api/driver/courseStatus")
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            print("&éé&é&é&é&///// SEND_API_AACT = \(AttributArrive) IDRqs:\(DriverRequestID)////&é&é&é&é&é&")
            
            
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
                                
                                alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                                
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
                                
                                alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                                
                            }
                            
                        }
                        
                }
                
                
                return
            }
            
            do
            {
                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                    
                  
                
                print("é&é&é&é&é \(json) *&é&é&&é&")
                    
 
                    
                
                DispatchQueue.main.async {
                    self.stopAnimating()
                    
                    let camera = GMSCameraPosition.camera(withLatitude: x.coordinate.latitude, longitude: x.coordinate.longitude, zoom: 12)
                    self.mapv.camera = camera
                    
                    self.inRoad = 0
                    
                    self.depart()
                    
                    self.viewCLIENT.isHidden = true
                    self.viewentreAC.isHidden = false
                    
                    
                    self.buttArrive.isUserInteractionEnabled = false
                    self.buttArrive.backgroundColor = UIColor.init(red: 181/255, green: 222/255, blue: 252/255, alpha: 1)
                    
                    keychain.set("1", forKey: "drvrid")
                    
                    self.aaaaa.isHidden = false
                    self.viewsuraaaaa.isHidden = false
                    
                    self.locationDepart = CLLocation(latitude: latArrive, longitude: lngArrive)
                    
                    
                    self.buttwaze2.isHidden = false
                    self.viewwaze2.isHidden = false
                    self.buttcontact2.isHidden = false
                    self.viewcontact2.isHidden = false
                    
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1) ) {
                    
                    self.buttCommencer.isHidden = false
                    
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
    
   
    
    
    func SendApi_Commencer(AttributCommencer: Int)
    {
        
        let DriverRequestID = IDDriverRequest
        let tok = "\(token)"
        
        
        let postString = ["status":"\(AttributCommencer)", "DriverRequestId":"\(DriverRequestID)"] as [String : Any]
        
        let url = NSURL(string: "\(weburl)/api/driver/courseStatus")
        let request = NSMutableURLRequest(url: url! as URL)
        
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            print("&éé&é&é&é&///// SEND_API_AACT = \(AttributCommencer) IDRqs:\(DriverRequestID)////&é&é&é&é&é&")
            
            
            
            
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
                
                
                
                return
            }
            
            do
            {
                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                
                print("é&é&é&é&é \(json) *&é&é&&é&")
 
                DispatchQueue.main.async {
                    self.stopAnimating()
                    self.txtMinute.isHidden = false

                }
                DispatchQueue.main.async {
                    
                self.viewCLIENT.isHidden = false
                self.viewentreAC.isHidden = true
                    
                self.timerTestchrono2?.invalidate()
                self.timerTestchrono?.invalidate()
                    
                keychain.set("1", forKey: "Direction")
                
                self.buttwaze2.isHidden = true
                self.viewwaze2.isHidden = true
                self.buttcontact2.isHidden = true
                self.viewcontact2.isHidden = true
                    
                    
                self.buttCommencer.isHidden = true
                self.buttwaze.isHidden = false
                
                self.enVoyage()
                self.press = 1
                self.cancelDrowPath = 0
             
                self.latwaze = latArrive
                self.lngwaze = lngArrive
                    
                    
                self.pathA = 0
                self.path = GMSPath()
                self.i = 0
                self.animationPolyline.map = nil
                self.polyline.map = nil
                self.polyline.path = self.path
                self.animationPolyline.path = self.path
                
                
                self.locationDepart = CLLocation(latitude: latArrive, longitude: lngArrive)
                self.pos = CLLocationCoordinate2DMake(latArrive, lngArrive)
                    
                print("buttdep:", self.pos)
                    
                self.txtAdressDEp.text = adressdes
                self.marker1.title = adressdes
                
                    let camera = GMSCameraPosition.camera(withLatitude: x.coordinate.latitude, longitude: x.coordinate.longitude, zoom: 16)
                    do {
                        // Set the map style by passing the URL of the local file. Make sure style.json is present in your project
                        if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                            self.mapv.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                        } else {
                            print("Unable to find style.json")
                        }
                    } catch {
                        print("The style definition could not be loaded: \(error)")
                    }
                    
                    self.mapv.camera = camera
                
                    self.refreshDestinal()
                    self.aaaaa.isHidden = false
                    self.viewsuraaaaa.isHidden = false
                    
                    self.drawPath(startLocation: x.coordinate, endLocation: self.locationDepart.coordinate)
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
    
    @IBAction func buttcancelcourse(_ sender: Any) {

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
            
            
            self.startAnimating(message: "Annulation...", type: NVActivityIndicatorType.ballRotateChase)
            
            self.SendApi_Annuler(AttributAnnuler: 3)
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
        
        alertView.showError("Annulation ?", subTitle: "Voulez-vous vraiment annuler la course?", circleIconImage: UIImage(named: "cancelx64"))
    }
    func SendApi_Annuler(AttributAnnuler: Int)
    {
        
        let DriverRequestID = IDDriverRequest
        let tok = "\(token)"
        
        
        let postString = ["status":"\(AttributAnnuler)", "DriverRequestId":"\(DriverRequestID)"] as [String : Any]
        
        let url = NSURL(string: "\(weburl)/api/driver/courseStatus")
        let request = NSMutableURLRequest(url: url! as URL)
        
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            print("&éé&é&é&é&///// SEND_API_AACT = \(AttributAnnuler) IDRqs:\(DriverRequestID)////&é&é&é&é&é&")
            
            
            
            
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
                
                
                return
            }
            
            do
            {
                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                
                print("é&é&é&é&é \(json) *&é&é&&é&")
                
                DispatchQueue.main.async {
                    self.stopAnimating()
                    
                    self.timerTestchrono2?.invalidate()
                    self.timerTestchrono?.invalidate()
                    
                }
                DispatchQueue.main.async {
                    
                
                
                
                self.locationManager.stopUpdatingHeading()
                self.locationManager.stopUpdatingLocation()
                if(StatutGlobal == true){
                    
                    self.sendStatutEL()
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
    func sendStatutEL()
    {
        
        let statutdriver = "1"
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
                        self.aaaaa.reset()
                        
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
                        
                    }}
                return
            }
            
            do
            {
                if  let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                
                print("fichier json", json)
                if let status = json["status"]{
                    print(status)
                    DispatchQueue.global(qos: .userInitiated).async {
                        // Do long running task here
                        // Bounce back to the main thread to update the UI
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            
                            
                            keychain.delete("InVoyage")
                            keychain.delete("Direction")
                            
                            keychain.delete("nomClient")
                            keychain.delete("prenomClient")
                            keychain.delete("adressdep")
                            keychain.delete("adressdes")
                            keychain.delete("volume")
                            
                            keychain.delete("lngDepart")
                            keychain.delete("latDepart")
                            keychain.delete("lngArrive")
                            keychain.delete("latArrive")
                            keychain.delete("drvrid")
                            keychain.delete("driverRequestId")
                            keychain.delete("numeroclient")
                            keychain.delete("numfacture")
                            keychain.delete("imgclient")
                            keychain.delete("tarif")
                            keychain.delete("datetime")
                            
                            
                            keychain.delete("aide")
                            keychain.delete("etage1")
                            keychain.delete("etage2")
                            keychain.delete("ascenseur1")
                            keychain.delete("ascenseur2")
                            keychain.delete("msg")
                            
                            if let nbrbgk = keychain.get("nbrbg"){
                                let nbrbgI = Int(nbrbgk)!
                                for i in 0 ..< nbrbgI{
                                    
                                    keychain.delete("databg\(i)")
                                    keychain.delete("datanbrbg\(i)")
                                }
                                keychain.delete("nbrbg")
                                
                            }
                            
                            IDDriverRequest = -1
                            notif = 0
                            notifBC = 0
                            volume = "0"
                            LastStatusGlobal = String()
                            self.locationManager.stopUpdatingLocation()
                            self.locationManager.stopUpdatingHeading()
                            if #available(iOS 9.0, *) {
                                self.locationManager.allowsBackgroundLocationUpdates = false
                            } else {
                                // Fallback on earlier versions
                            }
                            
                            let storyboard: UIStoryboard = UIStoryboard (name: "Main", bundle: nil)
                            let NewVC = storyboard.instantiateViewController(withIdentifier: "idMaps") as! MapsViewController
                            
                            
                            
                            
                            
                            self.present(NewVC, animated: false, completion: nil)
                            
                            
                        }}
                }else {
                    DispatchQueue.global(qos: .userInitiated).async {
                        // Do long running task here
                        // Bounce back to the main thread to update the UI
                        
                            DispatchQueue.main.async {
                                self.stopAnimating()
                                self.aaaaa.reset()
                                
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
                        
                        alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        
                        
                    }
                }
                
                }else {
                    DispatchQueue.global(qos: .userInitiated).async {
                        // Do long running task here
                        // Bounce back to the main thread to update the UI
                        
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            self.aaaaa.reset()
                            
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
                        
                        alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                        
                        
                        
                    }
                }
                
                
            }
            catch let error as NSError
            {
                print(error)
            }
        }
        task.resume()
        
        
    }
    
    func SendApi_Terminer(AttributTerminer: Int)
    {
        
        let DriverRequestID = IDDriverRequest
        let tok = "\(token)"
        
        
        let postString = ["status":"\(AttributTerminer)", "DriverRequestId":"\(DriverRequestID)"] as [String : Any]
        
        let url = NSURL(string: "\(weburl)/api/driver/courseStatus")
        let request = NSMutableURLRequest(url: url! as URL)
        
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            print("&éé&é&é&é&///// SEND_API_AACT = \(AttributTerminer) IDRqs:\(DriverRequestID)////&é&é&é&é&é&")
            
            
            
            
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
                        self.aaaaa.reset()
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
                            self.aaaaa.reset()

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
                            self.aaaaa.reset()

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
                
                
                return
            }
            
            do
            {
                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                
                print("é&é&é&é&é \(json) *&é&é&&é&")
                
                DispatchQueue.main.async {
                    //self.stopAnimating()
                    
                }
                DispatchQueue.main.async {
                    
                    
                    
                    self.locationManager.stopUpdatingHeading()
                    self.locationManager.stopUpdatingLocation()
                    if(StatutGlobal == true){
                        
                        self.sendStatutEL()
                    }
                    
                }
                }else {
                    
                    
                    
                    
                    
                    
                    DispatchQueue.main.async {
                        self.stopAnimating()
                        self.aaaaa.reset()
                        
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
            catch let error as NSError
            {
                print(error)
            }
        }
        task.resume()
    }
    
  
    
 
    //********************************************************************************************************
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewWillLayoutSubviews() {
        print("willlayout sub")

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("willapear")
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        closeMenu()
        heightviewbar = Double(viewBar.frame.height)
        
        heightviewClient = Double(viewCientR.frame.height)

        viewwaze.layer.shadowColor = UIColor.black.cgColor
        viewwaze.layer.shadowOpacity = 0.4
        viewwaze.layer.shadowOffset = .zero
        
        viewcontact.layer.shadowColor = UIColor.black.cgColor
        viewcontact.layer.shadowOpacity = 0.4
        viewcontact.layer.shadowOffset = .zero
        
        viewwaze2.layer.shadowColor = UIColor.black.cgColor
        viewwaze2.layer.shadowOpacity = 0.4
        viewwaze2.layer.shadowOffset = .zero
        
        viewcontact2.layer.shadowColor = UIColor.black.cgColor
        viewcontact2.layer.shadowOpacity = 0.4
        viewcontact2.layer.shadowOffset = .zero
        
        
        buttwaze.layer.cornerRadius = buttwaze.frame.height / 2
        viewwaze.layer.cornerRadius = viewwaze.frame.height / 2
        buttContact.layer.cornerRadius = buttContact.frame.height / 2
        viewcontact.layer.cornerRadius = viewcontact.frame.height / 2
        
        buttwaze2.layer.cornerRadius = buttwaze2.frame.height / 2
        viewwaze2.layer.cornerRadius = viewwaze2.frame.height / 2
        buttcontact2.layer.cornerRadius = buttcontact2.frame.height / 2
        viewcontact2.layer.cornerRadius = viewcontact2.frame.height / 2
        
        
        xview = view.center.x
        yview = view.center.y
        
        

          }
    
    
    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        //let imagea = UIImage(cgImage: (chosenImage.cgImage)!, scale: CGFloat(1.0), orientation: .right)
        image_camera = fixOrientation(img: chosenImage) //4
        print("envoie en cours...")

        let imageData1 = UIImageJPEGRepresentation(image_camera, 1)
        self.requestWith2(imageData: imageData1, parameters: ["DriverRequestId":IDDriverRequest])
        dismiss(animated:true, completion: nil) //5

    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)

    }
    
    func fixOrientation(img: UIImage) -> UIImage {
        if (img.imageOrientation == .up) {
            return img
        }
        
        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        img.draw(in: rect)
        
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return normalizedImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global(qos: .userInitiated).async {
            
            DispatchQueue.main.async {
          self.UIDevice()
          
                
            }}
        picker.delegate = self

        
        
        buttwaze2.isHidden = true
        viewwaze2.isHidden = true
        buttcontact2.isHidden = true
        viewcontact2.isHidden = true
        
        lOGIN = 1
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        UIApplication.shared.isIdleTimerDisabled = true

        
        self.viewsign.delegate = self
        
        deconnectstatut = 0
        
        
        buttCommencer.isHidden = true
        
        accepter = 1
        print("lllllM", EnLigneMaps)
        print("lllllP", EnLigneProfil)
        EnLigneMaps = 0
        EnLigneProfil = 0
        
        
        self.buttarrowright.isHidden = true
        
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.pausesLocationUpdatesAutomatically = false
        self.locationManager.startMonitoringSignificantLocationChanges()
        self.locationManager.stopUpdatingHeading()
        self.locationManager.startUpdatingHeading()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //self.locationManager.stopUpdatingLocation()
        self.locationManager.startUpdatingLocation()
            
        if #available(iOS 9.0, *) {
            self.locationManager.allowsBackgroundLocationUpdates = true
        } else {
            // Fallback on earlier versions
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: x.coordinate.latitude, longitude: x.coordinate.longitude, zoom: 16)
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
        
        menu_vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        
       
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
        
        ////////////////
        self.aaaaa.delegate = self
        aaaaa.isHidden = true
        self.viewsuraaaaa.isHidden = true
        self.viewentreAC.isHidden = true
        
        
        viewhid.isHidden = true
        self.buttArrive.isUserInteractionEnabled = false
        
        
        view.addSubview(viewBar)
        view.addSubview(viewBaradress)
        view.addSubview(viewCLIENT)
        
        viewBaradress.layer.shadowColor = UIColor.black.cgColor
        viewBaradress.layer.shadowOpacity = 0.2
        viewBaradress.layer.shadowOffset = .init(width: 0, height: 3)
        
        viewhid.layer.shadowColor = UIColor.black.cgColor
        viewhid.layer.shadowOpacity = 0.2
        viewhid.layer.shadowOffset = .init(width: 0, height: 3)
        
        view.addSubview(viewgliss)
        self.viewgliss.isHidden = true
        
        mapv.settings.rotateGestures = false
        
       
        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        mapv.padding = padding
        
        let swipedown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesturedownup))
        swipedown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipedown)
        let swipeup = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesturedownup))
        swipeup.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeup)
        
        
        
        latwaze = latDepart
        lngwaze = lngDepart
        txtAdressDEp.text = adressdep
        
        marker1.title = adressdep
        
        
        
        ////---------------------------------------------------------------------------------------
        //----------------------------------|     \-------/     |----------------------------------
        //----------------------------------|  |\  \-----/  /|  |----------------------------------
        //----------------------------------|  |-\  \---/  /-|  |----------------------------------
        //----------------------------------|  |--\  \-/  /--|  |----------------------------------
        //----------------------------------|  |-------------|  |----------------------------------
        //----------------------------------|  |-------------|  |----------------------------------
        //----------------------------------|  |-------------|  |----------------------------------
        //----------------------------------|  |-------------|  |----------------------------------
        //-----------------------------------------------------------------------------------------
        
        
        let InVoyage = keychain.get("InVoyage")
        let Direction = keychain.get("Direction")
        
        
        print("in v  \(String(describing: InVoyage))")
        print("in d \(String(describing: Direction))")
        
        if(InVoyage == nil){
            sendStatutEV()
            
            if(LastStatusGlobal == "3"){
                AppDelegate().refreshLocationAPP()
                UPDATE = 0
                LastStatusGlobal = String()
                
                
            }
            print(" n'existe pas course ??????????")
            print("??????????????????????????????")
            print("??????????????????????????????")
            print("??????????????????????????????")
            print("??????????????????????????????")
            
            keychain.set("1", forKey: "InVoyage")
            
            keychain.set(nonClient, forKey: "nomClient")
            keychain.set(prenomClient, forKey: "prenomClient")
            keychain.set(adressdep, forKey: "adressdep")
            keychain.set(adressdes, forKey: "adressdes")
            keychain.set(volume, forKey: "volume")
            keychain.set(NUMFACTURE, forKey: "numfacture")
            
            keychain.set("\(lngDepart)", forKey: "lngDepart")
            keychain.set("\(latDepart)", forKey: "latDepart")
            keychain.set("\(lngArrive)", forKey: "lngArrive")
            keychain.set("\(latArrive)", forKey: "latArrive")
            keychain.set("\(IDDriverRequest)", forKey: "driverRequestId")
            keychain.set("\(NUMTEL)", forKey: "numeroclient")
           
            
            if(TARIF == " "){
                print("tarif vide")
            }
            else{
                keychain.set("\(TARIF)", forKey: "tarif")
                
            }
            if(S_A_Aide == 0){
                
            }else {
                keychain.set("\(S_A_Aide)", forKey: "aide")
                keychain.set("\(EtageDep)", forKey: "etage1")
                keychain.set("\(Etagedest)", forKey: "etage2")
                keychain.set("\(Ascenseurdep)", forKey: "ascenseur1")
                keychain.set("\(Ascenseurdest)", forKey: "ascenseur2")
               
            }
            
            if(MSG == "<null>"){
                keychain.set("<null>", forKey: "msg")
            }else {
                keychain.set("\(MSG)", forKey: "msg")
            }
            
            
            if (press == 0){
                press = 1
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5) ) {
                    self.refreshArrival()
                    
                    self.drawPath(startLocation: x.coordinate, endLocation: self.locationDepart.coordinate)
                    
                }
            }
            
            print(" set in voyage")
            
            let nbrbg = "\(DataBagage.count)"
            keychain.set(nbrbg, forKey: "nbrbg")
            for i in 0 ..< DataBagage.count{
                keychain.set(DataBagage[i], forKey: "databg\(i)")
            }
            for i in 0 ..< DataNbrBagage.count{
                keychain.set(DataNbrBagage[i], forKey: "datanbrbg\(i)")
            }
            
            
            
            let datetime = Date()
            let calendar = Calendar.current
            
            let hour = calendar.component(.hour, from: datetime)
            let minutes = calendar.component(.minute, from: datetime)
            let seconds = calendar.component(.second, from: datetime)
            print("hours = \(hour):\(minutes):\(seconds)")
            let timedate = "\(hour):\(minutes):\(seconds)"
            HEURE = timedate
            keychain.set("\(HEURE)", forKey: "datetime")
            
        }else{
            
            if(LastStatusGlobal == "3"){
                
            }else{
                sendStatutEV()
            }
            
            print(" existe course  ????????????????")
            print("??????????????????????????????")
            print("??????????????????????????????")
            print("??????????????????????????????")
            print("??????????????????????????????")
            print("??????????????????????????????")
            
            StatutGlobal = true
            AppDelegate().refreshLocationAPP()
            
            let driverrequestid = keychain.get("driverRequestId")
            let driverrequestidKD = (driverrequestid! as NSString).intValue
            IDDriverRequest = Int(driverrequestidKD)
            
            let timedateget = keychain.get("datetime")
            HEURE = timedateget!
            
            
            if(Direction == nil){
                print(" before commencer ?????????????")
                print("??????????????????????????????")
                print("??????????????????????????????")
                print("??????????????????????????????")
                print("??????????????????????????????")
                
                let drvRid = keychain.get("drvrid")
                let nonClientK = keychain.get("nomClient")
                let prenomClientK = keychain.get("prenomClient")
                let adressdepk = keychain.get("adressdep")
                let adressdesK = keychain.get("adressdes")
                let volumeK = keychain.get("volume")
                let numFacturek = keychain.get("numfacture")
                
                if let SAAIDE = keychain.get("aide"){
                    S_A_Aide = Int(SAAIDE)!
                }
                if let etagdep = keychain.get("etage1"){
                    EtageDep = Int(etagdep)!
                }
                if let etagdes = keychain.get("etage2"){
                    Etagedest = Int(etagdes)!
                }
                if let ascdep = keychain.get("ascenseur1"){
                    Ascenseurdep = Int(ascdep)!
                }
                if let ascdest = keychain.get("ascenseur2"){
                    Ascenseurdest = Int(ascdest)!
                }
                
                if let msg = keychain.get("msg"){
                    MSG = msg
                    
                }
                
                if let tarf = keychain.get("tarif"){
                    TARIF = tarf
                    
                }
                
                if let nbrbgk = keychain.get("nbrbg"){
                    let nbrbgI = Int(nbrbgk)!
                    for i in 0 ..< nbrbgI{
                        
                        DataBagage.append(keychain.get("databg\(i)")!)
                        DataNbrBagage.append(keychain.get("datanbrbg\(i)")!)
                    }
                    
                }
                
                
                
                nonClient = nonClientK!
                prenomClient = prenomClientK!
                adressdep = adressdepk!
                adressdes = adressdesK!
                volume = volumeK!
                NUMFACTURE = numFacturek!
                
                
                let lngDepartK = keychain.get("lngDepart")
                let latDepartk = keychain.get("latDepart")
                let lngArriveK = keychain.get("lngArrive")
                let latArriveK = keychain.get("latArrive")
                let numclient = keychain.get("numeroclient")
                
                

                
                let lngDepartKD = (lngDepartK! as NSString).doubleValue
                
                let latDepartkD = (latDepartk! as NSString).doubleValue
                
                let lngArriveKD = (lngArriveK! as NSString).doubleValue
                
                let latArriveKD = (latArriveK! as NSString).doubleValue
                
                lngDepart = lngDepartKD
                latDepart = latDepartkD
                lngArrive = lngArriveKD
                latArrive = latArriveKD
                NUMTEL = numclient!
                
                txtAdressDEp.text = adressdep
                marker1.title = adressdep
                locationDepart = CLLocation(latitude: latDepart, longitude: lngDepart)
                
                if(drvRid == nil){
                    latwaze = latDepart
                    lngwaze = lngDepart
                    print(" before arriver ???????????????")
                    print("??????????????????????????????")
                    print("??????????????????????????????")
                    print("??????????????????????????????")
                    print("??????????????????????????????")
                    
                    if (press == 0){
                        press = 1
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5) ) {
                            self.refreshArrival()
                            self.drawPath(startLocation: x.coordinate, endLocation: self.locationDepart.coordinate)
                            
                        }
                    }
                }else{
                    print("between arriver and commencer ")
                    print("??????????????????????????????")
                    print("??????????????????????????????")
                    print("??????????????????????????????")
                    print("??????????????????????????????")
                    

                    print("TTTTTTTT\(TARIF)")
                    
                    self.viewhid.isHidden = false
                    self.viewBaradress.isHidden = true
                    
                    self.txtMinute.text? = "arrivé dans 0 min"
                    
                    self.txtMinute.textColor = UIColor.white
                    self.txtNomClient.textColor = UIColor.white
                    txtdepdep.text = adressdep
                    txtdesdep.text = adressdes
                    
                    polyline.map = nil
                    
                    let camera = GMSCameraPosition.camera(withLatitude: x.coordinate.latitude, longitude: x.coordinate.longitude, zoom: 12)
                    self.mapv.camera = camera
                    
                    self.inRoad = 0
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3) ) {
                        
                        self.buttCommencer.isHidden = false
                        
                    }
                    
                    self.locationDepart = CLLocation(latitude: latArrive, longitude: lngArrive)
                    
                    self.viewCLIENT.isHidden = true
                    self.viewentreAC.isHidden = false
                    
                    self.buttwaze2.isHidden = false
                    self.viewwaze2.isHidden = false
                    self.buttcontact2.isHidden = false
                    self.viewcontact2.isHidden = false
                }
                
            }else{
                print("after commencer ??????????????")
                print("??????????????????????????????")
                print("??????????????????????????????")
                print("??????????????????????????????")
                print("??????????????????????????????")
                let nonClientK = keychain.get("nomClient")
                let prenomClientK = keychain.get("prenomClient")
                let adressdepk = keychain.get("adressdep")
                let adressdesK = keychain.get("adressdes")
                let volumeK = keychain.get("volume")
                let numclient = keychain.get("numeroclient")
                let numFacturek = keychain.get("numfacture")

                nonClient = nonClientK!
                prenomClient = prenomClientK!
                adressdep = adressdepk!
                adressdes = adressdesK!
                volume = volumeK!
                NUMFACTURE = numFacturek!
                
                self.viewentreAC.isHidden = true
                
                if let SAAIDE = keychain.get("aide"){
                    S_A_Aide = Int(SAAIDE)!
                }
                if let etagdep = keychain.get("etage1"){
                    EtageDep = Int(etagdep)!
                }
                if let etagdes = keychain.get("etage2"){
                    Etagedest = Int(etagdes)!
                }
                if let ascdep = keychain.get("ascenseur1"){
                    Ascenseurdep = Int(ascdep)!
                }
                if let ascdest = keychain.get("ascenseur2"){
                    Ascenseurdest = Int(ascdest)!
                }
                
                if let msg = keychain.get("msg"){
                    MSG = msg
                    
                }
                
                if let tarf = keychain.get("tarif"){
                    TARIF = tarf
                }
                
                if let nbrbgk = keychain.get("nbrbg"){
                    let nbrbgI = Int(nbrbgk)!
                    for i in 0 ..< nbrbgI{
                        
                        DataBagage.append(keychain.get("databg\(i)")!)
                        DataNbrBagage.append(keychain.get("datanbrbg\(i)")!)
                    }
                    
                }
                
                let lngDepartK = keychain.get("lngDepart")
                let latDepartk = keychain.get("latDepart")
                let lngArriveK = keychain.get("lngArrive")
                let latArriveK = keychain.get("latArrive")
                
                
                let lngDepartKD = (lngDepartK! as NSString).doubleValue
                
                let latDepartkD = (latDepartk! as NSString).doubleValue
                
                let lngArriveKD = (lngArriveK! as NSString).doubleValue
                
                let latArriveKD = (latArriveK! as NSString).doubleValue
                
                lngDepart = lngDepartKD
                latDepart = latDepartkD
                lngArrive = lngArriveKD
                latArrive = latArriveKD
                
                NUMTEL = numclient!

                keychain.set("1", forKey: "Direction")
                
                buttCommencer.isHidden = true
                
                enVoyage()
                press = 1
                cancelDrowPath = 0
                
                
                refreshDestinal()
                self.aaaaa.isHidden = false
                self.viewsuraaaaa.isHidden = false
                
                latwaze = latArrive
                lngwaze = lngArrive
                
                pathA = 0
                path = GMSPath()
                i = 0
                animationPolyline.map = nil
                polyline.map = nil
                polyline.path = path
                animationPolyline.path = path
                locationDepart = CLLocation(latitude: latArrive, longitude: lngArrive)
                
                pos = CLLocationCoordinate2DMake(latArrive, lngArrive)
                print("buttdep:", pos)
                txtAdressDEp.text = adressdes
                
                marker1.title = adressdes
                DispatchQueue.main.async {
                self.drawPath(startLocation: x.coordinate, endLocation: self.locationDepart.coordinate)
                }
                print(locationDepart)
            }
        }
        
        
        
        ////---------------------------------------------------------------------------------------
        //----------------------------------|     \-------/     |----------------------------------
        //----------------------------------|  |\  \-----/  /|  |----------------------------------
        //----------------------------------|  |-\  \---/  /-|  |----------------------------------
        //----------------------------------|  |--\  \-/  /--|  |----------------------------------
        //----------------------------------|  |-------------|  |----------------------------------
        //----------------------------------|  |-------------|  |----------------------------------
        //----------------------------------|  |-------------|  |----------------------------------
        //----------------------------------|  |-------------|  |----------------------------------
        //-----------------------------------------------------------------------------------------
        
        self.getdrawPath(startLocation: (x.coordinate), endLocation: locationDepart.coordinate)
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            DispatchQueue.main.async {
                self.txtMinute.text? = "arrivé dans \(self.timesroute)"
                self.txtminuteCourse.text = "\(self.timesroute)"
            }}
        
        txtNomClient.text = "\(nonClient) \(prenomClient)".uppercased()
        txtNC.text = "\(nonClient) \(prenomClient)".uppercased()
        
        
        buttArrive.layer.shadowColor = UIColor.init(red: 177/255, green: 182/255, blue: 186/255, alpha: 1).cgColor
        buttArrive.layer.shadowOpacity = 0.3
        buttArrive.layer.shadowOffset = .zero
        
        buttCommencer.layer.shadowColor = UIColor.init(red: 177/255, green: 182/255, blue: 186/255, alpha: 1).cgColor
        buttCommencer.layer.shadowOpacity = 0.3
        buttCommencer.layer.shadowOffset = .zero
        
        
            DispatchQueue.main.async {
                self.aaaaa.layer.shadowColor = UIColor.white.cgColor
                self.aaaaa.layer.shadowOpacity = 1
                self.aaaaa.layer.shadowOffset = .zero
                
                self.viewCientR.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.9)
                
                self.viewgliss.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.9)
                
                self.viewsuraaaaa.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.3)
            }
    
    }
    
    func sendStatutEV()
    {
        
        let statutdriver = "3"
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
                            self.sendStatutEV()
                        }
                        
                        alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                        
                    }}
                return
            }
            
            do
            {
                if  let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                
                print("fichier json", json)
                if let status = json["status"]{
                    print(status)
                    
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
                                self.sendStatutEV()
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }}
                }
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
                                self.sendStatutEV()
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
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
    
    //********************************************************************************************************
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //********************************************************************************************************
    
    func refreshArrival(){
        timerArrival = Timer.scheduledTimer(timeInterval: 4
            , target: self, selector: #selector(self.Arrival), userInfo: nil, repeats: true)
    }
    func Arrival(){
        let coordinate0 = CLLocation(latitude: x.coordinate.latitude, longitude: x.coordinate.longitude)
        let coordinate1 = CLLocation(latitude: latDepart, longitude: lngDepart)
        let DInMeters = coordinate0.distance(from: coordinate1)
        if (DInMeters < 100) || DInMeters > 100{
            print("hello, camion arrive ")
            timerArrival?.invalidate()
            
            self.buttArrive.isUserInteractionEnabled = true
            self.buttArrive.backgroundColor = UIColor.init(red: 5/255, green: 150/255, blue: 254/255, alpha: 1)
            self.buttArrive.isHidden = false
            
        }
    }
    func refreshDestinal(){
        timerDestinal = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.Destinal), userInfo: nil, repeats: true)
    }
    func Destinal(){
        let coordinate0 = CLLocation(latitude: x.coordinate.latitude, longitude: x.coordinate.longitude)
        let coordinate1 = CLLocation(latitude: latArrive, longitude: lngArrive)
        let DInMeters = coordinate0.distance(from: coordinate1)
        if (DInMeters < 100) || DInMeters > 100   {
            timerDestinal?.invalidate()
            
            self.press = 0
            print("mouadh")
            self.aaaaa.isHidden = false
            self.viewsuraaaaa.isHidden = false
            self.buttarrowright.isHidden = false
            self.buttArrive.isHidden = true

        }
    }
    
    func depart() {
       
        self.viewhid.isHidden = false
        self.viewBaradress.isHidden = true
        self.txtMinute.text? = "arrivé dans 0 min"
        self.txtMinute.textColor = UIColor.white
        self.txtNomClient.textColor = UIColor.white
        txtdepdep.text = adressdep
        txtdesdep.text = adressdes
        polyline.map = nil
        
    }
    
    //********************************************************************************************************
    
    func enVoyage() {
        
        marker1.title = adressdes
        self.viewhid.isHidden = true
        self.viewBaradress.isHidden = false
        self.buttArrive.isHidden = true
        
    }
    
    //********************************************************************************************************
    
    //********************************************************************************************************
   
    
    //********************************************************************************************************
    
    func showMenu() {
        self.view.addSubview(menu_vc.view)
        menu_vc.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: CGFloat(self.heightviewbar), width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)

        UIView.animate(withDuration: 0.4 , animations: {
            ()->Void in
            
            menu_vc.view.frame = CGRect(x: 0, y: CGFloat(self.heightviewbar), width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            menu_vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            self.addChildViewController(menu_vc)
        })
        
        
        
        AppDelegate.menu_bool = false
        let tapCloseMenu: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.closeMenu))
        menu_vc.viewclosemenu.addGestureRecognizer(tapCloseMenu)
        
    }
    
    //********************************************************************************************************
    
    func closeMenu() {
        
        UIView.animate(withDuration: 0.4, animations: {
            ()->Void in
            menu_vc.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: CGFloat(self.heightviewbar), width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            
        }) { (finished) in
            
            menu_vc.view.removeFromSuperview()
        }
        AppDelegate.menu_bool = true
    }
    
    //********************************************************************************************************
    
    func respondToGesture(gesture : UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.right:
            print("right")
            if(AppDelegate.menu_bool == false){
                print("nn")
            }else{
                //showMenu()
            }
           
        case UISwipeGestureRecognizerDirection.left:
            print("left")
            closeMenu()
        default:
            break
        }
        
    }
    func respondToGesturedownup(gesture : UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.down:
            print("down")
            //down()
        case UISwipeGestureRecognizerDirection.up:
            print("up")
            //up()
        default:
            break
        }
        
    }

    
    //********************************************************************************************************
    
    func drawPath(startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D)
    {
        pathslat = 0.0
        pathslong = 0.0
        
        let origin = "\(startLocation.latitude),\(startLocation.longitude)"
        let destination = "\(endLocation.latitude),\(endLocation.longitude)"
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&sensor=false&mode=\("DRIVING")&key=\(googleAPIKey1)"
        
        
        Alamofire.request(url).responseJSON { response in
            
            
            print("Update Polyline", response.result as Any)
            
            let json = JSON(data: response.data!)
            let routes = json["routes"].arrayValue
            
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                
                
                self.path = GMSPath.init(fromEncodedPath: points!)!
                
                self.polyline.map = nil
                self.polyline.path = self.path
                
                self.polyline.strokeWidth = 3.0
                self.polyline.strokeColor = UIColor.init(red: 03/255, green: 150/255, blue: 1, alpha: 1)
                self.polyline.userData = "root"
                self.polyline.map = self.mapv
                
            }
            
        }
    }
    func getdrawPath(startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D)
    {
        
        let origin = "\(startLocation.latitude),\(startLocation.longitude)"
        let destination = "\(endLocation.latitude),\(endLocation.longitude)"
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&sensor=false&mode=\("DRIVING")&key=\(googleAPIKey1)"

        Alamofire.request(url).responseJSON { response in
            
            
            print("Update time", response.result as Any)
            //print(response)
           
            if let result = (try? JSONSerialization.jsonObject(with: response.data!, options: [])) as? [String:Any], let routes = result["routes"] as? [[String:Any]], let route = routes.first,
            let legs = route["legs"] as? [[String:Any]], let leg = legs.first,
            let duration = leg["duration"] as? [String:Any], let durationText = duration["text"] as? String{
             print("duration", durationText)
                self.timesroute = durationText
            }
            }
    }
    
    //********************************************************************************************************
    func animatePolylinePath() {
        if (self.i < self.path.count()) {
            self.animationPath.add(self.path.coordinate(at: self.i))
            self.animationPolyline.path = self.animationPath
            self.animationPolyline.strokeWidth = 4
            let redYellow = GMSStrokeStyle.gradient(from: .blue, to: .black)
            animationPolyline.spans = [GMSStyleSpan(style: redYellow, segments:10)]
            self.animationPolyline.map = self.mapv
            self.i += 1
        }
        else {
            
            self.polyline.map = self.mapv
            animationPath = GMSMutablePath()
            self.animationPolyline.map = nil
            pathA = 1
            timer.invalidate()
            inRoad = 1
            cancelDrowPath = 1
        }
        
        
    }
    
    //********************************************************************************************************
    
    
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newSize.width, height: newSize.height))  )
        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    //********************************************************************************************************
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("---------- update x location in maps 2 -----------")
        x = locations.last!
        
        
        let position = CLLocationCoordinate2DMake((x.coordinate.latitude), (x.coordinate.longitude))
        marker.position = position
        marker.title = "vous êtes ici"
        marker.icon = self.imageWithImage(image: UIImage(named: "ic_truck1")!, scaledToSize: CGSize(width: 18.0, height: 35.0))
        marker.map = mapv
        
        mapv.animate(toLocation: CLLocationCoordinate2D(latitude: x.coordinate.latitude, longitude: x.coordinate.longitude))
        
        marker1.position = pos
        marker1.icon = UIImage(named: "ic_pt_arrive")
        marker1.map = mapv
        
        self.getdrawPath(startLocation: (x.coordinate), endLocation: locationDepart.coordinate)

        
        DispatchQueue.global(qos: .userInitiated).async {
            
            DispatchQueue.main.async {
                self.txtMinute.text? = "arrivé dans \(self.timesroute)"
                self.txtminuteCourse.text = "\(self.timesroute)"
            }}
        if(cameraview == 0){
            cameraview = 1
        
        let camera = GMSCameraPosition.camera(withLatitude: x.coordinate.latitude, longitude: x.coordinate.longitude, zoom: 16)
        do {
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
        
        print("time route", self.timesroute)
        
    }
    
    //********************************************************************************************************
    
    func moveCamera(marker:GMSMarker){
    }
    
    //********************************************************************************************************
    
    
    func degreesToRadians(degrees: Double) -> Double { return degrees * .pi / 180.0 }
    
    //********************************************************************************************************
    
    func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / .pi }
    
    //********************************************************************************************************
    
    func getBearingBetweenTwoPoints1(point1 : CLLocation, point2 : CLLocation) -> Double {
        
        let lat1 = degreesToRadians(degrees: point1.coordinate.latitude)
        let lon1 = degreesToRadians(degrees: point1.coordinate.longitude)
        
        let lat2 = degreesToRadians(degrees: point2.coordinate.latitude)
        let lon2 = degreesToRadians(degrees: point2.coordinate.longitude)
        
        let dLon = lon2 - lon1
        
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        var radiansBearing = atan2(y, x)
        
        if(radiansBearing<0){
            radiansBearing = -radiansBearing
        } else {
            
            radiansBearing = 360 - radiansBearing
            
        }
        degrees = Float(radiansBearing)
        
        return radiansToDegrees(radians: radiansBearing)
    }
    
    //********************************************************************************************************
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading heading: CLHeading) {
        
        
        let direction:CLLocationDirection = heading.trueHeading
        lastDriverAngleFromNorth = direction
        mapv.animate(toBearing: heading.trueHeading)
        
    }
    
    //********************************************************************************************************
    func delay(seconds: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            closure()
        }
    }
    
    //********************************************************************************************************
    
    func mapView(_ mapView:GMSMapView, didChange position: GMSCameraPosition)  {
        
        mapBearing = position.bearing
        marker.rotation = lastDriverAngleFromNorth - mapBearing
    }
    
    //********************************************************************************************************
    
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        mapv.isMyLocationEnabled = true
        
        
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
    
    
    func sideBarSelectButtonAtIndex(_ index: Int) {
        
    }
    //********************************************************************************************************

    
    @IBAction func butttake_photo(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        } else {
            noCamera()
        }
        
    }
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    //********************************************************************************************************
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
    
    func buttonStatus(status: String, sender: MMSlidingButton) {
        
        
        self.buttvidsign.isHidden = true
        
        imagesign = UIImage.imageWithView(view: viewsign)
        
        self.buttvidsign.isHidden = false
        
        
        let activityInd = NVActivityIndicatorView(frame: CGRect(x: xview - 25, y: yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
        view.addSubview(activityInd)
        
        
        self.startAnimating(message: "", type: NVActivityIndicatorType.ballRotateChase)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            
            print("driverrequestid", IDDriverRequest)
            let imageData = UIImageJPEGRepresentation(imagesign, 1)
            self.requestWith(imageData: imageData, parameters: ["DriverRequestId":IDDriverRequest])
        }
        
        
    }
    
    
    func requestWith( imageData: Data?, parameters: [String : Any], onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
         let tok = "\(token)"
        let url = NSURL(string: "\(weburl)/api/driver/signature")
        
        
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + tok,
            "Accept": "application/json",
            "Content-type": "multipart/form-data"
            
        ]
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if let data = imageData{
                multipartFormData.append(data, withName: "image", fileName: "The_death.png", mimeType: "image/png")
            }
            
        }, usingThreshold: UInt64.init(), to: url! as URL, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    print("debug", response)
                    self.SendApi_Terminer(AttributTerminer: 2)
                    
                    onCompletion?(nil)
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                onError?(error)
                let imageData = UIImageJPEGRepresentation(imagesign, 1)
                self.requestWith(imageData: imageData, parameters: ["DriverRequestId":IDDriverRequest])
            }
        }
    }
    
    func requestWith2( imageData: Data?, parameters: [String : Any], onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        let tok = "\(token)"
        let url = NSURL(string: "\(weburl)/api/driver/photocasse")
        
        
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + tok,
            "Accept": "application/json",
            "Content-type": "multipart/form-data"
            
        ]
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if let data = imageData{
                multipartFormData.append(data, withName: "image", fileName: "The_death.png", mimeType: "image/png")
            }
            
        }, usingThreshold: UInt64.init(), to: url! as URL, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    print("debug", response)
                    
                    onCompletion?(nil)
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                onError?(error)
                let imageData = UIImageJPEGRepresentation(imagesign, 1)
                self.requestWith(imageData: imageData, parameters: ["DriverRequestId":IDDriverRequest])
            }
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
            SIZEBUTT = 15
            
            labdestin.font = labdestin.font.withSize(16)
            txtAdressDEp.font = txtAdressDEp.font.withSize(14)
            txtNomClient.font = txtNomClient.font.withSize(14)
            txtMinute.font = txtMinute.font.withSize(15)
            txtdepdep.font = txtdepdep.font.withSize(14)
            txtdesdep.font = txtdesdep.font.withSize(14)
            labelClient.font = labelClient.font.withSize(15)
            buttCommencer.titleLabel?.font = buttCommencer.titleLabel?.font.withSize(14)
            buttArrive.titleLabel?.font = buttArrive.titleLabel?.font.withSize(14)
            
            buttvidsign.titleLabel?.font.withSize(11)
            txtveuillezsign.font = txtveuillezsign.font.withSize(11)
            
            labvotrecourse.font = labvotrecourse.font.withSize(16)
            txtminuteCourse.font = txtminuteCourse.font.withSize(16)
            
            txtbar.font = txtbar.font.withSize(17)
            
            labvotreclientEntreAC.font = labvotreclientEntreAC.font.withSize(15)
            txtNC.font = txtNC.font.withSize(17)
            
            sizeT = 13
            
            return
        //.iPhones_5_5s_5c_SE
        case 1334:
            print("iPhones_6_6s_7_8")
            
            
            return
        //.iPhones_6_6s_7_8
        case 1920, 2208:
            print("iPhones_6Plus_6sPlus_7Plus_8Plus")
            SIZEBUTT = 22
            
            labdestin.font = labdestin.font.withSize(20)
            txtAdressDEp.font = txtAdressDEp.font.withSize(17)
            
            txtNomClient.font = txtNomClient.font.withSize(20)
            txtMinute.font = txtMinute.font.withSize(18)
            txtdepdep.font = txtdepdep.font.withSize(20)
            txtdesdep.font = txtdesdep.font.withSize(20)
            labelClient.font = labelClient.font.withSize(18)
           
            buttCommencer.titleLabel?.font = buttCommencer.titleLabel?.font.withSize(18)
            buttArrive.titleLabel?.font = buttArrive.titleLabel?.font.withSize(18)
            
            
            buttvidsign.titleLabel?.font.withSize(15)
            txtveuillezsign.font.withSize(14)
            
             labvotrecourse.font = labvotrecourse.font.withSize(20)
            txtminuteCourse.font = txtminuteCourse.font.withSize(20)
            
            txtbar.font = txtbar.font.withSize(22)
            
            labvotreclientEntreAC.font = labvotreclientEntreAC.font.withSize(19)
            txtNC.font = txtNC.font.withSize(21)
            
            sizeT = 16
            
            return
        //.iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            print("iphone x")
            
            
            return
        //.iPhoneX
        default:
            print("unknown")
            print("iPade")
           
            
            
            return
        }
    }
}



extension UIImage {
    class func imageWithView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
