//
//  ListTableViewCell.swift
//  RecordConsumption
//
//  Created by 林祔利 on 2023/5/9.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var ItemDate: UILabel!
    @IBOutlet weak var ItemPrice: UILabel!
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var ItemImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }

}
