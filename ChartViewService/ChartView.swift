//
//  ChartView.swift
//  HealthTodayApp
//
//  Created by Georgi Malkhasyan on 6/14/19.
//  Copyright © 2019 Malkhasyan. All rights reserved.
//

import Foundation
import Charts
import UIKit



class ChartDesignService {
  
    @IBOutlet weak var chartView: BarChartView!
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
