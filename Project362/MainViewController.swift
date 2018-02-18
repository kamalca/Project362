
import UIKit
import FacebookLogin
import FacebookCore
import FacebookShare

class MainViewController: UIViewController {
    
    @IBOutlet weak var UserInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UserInfoLabel.numberOfLines = 0
        
        UserProfile.loadCurrent { (result) in
            switch(result){
            case .failed(let error):
                print(error)
                print("User Profile didn't load in MainViewController")
                fatalError()
            case .success(let profile):
                self.UserInfoLabel.text = "You are logged in as \(profile.fullName!)"
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
