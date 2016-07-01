//
//  GDMapSearchManager.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/6/24.
//  Copyright © 2016年 izijia. All rights reserved.
//

import UIKit



class GDMapSearchManager: NSObject , MapSearchProtocol, AMapSearchDelegate{

    
    //代理对象
    weak var GDSearchDelegate:MapSearchDelegate?
    
    static let searchInstance = GDMapSearchManager()
    
    private override init() {}
    
    class func sharedInstance()-> GDMapSearchManager
    {
        
        return searchInstance
    }
    
    
    //根据id搜索
    func mapPOIIDSearch(request: MapSearchRequest?)
    {
        
    }
    
    //根据POI搜索
    func mapPOIKeywordSearch(request: MapSearchRequest?)
    {
    
    }
    
    //周边查询接口
    func mapPOIAroundSearch(request:MapSearchRequest?)
    {
    
    }
    
    //多边形查询接口
    func mapPOIPolygonSearch(request:MapSearchRequest?)
    {
    
    }
    
    //逆地理编码接口
    func mapReGeocodeSearch(request:MapSearchRequest?)
    {
        GDManager.AMapReGoecodeSearch(requestReGeocodeTrans(request!))
    }
    
    //设置代理对象
    func setDelegate(delegate:MapSearchDelegate)
    {
        GDManager.delegate = self
        GDSearchDelegate = delegate
    }
    
    
    //将请求转化为高德的id请求
    private func requestIDSearchTrans(request:MapSearchRequest) -> AMapPOIIDSearchRequest
    {
        let aMapRequest = AMapPOIIDSearchRequest()
        aMapRequest.uid = request.uid
        return aMapRequest
    }
    
    private func requestKeywordTrans(request:MapSearchRequest) -> AMapPOIKeywordsSearchRequest
    {
        let aMapRequest = AMapPOIKeywordsSearchRequest()
        aMapRequest.keywords = request.keywords
        return aMapRequest
    }
    
    private func requestReGeocodeTrans(request:MapSearchRequest) -> AMapReGeocodeSearchRequest
    {
        let aMapRequest = AMapReGeocodeSearchRequest()
        let aMApLocation = AMapGeoPoint.locationWithLatitude(CGFloat((request.location?.coordinate.latitude)!), longitude: CGFloat((request.location?.coordinate.longitude)!))
        aMapRequest.location = aMApLocation
        return aMapRequest
    }
    
    //将高德请求转化为本地请求
    private func requestAMapGeocodeTrans(request:AMapReGeocodeSearchRequest) -> MapSearchRequest
    {
        let mapRequest = MapSearchRequest()
        mapRequest.location = CLLocation.init(latitude: CLLocationDegrees(request.location.latitude), longitude: CLLocationDegrees(request.location.longitude))
        return mapRequest
    }
    

    //将高德返回转化为本地返回对象
    private func responseReGeocodeResponseTrans(response:AMapReGeocodeSearchResponse) -> MapSearchResponse
    {
        let mapResponse = MapSearchResponse()
        mapResponse.formattedAddress = response.regeocode.formattedAddress
        let addressCom = AddressComponent()
        addressCom.province = response.regeocode.addressComponent.province
        addressCom.city = response.regeocode.addressComponent.city
        addressCom.cityCode = response.regeocode.addressComponent.citycode
        mapResponse.addressComponent = addressCom
        return mapResponse
    }

    //MARK:AMapSearchDelegate
    
    //正向地理编码
    func onGeocodeSearchDone(request: AMapGeocodeSearchRequest!, response: AMapGeocodeSearchResponse!) {
        
        
    }
    
    //逆地理编码
    func onReGeocodeSearchDone(request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
                let localRequest = requestAMapGeocodeTrans(request)
        let localReponse = responseReGeocodeResponseTrans(response)
        GDSearchDelegate?.onReGeoCodeSearchDone!(localRequest,response: localReponse)
        
    }
    
    
    //MARk:Lazy
    private lazy var GDManager: AMapSearchAPI = {
        let aMap = AMapSearchAPI()
        return aMap
    }()
    
    
    
    
}
