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

class HomeHealthPostVC: UIViewController {
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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

