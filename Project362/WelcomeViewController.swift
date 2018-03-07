//
//  WelcomeViewController.swift
//  Project362
//
//  Created by Kameron Carr on 3/7/18.
//  Copyright © 2018 Kameron Carr. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    var buying: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buy(_ sender: Any) {
        self.buying = true
        self.performSegue(withIdentifier: "showTable", sender: self)
    }
    @IBAction func sell(_ sender: Any) {
        self.buying = false
        self.performSegue(withIdentifier: "showTable", sender: self)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? PostTableViewController {
            destination.buying = self.buying
        }
    }
}
