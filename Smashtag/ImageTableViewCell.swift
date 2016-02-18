//
//  ImageTableViewCell.swift
//  Smashtag
//
//  Created by Daniel Nakamashi on 2/17/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell
{
    var mediaItem: MediaItem? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var mediaItemImage: UIImageView!
    
    func updateUI() {
        if let mediaItemImageUrl = mediaItem?.url {
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), { () -> Void in
                if let imageData = NSData(contentsOfURL: mediaItemImageUrl) {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.mediaItemImage?.image = UIImage(data: imageData)
                    })
                }
            })
        }
    }
}
