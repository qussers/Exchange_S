//
//  User.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/5/17.
//  Copyright © 2016年 izijia. All rights reserved.
//

import UIKit

class User: NSObject {

    //获取当前用户是否登录
   class func getCurrentUser() -> Bool {
    return (NetService.init().manager.getLocalUser() != nil) ? true : false
    }
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
