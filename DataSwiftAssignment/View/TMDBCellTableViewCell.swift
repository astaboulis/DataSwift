//
//  TMDBCellTableViewCell.swift
//  DataSwiftAssignment
//
//  Created by Angelos Staboulis on 12/7/20.
//  Copyright © 2020 Angelos Staboulis. All rights reserved.
//

import UIKit

class TMDBCellTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMovie: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
