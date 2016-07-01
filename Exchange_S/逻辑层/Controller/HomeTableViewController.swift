//
//  HomeTableViewController.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/5/17.
//  Copyright © 2016年 izijia. All rights reserved.
//

import UIKit
import SDWebImage
class HomeTableViewController: BaseTableViewController,CitySelectTableViewDelegate, ScrollCycleViewDataSource{

    //存放轮播图数据
    var HeadInfos = [HeadInfo?](){
        //重写set方法
        didSet(newValue){
            
            self.scrollHeadView.reloadData()
        }
    }
    
    //左侧城市选择去器
    var citySelectViewController: CitySelectTableViewController?
    
    //MARK: ------ 父类方法--------
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        tableView.tableHeaderView = scrollHeadView
        scrollHeadView.dataSource = self
        
        
        requestHeadInfos();
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setNavTitle("navigationbar_friendattention", rightTitle: "navigationbar_pop")
        navigationItem.titleView = SearchView.createSearchView({ (searchView) in
            searchView.searchPlaceholder = "探索,物品无限价值"
        })
       navigationItem.titleView?.frame = CGRectMake(0, 0, self.view.frame.size.width, 30)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    //MARK:UIRefreshTableViewDelegate
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = HomeSegTableViewCell.makeCell(tableView)
        return cell
    }

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }

    //MARK:ScrollCycleViewDataSouce
    func numberofPage(scrollCycleView: ScrollCycleView) -> NSInteger {
        
        return HeadInfos.count
    }
    func scrollCycleView(index: NSInteger, scrollCycleView: UIView) -> UIView {
        
        let model = HeadInfos[index]
        let imageView = UIImageView()
        imageView.sd_setImageWithURL(NSURL.init(string: (model?.imageURL)!))
        return imageView
    }
    func scrollCycleView(didSelectedAtIndex index: NSInteger, scrollCycleView: UIView) {
        
    }
    
    //二维码按钮被点击
    override func rightNavClick() {
        //1.模态跳转到二维码扫描页面
        let sb =  UIStoryboard (name: "QRCodeViewController", bundle: nil)
        if let vc  =  sb.instantiateInitialViewController(){
             presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    
    override func leftNavClick() {
        
        if citySelectViewController != nil {
            citySelectViewController = nil
        }
        citySelectViewController = CitySelectTableViewController.createCitySelectTableViewController({ (citySelectTableViewController) in
            citySelectTableViewController.selectType = citySelectType.city
            citySelectTableViewController.delegate = self
        })
        //左按钮点击城市选择
        navigationController?.pushViewController(citySelectViewController!, animated: true)
    }
    
    //MARK:请求轮播图数据
    
    func requestHeadInfos(){
        
        [HeadInfo .requestData({ (result) in
            
            self.HeadInfos = result as [HeadInfo?]
            
            }, errorCallback: { (error) in
                
            //请求失败
                
        })]
    
    }

    //MARK:CitySelectViewControllerDelegate
    func selectedCity(city: CitySelectedCity?) {
        print(city?.cityName)
    }
    
    //MARK:懒加载
    //数据源
    lazy var dataSource:NSMutableArray = {
    
        var datas = NSMutableArray()
        return datas;
    }()
    
    lazy var scrollHeadView:ScrollCycleView = {
        var view = ScrollCycleView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, 100))
        return view
    }()

    
    


}
