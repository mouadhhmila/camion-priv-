//
////  CamionPrivé
//
//  Created by Forest Cab
//  Copyright © 2018 Administrateur. All rights reserved.
//
//--------------------------------------------------------------------------------------------
//----------------------------------IIIIIIII--------IIIIIIII----------------------------------
//----------------------------------IIII-IIII------IIII-IIII------------$$$-----$$$-----------
//----------------------------------IIII--IIII----IIII--IIII------------$$$-----$$$-----------
//----------------------------------IIII---IIII--IIII---IIII------------$$$$$$$$$$$-----------
//----------------------------------IIII----------------IIII------------$$$$$$$$$$$-----------
//----------------------------------IIII----------------IIII------------$$$-----$$$-----------
//----------------------------------IIII----------------IIII------------$$$-----$$$-----------
//----------------------------------IIII----------------IIII----------------------------------
//--------------------------------------------------------------------------------------------


import UIKit
import GoogleMaps
import GooglePlaces
import UserNotifications
import Alamofire
import KeychainSwift
import AVFoundation
import SCLAlertView
import AudioToolbox
import MediaPlayer
import Darwin

//**********************************************************************************************
//**********************************************************************************************



var frommaster = "0"
var fromPush = 0
var IDDriverRequest = -1
var Fontraleway = "Roboto"
var TOKEN = String()
var x = CLLocation()
let keychain = KeychainSwift()
var weburl = "https://www.camionprive.fr"
//http://192.168.1.10/camionprive1/public"


//https://www.camionprive.fr



//**********************************************************************************************
//**********************************************************************************************
var lOGIN = 0
var Place = 0
var notif = 0
var notifBC = 0
var nbr = 0
var open = 0
var send = 0
var accepter = 0
var EnLigneMaps = 0
var EnLigneProfil = 0
var EnLigneRevenu = 0
var closeProfil = 0
var closeMaps = 0
var closeRevenu = 0
var timerRunTime: Timer? = nil
var XIntervale = 0
var playerDelegate: AVAudioPlayer?
var testExistNot = false
var testExistNotLogout = false
var testExistAlert = false
var alertViewCxt = SCLAlertView()
var after30 = 0
var googleAPIKey1 = "AIzaSyCFudi7Ajot7iwgn6YvK3QwJAno2LJD3Y4"

                  //"AIzaSyBvoqpg-4GgNH_2zWhMeju4unOr3RNUR7g"//non payé

                  //"AIzaSyB3CY3cdx0rSVcf84dlGaFdfvO-2yGNUHY"non payé
                  //"AIzaSyCFudi7Ajot7iwgn6YvK3QwJAno2LJD3Y4"payé
//**********************************************************************************************
//**********************************************************************************************

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    static var menu_bool = true
    static var opencell = true
    
    var player1: AVAudioPlayer?
    var playerkill: AVAudioPlayer?
    
    var backgroundUpdateTask: UIBackgroundTaskIdentifier!
    
    var bgtimer = Timer()
    var bgtimer2 = Timer()
    
    var googleAPIKey = "AIzaSyDJQDVBr2qtSqnTdQX97vCH9tpZsejBEZs"
    
    //"AIzaSyB3CY3cdx0rSVcf84dlGaFdfvO-2yGNUHY"
    //AIzaSyBvoqpg-4GgNH_2zWhMeju4unOr3RNUR7g

    let kUrlSceme = "http://www.google.com"
    
    var runningLog: String = ""
    
    let localNotification1: UILocalNotification = UILocalNotification()
    let localNotification2: UILocalNotification = UILocalNotification()
    
    
    var lastLocation:CLLocation?
    
    var locationManager = CLLocationManager()
    
    //**********************************************************************************************
    //**********************************************************************************************
    
    var initialViewControllerlogout :UIViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        
        
        
       if(bgtimer.isValid || bgtimer2.isValid){
        bgtimer.invalidate()
        bgtimer2.invalidate()
        
        }
        
        
                let lauchedbefore = UserDefaults.standard.bool(forKey: "lauchedBefore")
        
                       if lauchedbefore {
                        
                             print("cbon")
                        
                       }else {
                        
                        UserDefaults.standard.set(true, forKey: "lauchedBefore")
                            keychain.clear()
                        
                        }
        
        GMSServices.provideAPIKey(googleAPIKey1)
        
        UIApplication.shared.applicationIconBadgeNumber = 0
       //UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {(permissionGranted, error) in
                //print (error as Any)
                DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
                    
                }
                print("gggggg")
                
            }
                 }
        
        if #available(iOS 9, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
            print("ios9")
        }
        if #available(iOS 8, *) {
            
            let notificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            
            UIApplication.shared.registerUserNotificationSettings(notificationSettings)

           
            print("ios8")
        }
        else {
            application.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
        }
        
        if #available(iOS 10.0, *) {
        
        let category = UNNotificationCategory(identifier: "customContentIdentifier", actions: [], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
            
        } else {
            // Fallback on earlier versions
        }
        
        let TOKEN = keychain.get("MyTokenDriver")
        print("hello in app delegate",TOKEN as Any)
        
        if (TOKEN?.isEmpty == false){
            
            
            let namee = keychain.get("LastnameDriver")
            let firstnamee = keychain.get("NameDriver")
            if(namee?.isEmpty == false){
                if(firstnamee?.isEmpty == false){
                    names = namee!
                    firstname = firstnamee!
                    print("get name et firstname")
                }
                
            }
            print(true)
            token = TOKEN!
            
        }
        
        do{
            playerDelegate = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "newtone", ofType: "mp3")!))
            playerDelegate?.prepareToPlay()
            playerDelegate?.volume = 1
            
            let audioSesion = AVAudioSession.sharedInstance()
            do{
                try audioSesion.setCategory(AVAudioSessionCategoryPlayback)
            }
            catch{
                
            }
            
        }
        catch{
            print(error)
        }
        
        do{
            playerkill = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "noti2018", ofType: "mp3")!))
            playerkill?.prepareToPlay()
            
            let audioSesion2 = AVAudioSession.sharedInstance()
            do{
                try audioSesion2.setCategory(AVAudioSessionCategoryPlayback)
            }
            catch{
                
            }
            
        }
        catch{
            print(error)
        }
         //MapsViewController().sendStatutHL()
       // InscriViewController().Sendrevoked()
       
        return true
    }
   
    
    // Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        // Print it to console
        print("APNs device token: \(deviceTokenString)")
        
        // Persist it in your backend in case it's new
    }
    
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }
    
    // Push notification received
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        // Print notification payload data
        print("Push notification received: \(data)")
       
        
        
    }
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        print("will finich launch")
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo)
        print("rrr")
        fromPush = 1
        
