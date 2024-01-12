//
//  GroupTableViewCell.swift
//  myTodoList
//
//  Created by 홍희곤 on 1/12/24.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    func setCell(indexPath:IndexPath) {
        self.titleLabel.text = categoryList[indexPath.row].title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
