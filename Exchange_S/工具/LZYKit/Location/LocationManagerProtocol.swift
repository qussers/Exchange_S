//
//  LocationProtocol.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/6/23.
//  Copyright © 2016年 izijia. All rights reserved.
//  规范定位接口

import Foundation

protocol LocationManagerProtocol:NSObjectProtocol {
    
    /**
     单例创建定位manager
     
     - returns: 返回定位管理者
     */
    static func sharedManager()->LocationManagerProtocol
    
    /**
     开启持续定位
     */
    func startUpdatingLocation()
    
    /**
     关闭持续定位
     */
    func stopUpdatingLocation()
    
    /**
     设置定位代理
     
     - parameter delegate: 设置定位代理对象
     */
    func setLocationDelegate(delegate:LocationDelegate)
    
    /**
     设置允许后台定位参数,保持不会被系统挂起
     
     - parameter isAUto: 是否被系统挂起
     */
    func setPausesLocationUpdatesAutomatically(isAUto:Bool)
    
    /**
     是否允许后台定位
     
     - parameter isBackground:后台定位
     */
    func setAllowBackgroundLocationUpdates(isBackground:Bool)
    
}