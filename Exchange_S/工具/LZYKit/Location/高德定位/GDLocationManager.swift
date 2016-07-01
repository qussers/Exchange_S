//
//  GDLocationManager.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/6/23.
//  Copyright © 2016年 izijia. All rights reserved.
//

import UIKit

class GDLocationManager: NSObject,LocationManagerProtocol,AMapLocationManagerDelegate{

    //静态
    static let manager = GDLocationManager()
    //
    let GDManager = AMapLocationManager()
    
     weak var GDLocationDelegate:LocationDelegate?
    
    //保证该方法私有性,确保创建过程的安全性
    private override init() {
    }
    
    /**
     单例创建定位manager
     
     - returns: 返回定位管理者
     */
    class func sharedManager()->LocationManagerProtocol
    {
        //创建单例类型
        return manager
    }
    
    /**
     开启持续定位
     */
    func startUpdatingLocation()
    {
        GDManager.startUpdatingLocation()
    }
    
    /**
     关闭持续定位
     */
    func stopUpdatingLocation()
    {
        GDManager.stopUpdatingLocation()
    }
    
    /**
     设置定位代理
     
     - parameter delegate: 设置定位代理对象
     */
    func setLocationDelegate(delegate:LocationDelegate)
    {
        GDManager.delegate = self
        GDLocationDelegate = delegate
    }
    
    /**
     设置允许后台定位参数,保持不会被系统挂起
     
     - parameter isAUto: 是否被系统挂起
     */
    func setPausesLocationUpdatesAutomatically(isAUto:Bool)
    {
        GDManager.pausesLocationUpdatesAutomatically = isAUto
    }
    
    /**
     是否允许后台定位
     
     - parameter isBackground:后台定位
     */
    func setAllowBackgroundLocationUpdates(isBackground:Bool)
    {
        GDManager.allowsBackgroundLocationUpdates = isBackground
    }
    
    
    //MARK:AMapLocationDelegate
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {
        GDLocationDelegate?.locationManagerDidUpdateLocation(location)
    }
    
    
}
