//
//  LocationPopupViewController.swift
//  Project362
//
//  Created by David Chen on 3/5/18.
//  Copyright © 2018 Kameron Carr. All rights reserved.
//

import UIKit

class LocationPopupViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationPicker: UIPickerView!
    @IBOutlet weak var saveLocation: UIButton!
    
    var loc = ""
    
    let locations = ["BPlate", "Covel", "De Neve", "Feast", "Rendezvous"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationPicker.delegate = self
        locationPicker.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locations[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        loc = locations[row]
    }
    
    
    @IBAction func saveLocation_TouchUpInside(_ sender: UIButton) {
        //let filterVC = storyboard?.instantiateViewController(withIdentifier: "filterVC") as! FilterViewController
        //filterVC.locationSelected = loc
        //navigationController?.pushViewController(filterVC, animated: true)
        
        
        dismiss(animated: true)
    }
}

