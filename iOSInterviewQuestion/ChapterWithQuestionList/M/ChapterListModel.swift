//
//  ChapterListModel.swift
//  iOSInterviewQuestion
//
//  Created by 郑娇鸿 on 17/2/24.
//  Copyright © 2017年 郑娇鸿. All rights reserved.
//

import Foundation

class Question {

    var assignmentType = ""
    var structureType = ""
    var question = ""

}
class ChapterModel {
		
    var chapterId = 0
    var questionNumber = ""
    var practiceNumber = ""
    var numberOfFinishedQuestion = 0
	var numberOfFinishedTest = 0
    var title = ""
    var chapterIcon = ""
    var foldingState = ChapterFoldingSectionState.ChapterSectionStateFlod;

    var questions = [Question]()
    
}

extension ChapterModel {
   static func fetchChapterArray() -> ([ChapterModel]) {
        
        guard let path = Bundle.main.path(forResource: "DataSource", ofType: "bundle"),
        let bundle = Bundle(path: path),
        let plistPath = bundle.path(forResource: "JSChapters", ofType: "plist"),
        let array = NSArray(contentsOfFile: plistPath) as? [[String:AnyObject]] else {
            return []
        }
        
        var chapterArray = [ChapterModel]();

        for i in 0..<array.count {
            let dic = array[i]
            
            let model = ChapterModel()
            let idString = dic["chapterId"] as! String
//            let myInt = Int(idString)!
            let x = Int(idString) ?? 0
            
            model.chapterId = x
            model.chapterIcon = dic["chapterIcon"] as! String
            model.title = dic["title"] as! String
            model.practiceNumber = dic["practiceNumber"] as! String
            model.questionNumber = dic["questionNumber"] as! String
            let questions = dic["questions"] as! [[String: AnyObject]]
            
            var questionArray = [Question]();

            for j in 0..<questions.count {
                let dic = questions[j]
                
                let questionModel = Question()
                questionModel.question = dic["question"] as! String
                questionModel.assignmentType = dic["assignmentType"] as! String
                questionModel.structureType = dic["structureType"] as! String
                
                questionArray.append(questionModel);
            }
            model.questions = questionArray
            chapterArray.append(model)
        }
        return chapterArray;
    }
}
