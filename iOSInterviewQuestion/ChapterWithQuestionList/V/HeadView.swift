//
//  HeadView.swift
//  iOSInterviewQuestion
//
//  Created by 郑娇鸿 on 17/2/25.
//  Copyright © 2017年 郑娇鸿. All rights reserved.
//

import UIKit
import SnapKit
protocol HeadViewProtocol: class {
    func headViewClicked(chapterModel: ChapterModel,headView: HeadView) -> ();
}

class HeadView: UITableViewHeaderFooterView {
    
    var icon: UIImageView!
    var titleLabel: UILabel!
    var indicateIcon: UIImageView!
    var practiceIcon: UIImageView!
    var practiceLabel: UILabel!
    var testIcon: UIImageView!
    var testLabel: UILabel!
    var bottomLine: UIView!
    var cellModel: ChapterModel!
    weak var delegate:HeadViewProtocol?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.buildHeadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        icon.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(self.snp.top)
            ConstraintMaker.left.equalTo(self.snp.left)
            ConstraintMaker.width.equalTo(self.snp.height)
            ConstraintMaker.height.equalTo(self.snp.height)
        }
        
        titleLabel.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(self)
            ConstraintMaker.left.equalTo(icon.snp.right)
            ConstraintMaker.right.equalTo(indicateIcon.snp.left)
            ConstraintMaker.height.equalTo(HeadViwInfo.titleLabelHeight);
        }
        indicateIcon.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.right.equalTo(self.snp.right).offset(HeadViwInfo.indicateIconRightMarge)
            ConstraintMaker.centerY.equalTo(self.snp.centerY)
            ConstraintMaker.width.equalTo(HeadViwInfo.indicateIconWidth)
            ConstraintMaker.height.equalTo(HeadViwInfo.indicateIconHeight)

        }
        practiceIcon.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(titleLabel.snp.bottom)
            ConstraintMaker.left.equalTo(icon.snp.right)
            ConstraintMaker.height.equalTo(HeadViwInfo.practiceIconWidth)
            ConstraintMaker.width.equalTo(HeadViwInfo.practiceIconHeight)
        }
        practiceLabel.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(titleLabel.snp.bottom)
            ConstraintMaker.left.equalTo(practiceIcon.snp.right).offset(HeadViwInfo.practiceLabelLeftMarge)
            ConstraintMaker.width.equalTo(HeadViwInfo.practiceLabelWidth)
            ConstraintMaker.height.equalTo(HeadViwInfo.practiceLabelHeight)
          
        }
        testIcon.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(titleLabel.snp.bottom)
            ConstraintMaker.left.equalTo(practiceLabel.snp.right)
            ConstraintMaker.height.equalTo(HeadViwInfo.testIconWidth)
            ConstraintMaker.width.equalTo(HeadViwInfo.testIconHeight)
        }
        testLabel.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(titleLabel.snp.bottom)
            ConstraintMaker.left.equalTo(testIcon.snp.right).offset(HeadViwInfo.testLabelLeftMarge)
            ConstraintMaker.width.equalTo(HeadViwInfo.testLabelWidth)
            ConstraintMaker.height.equalTo(HeadViwInfo.testLabelHeight)
            
        }
        bottomLine.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.bottom.equalTo(self.snp.bottom)
            ConstraintMaker.left.right.equalTo(self)
            ConstraintMaker.height.equalTo(HeadViwInfo.bottomLineHeight)
        }
    }
    
    deinit {
        print("HeadView deinit")
    
    }

}

