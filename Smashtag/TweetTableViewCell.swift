//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by CS193p Instructor.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell
{
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    
    let hashTagColor = UIColor.blueColor()
    let urlColor = UIColor.brownColor()
    let userMentionColor = UIColor.redColor()
    
    func updateUI() {
        // reset any existing tweet information
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        tweetCreatedLabel?.text = nil
        
        // load new information from our tweet (if any)
        if let tweet = self.tweet
        {
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil  {
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
                
                let coloredText = NSMutableAttributedString(string: tweet.text)
                for hashTag in tweet.hashtags {
                    coloredText.addAttribute(NSForegroundColorAttributeName,
                        value: hashTagColor,
                        range: hashTag.nsrange)
                }
                for userMention in tweet.userMentions {
                    coloredText.addAttribute(NSForegroundColorAttributeName,
                        value: userMentionColor,
                        range: userMention.nsrange)
                }
                for url in tweet.urls {
                    coloredText.addAttribute(NSForegroundColorAttributeName,
                        value: urlColor,
                        range: url.nsrange)
                }
                tweetTextLabel.attributedText = coloredText
            }
            
            tweetScreenNameLabel?.text = "\(tweet.user)" // tweet.user.description
            
            if let profileImageURL = tweet.user.profileImageURL {
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), {
                    if let imageData = NSData(contentsOfURL: profileImageURL) {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.tweetProfileImageView?.image = UIImage(data: imageData)
                        })
                    }
                })
            }
            
            let formatter = NSDateFormatter()
            if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
                formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            } else {
                formatter.timeStyle = NSDateFormatterStyle.ShortStyle
            }
            tweetCreatedLabel?.text = formatter.stringFromDate(tweet.created)
        }

    }
}
