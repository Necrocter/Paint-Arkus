//
//  PaintTableViewCell.swift
//  Paint
//
//  Created by Julio Barrera on 22/10/19.
//  Copyright © 2019 Julio Barrera. All rights reserved.
//

import UIKit

class PaintTableViewCell: UITableViewCell {
    
    @IBOutlet weak var paintView: UIView!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
