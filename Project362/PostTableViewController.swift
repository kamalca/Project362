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
	
    var posts = [Post]()
	@IBOutlet weak var postsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		DatabaseService.shared.postsReference.observe(DataEventType.value, with: { (snapshot) in
			guard let postsSnapshot = PostsSnapshot(with: snapshot) else { return }
			print(snapshot)
            self.posts = postsSnapshot.posts
            self.posts.sort(by: { (post1, post2) -> Bool in
                return post1.time > post2.time
            })
			self.postsTableView.reloadData()
		})
		
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
            destination.posts = self.posts
            
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
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
		if(!posts[indexPath.row].buyer)
        {
            cell.postTitleLabel.text = "Selling " + String(posts[indexPath.row].swipes) + " swipes for $" + String(posts[indexPath.row].price) + " each"
            cell.postSummaryLabel.text = "Sold By: " + posts[indexPath.row].name
        }
        else{
            cell.postTitleLabel.text = "Requesting " + String(posts[indexPath.row].swipes) + " swipes for $" + String(posts[indexPath.row].price) + " each"
            cell.postSummaryLabel.text = "Requested By: " + posts[indexPath.row].name
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tappedPostIndex = indexPath.row
        self.performSegue(withIdentifier: "segueToPost", sender: nil)
    }
    
    @IBAction func unwind(segue:UIStoryboardSegue) {
        print(filter)
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
