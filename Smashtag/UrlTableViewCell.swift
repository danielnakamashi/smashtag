//
//  UrlTableViewCell.swift
//  Smashtag
//
//  Created by Daniel Nakamashi on 2/17/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

class UrlTableViewCell: UITableViewCell
{
    var url: String? {
        didSet {
            updateUI()
        }
    }

    @IBOutlet weak var mentionUrl: UILabel!
    
    func updateUI() {
        mentionUrl?.text = url
    }
}
