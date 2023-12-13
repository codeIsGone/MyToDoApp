//
//  MyTableViewCell.swift
//  myTodoList
//
//  Created by 홍희곤 on 12/12/23.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    //ViewController 클래스 내부 메서드에 연결됨
    @IBOutlet weak var myLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
