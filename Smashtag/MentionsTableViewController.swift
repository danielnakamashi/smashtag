//
//  MentionsTableViewController.swift
//  Smashtag
//
//  Created by Daniel Nakamashi on 2/17/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

class MentionsTableViewController: UITableViewController {
    
    var tweet: Tweet?
    var sectionsName = ["Images", "Urls", "Hashtags", "Users"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        var sum = 0
        if tweet?.media.count > 0 {
            sum++
        } else {
            if let index = sectionsName.indexOf("Images") {
                sectionsName.removeAtIndex(index)
            }
        }
        if tweet?.urls.count > 0 {
            sum++
        } else {
            if let index = sectionsName.indexOf("Urls") {
                sectionsName.removeAtIndex(index)
            }
        }
        if tweet?.hashtags.count > 0 {
            sum++
        } else {
            if let index = sectionsName.indexOf("Hashtags") {
                sectionsName.removeAtIndex(index)
            }
        }
        if tweet?.userMentions.count > 0 {
            sum++
        } else {
            if let index = sectionsName.indexOf("Users") {
                sectionsName.removeAtIndex(index)
            }
        }
        
        return sum
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch sectionsName[section] {
        case "Images": return tweet?.media.count ?? 0
        case "Urls": return tweet?.urls.count ?? 0
        case "Hashtags": return tweet?.hashtags.count ?? 0
        case "Users": return tweet?.userMentions.count ?? 0
        default: return 0
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsName[section]
//        return section < sectionsName.count ? sectionsName[section] : ""
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch sectionsName[indexPath.section] {
        case "Images":
            let cell = tableView.dequeueReusableCellWithIdentifier("Image", forIndexPath: indexPath) as! ImageTableViewCell
            cell.mediaItem = tweet?.media[indexPath.row]
            return cell
        case "Urls":
            let cell = tableView.dequeueReusableCellWithIdentifier("Url", forIndexPath: indexPath) as! UrlTableViewCell
            cell.url = tweet?.text.substringWithRange((tweet?.urls[indexPath.row].range)!)
            return cell
        case "Hashtags":
            let cell = tableView.dequeueReusableCellWithIdentifier("Hashtag", forIndexPath: indexPath) as! HashtagTableViewCell
            cell.hashTag = tweet?.text.substringWithRange((tweet?.hashtags[indexPath.row].range)!)
            return cell
        case "Users":
            let cell = tableView.dequeueReusableCellWithIdentifier("UserMention", forIndexPath: indexPath) as! UserTableViewCell
            cell.user = tweet?.text.substringWithRange((tweet?.userMentions[indexPath.row].range)!)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch sectionsName[indexPath.section] {
        case "Hashtags":
            performSegueWithIdentifier("Show Tweets", sender: tweet!.text.substringWithRange(tweet!.hashtags[indexPath.row].range))
        case "Users":
            performSegueWithIdentifier("Show Tweets", sender: tweet!.text.substringWithRange(tweet!.userMentions[indexPath.row].range))
        default: break
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationViewController = segue.destinationViewController as? TweetTableViewController {
            if let search = sender as? String {
                destinationViewController.searchText = search
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
