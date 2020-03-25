//
//  formCell.swift
//  ACM-Challenge2
//
//  Created by Swamita on 24/03/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import UIKit

class formCell: UITableViewCell {

    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var label4: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
