//
//  BonCommandeViewController.swift
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

var menuMaps = 0
var menuMaps2 = 0
var menuProfil = 0
var menuRevenu = 0

var HEURE = String()

class BonCommandeViewController: UIViewController  {
    
    
    
    var presentedVC: UIViewController?
    var heightsansAide:CGFloat = 0.0
    
    
    
    @IBOutlet weak var txtbar: UILabel!
    @IBOutlet weak var labBondeCommande: UILabel!
    @IBOutlet weak var labservicetransport: UILabel!
    @IBOutlet weak var labNumero: UILabel!
    @IBOutlet weak var txtNumero: UILabel!
    @IBOutlet weak var labPrestataire: UILabel!
    @IBOutlet weak var txtPrestataire: UILabel!
    @IBOutlet weak var labchauffeur: UILabel!
    @IBOutlet weak var txtchauffeur: UILabel!
    @IBOutlet weak var labClient: UILabel!
    @IBOutlet weak var lanomprenom: UILabel!
    @IBOutlet weak var labnumerotel: UILabel!
    @IBOutlet weak var txttelephone: UIButton!
    @IBOutlet weak var txtnomPrenom: UILabel!
    @IBOutlet weak var lablieuPrise: UILabel!
    @IBOutlet weak var txtLieuPriseCharge: UILabel!
    @IBOutlet weak var labdestin: UILabel!
    @IBOutlet weak var txtDestination: UILabel!
    @IBOutlet weak var labtari: UILabel!
    @IBOutlet weak var txtTarifs: UILabel!
    @IBOutlet weak var labdateCommande: UILabel!
    @IBOutlet weak var txtDateCommande: UILabel!
    @IBOutlet weak var labS_Aaide: UILabel!
    @IBOutlet weak var labsanAideinv10: UILabel!
    @IBOutlet weak var labaudep: UILabel!
    @IBOutlet weak var labetagedep: UILabel!
    @IBOutlet weak var labascenseurdep: UILabel!
    @IBOutlet weak var labdest: UILabel!
    @IBOutlet weak var labetagedest: UILabel!
    @IBOutlet weak var labascenseurdest: UILabel!
    @IBOutlet weak var txtcommentaire: UITextView!
    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v3: UIView!
    @IBOutlet weak var v4: UIView!
    @IBOutlet weak var v5: UIView!
    @IBOutlet weak var v6: UIView!
    @IBOutlet weak var v7: UIView!
    @IBOutlet weak var v8: UIView!
    @IBOutlet weak var v9: UIView!
    @IBOutlet weak var v10: UIView!
    @IBOutlet weak var vtxt: UIView!
    @IBOutlet weak var viewins: UIView!
    @IBOutlet weak var viewins2: UIView!
    @IBOutlet weak var buttbackk: UIButton!
    
    
    //**********************************************************************************************
    //**********************************************************************************************
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            print("ghghhghhgh")
            heightsansAide = self.v10.frame.size.height
        if(S_A_Aide == 0){
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                DispatchQueue.main.async {
                    
                    print("hhhhhhhh1",self.v9.frame.size.height)
                    print("hhhhhhhh",self.heightsansAide)
                    self.vtxt.frame.origin.y = self.v10.frame.origin.y + self.v10.frame.size.height + 8
                    print("hhhhhhhh1",self.v9.frame.size.height)
                    
                 
                    
                }}
        }
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let result = formatter.string(from: date)


        txtchauffeur.text = "\(names) \(firstname)".uppercased()
        txtnomPrenom.text = "\(nonClient) \(prenomClient)".uppercased()
        txtDateCommande.text = "\(result) \(HEURE)"
        txtLieuPriseCharge.text = adressdep
        txtDestination.text = adressdes
        txtTarifs.text = "\(TARIF) €"
        txtNumero.text = NUMFACTURE
        txtPrestataire.text = PARTENAINE
        DispatchQueue.main.async {
        self.txttelephone.isEnabled = false
        self.txttelephone.titleLabel?.text = " "
        
        self.txttelephone.setTitle(NUMTEL,for: .normal)
            self.txttelephone.isEnabled = true
        }
        
     
        DispatchQueue.global(qos: .userInitiated).async {
           
            DispatchQueue.main.async {
                
                self.v1.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
               self.v2.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
                self.v3.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
                self.v4.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
                self.v5.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
                self.v6.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
                self.v7.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
                self.v8.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
                
                self.v9.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
                self.v10.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
                self.vtxt.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
                
                
        self.v1.layer.shadowColor = UIColor.black.cgColor
        self.v1.layer.shadowOpacity = 0.4
        self.v1.layer.shadowOffset = .zero
        
        self.v2.layer.shadowColor = UIColor.black.cgColor
        self.v2.layer.shadowOpacity = 0.4
        self.v2.layer.shadowOffset = .zero
        
        self.v3.layer.shadowColor = UIColor.black.cgColor
        self.v3.layer.shadowOpacity = 0.4
        self.v3.layer.shadowOffset = .zero
        
        self.v4.layer.shadowColor = UIColor.black.cgColor
        self.v4.layer.shadowOpacity = 0.4
        self.v4.layer.shadowOffset = .zero
        
        self.v5.layer.shadowColor = UIColor.black.cgColor
        self.v5.layer.shadowOpacity = 0.4
        self.v5.layer.shadowOffset = .zero
        
        self.v6.layer.shadowColor = UIColor.black.cgColor
        self.v6.layer.shadowOpacity = 0.4
        self.v6.layer.shadowOffset = .zero
        
        self.v7.layer.shadowColor = UIColor.black.cgColor
        self.v7.layer.shadowOpacity = 0.4
        self.v7.layer.shadowOffset = .zero
        
        self.v8.layer.shadowColor = UIColor.black.cgColor
        self.v8.layer.shadowOpacity = 0.4
        self.v8.layer.shadowOffset = .zero
                
                self.vtxt.layer.shadowColor = UIColor.black.cgColor
                self.vtxt.layer.shadowOpacity = 0.4
                self.vtxt.layer.shadowOffset = .zero
                
                
                
                if(S_A_Aide == 0){
                    self.v9.isHidden = true
                    self.v10.layer.shadowColor = UIColor.black.cgColor
                    self.v10.layer.shadowOpacity = 0.4
                    self.v10.layer.shadowOffset = .zero
                    
                   
           
                }else {
                    self.v10.isHidden = true
                    self.v9.layer.shadowColor = UIColor.black.cgColor
                    self.v9.layer.shadowOpacity = 0.4
                    self.v9.layer.shadowOffset = .zero
                    
                    if(EtageDep == 0){
                        self.labetagedep.text = "Etage: RDC"
                        
                    }else {
                        self.labetagedep.text = "Etage: \(EtageDep)"
                    }
                    
                    if(Etagedest == 0){
                        self.labetagedest.text = "Etage: RDC"
                        
                    }else {
                        self.labetagedest.text = "Etage: \(Etagedest)"
                    }
                    
                    if(Ascenseurdep == 0){
                        self.labascenseurdep.text = "Sans ascenseur"
                        
                    }else {
                        self.labascenseurdep.text = "Avec ascenseur"
                    }
                    
                    if(Ascenseurdest == 0){
                        self.labascenseurdest.text = "Sans ascenseur"
                        
                    }else {
                        self.labascenseurdest.text = "Sans ascenseur"
                    }
                    
                    
                }
                if(MSG == "<null>") || (MSG == " "){
                    self.txtcommentaire.text = "Aucune message"
                }else {
                    self.txtcommentaire.text = MSG
                }
                
            }}
        
        
        if (timerTest3.isValid) {
            timerTest3.invalidate()
            
       
            refreshinBp()
        }
        
        
        if(EnLigneMaps == 1){
            timerTest1?.invalidate()
            refreshinBm()
        }
        if(EnLigneRevenu == 1){
            timerTestinR?.invalidate()
            refreshinBR()
        }
        
            }
    
    //**********************************************************************************************
    //**********************************************************************************************
    
    func refreshinBp() {
        timerTestinBp = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(BonCommandeViewController.show1), userInfo: nil, repeats: true)
    }
    
    func show1(){
        print("in BandeCp")
        
        if (EnLigneProfil == 1){
            if (notif == 1) {
                
                if(closeProfil == 0){
                    timerTestinBp?.invalidate()
                    
                    let mymvc = storyboard?.instantiateViewController(withIdentifier: "idMaps") as! MapsViewController
                    
                    self.present(mymvc, animated: false, completion: nil)
                    print("enligneProfil=", EnLigneProfil)
                    
                }
                
            }
            
        }

    }
    //**********************************************************************************************

    func refreshinBR() {
        timerTestinBR = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(BonCommandeViewController.show3), userInfo: nil, repeats: true)
    }
    
    func show3(){
        print("in BandeCR")
        
        if (EnLigneRevenu == 1){
            if (notif == 1) {
                
                if(closeRevenu == 0){
                    timerTestinBR?.invalidate()
                    
                    let mymvc = storyboard?.instantiateViewController(withIdentifier: "idMaps") as! MapsViewController
                    
                    self.present(mymvc, animated: false, completion: nil)
                    print("enligneRevenu=", EnLigneRevenu)
                    
                }
                
            }
            
        }
        
    }
    
    //**********************************************************************************************


    func refreshinBm() {
        timerTestinBm = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(BonCommandeViewController.show2), userInfo: nil, repeats: true)
    }
    
    func show2(){
        print("in BandeCm")
        
        //*************
        if (EnLigneMaps == 1){
            if (notif == 1) {
                
                if(closeMaps == 0){
                    timerTestinBm?.invalidate()
                    
                    let mymvc = storyboard?.instantiateViewController(withIdentifier: "idMaps") as! MapsViewController
                    
                    self.present(mymvc, animated: false, completion: nil)
                    print("enligneMaps= ", EnLigneMaps)
                    
                }
                
            }
            
        }
        
    }

    //**********************************************************************************************

    
    @IBAction func buttcall(_ sender: Any) {
        if(NUMTEL == " "){
        }else{
            makeAPhoneCall()
        }
        
    }
    func makeAPhoneCall()  {
        
        let link:String = "TEL://"
        let url:NSURL = NSURL(string: link)!
        
        if UIApplication.shared.canOpenURL(url as URL) {
            
            UIApplication.shared.openURL(NSURL(string: "TEL://\(NUMTEL)")! as URL)
            UIApplication.shared.isIdleTimerDisabled = true
            
            
        }
        else
        {
            
        }
        
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        
       self.dismiss(animated: false, completion: nil)
        
    }
    
    //**********************************************************************************************

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    
    func UIDevice() {
        
        
        
        switch UIScreen.main.nativeBounds.height {
        case 960:
            print("iPhone4")

            return
        //.iPhone4
        case 1136:
            print("iPhones_5_5s_5c_SE")
            
            txtbar.font = txtbar.font.withSize(17)
            labBondeCommande.font = labBondeCommande.font.withSize(20)
            labservicetransport.font = labservicetransport.font.withSize(13)
            
            buttbackk.titleLabel?.font = buttbackk.titleLabel?.font.withSize(13)
            
            
            labNumero.font = labNumero.font.withSize(12)
            txtNumero.font = txtNumero.font.withSize(12)
            labPrestataire.font = labPrestataire.font.withSize(12)
            txtPrestataire.font = txtPrestataire.font.withSize(12)
            labchauffeur.font = labchauffeur.font.withSize(12)
            txtchauffeur.font = txtchauffeur.font.withSize(12)
            labClient.font = labClient.font.withSize(12)
            lanomprenom.font = lanomprenom.font.withSize(12)
            labnumerotel.font = labnumerotel.font.withSize(12)
            txtnomPrenom.font = txtnomPrenom.font.withSize(12)
            txttelephone.titleLabel?.font = txttelephone.titleLabel?.font.withSize(12)
            lablieuPrise.font = lablieuPrise.font.withSize(12)
            txtLieuPriseCharge.font = txtLieuPriseCharge.font.withSize(12)
            labdestin.font = labdestin.font.withSize(12)
            txtDestination.font = txtDestination.font.withSize(12)
            labtari.font = labtari.font.withSize(12)
            txtTarifs.font = txtTarifs.font.withSize(12)
            labdateCommande.font = labdateCommande.font.withSize(12)
            txtDateCommande.font = txtDateCommande.font.withSize(12)
            
            
            
            
            labS_Aaide.font = labS_Aaide.font.withSize(12)
            labsanAideinv10.font = labsanAideinv10.font.withSize(12)
            
            labaudep.font = labaudep.font.withSize(12)
            labetagedep.font = labetagedep.font.withSize(12)
            labascenseurdep.font = labascenseurdep.font.withSize(12)
            
            labdest.font = labdest.font.withSize(12)
            labetagedest.font = labetagedest.font.withSize(12)
            labascenseurdest.font = labascenseurdest.font.withSize(12)
            
            txtcommentaire.font = txtcommentaire.font?.withSize(10)
            
           
            return
        //.iPhones_5_5s_5c_SE
        case 1334:
            print("iPhones_6_6s_7_8")
            return
        //.iPhones_6_6s_7_8
        case 1920, 2208:
            print("iPhones_6Plus_6sPlus_7Plus_8Plus")
            
            txtbar.font = txtbar.font.withSize(22)
            labBondeCommande.font = labBondeCommande.font.withSize(24)
            labservicetransport.font = labservicetransport.font.withSize(17)
            
            buttbackk.titleLabel?.font = buttbackk.titleLabel?.font.withSize(16)
            
            
            labNumero.font = labNumero.font.withSize(16)
            txtNumero.font = txtNumero.font.withSize(15)
            labPrestataire.font = labPrestataire.font.withSize(16)
            txtPrestataire.font = txtPrestataire.font.withSize(15)
            labchauffeur.font = labchauffeur.font.withSize(16)
            txtchauffeur.font = txtchauffeur.font.withSize(15)
            labClient.font = labClient.font.withSize(16)
            lanomprenom.font = lanomprenom.font.withSize(16)
            labnumerotel.font = labnumerotel.font.withSize(16)
            txtnomPrenom.font = txtnomPrenom.font.withSize(15)
            txttelephone.titleLabel?.font = txttelephone.titleLabel?.font.withSize(15)
            lablieuPrise.font = lablieuPrise.font.withSize(16)
            txtLieuPriseCharge.font = txtLieuPriseCharge.font.withSize(15)
            labdestin.font = labdestin.font.withSize(16)
            txtDestination.font = txtDestination.font.withSize(15)
            labtari.font = labtari.font.withSize(16)
            txtTarifs.font = txtTarifs.font.withSize(15)
            labdateCommande.font = labdateCommande.font.withSize(16)
            txtDateCommande.font = txtDateCommande.font.withSize(15)
            
            
            
            
            labS_Aaide.font = labS_Aaide.font.withSize(16)
            labsanAideinv10.font = labsanAideinv10.font.withSize(16)
            
            labaudep.font = labaudep.font.withSize(16)
            labetagedep.font = labetagedep.font.withSize(15)
            labascenseurdep.font = labascenseurdep.font.withSize(15)
            
            labdest.font = labdest.font.withSize(16)
            labetagedest.font = labetagedest.font.withSize(15)
            labascenseurdest.font = labascenseurdest.font.withSize(15)
            
            txtcommentaire.font = txtcommentaire.font?.withSize(13)
            
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
