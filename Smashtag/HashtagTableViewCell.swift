//
//  HashtagTableViewCell.swift
//  Smashtag
//
//  Created by Daniel Nakamashi on 2/17/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

class HashtagTableViewCell: UITableViewCell
{
    var hashTag: String? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var hashTagLabel: UILabel!
    
    func updateUI() {
        hashTagLabel?.text = hashTag
    }
}
