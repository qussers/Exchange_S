//
//  MapSearchProtocol.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/6/24.
//  Copyright © 2016年 izijia. All rights reserved.
//  地图搜索服务
/**
 *  包含有地理编码,周边POI返回等
 */

import UIKit

//MapSearch请求体
class MapSearchRequest: NSObject {
    
    var keywords: String?
    var uid: String?
    var cityName: String?
    var cityLimit: Bool?
    var address: String?
    var location :CLLocation?
}


protocol MapSearchProtocol:NSObjectProtocol {
    
    //根据id搜索
    func mapPOIIDSearch(request: MapSearchRequest?)
    
    //根据POI搜索
    func mapPOIKeywordSearch(request: MapSearchRequest?)
    
    //周边查询接口
    func mapPOIAroundSearch(request:MapSearchRequest?)
    
    //多边形查询接口
    func mapPOIPolygonSearch(request:MapSearchRequest?)
    
    //逆地理编码接口
    func mapReGeocodeSearch(request:MapSearchRequest?)
    
    //设置代理对象
    func setDelegate(delegate:MapSearchDelegate)
}