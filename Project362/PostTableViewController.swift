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

    let colorWave: [Int] =
       [0,   0,   0,   0,   0,   1,   1,   2,
        2,   3,   4,   5,   6,   7,   8,   9,
        11,  12,  13,  15,  17,  18,  20,  22,
        24,  26,  28,  30,  32,  35,  37,  39,
        42,  44,  47,  49,  52,  55,  58,  60,
        63,  66,  69,  72,  75,  78,  81,  85,
        88,  91,  94,  97, 101, 104, 107, 111,
        114, 117, 121, 124, 127, 131, 134, 137,
        141, 144, 147, 150, 154, 157, 160, 163,
        167, 170, 173, 176, 179, 182, 185, 188,
        191, 194, 197, 200, 202, 205, 208, 210,
        213, 215, 217, 220, 222, 224, 226, 229,
        231, 232, 234, 236, 238, 239, 241, 242,
        244, 245, 246, 248, 249, 250, 251, 251,
        252, 253, 253, 254, 254, 255, 255, 255,
        255, 255, 255, 255, 254, 254, 253, 253,
        252, 251, 251, 250, 249, 248, 246, 245,
        244, 242, 241, 239, 238, 236, 234, 232,
        231, 229, 226, 224, 222, 220, 217, 215,
        213, 210, 208, 205, 202, 200, 197, 194,
        191, 188, 185, 182, 179, 176, 173, 170,
        167, 163, 160, 157, 154, 150, 147, 144,
        141, 137, 134, 131, 127, 124, 121, 117,
        114, 111, 107, 104, 101,  97,  94,  91,
        88,  85,  81,  78,  75,  72,  69,  66,
        63,  60,  58,  55,  52,  49,  47,  44,
        42,  39,  37,  35,  32,  30,  28,  26,
        24,  22,  20,  18,  17,  15,  13,  12,
        11,   9,   8,   7,   6,   5,   4,   3,
        2,   2,   1,   1,   0,   0,   0,   0,
        0,   0,   0,   0,   0,   0,   0,   0,
        0,   0,   0,   0,   0,   0,   0,   0,
        0,   0,   0,   0,   0,   0,   0,   0,
        0,   0,   0,   0,   0,   0,   0,   0,
        0,   0,   0,   0,   0,   0,   0,   0,
        0,   0,   0,   0,   0,   0,   0,   0,
        0,   0,   0,   0,   0,   0,   0,   0,
        0,   0,   0,   0,   0,   0,   0,   0,
        0,   0,   0,   0,   0,   0,   0,   0,
        0,   0,   0,   0,   0,   0,   0,   0,
        0,   0,   0,   0,   0,   0,   0,   0,
        0,   0,   0,   0,   0,   0,   0,   0,
        0,   0,   0,   0,   0,   0,   0,   0,
        0,   0,   0,   0,   0,   0,   0,   0,
        0,   0,   0,   0,   0,   0,   0,   0]
    
    var tappedPostIndex: Int = 0
	
    var posts = [Post]()
	@IBOutlet weak var postsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		DatabaseService.shared.postsReference.observe(DataEventType.value, with: { (snapshot) in
			guard let postsSnapshot = PostsSnapshot(with: snapshot) else { return }
			print(snapshot)
            self.posts = postsSnapshot.posts
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
        //let red: CGFloat = CGFloat(colorWave[(color+120)%360]) / 255
        //let green: CGFloat = CGFloat(colorWave[(color%360)]) / 255
        //let blue:CGFloat = CGFloat(colorWave[(color+240)%360]) / 255
        //cell.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 0.75)
        //cell.postSummaryLabel.text = "Post Summary"
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
