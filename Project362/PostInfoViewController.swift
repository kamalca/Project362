//
//  PostInfoViewController.swift
//  Project362
//
//  Created by Kameron Carr on 2/28/18.
//  Copyright © 2018 Kameron Carr. All rights reserved.
//

import UIKit
import Firebase

class PostInfoViewController: UIViewController {

    let dateReader = DateFormatter()
    let dateWriter = DateFormatter()
    @IBOutlet weak var postInfoLabel: UILabel!
    var postIndex: Int = 0
    var posts: [Post] = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postInfoLabel.numberOfLines = 0
        
        dateReader.dateFormat = "YYYY/MM/dd hh:mm a"
        dateWriter.dateFormat = "MM/dd h:mm a"
        
        var comments = posts[postIndex].comments
        if comments == "" {
            comments = "N/A"
        }
        
        var buyerOrSeller = "Seller"
        if (posts[postIndex].buyer == true) {
            buyerOrSeller = "Buyer"
        }
        
        postInfoLabel.text = "\(buyerOrSeller) Name: \(posts[postIndex].name) \n\nNumber of Swipes: \(posts[postIndex].swipes) \n\nPrice of Each Swipe: \(posts[postIndex].price) \n\nDate: \(dateWriter.string(from: dateReader.date(from: "2017/" + posts[postIndex].time)!)) \n\nLocation: \(posts[postIndex].location) \n\nComments: \(comments)"
        
        // Do any additional setup after loading the view.
    }

    @IBAction func contact(_ sender: Any) {
        if (UIApplication.shared.canOpenURL(URL(string: "sms:")!))
        {
            UIApplication.shared.open(URL(string: "sms:" + posts[postIndex].phoneNumber)!, options: [:] , completionHandler:{ (didComplete) in
                //Completion Handler
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
