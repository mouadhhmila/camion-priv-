//
//  ViewClient.swift
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

class ViewClient: UIView {

  


required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
}

override init(frame: CGRect) {
    super.init(frame: frame)
}

    func updateRaduis(){
    let patho = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 15, height: 15)).cgPath
    
    
    let maskLayer = CAShapeLayer()
    maskLayer.path = patho
    self.layer.mask = maskLayer
    }
}
