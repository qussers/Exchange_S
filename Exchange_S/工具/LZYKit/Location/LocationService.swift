//
//  LocationService.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/6/23.
//  Copyright © 2016年 izijia. All rights reserved.
//  定位服务总控制

import UIKit

class LocationService: NSObject {

    var manager:LocationManagerProtocol?
    
    //创建定位服务类
    class func createService(closure:(locationService:LocationService) ->()) -> LocationService
    {
        let service = LocationService()
        closure(locationService: service)
        if service.manager == nil{
            //高德!
            service.manager = GDLocationManager.sharedManager()
        }
        return service
    }
    
}