//        let volumeView = MPVolumeView()
//        if let view = volumeView.subviews.first as? UISlider{
//            view.value = 1
//        }
      
    
    }
    func BG(_ block: @escaping ()->Void) {
        DispatchQueue.global(qos: .default).async(execute: block)
        
        
    }
   
    
    func scheduleNotification(){
        
        if #available(iOS 10.0, *) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "vous avez une course"
        content.body = ""//vous avez une course de M./.Mr \(nonClient) du \(adressdep) à \(adressdes)"
        //content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "customContentIdentifier"//"camionCategory"
        
        let request = UNNotificationRequest(identifier: "camionNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) { (error:Error?) in
            if let error = error {
                print("error\(error.localizedDescription)")
            }
            
        }
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    
    func sendLocalNotif6() {
        
        if #available(iOS 10.0, *) {
            let notification = UNMutableNotificationContent()
        
        notification.title = "Attention"
        notification.subtitle = "l'application est fermée"
        notification.body = "vous devez rester en ligne"
        //notification.sound = UNNotificationSound.default()
        
            let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(identifier: "notification1", content: notification, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
            }
    else {
    // Fallback on earlier versions
    }
    }
    
    func soundNotification(){
        
        if #available(iOS 10.0, *) {
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let content = UNMutableNotificationContent()
            content.title = "Attention"
            content.subtitle = "l'application est fermée"
            content.body = "vous devez rester en ligne"
            content.badge = 1
            //content.sound = UNNotificationSound(named: "ios_notification.mp3")
            let request = UNNotificationRequest(identifier: "azanSoon", content: content, trigger: trigger)
           // UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UNUserNotificationCenter.current().add(request) {(error) in
                if let error = error {
                    print("error: \(error)")
                }
            }
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        } else {
            // Fallback on earlier versions
            print("ok")
        }
        
    }
    
    
    
    func sendLocalNotiferreurC() {
        if(testExistNot == false){
            playernot?.play()
            testExistNot = true
        if #available(iOS 10.0, *) {
            let notification = UNMutableNotificationContent()
            
            notification.title = ""
            notification.subtitle = "Vérifier internet"
            
            notification.body = ""
            //notification.sound = UNNotificationSound.default()
            
            let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(identifier: "notification123", content: notification, trigger: notificationTrigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
        }
        else {
            // Fallback on earlier versions
        }
        }
    }
    func sendLocalNotiflogout() {
        if(testExistNotLogout == false){
            playernot?.play()
            testExistNotLogout = true
            if #available(iOS 10.0, *) {
                let notification = UNMutableNotificationContent()
                
                notification.title = ""
                notification.subtitle = "Désolé, votre session a expiré"
                
                notification.body = "veillez reconnecter s'il vous plaît"
                //notification.sound = UNNotificationSound.default()
                
                let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                let request = UNNotificationRequest(identifier: "notification123", content: notification, trigger: notificationTrigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                
            }
            else {
                // Fallback on earlier versions
            }
        }
    }
    
   func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let tabBarController = window?.rootViewController as? UITabBarController,
            let viewControllers = tabBarController.viewControllers
        {
            for viewController in viewControllers {
                if let fetchViewController = viewController as? MapsViewController {
                    fetchViewController.fetch {
                       // fetchViewController.updateUI()
                        completionHandler(.newData)
                        
                        
                    }
                }else{
                    print("what happened !")
                }
            }
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
       print("foreground go")
        timerRunTime?.invalidate()
        UIApplication.shared.applicationIconBadgeNumber = 0
    after30 = 1
        timerRunTime?.invalidate()
            if(bgtimer.isValid || bgtimer2.isValid){
                bgtimer.invalidate()
                bgtimer2.invalidate()
            timerRunTime?.invalidate()
            if (XIntervale > 15){
                notif = 0
                print("chchcf")
                
            }else if (XIntervale != 0) && (XIntervale < 15){
                print("cgcgcgcf")
                
                notif = 1
                
                
            }else{
                print("GMGMGMf")
                if(notifBC == 1){
                    notif = 1
                }else {
                notif = 0
                }
            }
            
            refreshLocationAPP()
            
            print("ggggf")
            }
        print("from fg ---------- notifbg", notifBC)
        print("from fg ---------- notif", notif)
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        opentel = 0
       
        if(lOGIN == 1){
        if StatutGlobal == true{
        print("Entering Backgroundtrue")
        self.doBackgroundTask()
        }else{
             print("Entering Backgroundfalse")
            //doBackgroundTask2()
        }
        }else {
            print("notlogin")
        }
        print("from BG ---------- notifbg", notifBC)
        print("from BG ---------- notif", notif)
    }
