//
//  HeadInfo.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/6/29.
//  Copyright © 2016年 izijia. All rights reserved.
//

import UIKit

class HeadInfo: NSObject {

    var imageURL:String?
    var title: String?
    var number: NSInteger?
    
    
    //请求头数据
    class func requestData(successCallback:(result:[HeadInfo?])->(),errorCallback:(error:NSError)->()){
        
        NetService().manager.requestHeadViewData({ (result) in
            successCallback(result: result)
            }) { (error) in
            errorCallback(error: error)
        }
    }
}
