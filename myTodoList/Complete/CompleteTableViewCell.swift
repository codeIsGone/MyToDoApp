//
//  completeTableViewCell.swift
//  myTodoList
//
//  Created by 홍희곤 on 1/12/24.
//

import UIKit

class CompleteTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
