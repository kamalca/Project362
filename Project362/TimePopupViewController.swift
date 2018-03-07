//
//  TimePopupViewController.swift
//  Project362
//
//  Created by David Chen on 3/5/18.
//  Copyright © 2018 Kameron Carr. All rights reserved.
//

import UIKit

class TimePopupViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var saveTime: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTime_TouchUpInside(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
}
