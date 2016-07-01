//
//  LocationDelegate.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/6/23.
//  Copyright © 2016年 izijia. All rights reserved.
//

import Foundation

protocol LocationDelegate :NSObjectProtocol{
    
    //地理位置发生了更新
    func locationManagerDidUpdateLocation(location:CLLocation)
}