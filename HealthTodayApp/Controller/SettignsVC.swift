//
//  SettignsVC.swift
//  HealthTodayApp
//
//  Created by Georgi Malkhasyan on 6/16/19.
//  Copyright © 2019 Malkhasyan. All rights reserved.
//

import UIKit
import CoreData
import Foundation


class SettignsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
  
    
    @IBOutlet weak var addUserPhoto: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var settingsTableView: UITableView!
    @IBOutlet weak var todayDateLbl: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var designsettingsViww: UIView!
    @IBOutlet weak var goalView: UIView!
    @IBOutlet weak var goalTextField: UITextField!
    
    @IBOutlet var backroundView: UIView!
    
    let settingsList = ["Your Goal","Smart Notification","Clear data","Follow on Instagram", "Follow on Facebook", "Follow on Twitter", "Support Developer","Team"]
    let settingsImage = ["goal","notification","data","instagram","facebook","twitter","message","team"]
    
    
    var coreDataModel = CoreDataStackClass()
    var goal = [Goal]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SettingsCell else {return UITableViewCell()}
        return cell
    }

}