// 创建视图
extension HeadView {
    func buildHeadView() -> () {
        
        //self.contentView.backgroundColor 默认是有颜色的
        self.contentView.backgroundColor = UIColor.white
        
        titleLabel = UILabel.init();
        titleLabel.textColor = HeadViwInfo.titleLabelTextColor
        titleLabel.font = HeadViwInfo.titleLabelFont
        self.contentView.addSubview(titleLabel);
        
        icon = UIImageView.init();
        self.contentView.addSubview(icon);
        
        indicateIcon = UIImageView.init()
        indicateIcon.image = UIImage.init(named: "showMenu1")
        self.contentView.addSubview(indicateIcon)
        
        practiceIcon = UIImageView.init()
        practiceIcon.image = UIImage.init(named: "headViewP")
        self.contentView.addSubview(practiceIcon)

        practiceLabel = UILabel.init();
        practiceLabel.textColor = HeadViwInfo.practiceLabelTextColor
        practiceLabel.font = HeadViwInfo.practiceLabelFont
        self.contentView.addSubview(practiceLabel);
        
        testIcon = UIImageView.init()
        testIcon.image = UIImage.init(named: "headViewT")
        self.contentView.addSubview(testIcon)

        testLabel = UILabel.init();
        testLabel.textColor = HeadViwInfo.testLabelTextColor
        testLabel.font = HeadViwInfo.testLabelFont
        self.contentView.addSubview(testLabel);

        bottomLine = UIView.init()
        bottomLine.backgroundColor = HeadViwInfo.bottomLineColor
        self.contentView.addSubview(bottomLine)
        
        self.selfAddTapGesture()
    }
    
}

// 添加tap手势
extension HeadView {
    func selfAddTapGesture() -> () {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(HeadView.tapAction))
 
        self.addGestureRecognizer(tap)
    }
    
    func tapAction() -> () {
        
        UIView.animate(withDuration: HeadViwInfo.foldDuration) {
            
            if self.cellModel.foldingState == ChapterFoldingSectionState.ChapterSectionStateFlod {
                self.cellModel.foldingState = ChapterFoldingSectionState.ChapterSectionStateShow
                self.indicateIcon.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI));

            } else {
                self.cellModel.foldingState = ChapterFoldingSectionState.ChapterSectionStateFlod
                self.indicateIcon.transform = CGAffineTransform(rotationAngle: CGFloat(0));

            }

        }
        
        delegate?.headViewClicked(chapterModel: self.cellModel, headView:self)

    }
}

// 配置headView
extension HeadView {
    func configHeadView(model:ChapterModel) -> () {
        cellModel = model;
        titleLabel.text = model.title
        practiceLabel.text = model.practiceNumber
        testLabel.text = model.questionNumber
        icon.image = UIImage.init(named: model.chapterIcon)
        
        //保持箭头方向
        if ChapterFoldingSectionState.ChapterSectionStateFlod == model.foldingState {
            self.indicateIcon.transform = CGAffineTransform.identity;
            
        } else {
            self.indicateIcon.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI));

        }
    }
}

class HeadViwInfo {
    //size
    fileprivate static let titleLabelHeight = 33
    fileprivate static let indicateIconRightMarge = -20
    
    fileprivate static let indicateIconWidth = 18
    fileprivate static let indicateIconHeight = 12
    
    fileprivate static let practiceIconWidth = 18
    fileprivate static let practiceIconHeight = 12
    
    fileprivate static let practiceLabelWidth = 20
    fileprivate static let practiceLabelHeight = 18
    fileprivate static let practiceLabelLeftMarge = 10

    
    fileprivate static let testIconWidth = 18
    fileprivate static let testIconHeight = 12
    
    fileprivate static let testLabelWidth = 20
    fileprivate static let testLabelHeight = 18
    fileprivate static let testLabelLeftMarge = 10

    fileprivate static let bottomLineHeight = 1
    
    //font practiceLabel
    fileprivate static let titleLabelFont = UIFont.systemFont(ofSize: 16)
    fileprivate static let practiceLabelFont = UIFont.systemFont(ofSize: 14)
    fileprivate static let testLabelFont = UIFont.systemFont(ofSize: 14)
    
    //background color
    fileprivate static let bottomLineColor = UIColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    fileprivate static let titleLabelTextColor =  UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
    fileprivate static let practiceLabelTextColor =  UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    fileprivate static let testLabelTextColor =  UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    
    
    //fold section animation time
    fileprivate static let foldDuration = 0.25
    
}
