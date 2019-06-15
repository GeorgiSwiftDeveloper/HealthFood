//
//  CreateNoteVC.swift
//  HealthTodayApp
//
//  Created by Georgi Malkhasyan on 6/15/19.
//  Copyright © 2019 Malkhasyan. All rights reserved.
//

import UIKit

class CreateNoteVC: UIViewController {

    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBOutlet weak var selectPostType: UISegmentedControl!
    
    @IBOutlet weak var chooseTimeBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var pickerView: CardView!
    @IBOutlet weak var picker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   

}