//    func doBackgroundTask2() {
//        print("do background")
//
//        DispatchQueue.global().async {
//
//            if(timerTestAPP.isValid){
//                timerTestAPP.invalidate()
//            }
//            if(timerTestAPP2.isValid){
//
//                timerTestAPP2.invalidate()
//            }
//
//            self.beginBackgroundUpdateTask()
//
//
//            self.StartupdateLocation()
//
//
//            self.bgtimer2 = Timer.scheduledTimer(timeInterval:10, target: self, selector: #selector(AppDelegate.bgtimer2(_:)), userInfo: nil, repeats: true)
//            RunLoop.current.add(self.bgtimer2, forMode: RunLoopMode.defaultRunLoopMode)
//            RunLoop.current.run()
//
//            self.endBackgroundUpdateTask()
//
//        }
//    }
    func doBackgroundTask() {
            print("do background")
            
            DispatchQueue.global().async {
                if(timerTestAPP.isValid){
                    timerTestAPP.invalidate()
                }
                if(timerTestAPP2.isValid){
                    
                    timerTestAPP2.invalidate()
                }
            self.beginBackgroundUpdateTask()
                

            self.StartupdateLocation()
            
            
            self.bgtimer = Timer.scheduledTimer(timeInterval:3, target: self, selector: #selector(AppDelegate.bgtimer(_:)), userInfo: nil, repeats: true)
            RunLoop.current.add(self.bgtimer, forMode: RunLoopMode.defaultRunLoopMode)
            RunLoop.current.run()
            
            self.endBackgroundUpdateTask()
            
            }
        
    }
    func beginBackgroundUpdateTask() {
        self.backgroundUpdateTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            self.endBackgroundUpdateTask()
        })
    }
    
    func endBackgroundUpdateTask() {
        UIApplication.shared.endBackgroundTask(self.backgroundUpdateTask)
        self.backgroundUpdateTask = UIBackgroundTaskInvalid
    }
    
    func StartupdateLocation() {
       
    }
    

//    @objc func bgtimer2(_ timer:Timer!){
//
//
//        if UIApplication.shared.applicationState == .active {
//            timer.invalidate()
//
//            print("gggg2")
//        }else{
//            print("hhhh2")
//        }
//        updateLoc2()
//    }
    
    @objc func bgtimer(_ timer:Timer!){
        
        
        if UIApplication.shared.applicationState == .active {
            timer.invalidate()
       
            print("gggg")
        }else{
            print("hhhh")
        }
        updateLoc()
    }
    
    
    func updateLoc(){
        print("I'm here !")
        show()
        showlatt1()
        
    }
    
