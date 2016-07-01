//
//  CitySelectTableViewController.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/6/21.
//  Copyright © 2016年 izijia. All rights reserved.
//

import UIKit

enum citySelectType{
    case province
    case city
}

//城市对象
class CitySelectedCity: NSObject {
    
    var provinceName: String?
    var provinceCode: String?
    var cityName: String?
    var cityCode: String?
    
}

protocol CitySelectTableViewDelegate: NSObjectProtocol{
    
    //选择后的城市
    func selectedCity(city:CitySelectedCity?)
    
}

class CitySelectTableViewController: BaseTableViewController, SearchViewDelegate {

    //城市选择级别类型-0.只选择到省份 1.选择到城市,默认为省份
    var selectType: citySelectType?
    
    //代理对象
    weak var delegate: CitySelectTableViewDelegate?
    
    //选择第几个JSON数据,默认为省份的"-1"
    private var selectPage: String?
    
    private var isSearch: Bool?
    
    
    //创建当前对象
    class func  createCitySelectTableViewController(closure:(citySelectTableViewController: CitySelectTableViewController)->()) ->CitySelectTableViewController
    {
        let cityTableViewController = CitySelectTableViewController()
        closure(citySelectTableViewController: cityTableViewController)
        return cityTableViewController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let page = selectPage{
            readLocaldata(page)
        }
        else{
            readLocaldata("-1")
        }

    }

    override func viewWillAppear(animated: Bool) {
        
        setNavTitle("返回", rightTitle: "地图")
        weak var weakself = self
        navigationItem.titleView = SearchView.createSearchView({ (searchView) in
            
            if weakself!.selectPage == nil{
                searchView.searchPlaceholder = "搜索省份"
            }
            else{
                searchView.searchPlaceholder = "搜索城市"
            }
            searchView.delegate = weakself

        })
        navigationItem.titleView?.frame = CGRectMake(0, 0, self.view.frame.size.width, 30)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        scrollViewDidScroll(self.tableView)
    }
    

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (isSearch == true) ? 1:dataSource.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //读取二级对象
        let dict = dataSource[section]
        return  (isSearch == true) ? searchResults.count:(dict.objectForKey("datas") as! NSMutableArray).count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let data:NSDictionary?
        if isSearch == true {
            data = searchResults[indexPath.row] as? NSDictionary
        }
        else{
            let dict = dataSource[indexPath.section]
            let mData = dict.objectForKey("datas") as! NSMutableArray
            //取出当前内容
            data = mData[indexPath.row] as? NSDictionary
        }

        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        cell!.textLabel?.text = data!.objectForKey("NAME") as? String
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearch == true {
            return "搜索结果"
        }
        return(dataSource.valueForKey("letter") as! NSArray as? [String])![section]
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        
        if isSearch == true {
            return nil
        }
        return dataSource.valueForKey("letter") as! NSArray as? [String]
        
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        navigationItem.titleView?.endEditing(true)
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let datas = dataSource[indexPath.section].objectForKey("datas") as! NSMutableArray
        let data = datas[indexPath.row]
        if selectType == citySelectType.city {
            
            city.provinceName = data.objectForKey("NAME") as? String
            city.provinceCode = data.objectForKey("CODE") as? String
            //城市选择
            weak var weakself = self
            let citySelectVc = CitySelectTableViewController.createCitySelectTableViewController({ (citySelectTableViewController) in
                citySelectTableViewController.selectPage = data.objectForKey("CODE") as? String
                citySelectTableViewController.delegate = weakself!.delegate
                citySelectTableViewController.city = weakself!.city
            })
            navigationController?.pushViewController(citySelectVc, animated: true)
        }
        else{
            city.cityName = data.objectForKey("NAME") as? String
            city.cityCode = data.objectForKey("CODE") as? String
            //返回当前选择的对象
            delegate?.selectedCity(city)
            navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    
    //MARK:读取本地省份城市JSON
    func readLocaldata(jsonName:String){
    let path = NSBundle.mainBundle().pathForResource(jsonName, ofType: "json")
    if let p = path{
            let datas = NSData.init(contentsOfURL: NSURL.fileURLWithPath(p))
            if let d = datas{
                do{
                let dict = try NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                //对数组中的数字进行排序
                sortArray(dict.objectForKey("datas") as! NSArray as [AnyObject])
                //刷新
                tableView.reloadData()
                }
                catch{
                    print(error)
                }
            }
        }

    }
    
    //拆分排序
    func sortArray(datas:NSArray )
    {
        //遍历数组
        for dict in datas  {
            //取出第一个字符
            let letter = (dict.objectForKey("NAME") as! String).getFirstAlphabet()
            //如果包含本字母的字典没有创建,那么创建
            if (dataSource.valueForKey("letter") as! NSArray).containsObject(letter) == false {
                let mDict = NSMutableDictionary()
                let mDatas = NSMutableArray()
                mDatas.addObject(dict)
                mDict.setObject(mDatas, forKey: "datas")
                mDict.setObject(letter, forKey: "letter")
                dataSource.addObject(mDict)
            }
            else{
                //取出数组,加入
                dataSource.enumerateObjectsUsingBlock({ (data, index, UnsafeMutablePointer) in
                    if data.objectForKey("letter") as! String == letter{
                        (data.objectForKey("datas") as! NSMutableArray).addObject(dict)
                    }
                })
            
            }
            
        }
        //重新排序
        dataSource.sortUsingComparator { (dict1:AnyObject!, dict2:AnyObject!
            ) -> NSComparisonResult in
         return  (dict1.objectForKey("letter") as! NSString).compare(dict2.objectForKey("letter") as! String)
        }
    }
 
    //MARK:城市筛选
    func siftCity(keyword: String?){
        searchResults.removeAllObjects()
        dataSource.enumerateObjectsUsingBlock { (dict, index, pointer) in
            let datas = dict.objectForKey("datas") as? NSMutableArray
            datas?.enumerateObjectsUsingBlock({ (data, subIndex, subPointer) in
                let name = data.objectForKey("NAME") as? String
                let st1 = name!.transChineseToPhonetic()
                let st2 = keyword!.transChineseToPhonetic()
                if st1.containsString(st2) == true{
                    self.searchResults.addObject(data)
                }
            })
        }
    }

    //MARK:导航按钮点击事件
    override func leftNavClick() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    //右侧按钮点击事件
    override func rightNavClick() {
        
    }
    
    //MARK:SearchViewDelegate
    func searchView_textFieldDidEditing(editText: String?) {
        
        print(editText)
        if editText != "" {
            self.isSearch = true
            siftCity(editText)
            tableView.reloadData()
        }
        else{
            self.isSearch = false
            tableView.reloadData()
        }

    }
    func searchView_textFieldDidEndEditing(searchView: SearchView) {
        
        print("AAAA")
    }
    
    
    //MARK:lzay
    lazy var dataSource: NSMutableArray = {
        let data = NSMutableArray()
        return data
    }()
    
    private lazy var city: CitySelectedCity = {
        let city = CitySelectedCity()
        return city
    }()
    
    private lazy var searchResults: NSMutableArray = {
        let results = NSMutableArray()
        return results
    }()

}
