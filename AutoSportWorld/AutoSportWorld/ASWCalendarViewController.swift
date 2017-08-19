//
//  ViewController.swift
//  CVCalendar Demo
//
//  Created by Мак-ПК on 1/3/15.
//  Copyright (c) 2015 GameApp. All rights reserved.
//
import UIKit
import FSCalendar


class ASWCalendarViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    

    
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var titleView: UIView!
   
    
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    
    fileprivate lazy var dateFormatter1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    fileprivate lazy var monthLabeldateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    var datesWithEvent = ["2017-08-01","2017-08-02","2017-08-03"]
    var datesWithMultipleEvents = ["2017-08-04","2017-08-05","2017-08-06"]
    
    
    
    
    
//    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
//        calendar.allowsMultipleSelection = false
//        var cell = calendar.cell(for: date, at: monthPosition)
//        cell?.backgroundColor = UIColor.gray
//        return true
//    }
//    
//    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
//        
//        var cell = calendar.cell(for: date, at: monthPosition)
//        cell?.backgroundColor = UIColor.white
//        return true
//    }
    
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        setTodayCell(cell: cell, date: date, selected: false)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        var cell = calendar.cell(for: date, at: monthPosition)

        cell = setTodayCell(cell: cell!, date: date,selected: true)
        
    
    }
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        var cell = calendar.cell(for: date, at: monthPosition)
        
        cell = setTodayCell(cell: cell!, date: date,selected: false)

    }
    
    
    
    func setTodayCell(cell:FSCalendarCell,date:Date,selected:Bool)->FSCalendarCell{
        cell.contentView.layer.borderWidth = 0
        cell.contentView.layer.cornerRadius = 10.0
        cell.contentView.clipsToBounds = true
        cell.clipsToBounds = true
        
        if(selected && dateFormatter1.string(from: date) == dateFormatter1.string(from: Date())){
            cell.contentView.layer.borderWidth = 2
            cell.contentView.backgroundColor = UIColor.white
            cell.titleLabel.textColor = UIColor.black
            cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
            //cell.imageView.isHidden = true
        }
        else{
            if(selected){
                cell.contentView.layer.borderWidth = 2
                cell.contentView.backgroundColor = UIColor.gray
                cell.titleLabel.textColor = UIColor.white
            }
            else{
                cell.contentView.backgroundColor = UIColor.white
                cell.titleLabel.textColor = UIColor.black
            }
            
            if(dateFormatter1.string(from: date) == dateFormatter1.string(from: Date())){
                cell.contentView.layer.borderWidth = 2
                cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
                cell.backgroundColor = UIColor.white
            }
        }
        
                return cell
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.allowsMultipleSelection = false
        calendar.swipeToChooseGesture.isEnabled = false
        calendar.backgroundColor = UIColor.white
        
        //first day = monday
        calendar.firstWeekday = 0
        calendar.appearance.headerMinimumDissolvedAlpha = 0;
        calendar.appearance.headerTitleFont = calendar.appearance.headerTitleFont.withSize(0)
        calendar.appearance.titleFont.withSize(26)
        calendar.appearance.weekdayFont.withSize(26)
        
        calendar.appearance.borderRadius = 0// квадрат
        
        calendar.appearance.todayColor = UIColor.white
        
        
        calendar.appearance.borderSelectionColor = UIColor.gray.withAlphaComponent(0)
        calendar.appearance.selectionColor = UIColor.gray.withAlphaComponent(0)
        calendar.appearance.todaySelectionColor = UIColor.gray.withAlphaComponent(0)
        
        calendar.layer.cornerRadius = 10.0
        calendar.clipsToBounds = true
        titleView.layer.cornerRadius = 10.0
        titleView.clipsToBounds = true

        
        self.title = "Календарь событий"
       
        //calendar.select(Date())
    }

   
   
    func todayItemClicked(sender: AnyObject) {
        self.calendar.setCurrentPage(Date(), animated: false)
    }
    
    //date selected
    func calendar(_ calendar: FSCalendar, didSelect date: Date) {
        NSLog(self.dateFormatter2.string(from: date))
    }
   
    //month change
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        updateMonthLabel()
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.dateFormatter2.string(from: date)
        if self.datesWithEvent.contains(dateString) {
            return 1
            
        }
        if self.datesWithMultipleEvents.contains(dateString) {
            return 3
        }
        return 0
    }
    
    func updateMonthLabel(){
        let date = calendar.currentPage
        monthLabel.text = monthLabeldateFormatter.string(from: date)
    }
    
    @IBAction func previousMonth(_ sender: Any) {
        var date = calendar.currentPage
        date = Calendar.current.date(byAdding: .month, value: -1, to: date)!
        calendar.setCurrentPage(date, animated: true)
    }
    
    @IBAction func nextMonth(_ sender: Any) {
        var date = calendar.currentPage
        date = Calendar.current.date(byAdding: .month, value: 1, to: date)!
        calendar.setCurrentPage(date, animated: true)
    }

    

}
