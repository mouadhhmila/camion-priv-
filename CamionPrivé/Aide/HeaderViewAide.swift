//
//  HeaderView.swift
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

protocol HeaderViewAideDelegate {
    func openedView(section: Int)
    func closedView(section: Int)
}

class HeaderViewAide: UIView {
    
    
    
    
    
    var tableView: ExpandableTableViewAide!
    var delegate: HeaderViewAideDelegate?
    var section = 0
    
    required init(tableView:ExpandableTableViewAide, section:Int){
        
        guard let height = tableView.delegate?.tableView?(tableView, heightForHeaderInSection: section) else{
            fatalError("heightForHeaderInSection")
        }
        
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: height)
        super.init(frame: frame)
        
        self.tableView = tableView
        self.delegate = tableView
        self.section = section
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) 。")
    }
    
    override func layoutSubviews() {
        
        let toggleButton = UIButton()
        
        toggleButton.addTarget(self,
                               action: #selector(HeaderViewAide.toggle(sender:)),
                               for: .touchUpInside)
        
        toggleButton.backgroundColor = UIColor.clear
        toggleButton.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(toggleButton)
    }
    
    func toggle(sender:AnyObject){
        
        if tableView.sectionOpen != section {
           
            delegate?.openedView(section: section)
           
        } else if tableView.sectionOpen != NSNotFound {
            print("close")
            
            delegate?.closedView(section: self.tableView!.sectionOpen)
        }
    }
}
