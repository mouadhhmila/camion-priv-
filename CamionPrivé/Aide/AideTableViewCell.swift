//
//  AideTableViewCell.swift
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

class AideTableViewCell: UITableViewCell{
    
    
   
    
    @IBOutlet weak var txtquest: UILabel!
    @IBOutlet weak var txtrepos: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.UIDevice()
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
            txtquest.font = txtquest.font.withSize(12)
            txtrepos.font = txtrepos.font.withSize(11)
           
            
            return
        //.iPhones_5_5s_5c_SE
        case 1334:
            print("iPhones_6_6s_7_8")
            return
        //.iPhones_6_6s_7_8
        case 1920, 2208:
            print("iPhones_6Plus_6sPlus_7Plus_8Plus")
            
            txtquest.font = txtquest.font.withSize(16)
            txtrepos.font = txtrepos.font.withSize(14)
            
            
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
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
