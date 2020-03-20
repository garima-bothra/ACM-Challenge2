//
//  ShowProfileDataViewController.swift
//  ACM-Challenge2
//
//  Created by Aaryan Kothari on 20/03/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import UIKit

class ShowProfileDataViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    //MARK: - Variables
    var name : String = ""
    var birthday : String = ""
    var phone : String = ""
    var latitude : String = ""
    var longitude : String = ""
    var gender : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = name
        birthdayLabel.text = birthday
        genderLabel.text = gender
        locationLabel.text = "\(latitude)   \(longitude)"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
