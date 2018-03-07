//
//  NewPostViewController.swift
//  Project362
//
//  Created by Kameron Carr on 3/6/18.
//  Copyright © 2018 Kameron Carr. All rights reserved.
//

import UIKit
import FacebookCore

class NewPostViewController: UIViewController {

    @IBOutlet weak var BuyOrSell: UISegmentedControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var numberOfSwipes: UITextField!
    @IBOutlet weak var pricePerSwipe: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var time: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var comments: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        saveButton.isEnabled = false
    }

    @IBAction func save(_ sender: Any) {
        dismiss(animated: true) {
            print("Save Data")
            let parameters: [String:Any] = ["name"	: "Kameron",
							  "price"	: self.pricePerSwipe.text!,
							  "swipes"	: self.numberOfSwipes.text!,
							  "location": self.location.text!,
							  "time"	: self.time.text!,
							  "phoneNumber": self.phoneNumber.text!,
							  "comments": self.comments.text]
            
            
//            UserProfile.loadCurrent({ (result) in
//                switch(result)
//                {
//                case .failed(let error):
//                    fatalError()
//                case .success(let profile):
//                    print(profile.firstName!)
//                    parameters["name"] = profile.firstName!
//                }
//            })
//            print(parameters["name"]!)
			DatabaseService.shared.postsReference.childByAutoId().setValue(parameters)
        }
    }
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editingDidBegin(_ sender: Any) {
        saveButton.isEnabled = false
    }
    @IBAction func editingDidEnd(_ sender: UITextField) {
        if (Int(numberOfSwipes.text!) != nil &&
            Double(pricePerSwipe.text!) != nil &&
            location.text != "")
        {
            saveButton.isEnabled = true
        }
        else
        {
            saveButton.isEnabled = false
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            print("Post not saved")
            return
        }
    }

}
