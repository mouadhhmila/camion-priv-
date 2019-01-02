//
//  ExpandableTableView.swift
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

class ExpandableTableViewAide : UITableView {
    var sectionOpen = NSNotFound
}

extension ExpandableTableViewAide: HeaderViewAideDelegate {
    
    func openedView(section: Int) {
        print("fff")
        if self.sectionOpen != NSNotFound {
            closedView(section: self.sectionOpen)
        }

        self.sectionOpen = section

        if let numberOfRows = self.dataSource?.tableView(self, numberOfRowsInSection: section) {

            var indexesPathToInsert:[IndexPath] = []

            for i in 0 ..< numberOfRows {
                indexesPathToInsert.append(IndexPath(row: i, section: section))
            }

            if indexesPathToInsert.count > 0 {
                self.beginUpdates()
                self.insertRows(at: indexesPathToInsert as [IndexPath], with: UITableViewRowAnimation.none)
                self.endUpdates()
            }
        }
        
        
    }
    
    func closedView(section: Int) {
        
        if let numberOfRows = self.dataSource?.tableView(self, numberOfRowsInSection: section) {
            var indexesPathToDelete:[IndexPath] = []
            self.sectionOpen = NSNotFound
            
            for i in 0 ..< numberOfRows {
                indexesPathToDelete.append(IndexPath(row: i, section: section))
            }
            
            if indexesPathToDelete.count > 0 {
                print("fffffouafh")
                self.beginUpdates()
                self.deleteRows(at: indexesPathToDelete as [IndexPath], with: UITableViewRowAnimation.middle)
                self.endUpdates()
            }
        }
    }
}
