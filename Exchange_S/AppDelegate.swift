//
//  AppDelegate.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/5/17.
//  Copyright © 2016年 izijia. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,LocationDelegate,MapSearchDelegate {

    var window: UIWindow?
    
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Override point for customization after application launch.
        window = UIWindow (frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        //注册bomb账号
        registerForService();
        //开启定位
        startLocation()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    /**
     三方注册
     */
    func registerForService() -> Void {
        //注册存储
        Bmob.registerWithAppKey(BmobKey)
        AMapLocationServices.sharedServices().apiKey = LocationKey
        AMapSearchServices.sharedServices().apiKey = LocationKey
    }
    
    //定位
    func startLocation(){
    
        locationService.manager?.setLocationDelegate(self)
        locationService.manager?.startUpdatingLocation()
    }
    
    
    //MARK:LocationDelegate
    func locationManagerDidUpdateLocation(location: CLLocation) {
        //反地理编码

        let mapSearchRequest = MapSearchRequest()
        mapSearchRequest.location = location
        searchService.manager?.mapReGeocodeSearch(mapSearchRequest)
        searchService.manager?.setDelegate(self)
        
        
    }
    //MARK:MapSearchDelegate
    func onReGeoCodeSearchDone(request: MapSearchRequest, response: MapSearchResponse) {
        
        let locationCity = LocationCity.sharedLocationCity()
        locationCity.location = request.location
        locationCity.cityCode = response.addressComponent?.cityCode
        locationCity.cityName = response.addressComponent?.city
        locationCity.provinceName = response.addressComponent?.province
        
    }
    
    
    //MARK:lazy
    lazy var locationService:LocationService = {
    
        let service = LocationService.createService({ (locationService) in
            
        })
        return service
    }()
    
    lazy var searchService:MapSearchService = {
    
        let searchSer = MapSearchService.createService { (service) in
            
        }
        return searchSer
    }()

}

