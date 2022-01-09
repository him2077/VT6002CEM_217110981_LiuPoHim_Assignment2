//
//  CustomCell.swift
//  VT6002CEM_217110981_LiuPoHim_Assignment2
//
//  Created by user211668 on 1/9/22.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var introduction: UILabel!
    var detail : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
