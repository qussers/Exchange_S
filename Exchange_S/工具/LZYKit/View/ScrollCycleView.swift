//
//  ScrollCycleView.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/6/25.
//  Copyright © 2016年 izijia. All rights reserved.
//

import UIKit


@objc protocol ScrollCycleViewDataSource {
    
    //总共有多少页
    func numberofPage(scrollCycleView:ScrollCycleView)->NSInteger
    
    //每页展示什么
    func scrollCycleView(index:NSInteger, scrollCycleView:UIView) ->UIView
    
    //点击某页
    func scrollCycleView(didSelectedAtIndex index:NSInteger, scrollCycleView:UIView)
    
}


class ScrollCycleView: UIView ,UIScrollViewDelegate{
    

    weak var dataSource:ScrollCycleViewDataSource?
    //当前页
    var currentPage:NSInteger?
    //总页数
    var totalPage: NSInteger?

    var curViews = [UIView?]()
    //初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func reloadData(){
        currentPage = 0
        totalPage = dataSource?.numberofPage(self)

        //检查有效性
        if totalPage == 0 {

            for subView in scrollView.subviews {
                subView.removeFromSuperview()
            }
            return
        }
        
        
        //加载数据显示
        loadData()
    }
    private func loadData(){
    
        //移除子view
        for subView in scrollView.subviews {
            subView.removeFromSuperview()
        }
        getDisplayViewWithCurpage(currentPage!)
        //添加子控件
        for index  in 0..<3 {
            let subView = curViews[index]
            subView!.frame = CGRectMake(CGFloat(index) * scrollView.frame.size.width , 0, scrollView.frame.size.width, scrollView.frame.size.height)
            //添加到当前
            scrollView.addSubview(subView!)
        }
        scrollView.setContentOffset(CGPointMake(scrollView.frame.size.width, 0), animated: false)
    }
    private func getDisplayViewWithCurpage(index:NSInteger){
        
        let pre = validPageValue(currentPage! - 1)
        let last = validPageValue(currentPage! + 1)
        curViews.removeAll()
        let preView  = dataSource?.scrollCycleView(pre, scrollCycleView: self);
        let curView  = dataSource?.scrollCycleView(index, scrollCycleView: self);
        let lastView  = dataSource?.scrollCycleView(last, scrollCycleView: self);
        curViews.append(preView!);
        curViews.append(curView!);
        curViews.append(lastView!);
    }
    
    private func validPageValue(value:NSInteger)->NSInteger{
        
        if value == -1 {
            
             return totalPage! - 1
        }
        if value == totalPage {
            
            return 0
        }
        return value
    }
    
    private func setViewContent(view:UIView, atIndex index:NSInteger){
    
        if index == currentPage {
            curViews[1] = view
            for index in 0...3 {
                let v = curViews[index]
                v!.userInteractionEnabled = true
                v!.frame = CGRectMake(v!.frame.size.width * CGFloat(index), 0, v!.frame.size.width, v!.frame.size.height)
                scrollView.addSubview(v!)
            }
        }
    }
    
    //MARK:UIScrollViewDelegate
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let x = scrollView.contentOffset.x
        
        //往下翻一张
        if x >= (2 * self.frame.size.width) {
            
            currentPage = validPageValue(currentPage! + 1)
            
            loadData()
        }
        //往下翻
        if x <= 0 {
            currentPage = validPageValue(currentPage! - 1)
            loadData()
        }

    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        scrollView.setContentOffset(CGPointMake(scrollView.frame.size.width, 0), animated: false)
    }
    
    
    //MARK:lazy
    lazy var scrollView:UIScrollView = {
    
        let scr = UIScrollView (frame:self.bounds)
        scr.delegate = self
        scr.pagingEnabled = true
        scr.scrollsToTop = true
        scr.contentSize = CGSizeMake(self.bounds.width * 3, self.bounds.height)
        return scr
    }()
    

    
    
    

}
