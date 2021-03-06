//
//  PostTableViewController.swift
//  Project362
//
//  Created by Kameron Carr on 2/21/18.
//  Copyright © 2018 Kameron Carr. All rights reserved.
//

import UIKit
import Firebase

class PostTableViewController: UITableViewController {
    
    var tappedPostIndex: Int = 0
    var filter: String = ""
    var buying: Bool = false
	
    var posts = [Post]()
    var displayedPosts = [Post]()
	@IBOutlet weak var postsTableView: UITableView!
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    let dateReader = DateFormatter()
    let dateWriter = DateFormatter()
    
    func reload() {
        DatabaseService.shared.postsReference.observe(DataEventType.value, with: { (snapshot) in
            guard let postsSnapshot = PostsSnapshot(with: snapshot) else { return }
            self.posts = postsSnapshot.posts
            
            self.displayedPosts = [Post]()
            
            //Filter
            for post in self.posts{
                if (post.buyer != self.buying)
                {
                    if(self.filter == "" || post.location == self.filter || post.location == "No Preference")
                    {
                            self.displayedPosts.append(post)
                    }
                }
            }
            
            //Sort
            self.displayedPosts.sort(by: { (post1, post2) -> Bool in
                return self.dateReader.date(from: "2018/" + post1.time)! < self.dateReader.date(from: "2018/" + post2.time)!
            })
            
            self.postsTableView.reloadData()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationController?.isNavigationBarHidden = false
        dateReader.dateFormat = "YYYY/MM/dd hh:mm a"
        dateWriter.dateFormat = "MM/dd h:mm a"
        
        if (buying)
        {
            navBar.title = "Sellers"
        }
        else{
            navBar.title = "Buyers"
        }
        reload()
		
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let destination = segue.destination as? PostInfoViewController {
            
            //pass data here
            destination.postIndex = tappedPostIndex
            destination.posts = self.displayedPosts
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParentViewController {
            self.navigationController?.isNavigationBarHidden = true
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return displayedPosts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "PostViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PostTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetch the appropriate post for the data source layout.
        var color: Int = indexPath.row
        color *= 36
        color /= 10
		if(!displayedPosts[indexPath.row].buyer)
        {
            if Int(displayedPosts[indexPath.row].swipes)! == 1 {
                cell.postTitleLabel.text = "1 swipe for $" + (NSString(format: "%.2f", Double(displayedPosts[indexPath.row].price)!) as String)
            }
            else {
                cell.postTitleLabel.text = String(displayedPosts[indexPath.row].swipes) + " swipes for $" + (NSString(format: "%.2f", Double(displayedPosts[indexPath.row].price)!) as String) + " each"
            }
            cell.postSummaryLabel.text = "  " + displayedPosts[indexPath.row].location + " at " + dateWriter.string(from: dateReader.date(from: "2018/" + displayedPosts[indexPath.row].time)!)
        }
        else{
            if Int(displayedPosts[indexPath.row].swipes)! == 1 {
                cell.postTitleLabel.text = "1 swipe for $" + (NSString(format: "%.2f", Double(displayedPosts[indexPath.row].price)!) as String)
            }
            else {
                cell.postTitleLabel.text = String(displayedPosts[indexPath.row].swipes) + " swipes for $" + (NSString(format: "%.2f", Double(displayedPosts[indexPath.row].price)!) as String) + " each"
            }
            cell.postSummaryLabel.text = "  " + displayedPosts[indexPath.row].location + " at " + dateWriter.string(from: dateReader.date(from: "2018/" + displayedPosts[indexPath.row].time)!)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tappedPostIndex = indexPath.row
        self.performSegue(withIdentifier: "segueToPost", sender: nil)
    }
    
    @IBAction func unwind(segue:UIStoryboardSegue) {
        reload()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
