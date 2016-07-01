//
//  RegularVerification.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/6/21.
//  Copyright © 2016年 izijia. All rights reserved.
//

import UIKit


/**
 
 正则判断
 
 
 - email:        邮箱
 
 - phoneNumber:  手机号码
 
 - userName:     用户名
 
 - password:     密码
 
 - identityCard: 身份证
 
 */

enum validateType{
    case email
    case phoneNumber
    case userName
    case password
    case identityCard
}



class RegularVerification: NSObject {
    
    static func validate(data:String, type: validateType) -> Bool
    {
        var regex: String?
        var predicate: NSPredicate?
        switch type {
        case .email:
            regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            break
        case .phoneNumber:
            regex = "^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$"
            break
        case .userName:
            regex = "^[A-Za-z0-9]{6,20}+$"
            break
        case .password:
            regex = "^[a-zA-Z0-9]{6,20}+$"
            break
        case .identityCard:
            regex = "^(\\d{14}|\\d{17})(\\d|[xX])$"
            break
        }
        predicate = NSPredicate(format:"SELF MATCHES %@",regex!)
        return (predicate?.evaluateWithObject(data))!
    }

}
