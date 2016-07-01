//
//  NetServiceProtocol.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/5/19.
//  Copyright © 2016年 izijia. All rights reserved.
//

import UIKit

protocol NetServiceProtocol {
    
    //MARK:-------------用户相关-------------
    /**
     注册用户
     
     - parameter parameters:      注册的参数
     - parameter successCallback: 成功
     - parameter errorCallback:   失败
     */
    func registerUser(parameters:NSMutableDictionary,successCallback:(result:AnyObject?)->(), errorCallback:(error:NSError)->())
    
    /**
     根据手机号码请求验证码
     
     - parameter phoneNumber:     手机号码
     - parameter successCallback: 成功请求
     - parameter errorCallback:   失败请求
     
     - returns: 返回请求结果
     */
    func registerCode(phoneNumber:String,successCallback:(result:AnyObject?)->(), errorCallback:(error:NSError)->())
    
    /**
     根据短信验证码等注册用户
     
     - parameter password:        密码
     - parameter SMSCode:         短信验证码
     - parameter phoneNumber:     手机号码
     - parameter successCallback: 返回成功信息
     - parameter errorCallback:   返回失败信息
     
     - returns:
     */
    func registerUser(password:String,SMSCode:String,phoneNumber:String,successCallback:(result:AnyObject?)->(), errorCallback:(error:NSError)->())
    
    /**
     用户登录
     
     - parameter account:         用户账户
     - parameter password:        用户密码
     - parameter successCallback: 成功
     - parameter errorCallbacl:   失败
     */
    func loginUser(account:AnyObject,password:AnyObject,successCallback:(result:AnyObject?)->(),errorCallback:(error:NSError)->())
    
    
    /**
     根据用户名查询用户
     
     - parameter userName:        用户名
     - parameter successCallback: 成功
     - parameter errorCallback:   失败
     */
    func queryUser(userName:String,successCallback:(result:AnyObject?)->(),errorCallback:(error:NSError)->())
    
    /**
     获取本地用户
     
     - returns:返回本地用户对象
     */
    func getLocalUser() ->AnyObject?
    
    
    
    //MARK:-------------基本数据请求相关-------------
    
    /**
     请求基本数据
     
     - parameter pargema:         数据的参数
     - parameter url:             接口
     - parameter successCallback: 成功回调
     */
    func requestData(pargema:[String:String],url:String, successCallback:(result:(AnyObject?)->(),errorCallback:(error:NSError)->()));
    
    
    
    /**
     获取头部轮播图数据
     
     - parameter successCallback: 成功回调
     */
    func requestHeadViewData(successCallback:(result:[HeadInfo?])->(),errorCallback:(error:NSError)->());
    
    
    
}
