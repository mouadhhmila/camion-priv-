//
//  AideTableViewCell.swift
//  CamionPrivé
//
//  Created by Administrateur on 15/12/2017.
//  Copyright © 2017 Administrateur. All rights reserved.
//

import UIKit

class RevenuTableViewCell: UITableViewCell {

    @IBOutlet weak var depart: UILabel!
    @IBOutlet weak var arrive: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var euro: UILabel!
    
    @IBOutlet weak var viewincell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.async {
            self.UIDevice()
        }
        viewincell.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.4)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    func UIDevice() {
        
        
        
        switch UIScreen.main.nativeBounds.height {
        case 960:
            print("iPhone4")
            
            
            
            return
        //.iPhone4
        case 1136:
            print("iPhones_5_5s_5c_SE")
            
            depart.font = depart.font.withSize(12)
            arrive.font = arrive.font.withSize(12)
            
            distance.font = distance.font.withSize(18)
            time.font = time.font.withSize(18)
            euro.font = euro.font.withSize(18)
            
            
            return
        //.iPhones_5_5s_5c_SE
        case 1334:
            print("iPhones_6_6s_7_8")
            
            return
        //.iPhones_6_6s_7_8
        case 1920, 2208:
            print("iPhones_6Plus_6sPlus_7Plus_8Plus")
            
            depart.font = depart.font.withSize(16)
            arrive.font = arrive.font.withSize(16)
            
            distance.font = distance.font.withSize(22)
            time.font = time.font.withSize(22)
            euro.font = euro.font.withSize(22)
            
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
