//
//  IQEnumerations.swift
//  iOSInterviewQuestion
//
//  Created by 郑娇鸿 on 17/2/24.
//  Copyright © 2017年 郑娇鸿. All rights reserved.
//

import Foundation

enum ChapterFoldingSectionState: Int {
    case ChapterSectionStateFlod = 0
    case ChapterSectionStateShow
}

enum ChapterAssignmentType: Int {
    case ChapterAssignmentTypeStudy = 1
    case ChapterAssignmentTypeReview
}

enum StructureType: Int {
    case SubjectTypeRead = 0
    case SubjectTypeChoiceTapMe
    case SubjectTypeChoiceABC
    case SubjectTypeFillOut
    case SubjectTypeRunCode
    case SubjectTypeCompositorial
    case SubjectTypeTapmeMore
    case SubjectTypeShowName
    case SubjectTypeShowFlow
    case SubjectTypeBtnOrder

}

enum TableViewCellType: Int {
    case TableViewCellTypeTapmeBtn = 1
    case TableViewCellTypeTextField
    case TableViewCellTypeABCDBtn
    case TableViewCellTypeCanMove
    case TableViewCellTypeMoreTapMe
    case TableViewCellTypeBtnOrder
    
}

enum TextFieldSpecailDealType: Int {
    case TextFieldSpecailType1 = 1
    case TextFieldSpecailType2
    case TextFieldSpecailType3
    case TextFieldSpecailType4
    
}

enum SubjectFeedbackType: Int {
    case SubjectFeedbackTypeWebPageWord = 1
    case SubjectFeedbackTypeConsole = 3
    case SubjectFeedbackTypeWebPagePicture = 6
    
}