//    func updateLoc2(){
//        print("I'm here !  updateLoc2 ")
//
//        showlatt2()
//    }
    
    
    func show(){
        print("in APPLatt1")
        if(XIntervale > 15){
            if(after30 == 0){
                after30 = 1
            playerDelegate?.stop()
                if(frommaster == "1"){
                    self.SendRefuseCoursetomaster(AttributAccepteRefuse: 6)
                }else {
              self.SendRefuseCourse(AttributAccepteRefuse: 4)
                    
                }
            
                
            }
        }
        if (notifBC == 1) {
            after30 = 0
            notifBC = 0
            notif = 0
            
            
            
            
    print("0000000000000000000000000000000000000000000000000000000000000000000000000000000")
            
            
//            let volumeView = MPVolumeView()
//            if let view = volumeView.subviews.first as? UISlider{
//                view.value = 1
//
//            }
            DispatchQueue.global(qos: .userInitiated).async {
                DispatchQueue.main.async {
            playerDelegate?.stop()
                    playerDelegate?.currentTime = 0
            playerDelegate?.play()
                }}
            self.scheduleNotification()
            
            refreshRunTime()
         
        }
}
    
    
    func refreshRunTime() {
        XIntervale = 0
        timerRunTime = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(AppDelegate.RunTime), userInfo: nil, repeats: true)
    }
    func RunTime(){
        XIntervale += 1
        print(XIntervale)
        if(playerDelegate?.isPlaying)!{
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
    
    
    
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        if(StatutGlobal == true){
            
            playerkill?.play()

            print("termined")
            let InVoyage = keychain.get("InVoyage")

            if(InVoyage?.isEmpty == true){
                //sendStatutwhenkill()
            }
            //sendLocalNotif6()
            soundNotification()
            
        }

        print("termined")
        
    }
   
    
    
    
    
    
    
    func sendStatutwhenkill()
    {
        let statt = 2
        let statutdriver = "\(statt)"
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
    func sendLocalNotif() {
        DispatchQueue.main.async {
            self.localNotification1.alertAction = "Attention" // 2
            self.localNotification1.alertBody = ("l'application est fermée, vous devez rester actif") // 3
            self.localNotification1.fireDate = NSDate(timeIntervalSinceNow: 0) as Date // 4
            self.localNotification1.category = "status" // 5
            self.localNotification1.userInfo = [ "cause": "inactiveMembership"]
            self.localNotification1.shouldGroupAccessibilityChildren = true
            self.localNotification1.soundName = "default"
            UIApplication.shared.scheduleLocalNotification(self.localNotification1)
        }
    }
    func sendLocalNotif1() {
        
        DispatchQueue.main.async {
            
            
            self.localNotification2.alertAction = "" // 2
            self.localNotification2.alertBody = ("vous avez une course de M./.Mr \(nonClient) \(prenomClient) du \(adressdep) à \(adressdes)") // 3
            self.localNotification2.fireDate = NSDate(timeIntervalSinceNow: 0) as Date // 4
            self.localNotification2.category = "status" // 5
            self.localNotification2.userInfo = [ "cause": "inactiveMembership"]
            self.localNotification2.shouldGroupAccessibilityChildren = true
            self.localNotification2.soundName = "default"
            
            
            self.localNotification2.applicationIconBadgeNumber = 1
            
            UIApplication.shared.scheduleLocalNotification(self.localNotification2)
        }
        
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
     
        if(StatutGlobal == true){
            
            if(opentel == 0){
               print("resign111")
            }else{
                print("resign222")
                print("last open 1 devient 0")
                
            }
            
         
        }
        
      
            
    }
  
  
    
  
    
   
    
    //-*********************************************************************************************
    //-*********************************************************************************************
    //-*********************************************************************************************
    //-*********************************************************************************************
    //-*********************************************************************************************
    //-*********************************************************************************************
    func SendRefuseCoursetomaster(AttributAccepteRefuse: Int)
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
            
            print("**********///// SEND ACCEPTE OR REFUSE to master = \(AttributAccepteRefuse) IDRqs:\(DriverRequestID)////*************")
            
            
            
            
            if error != nil
            {
                self.SendRefuseCoursetomaster(AttributAccepteRefuse: 6)
                return
            }
            
            do
            {
                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                    
                    print("************* \(json) *************")
                    
                    if let Result = json["status"]{
                        let result = Result as! NSNumber
                        //0 course effectue a autre driver
                        if(result == 0){
                            
                        }
                        else{
                            
                        }
                        IDDriverRequest = -1
                        timerRunTime?.invalidate()
                        frommaster = "0"
                    }else {
                        self.SendRefuseCoursetomaster(AttributAccepteRefuse: 6)
                    }
                    
                    
                    
                }else {
                    self.SendRefuseCoursetomaster(AttributAccepteRefuse: 6)
                }
            }
            catch let error as NSError
            {
                print(error)
            }
        }
        task.resume()
    }
    
    
    
    func SendRefuseCourse(AttributAccepteRefuse: Int)
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
            
            print("**********///// SEND ACCEPTE OR REFUSE = \(AttributAccepteRefuse) IDRqs:\(DriverRequestID)////*************")
            
            
            
            
            if error != nil
            {
                self.SendRefuseCourse(AttributAccepteRefuse: 4)
                return
            }
            
            do
            {
                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                
                print("************* \(json) *************")
                
                if let Result = json["status"]{
                    let result = Result as! NSNumber
                    //0 course effectue a autre driver
                    if(result == 0){
                        
                    }
                    else{
                        
                    }
                    IDDriverRequest = -1
                    timerRunTime?.invalidate()
                }else {
                    self.SendRefuseCourse(AttributAccepteRefuse: 4)
                }
                
                    
             
                }else {
                    self.SendRefuseCourse(AttributAccepteRefuse: 4)
                }
            }
            catch let error as NSError
            {
                print(error)
            }
        }
        task.resume()
    }
    
    
    func Send1CourseSonore(AttributAccepteRefuse: Int)
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
            
            print("**********///// send 1'ere course sonore = \(AttributAccepteRefuse) IDRqs:\(DriverRequestID)////*************")
            
            
            
            
            if error != nil
            {
                self.Send1CourseSonore(AttributAccepteRefuse: 2)
                return
            }
            
            do
            {
                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                    
                    print("************* \(json) *************")
                    
                    if let Result = json["status"]{
                        print(Result)
                       
                    }else {
                        self.Send1CourseSonore(AttributAccepteRefuse: 2)
                    }
                    
                    
                    
                }else {
                    self.Send1CourseSonore(AttributAccepteRefuse: 2)
                }
            }
            catch let error as NSError
            {
                print(error)
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
//    func showlatt2()
//    {
//        //notif = notif - 1
//        let longitude = "\(x.coordinate.longitude)"
//        //let longitude = "11.110046"
//        let lattitude = "\(x.coordinate.latitude)"
//        //let lattitude = "33.521198"
//        let tok = "\(token)"
//        
//        
//        
//        let postString = ["lng":longitude, "lat":lattitude]
//        
//        let url = NSURL(string: "\(weburl)/api/driver/driverPosition")
//        let request = NSMutableURLRequest(url: url! as URL)
//        
//        
//        request.httpMethod = "POST"
//        
//        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
//        
//        
//        let task = URLSession.shared.dataTask(with: request as URLRequest)
//        {(data,response,error) -> Void in
//            
//            print("**********************///// SEND ////*************************")
//            print("++++++++ lattitude: \(lattitude) + longitude: \(longitude) +++++++++")
//            print("------------------     Chaque 10 seconde   -------------------")
//            print("**************************(  From APP Back hors ligne )**********************")
//            
//           
//            
//            if error != nil
//            {
//                print("problème seveur")
//              
//                return
//            }
//            
//            do
//            {
//                
//                if   let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
//                    
//                    print("************* \(json) *******************************************")
//                    if let messagee = json["message"]{
//                        print(messagee)
//                        let Attributmsg = messagee as! String
//                        if(Attributmsg == "Unauthenticated."){
//                            
//                            keychain.clear()
//                            let defaults = UserDefaults.standard
//                            let dictionary = defaults.dictionaryRepresentation()
//                            dictionary.keys.forEach { key in
//                                defaults.removeObject(forKey: key)
//                            }
//                            
//                            DispatchQueue.global(qos: .userInitiated).async {
//                                DispatchQueue.main.async {
//                                    UserDefaults.standard.set(true, forKey: "lauchedBefore")
//                                    self.renitialize()
//                                    
//                                    
//                                    self.sendLocalNotiflogout()
//                                    
//                                    let storyboard: UIStoryboard = UIStoryboard (name: "Main", bundle: nil)
//                                    let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "idConnection") as! ConnexionViewController
//                                    
//                                    let currentController = self.getCurrentViewController()
//                                    currentController?.present(vc, animated: false, completion: nil)
//                                    
//                                    
//                                }}
//                            
//                            
//                            
//                            
//                        }else {
//                            print("exeption")
//                        }
//                    }
//                }
//                
//                
//                
//                
//            }
//            catch let error as NSError
//            {
//                print(error)
//               
//            }
//        }
//        task.resume()
//        
//        
//        
//        
//        
//        
//        
//    }
    func showlatt1()
    {
        //notif = notif - 1
        let longitude = "\(x.coordinate.longitude)"
        //let longitude = "11.110046"
        let lattitude = "\(x.coordinate.latitude)"
        //let lattitude = "33.521198"
        let tok = "\(token)"
        
        
        
        let postString = ["lng":longitude, "lat":lattitude]
        
        let url = NSURL(string: "\(weburl)/api/driver/driverPosition")
        let request = NSMutableURLRequest(url: url! as URL)
        
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            print("**********************///// SEND ////*************************")
            print("++++++++ lattitude: \(lattitude) + longitude: \(longitude) +++++++++")
            print("------------------     Chaque 4 seconde   -------------------")
            print("**************************(  From APP Back  en ligne)**********************")
            
            //  print ("lllaaaattttINAPP:", lattitude)
            // print ("llonnnggggINAPP:", longitude)
            // print ("refuser:", refuser)
            
            if error != nil
            {
                print("problème seveur")
                    DispatchQueue.main.async {
                        let status = Reach().connectionStatus()
                        switch status {
                        case .unknown, .offline:
                            print("Not connected")
                            
                           
                            
                                            
                         //All requests have already been checked and notification with identifier wasn't found. Do stuff.
                         self.sendLocalNotiferreurC()
                            
                                        
                            
                           
                            
                        case .online(.wwan):
                            print("Connected via WWAN")
                            
                            
                        case .online(.wiFi):
                            print("Connected via WiFi")
                            
                            
                        }}
                return
            }
            
            do
            {
                
                if   let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                    
                    print("************* \(json) *******************************************")
                    
                    
                    testExistNot = false
                    
                    
                    if let status_chauffeur = json["status"] {
                        
                        let result_status = self.checkNull(obj: status_chauffeur as AnyObject)
                        
                        
                        
                        
                        if(result_status == true){
                            //notif = 0
                            print("status vide")
                        }
                        else{
                            let key_status = status_chauffeur as! NSNumber
                            if(key_status == 2){
                                set_OFF_HL = 1
                                StatutGlobal = false
                                if(self.bgtimer.isValid || self.bgtimer2.isValid){
                                    self.bgtimer.invalidate()
                                    self.bgtimer2.invalidate()
                                }
                            }
                        }
                        
                        
                        
                    }else{
                        print("no status")
                    }
                    if     let notification = json["notification"] as? NSDictionary {
                        
                        let total = notification["DriverRequestId"]
                        
                        let resulttotal = self.checkNull(obj: total as AnyObject)
                        
                        if(resulttotal == true){
                            //notif = 0
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
                            
                            
                            
//                            adressdep = notification["adrdep"] as! String
//                            adressdes = notification["adrarriv"] as! String
                                
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
                                
                                
                                
                                DataBagage.removeAll()
                                DataNbrBagage.removeAll()
                                //- Début parsing liste des objets
                                
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
                                
                                //- fin Parsing liste obj
                                
                                
                                
                                
                                
                                frommaster = "0"
                                if let fromM = notification["from_master"]{
                                    
                                    
                                    let frmmmm = String(describing: fromM)
                                    if(frmmmm == "1"){
                                        frommaster = "1"
                                    }else {
                                        frommaster = "0"
                                    }
                                    
                                }else{
                                    print("frommaster n'existe pas")
                                }
                                
                                
                            if(UIApplication.shared.applicationState == .active ){
                                
                                notif = 1
                            }else {
                                notifBC = 1
                                notif = 1
                                }
                                
                            
                            //timerTestAPP?.invalidate()
                            
                            print("dep x:", latDepart)
                            print("dep y:", lngDepart)
                            print("arr x:", LatArrive)
                            print("arr y:", lngArrive)
                                self.Send1CourseSonore(AttributAccepteRefuse: 2)
                            }else {
                                print("in back 2 eme notification")
                            }
                        }
                        
                    }else if let messagee = json["message"]{
                        print(messagee)
                        let Attributmsg = messagee as! String
                        if(Attributmsg == "Unauthenticated."){
                            
                            keychain.clear()
                            let defaults = UserDefaults.standard
                            let dictionary = defaults.dictionaryRepresentation()
                            dictionary.keys.forEach { key in
                                defaults.removeObject(forKey: key)
                            }
                            
                            DispatchQueue.global(qos: .userInitiated).async {
                                DispatchQueue.main.async {
                                    UserDefaults.standard.set(true, forKey: "lauchedBefore")
                                    self.renitialize()
                                    
                                    
                                    self.sendLocalNotiflogout()
                                    
                                    let storyboard: UIStoryboard = UIStoryboard (name: "Main", bundle: nil)
                                    let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "idConnection") as! ConnexionViewController
                                    
                                    let currentController = self.getCurrentViewController()
                                    currentController?.present(vc, animated: false, completion: nil)
                                    
                            
                        }}
                            
                            
                        }else {
                            print("exeption")
                        }
                
                    }else{
                        print("no notif in json")
                    }
                    
                }else{
                    print("no json")
                }
                
                
                
                
            }
            catch let error as NSError
            {
                print(error)
                let alert = UIAlertController(title: "", message: "impossible de se connecter", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ignorer", style: .cancel, handler: nil))
                
                print("show alert")
                UIViewController().present(alert, animated: false)
            }
        }
        task.resume()
        
        
        
        
        
        
        
    }
    
    func refreshLocationAPP(){
        if(StatutGlobal == true){
            if(timerTestAPP2.isValid){
                timerTestAPP2.invalidate()
                print("fermé 2")
            }
            timerTestAPP = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(AppDelegate.send_coordinate), userInfo: nil, repeats: true)

        }else{
            if(timerTestAPP.isValid){
                timerTestAPP.invalidate()
                print("fermé 1")
            }
            //timerTestAPP2 = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(AppDelegate.showlatt), userInfo: nil, repeats: true)

        }
        
        
    }
    func send_coordinate()
    {
        
        
        
        
        //notif = notif - 1
        let longitude = "\(x.coordinate.longitude)"
        //let longitude = "11.110046"
        let lattitude = "\(x.coordinate.latitude)"
        //let lattitude = "33.521198"
        let tok = "\(token)"
        
        
        
        let postString = ["lng":longitude, "lat":lattitude]
        
        let url = NSURL(string: "\(weburl)/api/driver/driverPosition")
        let request = NSMutableURLRequest(url: url! as URL)
        
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            print("**********************///// SEND ////*************************")
            print("++++++++ lattitude: \(lattitude) + longitude: \(longitude) +++++++++")
            if(StatutGlobal == true){
//                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc_Maps = mainStoryboard.instantiateViewController(withIdentifier: "idMaps") as! MapsViewController
                
//                vc_Maps.change_LO()
            print("------------------     Chaque 4 seconde   -------------------")
            print("**************************(  From APP active  enligne)**********************")
            }else{
                    print("------------------     Chaque 10 seconde   -------------------")
                    print("**************************(  From APP active  hors ligne)**********************")
                }
            
            //  print ("lllaaaattttINAPP:", lattitude)
            // print ("llonnnggggINAPP:", longitude)
            // print ("refuser:", refuser)
            
            if error != nil
            {
                print("problème seveur")
                if(UIApplication.shared.applicationState == .active){
                   DispatchQueue.main.async {
                    let status = Reach().connectionStatus()
                    switch status {
                    case .unknown, .offline:
                        print("Not connected")
                        if(testExistAlert == false){
                            testExistAlert = true
                            
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            alertViewCxt = SCLAlertView(appearance: appearance1)
                            alertViewCxt.addButton("RÉESSAYER"){
                                alertViewCxt.dismissPopover()
                                testExistAlert = false
                            }
                            
                            alertViewCxt.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                        }
                       
                    
                    case .online(.wwan):
                        print("Connected via WWAN")
                        
                        
                    case .online(.wiFi):
                        print("Connected via WiFi")
                        

                        
                    }}}
                 
                return
            }
            
            do
            {
                
                if   let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                
                print("************* \(json) ********************************************************")
                    
//                    if let viewControllers = self.window?.rootViewController?.childViewControllers {
//                        for viewController in viewControllers {
//                            if viewController.isKind(of: MapsViewController.self) {
//                                print("Found it!!!")
//                            }
//                        }
//                    }
                  
                   
                
                    
                    if(testExistAlert == true){
                        DispatchQueue.main.async {
                        testExistAlert = false
                        alertViewCxt.hideView()
                        }
                    }
                    if let status_chauffeur = json["status"] {
                    
                    let result_status = self.checkNull(obj: status_chauffeur as AnyObject)
                    
                    
                    
                    
                    if(result_status == true){
                        //notif = 0
                        print("status vide")
                    }
                    else{
                        let key_status = status_chauffeur as! NSNumber
                        if(key_status == 2){
                        set_OFF_HL = 1
                        StatutGlobal = false
                        }
                    }
                    
                    
                    
                }else{
                    print("no status")
                    }
                
                    if     let notification = json["notification"] as? NSDictionary {

                        
                        
                        
                        
                            let total = notification["DriverRequestId"]
                            
                            let resulttotal = self.checkNull(obj: total as AnyObject)
                        
                        
                        
                        
                            if(resulttotal == true){
                                //notif = 0
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
                                    
                                   
                                    
                                    frommaster = "0"
                                    if let fromM = notification["from_master"]{
                                        
                                        
                                        let frmmmm = String(describing: fromM)
                                        if(frmmmm == "1"){
                                            frommaster = "1"
                                        }else {
                                            frommaster = "0"
                                        }
                                        
                                    }else{
                                        print("frommaster n'existe pas")
                                    }
                                
                                if(UIApplication.shared.applicationState == .active ){
                                    notif = 1
                                    notifBC = 1
                                    }else {
                                    notifBC = 1
                                    }
                                
                                
                                //timerTestAPP?.invalidate()
                                
                                print("dep x:", latDepart)
                                print("dep y:", lngDepart)
                                print("arr x:", LatArrive)
                                print("arr y:", lngArrive)
                                    self.Send1CourseSonore(AttributAccepteRefuse: 2)
                                }else {
                                    print("2 eme notification")
                                    print(IDDriverRequest)
                                }
                                
                                
                                }
                            
                        
                    }else if let messagee = json["message"]{
                        print(messagee)
                        let Attributmsg = messagee as! String
                        if(Attributmsg == "Unauthenticated."){
                        
                        keychain.clear()
                        let defaults = UserDefaults.standard
                        let dictionary = defaults.dictionaryRepresentation()
                        dictionary.keys.forEach { key in
                            defaults.removeObject(forKey: key)
                        }
                        
                        DispatchQueue.global(qos: .userInitiated).async {
                                DispatchQueue.main.async {
                                    UserDefaults.standard.set(true, forKey: "lauchedBefore")
                            self.renitialize()
                            

                            
                                    
                                    let storyboard: UIStoryboard = UIStoryboard (name: "Main", bundle: nil)
                                    let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "idConnection") as! ConnexionViewController
                                    
                                    let currentController = self.getCurrentViewController()
                                    currentController?.present(vc, animated: false, completion: nil)
                                    
                                    
                                }}
                            
                        
                        
                        }else {
                            print("exeption")
                        }
                        
                        
                    }else{
                        print("no notif in json")
                    }
                    
                }else{
                    print("no json")
                }
                
                
                
               
            }
            catch let error as NSError
            {
                print(error)
                let alert = UIAlertController(title: "", message: "impossible de se connecter", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ignorer", style: .cancel, handler: nil))
                
                print("show alert")
                UIViewController().present(alert, animated: false)
            }
        }
        task.resume()
        
        
        
        
        
        
        
    }
    func getCurrentViewController() -> UIViewController? {
        
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
        
    }
    
    func renitialize(){
        
        //+++
        
        UPDATE = 1
        
        //+++
        
        HaveCamion = 1
        img = UIImage(named: "ic_photoc")
        IMMAT = String()
        MODEL = String()
        MARQUE = String()
        PHOTOFACE = String()
        PHOTOCOTE = String()
        PHOTOCARTEGRISSE = String()
        PHOTOASSURRANCE = String()
        EXpir_assurance = String()
        VolumeTotale = 0
        
        if(LastStatusGlobal == "3"){
            UPDATE = 0
        LastStatusGlobal = String()
        }
        
        lOGIN = 0
        Place = 0
        notif = 0
        notifBC = 0
        nbr = 0
        open = 0
        send = 0
        accepter = 0
        EnLigneMaps = 0
        EnLigneProfil = 0
        EnLigneRevenu = 0
        closeProfil = 0
        closeMaps = 0
        closeRevenu = 0
        timerRunTime?.invalidate()
        XIntervale = 0
        
        testExistNot = false
        testExistAlert = false
        after30 = 0
        
        fromPush = 0
        
        
        IDDriverRequest = -1
        
        names = "Pablo"
        firstname = String()
        Email = String()
        Tel = String()
        Addressss = String()
        PARTENAINE = String()
        
        
        CodePays = String()
        PhotoDRV = String()
        Villee = String()
        CodePostalee = String()
        Payss = String()
        
        NumIdentit = String()
        ImagIdentit = String()
        DatePermis = String()
        ImagePermis = String()
        DPAE = String()
        User_ID = String()
        ID = String()
        
        PHOTOPROFIL = String()
        
        
        
        StatutGlobal = false
        statutLO = true
        statutLOProfil = true
        
        
        
        IDCAMION = "-2"
        ListeIdCamion.removeAll()
        ListeMatriculeCamion.removeAll()
        ListeModeleCamion.removeAll()
        ListeMarqueCamion.removeAll()
        ListeVolumeCamion.removeAll()
        
        
        
        DataBagage.removeAll()
        DataNbrBagage.removeAll()
        
        
        
        
        
        //Déclaration des bagages course
        nonClient = " "
        prenomClient = " "
        adressdep = " "
        adressdes = " "
        volume = "0"
        NUMTEL = " "
        NUMFACTURE = " "
        TARIF = " "
        lngDepart = 2.352265
        latDepart = 48.859045
        lngArrive = 12.32
        latArrive = 13.45
        
        //Déclaration des timers
        timerTest1?.invalidate()
        timerTestVerifAccepter?.invalidate()
        timerAudio?.invalidate()
        
        
        
        refuser = 0
        statut = 0
        deconnectstatut = 1
        verifacept = 0
        deconnexion = 0
        
        
        set_ON =  0
        set_OFF_HL = 0
        
        
        
        IMGCLIENT = String()
        SIZEBUTT = 17
        statutInMaps2 = true
        TermineCourse = 0
        opentel = 0
        
        
        if (timerTest3.isValid) {
            timerTest3.invalidate()
            
        }
        
        AppDelegate.menu_bool = true
        AppDelegate.opencell = true
        
        
        
        if(bgtimer.isValid){
            bgtimer.invalidate()
        }
        if(bgtimer2.isValid){
            bgtimer2.invalidate()
        }
        
        if(timerTestbacktitle.isValid){
            timerTestbacktitle.invalidate()
        }
        
        
            if(timerTestAPP2.isValid){
                timerTestAPP2.invalidate()
              }
        
        
            if(timerTestAPP.isValid){
                timerTestAPP.invalidate()
              }
        
        frommaster = "0"
        
        timerTestinCC?.invalidate()
        timerTestinPC?.invalidate()
        timerTestinD?.invalidate()
        timerTestinA?.invalidate()
        timerTestinR?.invalidate()
        
        timerTestinBp?.invalidate()
        
        timerTestinBm?.invalidate()
        timerTestinVp?.invalidate()
        timerTestinVm?.invalidate()
        timerTestinV?.invalidate()
        timerTestinVR?.invalidate()
        timerTestinBR?.invalidate()
        
        heightviewbar = 0.0
        inC = 0
        inP = 0
        inD = 0
        inA = 0
        
        height = 0
        
     
        
        menuMaps = 0
        menuMaps2 = 0
        menuProfil = 0
        menuRevenu = 0
        
        HEURE = String()
        
        
        
        S_A_Aide = 0
        EtageDep = 0
        Etagedest = 0
        Ascenseurdep = 0
        Ascenseurdest = 0
        MSG = " "
    }
 
}


