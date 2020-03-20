//
//  DataViewController.swift
//  ACM-Challenge2
//
//  Created by Aaryan Kothari on 20/03/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import UIKit
import FirebaseFirestore

class DataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var userinfo = [String: String]()
    
    
    var user =  [[String:String]](){
           didSet {
               DispatchQueue.main.async {
                   self.tableView.reloadData()
               }
           }
       }
    
    var names : [String] = []
    
    override func viewDidLoad() {
        getData()
        super.viewDidLoad()
    }
    
    //MARK: - Get Data From FireBase
    func getData(){
        
        let db = Firestore.firestore()
        
            db.collection("users").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    
                print("Error getting documents: \(err)")
                    
                } else {
                    for document in querySnapshot!.documents {
                        
                        if let name = document.data()["name"] as? String
                            
                        , let birthday = document.data()["birthday"] as? String
                                
                            , let phone = document.data()["phone"] as? String
                                    
                                    , let latitude = document.data()["lat"] as? String
                            
                                        , let city = document.data()["city"] as? String
                            
                                            , let state = document.data()["state"] as? String
                            
                                                , let country = document.data()["country"] as? String

                                                    , let gender = document.data()["gender"] as? Int
                                            
                                                        ,let longitude = document.data()["long"] as? String {
                                                
                            self.userinfo = ["name":name,"birthday":birthday,"phone":phone,"gender":String(gender),"lat":latitude,"long":longitude,"city":city,"state":state,"country":country]
                                            
                                                self.user.append(self.userinfo)
                                                print(self.userinfo)
                                                    }
                            }
                        }
            self.tableView.reloadData()
                }
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? dataTableViewCell
        
        cell?.nameLabel.text = user[indexPath.row]["name"]
        cell?.cityLabel.text = (user[indexPath.row]["city"] ?? "") + "," + (user[indexPath.row]["state"] ?? "")
        cell?.selectedBackgroundView = UIView()
                
        let sex = user[indexPath.row]["gender"]
        
        switch sex {
            
        case "0":
            //cell?.profileImage.image = UIImage(named: "m")
            cell?.profileImage.image = UIImage(named: "Profile Picture")
            
        case "1":
            //cell?.profileImage.image = UIImage(named: "f")
            cell?.profileImage.image = UIImage(named: "f")
        default:
            cell?.profileImage.image = UIImage(named: "Profile Picture")
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                tableView.deselectRow(at: indexPath, animated: true)
        

        //perform segue
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "ShowProfileDataViewController") as? ShowProfileDataViewController

        let data = user[indexPath.row]
        
        vc?.name = data["name"] ?? ""
        
        vc?.birthday = data["birthday"] ?? ""

        vc?.phone = data["phone"] ?? ""
        
        vc?.gender = data["gender"] ?? ""
        
        vc?.latitude = data["lat"] ?? ""
        
        vc?.longitude = data["long"] ?? ""

        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
}
