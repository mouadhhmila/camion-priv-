//
//  BagageTableViewCell.swift
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

class BagageTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var blueviewnumber: UIView!
    @IBOutlet weak var labnumberinviewblue: UILabel!
    @IBOutlet weak var labbagage: UILabel!
    @IBOutlet weak var labnbrbagage: UILabel!
    
    @IBOutlet weak var viewquantie: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                
               self.blueviewnumber.backgroundColor = UIColor.clear
                
            }}
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func UIDevice() {
        
        
        
        switch UIScreen.main.nativeBounds.height {
        case 960:
            print("iPhone4")
       
            return
        //.iPhone4
        case 1136:
            print("iPhones_5_5s_5c_SE")
            labnbrbagage.font = labnbrbagage.font.withSize(13)
            labbagage.font = labbagage.font.withSize(13)
            labnumberinviewblue.font = labnumberinviewblue.font.withSize(14)
            
            return
        //.iPhones_5_5s_5c_SE
        case 1334:
            print("iPhones_6_6s_7_8")
            return
        //.iPhones_6_6s_7_8
        case 1920, 2208:
            print("iPhones_6Plus_6sPlus_7Plus_8Plus")
            labnbrbagage.font = labnbrbagage.font.withSize(17)
            labbagage.font = labbagage.font.withSize(17)
            labnumberinviewblue.font = labnumberinviewblue.font.withSize(18)
           
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
