//
//  formViewController.swift
//  ACM-Challenge2
//
//  Created by Swamita on 24/03/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import UIKit

class formViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var filledForms: [form] = [
        form(name: "Swamita", email: "12@g.com", number: 9699, address: "India"),
        form(name: "Swamita Gupta", email: "12@g.com", number: 9699, address: "India")
    
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self as? UITableViewDataSource
        
        tableView.register(UINib(nibName: "formCell", bundle: nil), forCellReuseIdentifier: "ReusableCell1")

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

extension formViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filledForms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell1", for: indexPath) as! formCell
        cell.label1.text = filledForms[indexPath.row].name
        return cell
    }
    
    
}
