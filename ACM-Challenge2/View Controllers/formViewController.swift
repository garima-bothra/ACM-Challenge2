//
//  formViewController.swift
//  ACM-Challenge2
//
//  Created by Swamita on 24/03/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import UIKit
import Firebase

class formViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
     let db = Firestore.firestore()
    
    var filledForms: [form] = [
        form(Name: "Swamita", Email: "12@g.com", Phone: "9669", DOB: "India"),
        form(Name: "Swamita Gupta", Email: "12@g.com", Phone: "9699", DOB: "India")
    
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self as? UITableViewDataSource
        
        tableView.register(UINib(nibName: "formCell", bundle: nil), forCellReuseIdentifier: "ReusableCell1")
        
        loadForms()
        

        // Do any additional setup after loading the view.
    }
    
    func loadForms() {
        db.collection("forms").addSnapshotListener { (QuerySnapshot, Error) in
            
            self.filledForms = []
            
            if let e=Error{
                print("Error: \(e)")
            } else {
                if let snapshotDocuments = QuerySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let name = data["Name"] as? String,
                        let email = data["Email"] as? String,
                        let phone = data["Phone"] as? String,
                            let DOB = data["DOB"] as? String {
                            let newForm = form(Name: name, Email: email, Phone: phone, DOB: DOB)
                            self.filledForms.append(newForm)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
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
}

extension formViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filledForms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell1", for: indexPath) as! formCell
        cell.label1.text = filledForms[indexPath.row].Name
        cell.label2.text = filledForms[indexPath.row].Email
        cell.label3.text = filledForms[indexPath.row].Phone
        cell.label4.text = filledForms[indexPath.row].DOB
        print(filledForms[indexPath.row].Name)
        print(indexPath.row)
        return cell
    }
   
    
}


