//
//  TimelineTableViewController.swift
//  DemoInsta
//
//  Created by Ayoola Solomon on 7/15/15.
//  Copyright (c) 2015 Ayoola Solomon. All rights reserved.
//

import UIKit

class TimelineTableViewController: UITableViewController {
    
    let ref = Firebase(url: "https://mecrush.firebaseio.com/")
    let usersRef = Firebase(url: "https://mecrush.firebaseio.com/users")
    let cellIdentifier: String = "Cell"
    
    var tableData: [String] = ["BMWW", "Ferrari", "Toyota", "Benz"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.translucent = false
        tableView.registerNib(UINib(nibName: "TimelineTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.parentViewController!.navigationItem.setHidesBackButton(true, animated: false)
        
        self.tableView.rowHeight = 350
        self.tableView.allowsSelection = false
        
        var refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.grayColor()
        refreshControl.tintColor = UIColor.whiteColor()
        refreshControl.addTarget(self, action: Selector("loadAllUsers"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        
        if ref.authData != nil {
            loadAllUsers()
        } else {
            ProgressHUD.showError("Error")
        }
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    var users: [AnyObject] = []
    
    func loadAllUsers() {
        usersRef.observeEventType(FEventType.ChildAdded, withBlock: { (snapshot) -> Void in
            self.users.append(snapshot.value)
            println(self.users)
        }) { (error) -> Void in
            ProgressHUD.showError("Error: \(error.localizedDescription)")
        }
        
        self.refreshControl?.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.tableData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: TimelineTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? TimelineTableViewCell
        
//        let user: AnyObject = self.users[indexPath.row] as AnyObject
//        println("user: \(user)")
        cell?.username.text = self.tableData[indexPath.row]
        
//        if var urlString: String? = user["profile"] as? String {
            var url: NSURL? = NSURL(string: "https://lh5.googleusercontent.com/-q_EwzqjaGiA/AAAAAAAAAAI/AAAAAAAABSg/6iyvndL3uaM/photo.jpg")
//
            cell?.userImage.hnk_setImageFromURL(url!)
//        }
        
        return cell!
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
