//
//  TimePopupViewController.swift
//  Project362
//
//  Created by David Chen on 3/5/18.
//  Copyright © 2018 Kameron Carr. All rights reserved.
//

import UIKit

class DatePopupViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var saveTime: UIButton!
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "MM/dd hh:mm a"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTime_TouchUpInside(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindDateSelector", sender: nil)
    }
    
    @IBAction override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? NewPostViewController {
            destination.time.text = formatter.string(from: timePicker.date)
        }
    }
    
}
