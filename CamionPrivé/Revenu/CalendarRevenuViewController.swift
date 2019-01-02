//
//  CalendarRevenuViewController.swift
//  CamionPrivé
//
//  Created by Forest Cab on 24/05/2018.
//  Copyright © 2018 Administrateur. All rights reserved.
//

import UIKit
import FSCalendar
import SwiftyJSON
import Alamofire
import NVActivityIndicatorView
import SCLAlertView
import JTMaterialTransition

var DEBUT_TRV = " "
var LabEuroYears = " "
var LabNbrCourseYears = " "
var LabNoteYears = " "

class CalendarRevenuViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, NVActivityIndicatorViewable, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var viewtxttotal: UIView!
    
    @IBOutlet weak var viewtotal: UIView!
    @IBOutlet weak var viewcourse: UIView!
    @IBOutlet weak var viewheur: UIView!
    @IBOutlet weak var viewnote: UIView!
    
    @IBOutlet weak var labrevenutot: UILabel!
    @IBOutlet weak var labnbrcourse: UILabel!
    @IBOutlet weak var labhtrav: UILabel!
    @IBOutlet weak var labnoteT: UILabel!
    
    @IBOutlet weak var txtlabrevenutot: UILabel!
    @IBOutlet weak var txtlabnbrcourse: UILabel!
    @IBOutlet weak var txtlabhtrav: UILabel!
    @IBOutlet weak var txtlabnoteT: UILabel!
    
 
    
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    @IBOutlet weak var calendar: FSCalendar!
    fileprivate weak var eventLabel: UILabel!
    
    
    @IBOutlet weak var viewbuttonYM: UIView!
    @IBOutlet weak var buttdétailsmois: UIButton!
    

    
   
    @IBOutlet weak var viewtbl: UIView!
    
 
    @IBOutlet weak var buttplusdetaill: UIButton!
    
    @IBOutlet weak var lab_le_date: UILabel!
    @IBOutlet weak var revenuJour: UILabel!
    @IBOutlet weak var txtrevenuJour: UILabel!
    @IBOutlet weak var labnbrCourseJour: UILabel!
    @IBOutlet weak var txtnbrCourseJour: UILabel!
    @IBOutlet weak var labheureJours: UILabel!
    @IBOutlet weak var txtheureJour: UILabel!
    @IBOutlet weak var labnoteJour: UILabel!
    @IBOutlet weak var txtnoteJour: UILabel!
    
    @IBOutlet weak var tableView: UITableView!

    
    @IBOutlet weak var viewbartotalyear: UIView!
    
    @IBOutlet weak var txtlabnoteyears: UILabel!
    @IBOutlet weak var txtlabnbrcourseyears: UILabel!
    @IBOutlet weak var txtlabeuroyears: UILabel!
    
    
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
  
    //var items:[[Int]?] = []
    private var data: [String] = []
    
    var tailleFont = 18
    var taillecell = 50
    
    var datesWithEvent = ["2018-05-03", "2018-05-06", "2018-05-12", "2018-05-25"]
    var datesWithMultipleEvents = ["2018-05-08", "2018-05-16", "2018-05-20", "2018-05-28"]
    
    let fillSelectionColors = ["\(DEBUT_TRV)": UIColor.init(red: 0, green: 180/255, blue: 1, alpha: 1)]
    let fillDefaultColors = ["\(DEBUT_TRV)": UIColor.purple]
    let borderDefaultColors = ["\(DEBUT_TRV)": UIColor.white]
    let borderSelectionColors = ["\(DEBUT_TRV)": UIColor.purple]
    
    
    var idCourse = Int()
    var datecettejour = String()
    
    var DEPARTR:[String] = []
    var ARRIVER:[String] = []
    var DISTANCER:[String] = []
    var HEURER:[String] = []
    var PRIXR:[String] = []
    
    
    var xview = CGFloat()
    var yview = CGFloat()
    
    var COUNT_RT = -1
    var COUNT_NBRC = -1
    var COUNT_HTRV = -1
    
    var DirectionCalendar = " "
    
    
    var DEBUTMOIS = String()
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
         UIDevice()
        
       
        
        
        DEBUTMOIS = self.dateFormatter.string(from: calendar.currentPage)
        print("in view did load debut mois =\(DEBUTMOIS)")
        
        
        BackProfil = 0
        
        buttdétailsmois.backgroundColor = UIColor.clear//init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
        //buttplusdetaill.backgroundColor = UIColor.init(red: 03/255, green: 150/255, blue: 1, alpha: 1).withAlphaComponent(0.4)
        
        viewtotal.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
        viewcourse.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
        viewheur.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
        viewnote.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
        
        
        self.revenuJour.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
        self.txtrevenuJour.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
        self.labnbrCourseJour.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
        self.txtnbrCourseJour.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
        self.labheureJours.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
        self.txtheureJour.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
        self.labnoteJour.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
        self.txtnoteJour.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
        
        buttdétailsmois.layer.borderColor = UIColor.white.cgColor
        buttdétailsmois.layer.borderWidth = 1.0
        
        self.viewbartotalyear.backgroundColor = UIColor.init(red: 4/255, green: 99/255, blue: 168/255, alpha: 1).withAlphaComponent(0.3)
        self.viewbartotalyear.isHidden = true
        
        viewtbl.isHidden = true
        viewtxttotal.isHidden = true
        self.calendar.clipsToBounds = true
        
        
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: "cellcourse", bundle: nil), forCellReuseIdentifier: "cellReuseIdentifier1")
        tableView.delegate = self
        
        
        calendar.swipeToChooseGesture.isEnabled = true
        calendar.appearance.todayColor = UIColor.purple
        calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesSingleUpperCase]
        //calendar.select(self.dateFormatter.date(from: "2018/05/10"))
        calendar.firstWeekday = 2
        calendar.locale = Locale(identifier: "fr_FR")
        // For UITest
        self.calendar.accessibilityIdentifier = "calendar"
       
        
        
        
        
        
        
      
        
        DirectionCalendar = "\(self.dateFormatter.string(from: calendar.currentPage))"
        
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idCourse
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellcalendar1")! as! RevenuTableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        print(DEPARTR)
        print(ARRIVER)
        print(PRIXR)
        print(DISTANCER)
        print(HEURER)
        if(idCourse == DEPARTR.count){
        cell.depart.text = DEPARTR[indexPath.row]
        cell.arrive.text = ARRIVER[indexPath.row]
        cell.euro.text = PRIXR[indexPath.row]
        cell.distance.text = DISTANCER[indexPath.row]
        cell.time.text = HEURER[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func respondToGesture(gesture : UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.right:
            print("right")
            DirectionCalendar = "right"
            
        case UISwipeGestureRecognizerDirection.left:
            print("left")
            DirectionCalendar = "left"
            
        default:
            break
        }
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("**¥¥¥¥¥¥¥¥ffffffffffff revenu")
        DispatchQueue.global(qos: .userInitiated).async {
            // Do long running task here
            // Bounce back to the main thread to update the UI
            DispatchQueue.main.async {
                
                
                
                
                self.xview = self.view.center.x
                self.yview = self.view.center.y
                
                
                
               
                
                
//                self.txtlabeuroyears.text = "\(LabEuroYears)"
//                self.txtlabnbrcourseyears.text = "\(LabNbrCourseYears)"
//                self.txtlabnoteyears.text = "\(LabNoteYears)"
                
                
            }}
    }
    
  
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.stopAnimating()
        let activityInd = NVActivityIndicatorView(frame: CGRect(x: self.xview - 25, y: self.yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
        self.view.addSubview(activityInd)
        
        buttdétailsmois.backgroundColor = UIColor.clear//init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
        self.viewtxttotal.isHidden = true
        
        self.txtrevenuJour.text = "-- €"
        self.txtnbrCourseJour.text = "--"
        self.txtheureJour.text = "--"
        self.txtnoteJour.text = "--"
        
        let formatterselct = DateFormatter()
        formatterselct.dateFormat = "dd-MM-yyyy"
        
        
        self.lab_le_date.text = "\(formatterselct.string(from: date))"
        print("did select date \(formatterselct.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
            
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            // Do long running task here
            // Bounce back to the main thread to update the UI
            DispatchQueue.main.async {
        self.calendar.reloadData()
              //  self..text = "\(selectedDates)"
        self.tableView.reloadData()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
                let datenow = Date()
               
        let currentDate = formatter.string(from: datenow)
        let selectDate = "\(self.dateFormatter.string(from: date))"
                
                print("mm1 \(String(describing: currentDate))")
                print("mm2 \(String(describing: selectDate))")
                
        let debutDate = "\(DEBUT_TRV)"
                
                
                
                switch selectDate.compare(currentDate) {
              
                case .orderedAscending:
                    print("Date   before date current")
                    
                    switch selectDate.compare(debutDate) {
                        
                    case .orderedAscending:
                        print("Date   before date debut")
                        self.viewtbl.isHidden = true
                         //self.viewtxttotal.isHidden = false
                        calendar.appearance.selectionColor = UIColor.init(red: 78/255, green: 88/255, blue: 100/255, alpha: 1)
                        calendar.appearance.borderSelectionColor = UIColor.white
                        
                        let appearance1 = SCLAlertView.SCLAppearance(
                            kCircleIconHeight: 45.0,
                            kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                            kTextFont: UIFont(name: "Roboto", size: 13)!,
                            kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                            showCloseButton: false
                        )
                        
                        // Initialize SCLAlertView using custom Appearance
                        let alertView = SCLAlertView(appearance: appearance1)
                        alertView.addButton("OK"){
                            alertView.dismiss(animated: true, completion: nil)
                        }
                        
                        alertView.showNotice("NOTICE", subTitle: "Divulgation des revenus entre la date de début (\(debutDate)) et aujourd'hui.", colorStyle: 0x002c4c)
                        
                    case .orderedSame:
                        print("The two dates are the same (select + debut)")
                        calendar.appearance.selectionColor = UIColor.init(red: 03/255, green: 150/255, blue: 1, alpha: 1)
                        calendar.appearance.borderSelectionColor = UIColor.white
                        self.startAnimating(message: "", type: NVActivityIndicatorType.ballRotateChase)
                        
                        
//                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
//                            self.stopAnimating()
                        self.viewtbl.isHidden = false
                            self.viewtxttotal.isHidden = true
                            self.tableView.isHidden = true
                            
                        self.viewtbl.isHidden = true

                            
                           
                            
//                                            self.calendar.layer.shadowColor = UIColor.white.cgColor
//                                            self.calendar.layer.shadowOpacity = 0.5
//                                            self.calendar.layer.shadowOpacity = 10.0
//                                            self.calendar.layer.shadowOffset = .zero
//                                            self.calendar.layer.shadowPath = UIBezierPath(rect: self.calendar.bounds).cgPath
//                                            self.calendar.layer.shouldRasterize = false
                            self.datecettejour = "\(self.dateFormatter.string(from: date))"
                            self.getRevenuJour(start: "\(self.dateFormatter.string(from: date))", end: "\(self.dateFormatter.string(from: date))")
                        
                       // }
                        
                    case .orderedDescending:
                        print("Date  after date debut")
                        calendar.appearance.selectionColor = UIColor.init(red: 03/255, green: 150/255, blue: 1, alpha: 1)
                        calendar.appearance.borderSelectionColor = UIColor.white
                        self.startAnimating(message: "", type: NVActivityIndicatorType.ballRotateChase)
                        
                        
//                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
//                            self.stopAnimating()
                        self.viewtbl.isHidden = false
                            self.viewtxttotal.isHidden = true
                            self.tableView.isHidden = true
                        
                        self.viewtbl.isHidden = true

                            
                            self.datecettejour = "\(self.dateFormatter.string(from: date))"
                            self.getRevenuJour(start: "\(self.dateFormatter.string(from: date))", end: "\(self.dateFormatter.string(from: date))")
                        //}
                    }
            
                    
                case .orderedSame:
                    print("The two dates are the same")
                    calendar.appearance.selectionColor = UIColor.init(red: 03/255, green: 150/255, blue: 1, alpha: 1)
                    calendar.appearance.borderSelectionColor = UIColor.white
                    self.startAnimating(message: "", type: NVActivityIndicatorType.ballRotateChase)
                    
                    
//                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
//                        self.stopAnimating()
                    self.viewtbl.isHidden = false
                        self.viewtxttotal.isHidden = true
                        self.tableView.isHidden = true
                        
                    self.viewtbl.isHidden = true

                    
                        self.datecettejour = "\(self.dateFormatter.string(from: date))"
                        self.getRevenuJour(start: "\(self.dateFormatter.string(from: date))", end: "\(self.dateFormatter.string(from: date))")
                    
                    //}
                    
                case .orderedDescending:
                    print("Date  after date current")
                    self.viewtbl.isHidden = true
                     //self.viewtxttotal.isHidden = false
                    calendar.appearance.selectionColor = UIColor.init(red: 78/255, green: 88/255, blue: 100/255, alpha: 1)
                    calendar.appearance.borderSelectionColor = UIColor.white
                    
                    let appearance1 = SCLAlertView.SCLAppearance(
                        kCircleIconHeight: 45.0,
                        kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                        kTextFont: UIFont(name: "Roboto", size: 13)!,
                        kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                        showCloseButton: false
                    )
                    
                    // Initialize SCLAlertView using custom Appearance
                    let alertView = SCLAlertView(appearance: appearance1)
                    alertView.addButton("OK"){
                        alertView.dismiss(animated: true, completion: nil)
                    }
                    
                    alertView.showNotice("NOTICE", subTitle: "Divulgation des revenus entre la date de début (\(debutDate)) et aujourd'hui.", colorStyle: 0x002c4c)
                }
        
self.calendar.reloadData()
                
            }}
        
    }
    
    
    
    
    
  
    
    // MARK:- FSCalendarDelegate
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendar.frame.size.height = bounds.height
        self.eventLabel.frame.origin.y = calendar.frame.maxY + 10
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition)   -> Bool {
        return monthPosition == .current
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return monthPosition == .current
    }
    
   
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date) {
        print("did deselect date \(self.dateFormatter.string(from: date))")
   
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventColorFor date: Date) -> UIColor? {
        let dateString = self.dateFormatter.string(from: date)
        if self.datesWithEvent.contains(dateString) {
            return UIColor.purple
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        let key = self.dateFormatter.string(from: date)
        if self.datesWithMultipleEvents.contains(key) {
            return [UIColor.magenta, appearance.eventDefaultColor, UIColor.black]
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        let key = self.dateFormatter.string(from: date)
        if let color = self.fillSelectionColors[key] {
            return color
        }
        return appearance.selectionColor
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let key = self.dateFormatter.string(from: date)
        if let color = self.fillDefaultColors[key] {
            return color
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
        let key = self.dateFormatter.string(from: date)
        if let color = self.borderDefaultColors[key] {
            return color
        }
        return appearance.borderDefaultColor
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderSelectionColorFor date: Date) -> UIColor? {
        let key = self.dateFormatter.string(from: date)
        if let color = self.borderSelectionColors[key] {
            return color
        }
        return appearance.borderSelectionColor
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderRadiusFor date: Date) -> CGFloat {
        if [1].contains((self.gregorian.component(.day, from: date))) {
            return 0.0
        }
        return 1.0
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.dateFormatter.string(from: date)
        if self.datesWithEvent.contains(dateString) {
            return 1
        }
        if self.datesWithMultipleEvents.contains(dateString) {
            return 3
        }
        return 0
    }
    
    
    @IBAction func buttdétailmoiss(_ sender: Any) {
        
        
        viewtbl.isHidden = true
        
        
        if(viewtxttotal.isHidden == false){
            buttdétailsmois.backgroundColor = UIColor.clear//init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
            viewtxttotal.isHidden = true
        }else{
            
            
        
            self.txtlabrevenutot.text = "--"
            self.txtlabnbrcourse.text = "--"
            self.txtlabhtrav.text = "--"
            self.txtlabnoteT.text = "--"
            
            
            
            
            print("scolling horiz \(self.dateFormatter.string(from: calendar.currentPage))")
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            let gggg = formatter.date(from: DEBUTMOIS)
            
            let Qalendar = NSCalendar.current
            let components = Qalendar.dateComponents([.year, .month, .day], from: gggg!)
            let startOfMonth = Qalendar.date(from: components)
            
            
           // print(, dateFormatter.string(from: startOfMonth!))
            
            let comps2 = NSDateComponents()
            comps2.month = 1
            comps2.day = -1
            let endOfMonth = Qalendar.date(byAdding: comps2 as DateComponents, to: startOfMonth!)// dateByAddingComponents(comps2, toDate: startOfMonth, options: [])!
            
            
           // print(dateFormatter.string(from: endOfMonth!))
      
            
            
            
            
            let start_mounth = "\(dateFormatter.string(from: startOfMonth!))"
            let end_mounth = "\(dateFormatter.string(from: endOfMonth!))"
            
            
            
            let activityInd = NVActivityIndicatorView(frame: CGRect(x: xview - 25, y: yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)

            NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
            NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
            view.addSubview(activityInd)


            self.startAnimating(message: "", type: NVActivityIndicatorType.ballRotateChase)
            
            
            
            getRevenuMois(start: start_mounth, end: end_mounth)
            
            
        }
        
        
    }
    
    
    
  
    
    
    
    
    
    @IBAction func buttPlusdétails(_ sender: Any) {
        
      
        let activityInd = NVActivityIndicatorView(frame: CGRect(x: xview - 25, y: yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.ballRotateChase, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
        view.addSubview(activityInd)
        
        
        self.startAnimating(message: "", type: NVActivityIndicatorType.ballRotateChase)
        self.getlistcourse(start: datecettejour, end: datecettejour)
        
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
    
        print("scolling horiz \(self.dateFormatter.string(from: calendar.currentPage))")
        
      
        
        
        DEBUTMOIS = self.dateFormatter.string(from: calendar.currentPage)
        print("fff")
        print(DEBUTMOIS)

        
        self.viewtbl.isHidden = true
         viewtxttotal.isHidden = true
        buttdétailsmois.backgroundColor = UIColor.clear//init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1).withAlphaComponent(0.6)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let datenow = Date()
        
        let currentDate = formatter.string(from: datenow)
        let pageDate = "\(self.dateFormatter.string(from: calendar.currentPage))"
        
        print("mm1 \(String(describing: currentDate))")
        print("mm2 \(String(describing: pageDate))")
        
        let debutDate = DEBUT_TRV
        
        
        
//        switch pageDate.compare(currentDate) {
//
//        case .orderedAscending:
//            print("Date   before date current")
//
//            switch pageDate.compare(debutDate) {
//
//            case .orderedAscending:
//                print("Date   before date debut")
//
//
//
//                //value:  "My String"
//                // let last3Chars = String(debutDate.characters.suffix(2)) // last3Chars = "ing"
//                let valueDEbutdate = "\(debutDate)"
//                let first2Chars = String(valueDEbutdate.characters.prefix(8)) // first2Chars = "My"
//                if(pageDate == "\(first2Chars)01"){
//                    print("In if test direction \(first2Chars)01")
//                    labrevenutot.isHidden = false
//                    labnbrcourse.isHidden = false
//                    labhtrav.isHidden = false
//                    txtlabrevenutot.isHidden = false
//                    txtlabhtrav.isHidden = false
//                    txtlabnbrcourse.isHidden = false
//
//
//
//                    self.txtlabrevenutot.text = REVENU_TOT[0]
//                    self.txtlabnbrcourse.text = NBR_COURSE[0]
//                    self.txtlabhtrav.text = H_TRV[0]
//                }else {
//                    labrevenutot.isHidden = true
//                    labnbrcourse.isHidden = true
//                    labhtrav.isHidden = true
//                    txtlabrevenutot.isHidden = true
//                    txtlabhtrav.isHidden = true
//                    txtlabnbrcourse.isHidden = true
//                }
//
//            case .orderedSame:
//                print("The two dates are the same (select + debut)")
//
//                labrevenutot.isHidden = false
//                labnbrcourse.isHidden = false
//                labhtrav.isHidden = false
//                txtlabrevenutot.isHidden = false
//                txtlabhtrav.isHidden = false
//                txtlabnbrcourse.isHidden = false
//
//
//
//                self.txtlabrevenutot.text = REVENU_TOT[0]
//                self.txtlabnbrcourse.text = NBR_COURSE[0]
//                self.txtlabhtrav.text = H_TRV[0]
//
//
//
//
//            case .orderedDescending:
//                print("Date  after date debut")
//
//
//                labrevenutot.isHidden = false
//                labnbrcourse.isHidden = false
//                labhtrav.isHidden = false
//                txtlabrevenutot.isHidden = false
//                txtlabhtrav.isHidden = false
//                txtlabnbrcourse.isHidden = false
//
//
//
//
//
//
//
//
//
//
//                switch pageDate.compare(DirectionCalendar) {
//
//                case .orderedAscending:
//                    print("Date   before date direction")
//
//
//                    COUNT_RT = COUNT_RT - 1
//                    COUNT_NBRC = COUNT_NBRC - 1
//                    COUNT_HTRV = COUNT_HTRV - 1
//
//                    self.txtlabrevenutot.text = REVENU_TOT[COUNT_HTRV]
//                    self.txtlabnbrcourse.text = NBR_COURSE[COUNT_NBRC]
//                    self.txtlabhtrav.text = H_TRV[COUNT_HTRV]
//
//
//
//                case .orderedDescending:
//                    print("Date  after date direction")
//                    COUNT_RT = COUNT_RT + 1
//                    COUNT_NBRC = COUNT_NBRC + 1
//                    COUNT_HTRV = COUNT_HTRV + 1
//
//                    self.txtlabrevenutot.text = REVENU_TOT[COUNT_HTRV]
//                    self.txtlabnbrcourse.text = NBR_COURSE[COUNT_NBRC]
//                    self.txtlabhtrav.text = H_TRV[COUNT_HTRV]
//
//
//                case .orderedSame:
//                    print("chrash")
//                }
//
//
//
//                DirectionCalendar = "\(self.dateFormatter.string(from: calendar.currentPage))"
//
//
//
////                if(DirectionCalendar == "left"){
////                    COUNT_RT = COUNT_RT + 1
////                    COUNT_NBRC = COUNT_NBRC + 1
////                    COUNT_HTRV = COUNT_HTRV + 1
////
////                    self.txtlabrevenutot.text = REVENU_TOT[COUNT_HTRV]
////                    self.txtlabnbrcourse.text = NBR_COURSE[COUNT_NBRC]
////                    self.txtlabhtrav.text = H_TRV[COUNT_HTRV]
////
////                }else{
////                    COUNT_RT = COUNT_RT - 1
////                    COUNT_NBRC = COUNT_NBRC - 1
////                    COUNT_HTRV = COUNT_HTRV - 1
////
////                    self.txtlabrevenutot.text = REVENU_TOT[COUNT_HTRV]
////                    self.txtlabnbrcourse.text = NBR_COURSE[COUNT_NBRC]
////                    self.txtlabhtrav.text = H_TRV[COUNT_HTRV]
////                }
//            }
//
//
//        case .orderedSame:
//            print("The two dates are the same")
//
//
//            labrevenutot.isHidden = false
//            labnbrcourse.isHidden = false
//            labhtrav.isHidden = false
//            txtlabrevenutot.isHidden = false
//            txtlabhtrav.isHidden = false
//            txtlabnbrcourse.isHidden = false
//
//
//
//            self.txtlabrevenutot.text = REVENU_TOT[REVENU_TOT.count - 1]
//            self.txtlabnbrcourse.text = NBR_COURSE[NBR_COURSE.count - 1]
//            self.txtlabhtrav.text = H_TRV[H_TRV.count - 1]
//
//
//        case .orderedDescending:
//            print("Date  after date current")
//
//            labrevenutot.isHidden = true
//            labnbrcourse.isHidden = true
//            labhtrav.isHidden = true
//            txtlabrevenutot.isHidden = true
//            txtlabhtrav.isHidden = true
//            txtlabnbrcourse.isHidden = true
//
//
//        }
        
        
        if(self.dateFormatter.string(from: calendar.currentPage) == "2018-03-01"){
            print("mounth debut")
            //calendar.select("2018/03/14")
         }
   print("TEST Direction index.row", COUNT_RT)
    }

   
    
   
    func getRevenuMois(start: String, end: String)
    {
        
        let tok = "\(token)"
        
        
        let postString = ["start":"\(start) 00:00", "end":"\(end) 23:59"] as [String : Any]
        
        let url = NSURL(string: "\(weburl)/api/driver/GetRevenu")
        let request = NSMutableURLRequest(url: url! as URL)
        
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            print("€€€€€€€€€€ (Revenu Mois) start = \(start) end:\(end)  €€€€€€€€")
            
            
            
            
            if error != nil
            {
                print("problème seveur")
                
                DispatchQueue.main.async {
                    let status = Reach().connectionStatus()
                    switch status {
                    case .unknown, .offline:
                        print("Not connected")
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            self.viewtxttotal.isHidden = true
                            self.buttdétailsmois.backgroundColor = UIColor.clear
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
                            alertView.addButton("OK"){
                                alertView.dismiss(animated: true, completion: nil)
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                        
                        
                    case .online(.wwan):
                        print("Connected via WWAN")
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            self.viewtxttotal.isHidden = true
                            self.buttdétailsmois.backgroundColor = UIColor.clear
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
                            alertView.addButton("OK"){
                                alertView.dismiss(animated: true, completion: nil)
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                        
                    case .online(.wiFi):
                        print("Connected via WiFi")
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            self.viewtxttotal.isHidden = true
                            self.buttdétailsmois.backgroundColor = UIColor.clear
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
                            alertView.addButton("OK"){
                                alertView.dismiss(animated: true, completion: nil)
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                        
                        
                    }
                    
                }
                
                
                
                return
            }
            
            do
            {
                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                    print("Json **€€ \(json) €€** Json")
                    if let Dict0 = json["success"]{
                        
                        let Dict1 : NSArray = Dict0 as! NSArray
                        
                        let Dict:NSDictionary = Dict1[0] as! NSDictionary
                    
                    DispatchQueue.main.async {
                        self.stopAnimating()
                        
                        
                    }
                    DispatchQueue.main.async {
                        
                        self.viewtxttotal.isHidden = false
                        self.buttdétailsmois.backgroundColor = UIColor.init(red: 1/255, green: 69/255, blue: 118/255, alpha: 1)
                        
                        if let prixtot = Dict["brut"]{
                            
                            let ns_prix = prixtot as! Int
//                            let int_prix = Int(ns_prix)
//                            let double_prix = Double(int_prix)
//                            let x = String(format: "%.2f", double_prix)
                            self.txtlabrevenutot.text = "\(ns_prix) €"
                            
                        }else{
                            print("prix tot n'existe pas")
                            self.txtlabrevenutot.text = "--"
                        }
                        
                        if let courset = Dict["all_course"]{
                            
                            self.txtlabnbrcourse.text = "\(courset)"
                            
                        }else{
                            print("courset n'existe pas")
                            self.txtlabnbrcourse.text = "--"
                        }
                        
                        if let heuret = Dict["time"]{
                            
//                            let ns_heure = heuret as! NSNumber
//                            let int_heure = Int(ns_heure)
//                            let double_heure = Double(int_heure)
//                            let Par_heure = double_heure/60
                            self.txtlabhtrav.text = "\(heuret)"
                            
                        }else{
                            print("heuret n'existe pas")
                            self.txtlabhtrav.text = "--"
                        }
                        
                        if let notet = Dict["note"]{
                            let fl_notet = notet as! Float
                            let float_notet = Float(fl_notet)
                            let x = String(format: "%.1f", float_notet)
                            self.txtlabnoteT.text = "\(x)"
                            
                        }else{
                            print("notet n'existe pas")
                            self.txtlabnoteT.text = "--"
                        }
                        
                        
                        
                        }}else{
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            self.viewtxttotal.isHidden = true
                            self.buttdétailsmois.backgroundColor = UIColor.clear
                            
                            
                            
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
                            alertView.addButton("OK"){
                                alertView.dismiss(animated: true, completion: nil)
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                    }
                    
                }else {
                    DispatchQueue.main.async {
                        self.stopAnimating()
                        self.viewtxttotal.isHidden = true
                        self.buttdétailsmois.backgroundColor = UIColor.clear
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                        let appearance1 = SCLAlertView.SCLAppearance(
                            kCircleIconHeight: 45.0,
                            kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                            kTextFont: UIFont(name: "Roboto", size: 13)!,
                            kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                            showCloseButton: false
                        )
                        
                        // Initialize SCLAlertView using custom Appearance
                        let alertView = SCLAlertView(appearance: appearance1)
                        alertView.addButton("OK"){
                            alertView.dismiss(animated: true, completion: nil)
                        }
                        
                        alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                        
                    }
                }
            }
            catch let error as NSError
            {
                print(error)
                DispatchQueue.main.async {
                    let status = Reach().connectionStatus()
                    switch status {
                    case .unknown, .offline:
                        print("Not connected")
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            self.viewtxttotal.isHidden = true
                            self.buttdétailsmois.backgroundColor = UIColor.clear
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
                            alertView.addButton("OK"){
                                alertView.dismiss(animated: true, completion: nil)
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                        
                        
                    case .online(.wwan):
                        print("Connected via WWAN")
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            self.viewtxttotal.isHidden = true
                            self.buttdétailsmois.backgroundColor = UIColor.clear
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
                            alertView.addButton("OK"){
                                alertView.dismiss(animated: true, completion: nil)
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                        
                    case .online(.wiFi):
                        print("Connected via WiFi")
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            self.viewtxttotal.isHidden = true
                            self.buttdétailsmois.backgroundColor = UIColor.clear
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
                            alertView.addButton("OK"){
                                alertView.dismiss(animated: true, completion: nil)
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                        
                        
                    }
                    
                }
            }
        }
        task.resume()
    }
    
   
    func getRevenuJour(start: String, end: String)
    {
        
        let tok = "\(token)"
        
        
        let postString = ["start":"\(start) 00:00", "end":"\(end) 23:59"] as [String : Any]
        
        let url = NSURL(string: "\(weburl)/api/driver/GetRevenu")
        let request = NSMutableURLRequest(url: url! as URL)
        
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            print("€€€€€€€€€€ (Revenu Jours) start = \(start) end:\(end)  €€€€€€€€")
            
            
            
            
            if error != nil
            {
                print("problème seveur")
                
                DispatchQueue.main.async {
                    let status = Reach().connectionStatus()
                    switch status {
                    case .unknown, .offline:
                        print("Not connected")
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            self.viewtbl.isHidden = true

                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
                            alertView.addButton("OK"){
                                alertView.dismiss(animated: true, completion: nil)
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                        
                        
                    case .online(.wwan):
                        print("Connected via WWAN")
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            self.viewtbl.isHidden = true

                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
                            alertView.addButton("OK"){
                                alertView.dismiss(animated: true, completion: nil)
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                        
                    case .online(.wiFi):
                        print("Connected via WiFi")
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            self.viewtbl.isHidden = true

                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
                            alertView.addButton("OK"){
                                alertView.dismiss(animated: true, completion: nil)
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                        
                        
                    }
                    
                }
                
                
                
                return
            }
            
            do
            {
                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                    print("Json **€€ \(json) €€** Json")
                    if let Dict0 = json["success"]{
                        
                        let Dict1 : NSArray = Dict0 as! NSArray
                        
                        let Dict:NSDictionary = Dict1[0] as! NSDictionary
                        
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            
                            
                        }
                        DispatchQueue.main.async {
                            
                            self.viewtbl.isHidden = false

                            
                            self.lab_le_date.isHidden = false
                            self.revenuJour.isHidden = false
                            self.txtrevenuJour.isHidden = false
                            self.labnbrCourseJour.isHidden = false
                            self.txtnbrCourseJour.isHidden = false
                            self.labheureJours.isHidden = false
                            self.txtheureJour.isHidden = false
                            self.labnoteJour.isHidden = false
                            self.txtnoteJour.isHidden = false
                            
                            self.buttplusdetaill.isHidden = false
                            
                            if let prixtot = Dict["brut"]{

                                let ns_prix = prixtot as! Int
//                                let int_prix = Int(ns_prix)
//                                let double_prix = Double(int_prix)
//                                let x = String(format: "%.2f", double_prix)
                                self.txtrevenuJour.text = "\(ns_prix) €"

                            }else{
                                print("prix tot n'existe pas")
                                self.txtrevenuJour.text = "--"
                            }

                            if let courset = Dict["all_course"]{

                                self.txtnbrCourseJour.text = "\(courset)"

                            }else{
                                print("courset n'existe pas")
                                self.txtnbrCourseJour.text = "--"
                            }

                            if let heuret = Dict["time"]{

//                                let ns_heure = heuret as! NSNumber
//                                let int_heure = Int(ns_heure)
//                                let double_heure = Double(int_heure)
//                                let Par_heure = double_heure/60
                                self.txtheureJour.text = "\(heuret)"

                            }else{
                                print("heuret n'existe pas")
                                self.txtheureJour.text = "--"
                            }
                            
                            
                            if let notej = Dict["note"]{
                                let flt_notej = notej as! Float
                                let float_notej = Float(flt_notej)
                                let x = String(format: "%.1f", float_notej)
                                self.txtnoteJour.text = "\(x)"
                                
                            }else{
                                print("notej n'existe pas")
                                self.txtnoteJour.text = "--"
                            }
                            
                            
                        }}else{
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            self.viewtbl.isHidden = true
                            
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
                            alertView.addButton("OK"){
                                alertView.dismiss(animated: true, completion: nil)
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                    }
                    
                }else {
                    DispatchQueue.main.async {
                        self.stopAnimating()
                        self.viewtbl.isHidden = true

                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                        let appearance1 = SCLAlertView.SCLAppearance(
                            kCircleIconHeight: 45.0,
                            kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                            kTextFont: UIFont(name: "Roboto", size: 13)!,
                            kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                            showCloseButton: false
                        )
                        
                        // Initialize SCLAlertView using custom Appearance
                        let alertView = SCLAlertView(appearance: appearance1)
                        alertView.addButton("OK"){
                            alertView.dismiss(animated: true, completion: nil)
                        }
                        
                        alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                        
                    }
                }
            }
            catch let error as NSError
            {
                print(error)
                DispatchQueue.main.async {
                    let status = Reach().connectionStatus()
                    switch status {
                    case .unknown, .offline:
                        print("Not connected")
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            self.viewtbl.isHidden = true

                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
                            alertView.addButton("OK"){
                                alertView.dismiss(animated: true, completion: nil)
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue.", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                        
                        
                    case .online(.wwan):
                        print("Connected via WWAN")
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            self.viewtbl.isHidden = true

                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
                            alertView.addButton("OK"){
                                alertView.dismiss(animated: true, completion: nil)
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                        
                    case .online(.wiFi):
                        print("Connected via WiFi")
                        DispatchQueue.main.async {
                            self.stopAnimating()
                            self.viewtbl.isHidden = true

                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
                            alertView.addButton("OK"){
                                alertView.dismiss(animated: true, completion: nil)
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                            
                        }
                        
                        
                    }
                    
                }
            }
        }
        task.resume()
    }
   
    
    
    func getlistcourse(start: String, end: String)
            {
                
                let tok = "\(token)"
                
                
                let postString = ["start":"\(start) 00:00", "end":"\(end) 23:59"] as [String : Any]
                
                let url = NSURL(string: "\(weburl)/api/driver/GetCoursesDetails")
                let request = NSMutableURLRequest(url: url! as URL)
                
                
                request.httpMethod = "POST"
                
                request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
                
                
                let task = URLSession.shared.dataTask(with: request as URLRequest)
                {(data,response,error) -> Void in
                    print("******** oloooooooooooooo listecourse ***********")
                    print("€€€€€€€€€€ (course de jour) start = \(start) end:\(end)  €€€€€€€€")
            
            if error != nil
            {
                
                print("rrrr", error?.localizedDescription as Any)
                print("error in get detail ")
                
                
                DispatchQueue.main.async {
                    self.stopAnimating()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                    
                    
                    let appearance1 = SCLAlertView.SCLAppearance(
                        kCircleIconHeight: 45.0,
                        kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                        kTextFont: UIFont(name: "Roboto", size: 13)!,
                        kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                        showCloseButton: false
                    )
                    
                    // Initialize SCLAlertView using custom Appearance
                    let alertView = SCLAlertView(appearance: appearance1)
                    alertView.addButton("OK"){
                        alertView.dismiss(animated: true, completion: nil)
                        
                        
                    }
                    
                    alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                }
                return
            }
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                print(json)
                
                if let message = json["message"] {
                    print("4 get detail")
                    
                    print("*****", message)
                    let Attributmsg = message as! String
                    if(Attributmsg == "Unauthenticated."){
                        keychain.clear()
                        let defaults = UserDefaults.standard
                        let dictionary = defaults.dictionaryRepresentation()
                        dictionary.keys.forEach { key in
                            defaults.removeObject(forKey: key)
                        }
                        
                        DispatchQueue.main.async{
                            UserDefaults.standard.set(true, forKey: "lauchedBefore")
                            
                            
                        }
                        DispatchQueue.main.async{
                            
                            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "idConnection") as! ConnexionViewController
                            
                            self.present(myVC, animated: false, completion: nil)
                        }
                    }else {
                        DispatchQueue.main.async {
                            self.stopAnimating()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                            
                            
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
                            alertView.addButton("OK"){
                                alertView.dismiss(animated: true, completion: nil)
                                
                                
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                        }
                    }
                    
                }
                else{
                    
                    self.idCourse = Int()
                    
                    self.DEPARTR.removeAll()
                    self.ARRIVER.removeAll()
                    self.PRIXR.removeAll()
                    self.DISTANCER.removeAll()
                    self.HEURER.removeAll()
                    
                    if let course = json["success"] as? [[String: Any]]{
                        self.idCourse = course.count
                        
                        if(course.count > 0){
                            
                            DispatchQueue.main.async {
                        for i in 0 ..< course.count {
                            
                            let dep = course[i]["adrarriv"]
                            let resultdep = self.checkNull(obj: dep as AnyObject)
                            if(resultdep == true){
                                print("dep is nil")
                            }
                            else{
                                print("dep:", dep!)
                                
                                let depdep = dep as! String
                                self.DEPARTR.append(depdep)
                            }
                            //////
                            let arr = course[i]["adrdep"]
                            let resultarr = self.checkNull(obj: arr as AnyObject)
                            if(resultarr == true){
                                print("arr is nil")
                            }
                            else{
                                print("arr:", arr!)
                                
                                let arrarr = arr as! String
                                self.ARRIVER.append(arrarr)
                            }
                            ///////
                            let eur = course[i]["prixtotal"]
                            let resulteur = self.checkNull(obj: eur as AnyObject)
                            if(resulteur == true){
                                print("eur is nil")
                            }
                            else{
                                print("eur:", eur!)
                                
                                let eureur = eur as! String
                                self.PRIXR.append(eureur)
                            }
                            //////
                            let dis = course[i]["distance"]
                            let resultdis = self.checkNull(obj: dis as AnyObject)
                            if(resultdis == true){
                                print("dis is nil")
                            }
                            else{
                                print("dis:", dis!)
                                
                                let ns_dis = dis as! Int
//                                let km_disf:Float = Float(ns_dis)/100
//
//
//                                print("km-dis", km_disf, ns_dis)
//                                let double_dis = Double(km_disf)
//                                let x = String(format: "%.2f", double_dis)
                                let strg_dis = String(ns_dis)
                                self.DISTANCER.append(strg_dis)
                            }
                            /////
                            let tim = course[i]["heure"]
                            let resulttim = self.checkNull(obj: tim as AnyObject)
                            if(resulttim == true){
                                print("tim is nil")
                            }
                            else{
                                print("tim:", tim!)
                                
                                let timtim = tim as! String
                                self.HEURER.append(timtim)
                            }
                            //////
                            DispatchQueue.main.async {
                                
                                self.stopAnimating()
                                
                                
                                self.viewtxttotal.isHidden = true
                                
                                self.lab_le_date.isHidden = true
                                self.revenuJour.isHidden = true
                                self.txtrevenuJour.isHidden = true
                                self.labnbrCourseJour.isHidden = true
                                self.txtnbrCourseJour.isHidden = true
                                self.labheureJours.isHidden = true
                                self.txtheureJour.isHidden = true
                                self.labnoteJour.isHidden = true
                                self.txtnoteJour.isHidden = true
                                
                                self.buttplusdetaill.isHidden = true
                                
                                
                                self.tableView.reloadData()
                                self.tableView.isHidden = false
                                
                            }
                            
                            
                            
                            
                            }}
                        }else{
                            DispatchQueue.main.async {
                                self.stopAnimating()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                                
                                
                                let appearance1 = SCLAlertView.SCLAppearance(
                                    kCircleIconHeight: 45.0,
                                    kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                    kTextFont: UIFont(name: "Roboto", size: 13)!,
                                    kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                    showCloseButton: false
                                )
                                
                                // Initialize SCLAlertView using custom Appearance
                                let alertView = SCLAlertView(appearance: appearance1)
                                alertView.addButton("OK"){
                                    alertView.dismiss(animated: true, completion: nil)
                                    
                                }
                                
                                alertView.showNotice("Oops", subTitle: "Vous n'avez pas de course", colorStyle: 0x002c4c)
                            }
                        }
                        
                        
                        
                    }else {
                        
                        DispatchQueue.main.async {
                            self.stopAnimating()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                            
                            
                            let appearance1 = SCLAlertView.SCLAppearance(
                                kCircleIconHeight: 45.0,
                                kTitleFont: UIFont(name: "Roboto-Bold", size: 17)!,
                                kTextFont: UIFont(name: "Roboto", size: 13)!,
                                kButtonFont: UIFont(name: "Roboto-Bold", size: 15)!,
                                showCloseButton: false
                            )
                            
                            // Initialize SCLAlertView using custom Appearance
                            let alertView = SCLAlertView(appearance: appearance1)
                            alertView.addButton("OK"){
                                alertView.dismiss(animated: true, completion: nil)
                                
                            }
                            
                            alertView.showError("ERREUR", subTitle: "La connexion Internet semble interrompue. Réessayer", colorStyle: 0x002c4c, circleIconImage: UIImage(named: "WhiteSmile"))
                        }
                        
                    }
                    
                    
                }
            }
            catch let error as NSError
            {
                
                print(error.localizedDescription)
                
            }
        }
        task.resume()
        
    }
    
    func checkNull(obj : AnyObject?) -> Bool {
        if obj is NSNull {
            return true
        } else {
            return false
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
           
            txtlabnoteyears.font = txtlabnoteyears.font.withSize(18)
            txtlabnbrcourseyears.font = txtlabnbrcourseyears.font.withSize(18)
            txtlabeuroyears.font = txtlabeuroyears.font.withSize(18)
            
            labrevenutot.font = labrevenutot.font.withSize(10)
            labnbrcourse.font = labnbrcourse.font.withSize(10)
            labhtrav.font = labhtrav.font.withSize(10)
            labnoteT.font = labnoteT.font.withSize(10)
            
            txtlabrevenutot.font = txtlabrevenutot.font.withSize(25)
            txtlabnbrcourse.font = txtlabnbrcourse.font.withSize(23)
            txtlabhtrav.font = txtlabhtrav.font.withSize(23)
            txtlabnoteT.font = txtlabnoteT.font.withSize(23)
            
            
            buttdétailsmois.titleLabel?.font = buttdétailsmois.titleLabel?.font.withSize(14)
            
            lab_le_date.font = lab_le_date.font.withSize(15)
            revenuJour.font = revenuJour.font.withSize(10)
            txtrevenuJour.font = txtrevenuJour.font.withSize(25)
            labnbrCourseJour.font = labnbrCourseJour.font.withSize(10)
            txtnbrCourseJour.font = txtnbrCourseJour.font.withSize(25)
            labheureJours.font = labheureJours.font.withSize(10)
            txtheureJour.font = txtheureJour.font.withSize(25)
            labnoteJour.font = labnoteJour.font.withSize(10)
            txtnoteJour.font = txtnoteJour.font.withSize(25)
            
            
            return
        //.iPhones_5_5s_5c_SE
        case 1334:
            print("iPhones_6_6s_7_8")
            
            return
        //.iPhones_6_6s_7_8
        case 1920, 2208:
            print("iPhones_6Plus_6sPlus_7Plus_8Plus")
          
            txtlabnoteyears.font = txtlabnoteyears.font.withSize(22)
            txtlabnbrcourseyears.font = txtlabnbrcourseyears.font.withSize(22)
            txtlabeuroyears.font = txtlabeuroyears.font.withSize(22)
            
            labrevenutot.font = labrevenutot.font.withSize(14)
            labnbrcourse.font = labnbrcourse.font.withSize(13)
            labhtrav.font = labhtrav.font.withSize(13)
            labnoteT.font = labnoteT.font.withSize(13)
            
            txtlabrevenutot.font = txtlabrevenutot.font.withSize(38)
            txtlabnbrcourse.font = txtlabnbrcourse.font.withSize(32)
            txtlabhtrav.font = txtlabhtrav.font.withSize(32)
            txtlabnoteT.font = txtlabnoteT.font.withSize(32)
            
            buttdétailsmois.titleLabel?.font = buttdétailsmois.titleLabel?.font.withSize(19)
            
            lab_le_date.font = lab_le_date.font.withSize(19)
            revenuJour.font = revenuJour.font.withSize(14)
            txtrevenuJour.font = txtrevenuJour.font.withSize(37)
            labnbrCourseJour.font = labnbrCourseJour.font.withSize(13)
            txtnbrCourseJour.font = txtnbrCourseJour.font.withSize(32)
            labheureJours.font = labheureJours.font.withSize(13)
            txtheureJour.font = txtheureJour.font.withSize(32)
            labnoteJour.font = labnoteJour.font.withSize(13)
            txtnoteJour.font = txtnoteJour.font.withSize(32)
            
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











