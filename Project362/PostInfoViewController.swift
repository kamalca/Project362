//
//  PostInfoViewController.swift
//  Project362
//
//  Created by Kameron Carr on 2/28/18.
//  Copyright © 2018 Kameron Carr. All rights reserved.
//

import UIKit

class PostInfoViewController: UIViewController {

    @IBOutlet weak var postInfoLabel: UILabel!
    var postIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postInfoLabel.numberOfLines = 0
        postInfoLabel.text = "Really short text. \(postIndex)"
        // Do any additional setup after loading the view.
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
