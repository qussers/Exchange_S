//
//  NetService.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/5/30.
//  Copyright © 2016年 izijia. All rights reserved.
//

import UIKit

class NetService: NSObject {

    let manager:NetServiceProtocol
    //初始化方法
    override init() {
        //初始化
        manager = BmobNetManager()
    }
    

}
