//
//  UIRefreshTableViewController.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/6/21.
//  Copyright © 2016年 izijia. All rights reserved.
//


import UIKit
/// 公共TableView上拉刷新下拉刷新类,可根据代理对象传入的值进行对应的设置的生成

//TableViewCell应当遵循的协议
protocol UIRefreshTableViewCellProtocol {
    func configCell(data : AnyObject?)
}

//使用本对象应当遵循的协议
protocol UIRefreshTableViewDelegate:NSObjectProtocol {
    
    //几个分组
    func refresh_numberOfSectionsInTableView(tableView: UITableView) -> Int
    
    //每个分组有几行
    func refresh_tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    //对应cell
    func refresh_tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    
    func refresh_tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    
}

class UIRefreshTableViewController: UITableViewController {

    //代理对象
    weak var delegate : UIRefreshTableViewDelegate?
    
    //cellName
    var cellName : String?
    
    //初始传入的url
    var url : String?
    
    //是否有上拉刷新
    var hasRefreshHeader : Bool?
    
    //是否有下拉刷新
    var hasRefreshFooter : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //创建当前对象并赋值
    class func createUIRefreshTableViewController(closure:(refresh :UIRefreshTableViewController) -> ()) -> UIRefreshTableViewController
     {
        let refreshClass = UIRefreshTableViewController()
        closure(refresh: refreshClass)
        return refreshClass
    }
    
    //刷新数据
     func refreshData(url : String)
    {
        
    }
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return (delegate?.refresh_numberOfSectionsInTableView(tableView))!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (delegate?.refresh_tableView(tableView, numberOfRowsInSection: section))!
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return (delegate?.refresh_tableView(tableView, cellForRowAtIndexPath: indexPath))!
    }

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return(delegate?.refresh_tableView(tableView, heightForRowAtIndexPath: indexPath))!
    }

}
