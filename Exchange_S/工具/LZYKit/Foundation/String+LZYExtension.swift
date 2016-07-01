//
//  NSString+LZYExtension.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/6/22.
//  Copyright © 2016年 izijia. All rights reserved.
//

import Foundation

extension String
{
    //获取字符串首字母并大写
    func getFirstAlphabet() -> String
    {
        let traStr = transChineseToPhonetic()
        let index = traStr.startIndex.advancedBy(1)
        return traStr.uppercaseString.substringToIndex(index)
    }
    
    //将汉字转换成拼音
    func transChineseToPhonetic() ->String
    {
        let transformContents = CFStringCreateMutableCopy(nil, 0, self)
        //转为带声调
        CFStringTransform(transformContents, nil, kCFStringTransformMandarinLatin, false)
        //转为不带声调
        CFStringTransform(transformContents, nil, kCFStringTransformStripDiacritics, false)
        return (transformContents as String).uppercaseString.stringByReplacingOccurrencesOfString(" " , withString:"")
    }
    


}