//
//  CalendarTableViewCell.swift
//  HealthTodayApp
//
//  Created by Georgi Malkhasyan on 6/15/19.
//  Copyright © 2019 Malkhasyan. All rights reserved.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    
    func configureCell(post: HealthModel) {
        descriptionLbl.text = post.brandName
        commentLbl.text = post.userComment
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "MMM-dd HH:mm"
        timeLbl.text = dateFormatter.string(from: post.postTime!)
        if post.selectedType == PostType.healthy.rawValue {
            selectedView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }else if post.selectedType == PostType.notHealthy.rawValue {
            selectedView.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        }
    }

}
