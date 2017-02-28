//
//  TableViewTitleCell.swift
//  iOSInterviewQuestion
//
//  Created by 郑娇鸿 on 17/2/26.
//  Copyright © 2017年 郑娇鸿. All rights reserved.
//

import UIKit
import SnapKit

class TableViewTitleCell: UITableViewCell {

    var icon: UIImageView!
    var title: UILabel!
    var bottomLine: UIView!
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = TabelViewCellConfig.contentViewBackgroundColor
        
        icon = UIImageView.init(image: UIImage.init(named: "assignment_unselected"))
        self.contentView.addSubview(icon)
        
        title = UILabel.init()
        title.textColor = TabelViewCellConfig.titleColor
        title.font = TabelViewCellConfig.titleFont
        self.contentView.addSubview(title)
        
        bottomLine = UIView.init()
        bottomLine.backgroundColor = TabelViewCellConfig.bottomLineColor
        self.contentView.addSubview(bottomLine)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        icon.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerY.equalTo(self.contentView.center.y)
            ConstraintMaker.left.equalTo(self.contentView.snp.left).offset(TabelViewCellConfig.iconLeftMarge)
            ConstraintMaker.width.equalTo(TabelViewCellConfig.iconWidth)
            ConstraintMaker.height.equalTo(TabelViewCellConfig.iconHeight)

        }
        
        title.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerY.equalTo(self.contentView.center.y)
            ConstraintMaker.left.equalTo(icon.snp.right).offset(TabelViewCellConfig.titleLeftMarge)
            ConstraintMaker.right.equalTo(self.contentView.snp.right).offset(TabelViewCellConfig.titleRightMarge)
            ConstraintMaker.height.equalTo(TabelViewCellConfig.titleHeight);
        }
        
        bottomLine.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.bottom.equalTo(self.snp.bottom)
            ConstraintMaker.left.equalTo(self).offset(TabelViewCellConfig.bottomLineLeftMarge)
            ConstraintMaker.right.equalTo(self)

            ConstraintMaker.height.equalTo(TabelViewCellConfig.bottomLineHeight)
        }
        
    }
    
    func config(model: Question) -> () {
        title.text = model.question
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    deinit {
        print("cell deinit")
    
    }

}

class TabelViewCellConfig {
    
    //size icon
    fileprivate static let iconWidth = 18
    fileprivate static let iconHeight = 12
    fileprivate static let iconLeftMarge = 40
    
    fileprivate static let titleHeight = 15
    fileprivate static let titleLeftMarge = 15
    fileprivate static let titleRightMarge = 20
    
    fileprivate static let bottomLineHeight = 0.5
    fileprivate static let bottomLineLeftMarge = 40

    //font
    fileprivate static let titleFont = UIFont.systemFont(ofSize: 14)
    
    //color
    fileprivate static let titleColor = UIColor.init(colorLiteralRed: 0.3, green: 0.3, blue: 0.3, alpha: 1)
    
    fileprivate static let bottomLineColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    
    fileprivate static let contentViewBackgroundColor = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)

}
