//
//  ViewController.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/5/17.
//  Copyright © 2016年 izijia. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addCildViewControllers()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //添加加号按钮
        setupComposeBtn()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK://添加子控制器
    private func addCildViewControllers(){
    
        //1.获取json文件路径
        let path = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil)
        
        //2.通过文件路径创建NSData
        if let jsonPath = path{
            
            let jsonData = NSData (contentsOfFile: jsonPath)
            do{
                //有可能发生异常的代码放在这里
                //3.序列化json数据--->
                //try:发生异常跳转到catch中执行
                //try!:发生异常程序直接崩溃
                let dictArr = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers)
                //4.遍历数组,动态创建控制器和设置数据
                //在Swift中,如果需要遍历一个数组,必须明确数据的类型
                for dict in dictArr as! [[String : String]]
                {
                //根据报错的原因是因为addChildViewController参数必须有值,但是字典的返回值是可选类型
                addChildViewController(dict["vcName"]!, title: dict["title"]!, imageName: dict["imageName"]!)
                }
            
            }catch{
                //发生异常之后会执行的代码
                print(error)
                //本地创建控制器
                addChildViewController("HomeTableViewController", title: "首页", imageName: "tabbar_home")
                addChildViewController("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
                //再添加一个占位控制器
                addChildViewController("NullviewController", title: "", imageName: "")
                addChildViewController("DiscoverTableViewController", title: "广场", imageName: "tabbar_discover")
                addChildViewController("ProfileTableViewController", title: "我", imageName: "tabbar_profile")
                
            }
            
        }
        
    
    }
    
    
    
    
    private func addChildViewController(childControllerName: String, title:String, imageName: String) {
        //-1.动态获取命名空间
        let ns = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        //0. 将字符串转换为类
        //0.1 默认情况下命名空间就是项目的名称,但是命名空间名称是可以修改的
        let cls:AnyClass? = NSClassFromString(ns + "." + childControllerName)
        //0.2通过类创建对象
        //0.2.1将AnyClass转换为指定的类型
        let vcCls = cls as! UIViewController.Type
        //0.2.2通过class创建对象
        let vc = vcCls.init()
        //1设置首页对应的数据
        vc.tabBarItem.image = UIImage (named: imageName)
        vc.tabBarItem.selectedImage = UIImage (named: imageName + "_highlighted")
        vc.title = title
        //2.给首页包装一个导航控制器
        let nav = UINavigationController()
        nav.addChildViewController(vc)
        //将导航控制器添加到当前控制器上
        addChildViewController(nav)
        
    }
    
    
    //MARK:-内部控制方法
    private func setupComposeBtn()
    {
        //1.添加加号按钮
        tabBar.addSubview(composeBtn)
        
        //2.添加加号按钮的位置
        let  width = UIScreen.mainScreen().bounds.size.width / CGFloat(viewControllers!.count)
        let rect = CGRect (x: 0, y: 0, width: width, height: 49)
        //第一个参数:frame的大小
        //第二个参数:是X方向偏移的大小
        //第三个参数:是y方向偏移的大小
        composeBtn.frame = CGRectOffset(rect, 2 * width, 0)
    }
    
    
    
    //MARK:-中部按钮点击
    func composeBtnClick(){
        print(#function)
    }
    
    
    //MARK:- 懒加载
    private lazy var composeBtn:UIButton = {
    
        let btn = UIButton()
        
        //设置前景图片
        btn.setImage( UIImage (named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        btn.setImage(UIImage (named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        
        //设置背景图片
        btn.setBackgroundImage(UIImage (named: "tabbar_compose_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage (named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        
        //添加监听方法
        btn.addTarget(self, action: #selector(MainViewController.composeBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        return btn
    }()
    
      

}

