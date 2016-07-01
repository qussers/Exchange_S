//
//  City.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/6/24.
//  Copyright © 2016年 izijia. All rights reserved.
//  城市类

import UIKit

class City: NSObject {
    
    var provinceName: String?
    var provinceCode: String?
    var cityName: String?
    var cityCode: String?
    var location: CLLocation?
}

//定位得到的类 单例类
class LocationCity: City {
    
    static let locationCity = LocationCity()
    private override init() {
        
    }
    class func sharedLocationCity() ->LocationCity{
        return locationCity
    }
    
}

