//
//  VolumeViewController.swift
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


var DataBagage:[String] = []
var DataNbrBagage:[String] = []

class VolumeViewController: UIViewController {

    var heightcell = 60.0
    
    @IBOutlet weak var txtbar: UILabel!
    @IBOutlet weak var tblbagage: UITableView!
    @IBOutlet weak var buttBackk: UIButton!
    
    
    
    
    @IBAction func buttback(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      UIDevice()
        
        
         UIApplication.shared.statusBarStyle = .lightContent
         self.tblbagage.allowsSelection = false
         self.tblbagage.separatorStyle = .none
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            DispatchQueue.main.async {
                if (self.tblbagage.frame.size.height < self.tblbagage.frame.size.height) {
                    self.tblbagage.isScrollEnabled = false
                    print(self.tblbagage.frame.size.height)
                    print(self.tblbagage.frame.size.height)
                    print("1111")
        }
        else {
                    self.tblbagage.isScrollEnabled = true
                    print("222222")
        }
            }}
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
            buttBackk.titleLabel?.font = buttBackk.titleLabel?.font.withSize(13)
            heightcell = 50.0
            
            return
        //.iPhones_5_5s_5c_SE
        case 1334:
            print("iPhones_6_6s_7_8")
            return
        //.iPhones_6_6s_7_8
        case 1920, 2208:
            print("iPhones_6Plus_6sPlus_7Plus_8Plus")
            txtbar.font = txtbar.font.withSize(22)
            buttBackk.titleLabel?.font = buttBackk.titleLabel?.font.withSize(16)
            heightcell = 70.0
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
   


//////////
extension VolumeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      return DataBagage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bagageid") as! BagageTableViewCell
        
        
        cell.labnumberinviewblue.text = "\(indexPath.row + 1)"
        cell.labbagage.text = DataBagage[indexPath.row]
        cell.labnbrbagage.text = DataNbrBagage[indexPath.row]
        
        cell.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Section \(indexPath.section), Row : \(indexPath.row)")
      
    }
}

// MARK: UITableViewDelegate
extension VolumeViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(heightcell)
    }
   
    
    
}
    

    


