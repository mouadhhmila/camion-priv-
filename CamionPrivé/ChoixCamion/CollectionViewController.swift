//
//  CollectionViewController.swift
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
import SCLAlertView
import GoogleMaps
import NVActivityIndicatorView





class CollectionViewController: UIViewController, GMSMapViewDelegate , CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate, NVActivityIndicatorViewable {
    
    var xview = CGFloat()
    var yview = CGFloat()
    private var data: [String] = []
    var locationManager = CLLocationManager()
    var heightcell = 0.0
    
    
    
    @IBOutlet weak var buttselectionner: UIButton!
    @IBOutlet weak var tablecamion: UITableView!
    @IBOutlet weak var labcamion: UILabel!
    @IBOutlet weak var ButtDownTable: UIButton!
    @IBOutlet weak var viewalpha: UIView!
    @IBOutlet weak var labmodele: UILabel!
    @IBOutlet weak var txtmodele: UILabel!
    @IBOutlet weak var labvolume: UILabel!
    @IBOutlet weak var txtvolume: UILabel!
    @IBOutlet weak var labmatricule: UILabel!
    @IBOutlet weak var viewChoisirCamion: UIView!
    
    
    
    
    
    @IBAction func buttSELECTION(_ sender: Any) {
        self.stopAnimating()
        
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
            sendidcamion()
        case .online(.wiFi):
            print("Connected via WiFi")
            let activityInd = NVActivityIndicatorView(frame: CGRect(x: xview - 25, y: yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
            
            NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
            NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
            view.addSubview(activityInd)
            
            
            self.startAnimating(message: "", type: NVActivityIndicatorType.ballRotateChase)
            
           send_coordinate_choix()
        }
    }
    func send_coordinate_choix()
    {
        
        let longitude = "\(x.coordinate.longitude)"
        
        let lattitude = "\(x.coordinate.latitude)"
        
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
            
            print("1 er **********************///// SEND ////*************************")
            print("++++++++ lattitude: \(lattitude) + longitude: \(longitude) +++++++++")
            
            
            
            if error != nil
            {
                print("problème seveur")
                if(UIApplication.shared.applicationState == .active){
                    DispatchQueue.main.async {
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
                            alertViewCxt = SCLAlertView(appearance: appearance1)
                            alertViewCxt.addButton("RÉESSAYER"){
                                self.send_coordinate_choix()
                            }
                            
                            alertViewCxt.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                            
                            
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
                    
                    print("************* 1 er att et long \(json) ********************************************************")
                    
                    self.sendidcamion()
                    
                    
                }else{
                    print("no json")
                    self.send_coordinate_choix()
                }
                
                
                
                
            }
            catch let error as NSError
            {
                print(error)
                
            }
        }
        task.resume()
        
        
        
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        xview = view.center.x
        yview = view.center.y
        heightcell = Double(labcamion.frame.size.height)
        
    }
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            UIDevice()
            tablecamion.isHidden = true
            
            UIApplication.shared.statusBarStyle = .lightContent
            
            self.viewChoisirCamion.layer.borderColor = UIColor.gray.cgColor
            self.viewChoisirCamion.layer.borderWidth = 1
            
            self.tablecamion.layer.borderColor = UIColor.gray.cgColor
            self.tablecamion.layer.borderWidth = 1
            
            
            viewalpha.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            
            IDDriverRequest = -1
            locationManager = CLLocationManager()
            locationManager.delegate = self
            
            tablecamion.dataSource = self
            tablecamion.register(UINib(nibName: "cellcamion", bundle: nil), forCellReuseIdentifier: "cellReuseIdentifier")
            tablecamion .delegate = self
            

        }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListeIdCamion.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellcamion")! as! CollectionTableViewCell
        cell.contentView.backgroundColor = UIColor.clear
        cell.labCamion.text = "\(ListeMarqueCamion[indexPath.row]) - \(ListeMatriculeCamion[indexPath.row])"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        tablecamion.isHidden = true
        ButtDownTable.isUserInteractionEnabled = true
        
        txtmodele.text = "\(ListeModeleCamion[indexPath.row])"
        txtvolume.text = "\(ListeVolumeCamion[indexPath.row]) m³"
        labcamion.text = "\(ListeMarqueCamion[indexPath.row]) - \(ListeMatriculeCamion[indexPath.row])"
        
