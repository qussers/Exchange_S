//
//  MapSearchService.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/6/24.
//  Copyright © 2016年 izijia. All rights reserved.
//

import UIKit

class MapSearchService: NSObject {

    var manager:MapSearchProtocol?
    
    class func createService(closure:(service:MapSearchService) ->())->MapSearchService
    {
        let mService = MapSearchService()
        closure(service: mService)
        if mService.manager == nil {
            mService.manager = GDMapSearchManager.sharedInstance()
        }
        return mService
    }
    
}
