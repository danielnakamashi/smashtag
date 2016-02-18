//
//  UserTableViewCell.swift
//  Smashtag
//
//  Created by Daniel Nakamashi on 2/17/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell
{
    var user: String? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var userLabel: UILabel!
    
    func updateUI() {
        userLabel?.text = user
    }
}
