//
//  ViewController.swift
//  iOSInterviewQuestion
//
//  Created by 郑娇鸿 on 17/2/24.
//  Copyright © 2017年 郑娇鸿. All rights reserved.
//

import UIKit
import SnapKit

let tableViewCellIdentifier = "tableViewCellIdentifier"
let tableViewHeadIdentifier = "tableViewHeadIdentifier"

class ViewController: UIViewController {
    fileprivate var tableView: UITableView!
    let modelData = ChapterModel.fetchChapterArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.buildUI()
    
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.edges.equalTo(self.view)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

// build UI
extension ViewController {
    fileprivate func buildUI() -> (){
        
        tableView = UITableView.init()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(TableViewTitleCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
        tableView.register(HeadView.self, forHeaderFooterViewReuseIdentifier: tableViewHeadIdentifier)
        view.addSubview(tableView);
    
    }
}
extension ViewController :HeadViewProtocol {
    func headViewClicked(chapterModel: ChapterModel,headView:HeadView) {
        print("HeadViewProtocol run")
   
        headView.isUserInteractionEnabled = false
        
        var indexPaths = [IndexPath]()
        
        for i in 0..<chapterModel.questions.count {
            let indexPath = IndexPath.init(row: i , section: chapterModel.chapterId - 1)
            indexPaths.append(indexPath as IndexPath)
        }
        
        let time = DispatchTime.now() + TableViewConfig.dispatchAfterTime
        DispatchQueue.main.asyncAfter(deadline: time) {
            if ChapterFoldingSectionState.ChapterSectionStateFlod == chapterModel.foldingState {
                self.tableView.deleteRows(at: indexPaths as [IndexPath], with: UITableViewRowAnimation.top)
            
            } else {
                self.tableView.insertRows(at: indexPaths as [IndexPath], with: UITableViewRowAnimation.top)
                let indexSection = IndexPath.init(row: 0, section: chapterModel.chapterId - 1)
                
                self.tableView.scrollToRow(at: indexSection as IndexPath, at: UITableViewScrollPosition.middle, animated:true)

            }
            headView.isUserInteractionEnabled = true

        }
    }
}

// tableviewDelegate and dataSource
extension ViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let chapter = modelData[section]
        if ChapterFoldingSectionState.ChapterSectionStateFlod == chapter.foldingState {
            return TableViewConfig.noneCell;
        
        } else {
            return chapter.questions.count

        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let head = HeadView.init(reuseIdentifier:tableViewHeadIdentifier)
        let model = modelData[section]
        head.delegate = self;
        head.configHeadView(model: model)
        
        return head
    }
    
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableViewTitleCell.init(style: UITableViewCellStyle.default, reuseIdentifier: tableViewCellIdentifier)
        let chapter = modelData[indexPath.section]
        let question = chapter.questions[indexPath.row]
        
        cell.config(model: question)
        return cell
    }
    
    @objc(numberOfSectionsInTableView:) func numberOfSections(in tableView: UITableView) -> Int {
        
        return modelData.count
    }
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableViewConfig.heightForCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return TableViewConfig.heightForHeader
    }
}
class TableViewConfig {
    //size
    fileprivate static let heightForHeader: CGFloat = 66.0
    fileprivate static let heightForCell: CGFloat = 44.0
    
    //zero cell
    fileprivate static let noneCell = 0
    
    //time
    fileprivate static let dispatchAfterTime = 0.25
}
