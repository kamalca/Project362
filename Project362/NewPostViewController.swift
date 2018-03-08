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
    var userName: String = "Julia"
    
    let dateReader = DateFormatter()
    let dateWriter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        saveButton.isEnabled = false
        
        //Testing
        UserProfile.loadCurrent({ (result) in
            switch(result)
            {
            case .failed(let error):
                self.userName = "Julia"
            case .success(let profile):
                self.userName = profile.fullName!
            }
        })
        
        
        //DateFormatter.dateFormat(fromTemplate: "MM-YY hh:mm", options: 0, locale: nil)
        dateReader.locale = Locale(identifier: "en_US_POSIX")
        dateWriter.locale = Locale(identifier: "en_US_POSIX")
        dateReader.dateFormat = "YYYY/MM/dd hh:mm a"
        dateWriter.dateFormat = "MM/dd h:mm a"
    }

    @IBAction func save(_ sender: Any) {
        UserProfile.loadCurrent({ (result) in
            switch(result)
            {
            case .failed(let error):
                self.userName = "Julia"
            case .success(let profile):
                self.userName = profile.fullName!
            }
        })
        
            let parameters: [String:Any] = ["name"	: self.userName,
							  "price"	: self.pricePerSwipe.text!,
							  "swipes"	: self.numberOfSwipes.text!,
							  "location": self.location.text!,
							  "time"	: self.time.text!,
							  "phoneNumber": self.phoneNumber.text!,
							  "comments": self.comments.text,
                              "buyer": self.BuyOrSell.selectedSegmentIndex == 0]
            
            
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
        performSegue(withIdentifier: "unwindNewPost", sender: nil)
    }
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEdit(_ sender: UITextField) {
        if let number = phoneNumber.text
        {
            phoneNumber.text = String(number.filter { "01234567890".contains($0) })
        }
        if (Int(numberOfSwipes.text!) != nil &&
            Double(pricePerSwipe.text!) != nil &&
            location.text != "" &&
            phoneNumber.text!.count == 10 &&
            time.text != "" &&
            dateReader.date(from: "2018/" + time.text!) != nil)
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
            
            return
        }
    }
    
    @IBAction func unwindToNewPost(segue:UIStoryboardSegue)
    {
        
    }

}
