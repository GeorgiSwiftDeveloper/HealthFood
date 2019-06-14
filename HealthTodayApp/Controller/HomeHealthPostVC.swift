//
//  ViewController.swift
//  HealthTodayApp
//
//  Created by Georgi Malkhasyan on 6/13/19.
//  Copyright © 2019 Malkhasyan. All rights reserved.
//

import UIKit
import Charts
import CoreData

class HomeHealthPostVC: UIViewController, ChartViewDelegate , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var yourGoalLbl: UILabel!
    @IBOutlet weak var goalLbl: UILabel!
    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var notePostTableView: UITableView!
    @IBOutlet weak var cardViewHeightLayout: NSLayoutConstraint!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var goodScoreLbl: UILabel!
    @IBOutlet weak var badScoreLbl: UILabel!
    
    
    var healthModelData = [HealthModel]()
    var goal = [Goal]()
    var coreDataModel = CoreDataStackClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateDataByWeek()
        chartViewDesingFunction()
    }
    
    
    func chartViewDesingFunction() {
        chartView.delegate = self
        chartView.setExtraOffsets(left: 0, top: 0, right: 0, bottom: 0)
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: DateService.service.weekDays.shortWeekdaySymbols)
        chartView.xAxis.granularity = 1.0
        chartView.doubleTapToZoomEnabled = false
        
        //Xaxis Label
        let xAxis: XAxis? = chartView.xAxis
        xAxis?.labelPosition = .top
        xAxis?.labelTextColor = .black
        xAxis?.labelFont = UIFont(name: "Helvetica", size: 12)!
        xAxis?.drawGridLinesEnabled = false
        chartView.rightAxis.drawLabelsEnabled = false
        chartView.leftAxis.drawLabelsEnabled = false
        //Grid
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.rightAxis.drawGridLinesEnabled = false
        
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
        
        chartView.maxVisibleCount = 0
        chartView.drawBarShadowEnabled = false
        chartView.legend.enabled = false
        chartView.highlightPerTapEnabled = true
        chartView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        chartView.reloadInputViews()
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }


    
    func updateDataByWeek() {
        let managedContext = coreDataModel.persistentContainer.viewContext
        let request = NSFetchRequest<HealthModel>(entityName: "HealthModel")
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let dayOfWeek = calendar.component(.weekday, from: today)
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: today)!
        let days = (weekdays.lowerBound ..< weekdays.upperBound)
            .compactMap { calendar.date(byAdding: .weekday, value: $0 - dayOfWeek, to: today) }
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let week =  days.map({ (DateelementOfCollection) -> Date in
            return DateelementOfCollection
        })
        
        let frompredicate = NSPredicate(format: "postTime > %@", week[0]  as CVarArg)
        let topredicate = NSPredicate(format: "postTime  <> %@",  week[6] as CVarArg )
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [frompredicate, topredicate])
        request.predicate = datePredicate
        do{
            let result = try managedContext.fetch(request)
            var aRed = Double()
            var agrean = Double()
            
            var goodArray = [String]()
            var badArray = [String]()
            var index: Int = -1
            var chardtData = [BarChartDataEntry]()
            for mydate in week {
                index += 1
                for getData in result {
                    if formatter.string(from: getData.postTime!) == formatter.string(from: mydate)  {
                        if getData.selectedType == "good"{
                            agrean += 3.0
                        }else if getData.selectedType == "bad" {
                            aRed -= 3.0
                        }
                    }
                }
                
                chardtData.append(BarChartDataEntry(x: Double(index), y: aRed))
                chardtData.append(BarChartDataEntry(x: Double(index), y: agrean))
                aRed = 0.0
                agrean = 0.0
            }
            
            for getData in result {
                if formatter.string(from: getData.postTime!) == formatter.string(from: Date()) {
                    if getData.selectedType == "good"{
                        goodArray.append(getData.selectedType!)
                    }else if getData.selectedType == "bad" {
                        badArray.append(getData.selectedType!)
                    }
                }
            }
            if goodArray.count < 1 {
                goodScoreLbl.isHidden = true
            }else{
                goodScoreLbl.text = "\(goodArray.count)"
                goodScoreLbl.isHidden = false
            }
            
            if badArray.count < 1 {
                badScoreLbl.isHidden = true
            }else{
                badScoreLbl.text = "\(badArray.count)"
                badScoreLbl.isHidden = false
            }
            
            
            let red = ColorSelection.colorPicker.badType
            let green = ColorSelection.colorPicker.goodType
            let colors = chardtData.map { (entry) -> NSUIColor in
                return entry.y < 0 ? red : green
            }
            let set =
                BarChartDataSet(entries: chardtData, label: "Values")
            set.colors = colors
            set.valueColors = colors
            
            let data = BarChartData(dataSet: set)
            data.setValueFont(.systemFont(ofSize: 10))
            
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 1
            data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
            data.barWidth = 0.3
            chartView.data = data
        }catch let error as NSError{
            print(error.description)
        }
    }
    
    
    
    func fetchDataByDate() {
        let managedContext = coreDataModel.persistentContainer.viewContext
        let request = NSFetchRequest<HealthModel>(entityName: "HealthModel")
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        // Get today's beginning & end
        let dateFrom = calendar.startOfDay(for: Date())
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)
        let frompredicate = NSPredicate(format:"postTime > %@", dateFrom as CVarArg)
        let toPredicate = NSPredicate(format: "postTime < %@", dateTo! as NSDate)
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [frompredicate, toPredicate])
        request.predicate = datePredicate
        
        let sectionSortDescriptor = NSSortDescriptor(key: "postTime", ascending: true)
        let sortDescriptors = [sectionSortDescriptor]
        request.sortDescriptors = sortDescriptors
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        do {
            healthModelData = try managedContext.fetch(request)
            for item in healthModelData {
//                print("\(item.brandName)aaaaaaaa")
                item.value(forKey: "userComment")
                item.value(forKey: "postTime")
                item.value(forKey: "selectedType")
                item.value(forKey: "brandName")
            }
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return healthModelData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "noteHealthCell", for: indexPath) as? NoteTableViewCell else {return UITableViewCell()}
        cell.configureCell(post: healthModelData[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

