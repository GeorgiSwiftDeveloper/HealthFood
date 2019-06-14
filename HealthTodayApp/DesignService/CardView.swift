//
//  CardView.swift
//  HealthTodayApp
//
//  Created by Georgi Malkhasyan on 6/14/19.
//  Copyright © 2019 Malkhasyan. All rights reserved.
//

import Foundation
import UIKit


class CardView: UIView {
    let contentView = UIView()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureAll()
    }
    
    // MARK: - Configuration
    
    private func configureAll() {
        configureCell()
    }
    
    private func configureCell() {
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = self.contentView.layer.cornerRadius
    }
}
