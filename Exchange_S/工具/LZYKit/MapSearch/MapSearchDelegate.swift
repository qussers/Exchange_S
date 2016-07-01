
//
//  MapSearchDelegate.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/6/24.
//  Copyright © 2016年 izijia. All rights reserved.
//

import Foundation

class AddressComponent:NSObject {
    
    var province: String?
    var city: String?
    var cityCode: String?
    
}


class MapSearchResponse: NSObject {
    
    //格式化地址
    var formattedAddress: String?
    
    //组件
    var addressComponent: AddressComponent?
}

@objc protocol MapSearchDelegate:NSObjectProtocol {
    
    //逆地理编码回调
   optional func onReGeoCodeSearchDone(request:MapSearchRequest,response:MapSearchResponse)
    
    //正地理编码回调
   optional func onGeoCodeSearchDone(request:MapSearchRequest,response:MapSearchResponse)
    
    
    
}