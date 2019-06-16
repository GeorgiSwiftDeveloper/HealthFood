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
        if let data = UserDefaults.standard.object(forKey: "image"){
            userImage.image = UIImage(data: data as! Data)
        }
        if let userName = UserDefaults.standard.object(forKey: "userName") {
            userNameTextField.text = userName as? String
            
        }
        
        if userImage.image == nil {
            userImage.image = UIImage(named: "addPhoto")
        }
        userImage.layer.cornerRadius = 4
        
        let toolBar = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneEditing))
         let flexibaleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        userNameTextField.inputAccessoryView = toolBar
        toolBar.setItems([flexibaleSpace,doneButton], animated: true)
        toolBar.sizeToFit()
        userNameTextField.delegate = self
        
        todayDateLbl.text = "\(DateService.service.crrentDateTime())"
        settingsTableView.separatorColor = UIColor(white: 0.95, alpha: 1)
    }
    
    
    @objc func doneEditing() {
        view.endEditing(true)
        UserDefaults.standard.set(userNameTextField.text, forKey: "userName")
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
