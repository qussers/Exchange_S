//
//  BmobNetManager.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/5/19.
//  Copyright © 2016年 izijia. All rights reserved.
//

import UIKit

class BmobNetManager: NSObject,NetServiceProtocol {

    
    //MARK:-------------用户相关-------------
    /**
     注册用户
     
     - parameter parameters:      注册的参数
     - parameter successCallback: 成功
     - parameter errorCallback:   失败
     */
    func registerUser(parameters:NSMutableDictionary,successCallback:(result:AnyObject?)->(), errorCallback:(error:NSError)->())
    {
        
        
    }
    
    
    
    /**
     根据手机号码请求验证码
     
     - parameter phoneNumber:     手机号码
     - parameter successCallback: 成功请求
     - parameter errorCallback:   失败请求
     
     - returns: 返回请求结果
     */
    func registerCode(phoneNumber:String,successCallback:(result:AnyObject?)->(), errorCallback:(error:NSError)->()){
    
        BmobSMS.requestSMSCodeInBackgroundWithPhoneNumber(phoneNumber, andTemplate: "") { (code, error) in
            //如果错误为空
            if error == nil{
                successCallback(result:String(code))
            }
            else{
                errorCallback(error:error)
            }
        }
    }
    
    
    /**
     根据短信验证码等注册用户
     
     - parameter password:        密码
     - parameter SMSCode:         短信验证码
     - parameter phoneNumber:     手机号码
     - parameter successCallback: 返回成功信息
     - parameter errorCallback:   返回失败信息
     
     - returns:
     */
    func registerUser(password:String,SMSCode:String,phoneNumber:String,successCallback:(result:AnyObject?)->(), errorCallback:(error:NSError)->()){
    
        let user = BmobUser()
        user.password = password
        user.mobilePhoneNumber = phoneNumber
        user.signUpOrLoginInbackgroundWithSMSCode(SMSCode) { (isSuccess, error) in
            
            if error == nil{
                successCallback(result: String("success"))
            }
            else{
                errorCallback(error:error)
            }
        }
    
    }
    
    
    /**
     用户登录
     
     - parameter account:         用户账户
     - parameter password:        用户密码
     - parameter successCallback: 成功
     - parameter errorCallbacl:   失败
     */
    func loginUser(account:AnyObject,password:AnyObject,successCallback:(result:AnyObject?)->(),errorCallback:(error:NSError)->())
    {
        
        BmobUser.loginWithUsernameInBackground(account as! String, password: password as! String) { (user, error) in
            //登录成功
            if error == nil{
                successCallback(result: user)
            }
            else{
                errorCallback(error: error)
            }
        }
    
    }
    
    /**
     根据用户名查询用户
     
     - parameter userName:        用户名
     - parameter successCallback: 成功
     - parameter errorCallback:   失败
     */
    func queryUser(userName:String,successCallback:(result:AnyObject?)->(),errorCallback:(error:NSError)->())
    {
        
    
    }
    
    /**
     获取本地用户
     
     - returns:返回本地用户对象
     */
    func getLocalUser() ->AnyObject?
    {
        return BmobUser.getCurrentUser()
    }
    
    //MARK:-------------基本网络请求-------------
    
    func requestData(pargema: [String : String], url: String, successCallback: (result: (AnyObject?) -> (), errorCallback: (error: NSError) -> ())) {
        
//        //1.将url转换成model表对应的大写扩展:EXC_
//        var URL = "EXC_".stringByAppendingString(url.uppercaseString)
//        
        //2.构造查询的条件
        
        
        
        
    }
    
    
    /**
     获取头部轮播图数据
     
     - parameter successCallback: 成功回调
     */
    func requestHeadViewData(successCallback:(result:[HeadInfo?])->(),errorCallback:(error:NSError)->())
    {
        let query = BmobQuery.init(className: "EXC_HEADINFO")
        query.whereKey("isActive", equalTo: true)
        
        query.findObjectsInBackgroundWithBlock { (resules, error) in
            if error != nil{
                errorCallback(error: error)
                return
            }
            var models = [HeadInfo?]()
            for (result ) in (resules as! [BmobObject]){
               let model = HeadInfo()
                model.imageURL = result.objectForKey("imageURL") as? String
                model.title = result.objectForKey("title") as? String
                model.number = result.objectForKey("number") as? NSInteger
                models.append(model);
            }
            successCallback(result: models)
        }
    
    }
    
    
    
    
    
    
    
}

