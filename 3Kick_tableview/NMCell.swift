//
//  NMCell.swift
//  3Kick_tableview
//
//  Created by Нечаев Михаил on 11.02.2024.
//

import UIKit

final class NMCell: UITableViewCell {
    
    var checkImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(checkImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = 24.0
        let width = 24.0
        checkImageView.frame = CGRect(
            x: frame.width - 40.0,
            y: (frame.height - width) / 2,
            width: width,
            height: height
        )
    }
    

    
}
