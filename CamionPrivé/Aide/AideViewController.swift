//
//  AideViewController.swift
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
import JTMaterialTransition

var labeles:[String] = [""]
var quest:[[String]] = [[""]]
var repons:[[String]] = [[""]]

var allquest:[String] = [""]
var allrep:[String] = [""]

class AideViewController: UIViewController, NVActivityIndicatorViewable {
    
    var labheights = 10
    @IBOutlet weak var tableView:ExpandableTableViewAide!
    var items:[[String]?] = []
    
    
    var tailleFont = 15
    var taillecell = 65
   
    var xview = CGFloat()
    var yview = CGFloat()
   
    var Section = 0
    
    var imageaide:[String] = ["ic_message24x24"]
    
    //**********************************************************************************************
    //**********************************************************************************************

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("**¥¥¥¥¥¥¥¥ffffffffffffaide")
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.xview = self.view.center.x
                self.yview = self.view.center.y
                
                self.tableView.reloadData()

            }}
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice()
        
        BackProfil = 0
        
    DispatchQueue.main.async {
        
        for i in 0 ..< labeles.count {
            self.items.append([])
            for j in 0 ..< quest[i].count{
                
                self.items[i]!.append("\(j)")
            }
            
        }
        }

    }
    
    func findbeginweek(){
        
        var startDate = DateComponents()
        startDate.year = 2018
        startDate.month = 1
        startDate.day = 1
        let calendar = Calendar.current
        let startDateNSDate = calendar.date(byAdding: startDate, to: Date.init(timeIntervalSinceNow: 0))
        
        var date = startDateNSDate// first date
        let endDate = Date() // last date
        
        let fmt = DateFormatter()
        fmt.dateFormat = "dd/MM/yyyy"
        
        while date! <= endDate {
            
            date = calendar.date(byAdding: .day, value: 1, to: date!)!
            print("aaa", fmt.string(from: date!))
        }
    }
    

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
            
           tailleFont = 13
           taillecell = 60
           
            return
        //.iPhones_5_5s_5c_SE
        case 1334:
            print("iPhones_6_6s_7_8")
            return
        //.iPhones_6_6s_7_8
        case 1920, 2208:
            print("iPhones_6Plus_6sPlus_7Plus_8Plus")
            
          tailleFont = 16
          taillecell = 70
            
            
            return
        //.iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            print("iPhoneX")
            taillecell = 65
            tailleFont = 15
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

// MARK: UITableViewDataSource
extension AideViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("1")
        return labeles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (!items.isEmpty) {
            if (self.tableView.sectionOpen != NSNotFound && section == self.tableView.sectionOpen) {
                return items[section]!.count
            }
        }
        print("2")
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellaide", for: indexPath) as! AideTableViewCell
        
        
        let section = quest[indexPath.section]
        let section1 = repons[indexPath.section]
        
       
        cell.txtquest.text = section[indexPath.row]
        cell.txtrepos.text = section1[indexPath.row]
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        
        return cell
    }

}


// MARK: UITableViewDelegate
extension AideViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(taillecell)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderViewAide(tableView: self.tableView, section: section) as UIView
       
        let ViewV = UIView(frame: CGRect(x: 0, y: 0, width: headerView.frame.size.width, height: headerView.frame.size.height - 10))//headerView.bounds)
    
        ViewV.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
        
        headerView.backgroundColor = UIColor.clear
        
        let imgnameaide = "\(imageaide[0])"//section
        let imaged1 = UIImage(named: imgnameaide)
        let imageView1 = UIImageView(image: imaged1!)
        
        imageView1.frame = CGRect(x: 22, y: ViewV.center.y, width: imageView1.frame.width, height: imageView1.frame.height)
        imageView1.center.y = ViewV.center.y
        
        
        
        
        let labelquest = UILabel(frame: CGRect(x: imageView1.frame.width + 37, y: ViewV.frame.origin.y, width: ViewV.frame.width-(imageView1.frame.width + 37), height: ViewV.frame.height))
        
		labelquest.text = "\(labeles[section])".uppercased()
        labelquest.textAlignment = NSTextAlignment.left
        labelquest.font = UIFont(name: "Roboto-Medium", size: CGFloat(tailleFont))
        labelquest.textColor = UIColor.white
        
        print("sectionopen", self.tableView.sectionOpen)
        if(self.tableView.sectionOpen == section){
           self.tableView.closedView(section: section)
        }
        
        let viewsepar = UIView(frame: CGRect(x: ViewV.frame.origin.x, y: (ViewV.frame.height - 1.5), width: ViewV.frame.width, height: 1.5))
        viewsepar.backgroundColor = UIColor.clear
        
        
        ViewV.addSubview(imageView1)
        
        ViewV.addSubview(viewsepar)
        ViewV.addSubview(labelquest)
        
        headerView.addSubview(ViewV)
        
        
        return headerView
    }
    
    
}

