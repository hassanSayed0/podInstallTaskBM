//
//  homePageTableViewCell.swift
//  task5
//
//  Created by hassan sayed on 8/11/22.
//

import UIKit

class homePageTableViewCell: UITableViewCell {

    @IBOutlet weak var lblView: UIView!
    
    @IBOutlet weak var lblName: UILabel!
    func setup(name:String) {
        lblName.text = name
    }
}