        IDCAMION = ListeIdCamion[indexPath.row]
        ChoixCamion_vc.buttselectionner.backgroundColor = UIColor.init(red: 5/255, green: 150/255, blue: 253/255, alpha: 1)
        ChoixCamion_vc.buttselectionner.isUserInteractionEnabled = true
        print("select")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return labcamion.frame.size.height
    }
 
    
    @IBAction func buttdowntable(_ sender: Any) {
        
        
         self.stopAnimating()
        
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
            getlistcamion()
        case .online(.wiFi):
            print("Connected via WiFi")
            let activityInd = NVActivityIndicatorView(frame: CGRect(x: xview - 25, y: yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
            
            NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
            NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
            view.addSubview(activityInd)
            
            
            self.startAnimating(message: "", type: NVActivityIndicatorType.ballRotateChase)
            getlistcamion()
        
        }
    }
    
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    
   
    func getlistcamion()
    {
        print("******** oloooooooooooooo listecamion ***********")
        
        
        let tok = "\(token)"
        print("aaa", tok)
        let url = NSURL(string: "\(weburl)/api/driver/details")
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
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
                    alertView.addButton("RÉESSAYER"){
                        self.getlistcamion()
                       
                        
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
                        self.getlistcamion()
                    }
                    
                }
                else{
                    
                    if let camions = json["camions"] as? [[String: Any]]{
                        
                        IDCAMION = "-2"
                        ListeIdCamion.removeAll()
                        ListeMatriculeCamion.removeAll()
                        ListeModeleCamion.removeAll()
                        ListeMarqueCamion.removeAll()
                        ListeVolumeCamion.removeAll()
                        
                        
                        DispatchQueue.main.async{
                        for i in 0 ..< camions.count {
                            
                            let idc = camions[i]["id"]
                            let resultidc = self.checkNull(obj: idc as AnyObject)
                            if(resultidc == true){
                                print("idc is nil")
                            }
                            else{
                                print("idc:", idc!)
                                
                                let idcidc = idc as! String
                                ListeIdCamion.append(idcidc)
                            }
                            //////
                            let immatc = camions[i]["immatricule"]
                            let resultimmatc = self.checkNull(obj: immatc as AnyObject)
                            if(resultimmatc == true){
                                print("immatc is nil")
                            }
                            else{
                                print("immatc:", immatc!)
                                
                                let immatcimmatc = immatc as! String
                                ListeMatriculeCamion.append(immatcimmatc)
                            }
                            ///////
                            let marqc = camions[i]["marque"]
                            let resultmarqc = self.checkNull(obj: marqc as AnyObject)
                            if(resultmarqc == true){
                                print("marqc is nil")
                            }
                            else{
                                print("marqc:", marqc!)
                                
                                let marqcmarqc = marqc as! String
                                ListeMarqueCamion.append(marqcmarqc)
                            }
                            //////
                            let modelc = camions[i]["model"]
                            let resultmodelc = self.checkNull(obj: modelc as AnyObject)
                            if(resultmodelc == true){
                                print("modelc is nil")
                            }
                            else{
                                print("modelc:", modelc!)
                                
                                let modelcmodelc = modelc as! String
                                ListeModeleCamion.append(modelcmodelc)
                            }
                            /////
                            let volumc = camions[i]["volume"]
                            let resultvolumc = self.checkNull(obj: volumc as AnyObject)
                            if(resultvolumc == true){
                                print("volumc is nil")
                            }
                            else{
                                print("volumc:", volumc!)
                                
                                let volumcvolumc = volumc as! String
                                ListeVolumeCamion.append(volumcvolumc)
                            }
                            //////
                            DispatchQueue.main.async {
                                self.stopAnimating()
                            
                            if(ListeIdCamion.isEmpty){
                                
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
                                        alertView.dismiss(animated: true, completion: nil)
                                        
                                    }
                                    
                                    alertView.showError("RÉESSAYER", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                                }
                            }else {
                                IDCAMION = ListeIdCamion[0]
                                self.labcamion.text = "\(ListeMarqueCamion[0]) -\(ListeMatriculeCamion[0])"
                                
                                self.tablecamion.reloadData()
                                self.txtmodele.text = "\(ListeModeleCamion[0])"
                                self.txtvolume.text = "\(ListeVolumeCamion[0])"
                                
                                self.tablecamion.isHidden = false
                                
                             
                                }}
                            
                            
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
                            alertView.addButton("RÉESSAYER"){
                                self.getlistcamion()
                               
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
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
    func checkNull(obj : AnyObject?) -> Bool {
        if obj is NSNull {
            return true
        } else {
            return false
        }
    }
    
    func sendidcamion()
    {
        
        let idcamion = "\(IDCAMION)"
        let tok = "\(token)"
        
        
        
        let postString = ["camion_id":idcamion]
        
        let url = NSURL(string: "\(weburl)/api/driver/selectcamion")
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
                            self.sendidcamion()
                        }
                        
                        alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                    }}
                return
            }
            
            do
            {
                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                    
                    print("fichier json", json)
                    if let success = json["success"], let status = json["status"]{
                        print(success)
                        print(status)
                        DispatchQueue.global(qos: .userInitiated).async {
                            
                            DispatchQueue.main.async {
                                
                                self.getDocCamionfromlist()
                                
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
                                    self.sendidcamion()
                                }
                                
                                alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
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
                                self.sendidcamion()
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
    
    func getDocCamionfromlist()
    {
        
        print("******** get document camion in cell liste ***********")
        
        
        let tok = "\(token)"
        let url = NSURL(string: "\(weburl)/api/driver/getCamion")
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            if error != nil
            {
                print("1")
                print(error?.localizedDescription as Any)
                DispatchQueue.main.async {
                    //self.stopAnimating()
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
                        self.getDocCamionfromlist()
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
                            // Do long running task here
                            // Bounce back to the main thread to update the UI
                            DispatchQueue.main.async {
                                print(IDCAMION)
                                print("aallez")
                                //self.stopAnimating()
                                
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
                                        
                                        self.getDocCamionfromlist()
                                    }
                                    alertView.addButton("RETOUR"){
                                        self.stopAnimating()
                                        alertView.dismiss(animated: true, completion: nil)
                                    }
                                    alertView.showError("ERREUR", subTitle: "Contacter votre partenaire, probléme d'affectation du camion.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                                    
                                }
                                
                            }}
                    }
                    else if let message = json["message"] {
                        print("3 get doc c")
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
                        alertView.addButton("RÉESSAYER"){
                            self.getDocCamionfromlist()
                        }
                        
                        alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
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
                                
                                set_ON = 0
                                //self.sendStatutEL()
                                StatutGlobal = true
                               
                                AppDelegate().refreshLocationAPP()
                                
                                self.stopAnimating()
                                ChoixCamion_vc.view.removeFromSuperview()
                                
                                

                            }}
                        
                        
                    }
                }else{
                    
                }
                
            }
            catch let error as NSError
            {
                
                print(error.localizedDescription)
               
            }
        }
        task.resume()
        
    }
    
    
    func UIDevice() {
        
        
        
        switch UIScreen.main.nativeBounds.height {
        case 960:
            print("iPhone4")
            
            return
        //.iPhone4
        case 1136:
            print("iPhones_5_5s_5c_SE")
            
            
            labmodele.font = labmodele.font.withSize(12)
            labvolume.font = labvolume.font.withSize(12)
            labmatricule.font = labmatricule.font.withSize(12)
            
            txtmodele.font = txtmodele.font.withSize(11)
            txtvolume.font = txtvolume.font.withSize(11)
            
            return
        //.iPhones_5_5s_5c_SE
        case 1334:
            print("iPhones_6_6s_7_8")
            
            return
        //.iPhones_6_6s_7_8
        case 1920, 2208:
            print("iPhones_6Plus_6sPlus_7Plus_8Plus")
            
            labmodele.font = labmodele.font.withSize(15)
            labvolume.font = labvolume.font.withSize(15)
            labmatricule.font = labmatricule.font.withSize(15)
            
            txtmodele.font = txtmodele.font.withSize(14)
            txtvolume.font = txtvolume.font.withSize(14)
            
            return
        //.iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            print("iPhoneX")
            return
        //.iPhoneX
        default:
            print("ipade")
            //***************
            
            return
            //.unknown
        }
        
    }
    
    
}


