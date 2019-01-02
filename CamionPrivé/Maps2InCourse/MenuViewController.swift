//
//  MenuViewController.swift
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
import NVActivityIndicatorView


class MenuViewController: UIViewController, NVActivityIndicatorViewable {
    
    var xview = CGFloat()
    var yview = CGFloat()

    @IBOutlet weak var viewclosemenu: UIView!
    @IBOutlet weak var LabBC: UILabel!
    @IBOutlet weak var LabLB: UILabel!
    @IBOutlet weak var viewmenu: UIView!
    @IBOutlet weak var view_boncommande: UIView!
    @IBOutlet weak var view_listebagage: UIView!
    

    
    //**********************************************************************************************
    //**********************************************************************************************
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        xview = view.center.x
        yview = view.center.y
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       UIDevice()
        
        viewmenu.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.8)
        view_boncommande.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.8)
        view_listebagage.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.8)
     
    
        
        let tapdedBondeCommande: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.clickBondeCommande))
        view_boncommande.addGestureRecognizer(tapdedBondeCommande)
        
        let tapdedListeBagage: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.clickListeBagage))
        view_listebagage.addGestureRecognizer(tapdedListeBagage)
        
       
    }
    
    

     func clickBondeCommande(){
        
    let myVC = storyboard?.instantiateViewController(withIdentifier: "SVBonDeCommande") as! BonCommandeViewController
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        menu_vc.view.removeFromSuperview()
    }
    
    
    self.present(myVC, animated: false, completion: nil)
   
}
    
    func clickListeBagage(){
        let myVC = storyboard?.instantiateViewController(withIdentifier: "SVVolume") as! VolumeViewController

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            menu_vc.view.removeFromSuperview()
        }
        
        self.present(myVC, animated: false, completion: nil)
        
    }
    
   

    //**********************************************************************************************
    //**********************************************************************************************

    
   

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    func UIDevice() {
        
        
        
        switch UIScreen.main.nativeBounds.height {
        case 960:
            print("iPhone4")
           
            return
        //.iPhone4
        case 1136:
            print("iPhones_5_5s_5c_SE")
            LabBC.font = LabBC.font.withSize(13)
            LabLB.font = LabLB.font.withSize(13)
            
            
            return
        //.iPhones_5_5s_5c_SE
        case 1334:
            print("iPhones_6_6s_7_8")
            return
        //.iPhones_6_6s_7_8
        case 1920, 2208:
            print("iPhones_6Plus_6sPlus_7Plus_8Plus")
            LabBC.font = LabBC.font.withSize(18)
            LabLB.font = LabLB.font.withSize(18)
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
