//
//  ViewController.swift
//  Project362
//
//  Created by Kameron Carr on 2/17/18.
//  Copyright © 2018 Kameron Carr. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FacebookShare


class LogInViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UserProfile.updatesOnAccessTokenChange = true
    }

    @IBAction func loginButtonAction(_ sender: UIButton) {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email, .userFriends], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print("Error:::::::\(error)")
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let mainViewController = storyBoard.instantiateViewController(withIdentifier: "MainView")
                
                self.present(mainViewController, animated:false, completion:nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

