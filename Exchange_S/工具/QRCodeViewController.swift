//
//  QRCodeViewController.swift
//  Exchange_S
//
//  Created by 李志宇 on 16/5/18.
//  Copyright © 2016年 izijia. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController,UITabBarDelegate {

    //MARK: ---------成员变量--------
    //底部按钮
    @IBOutlet weak var bottomTabbar: UITabBar!
    //冲击波顶部约束
    @IBOutlet weak var scanLineCons: NSLayoutConstraint!
    //扫描视图高度约束
    @IBOutlet weak var containerHeightCons: NSLayoutConstraint!
    //冲击波视图
    @IBOutlet weak var scanLineView: UIImageView!
    
    //最后扫描到的结果
    var resultQRString: String?
    
    //MARK:---------父类方法--------
    override func viewDidLoad() {
        super.viewDidLoad()

        //1.设置底部视图默认选中0
        bottomTabbar.selectedItem = bottomTabbar.items![0]
        //加入其代理方法
        bottomTabbar.delegate = self
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        //2.开始扫描
         startScan()
        //1.开始冲击波动画
         startAnimation()

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
       
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK:- 左右导航条点击事件
    
    //关闭按钮
    @IBAction func leftNavBtnClick(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    //扫描按钮
    @IBAction func rightNavBtnClick(sender: AnyObject) {
        
        
    }

    //MARK: --------自定义方法--------
    private func startAnimation(){
        
        
        //重置冲击波的frame:注->直接修改约束值在实际开发中无效,故改变其frame
        //1.执行冲击波动画
        let anit = CABasicAnimation (keyPath: "transform.translation.y")
        anit.fromValue = -self.containerHeightCons.constant
        anit.toValue = 0
        anit.duration = 2.0
        anit.repeatCount = MAXFLOAT
        self.scanLineView.layer.addAnimation(anit, forKey: "anit.transtion")
    }

    
    private func startScan(){
    
        //1.判断能否将输入添加到会话中
        
        if !session.canAddInput(deviceInput){
            return
        }
        //2.判断能否将输出添加到会话中
        if !session.canAddOutput(output) {
            return
        }
        
        //3.添加输入输出
        session.addInput(deviceInput)
        session.addOutput(output)
        
        //4.设置输出能够解析的数据类型
        //解析的类型有"支持的所有类型",必须在添加之后设置
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        //5.设置输出对象的代理
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        //添加预览土城
        view.layer.insertSublayer(previewLayer, atIndex: 0)
        previewLayer.addSublayer(drawLayer)
        //6.告诉session开始扫描
        session.startRunning()
    }
    
    
    
    //MARK:----------UITabBarDelegate-----------
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
        self.containerHeightCons.constant = item.tag == 0 ? 300:150
        self.scanLineView.layer.removeAnimationForKey("anit.transtion")
        startAnimation()
    }
    
    
    //MARK:-懒加载
    
    //会话
    private lazy var session:AVCaptureSession = AVCaptureSession()
    //拿到输入设备
    private lazy var deviceInput:AVCaptureDeviceInput? = {
        
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        do{
            let input = try AVCaptureDeviceInput (device: device)
            return input
            
        }catch{
            print(error)
            return nil
        }
   
        
    }()
    
    //输出
    private lazy var output: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
    
    //创建预览图层
    private lazy var previewLayer:AVCaptureVideoPreviewLayer = {

        let layer = AVCaptureVideoPreviewLayer (session: self.session)
        layer.frame = UIScreen.mainScreen().bounds

        return layer

    }()
    
    //创建边线的图层
    private lazy var drawLayer:CALayer = {
        let layer = CALayer()
        layer.frame = UIScreen.mainScreen().bounds
        return layer
    }()
    
    
}
extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate
{
    //只要解析到数据就会调用方法
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {

        //1.获取扫描到的数据
        if let resultValue = metadataObjects.last?.stringValue {
            //打印出最终结果
            self.resultQRString = resultValue
        }

        //2.获取扫描到的二维码的位置
        //2.1转换坐标
        for object in metadataObjects{
            //2.1.1判断当前获取到的数据是否是机器可识别的类型
            if object is AVMetadataMachineReadableCodeObject
            {
                //2.1.2将坐标转换为界面可以识别的坐标
                let codeObject = previewLayer.transformedMetadataObjectForMetadataObject(object as! AVMetadataObject) as! AVMetadataMachineReadableCodeObject
                //2.1.3绘制图形
                drawCorners(codeObject)
            }
        }
        
}
    
    private func drawCorners(codeObject:AVMetadataMachineReadableCodeObject){
    
        //如果是空 那么返回
        if codeObject.corners.isEmpty {
            return
        }
        //清空图层
        clearDrawLayer()
        // 1.创建一个图层
        let layer = CAShapeLayer()
        layer.lineWidth = 4
        layer.strokeColor = UIColor.greenColor().CGColor
        layer.fillColor = UIColor.clearColor().CGColor
        
        // 2.创建路径
        //        layer.path = UIBezierPath(rect: CGRect(x: 100, y: 100, width: 200, height: 200)).CGPath
        let path = UIBezierPath()
        var point = CGPointZero
    
        var index: Int = 0
        // 2.1移动到第一个点
        //        print(codeObject.corners.last)
        // 从corners数组中取出第0个元素, 将这个字典中的x/y赋值给point
        CGPointMakeWithDictionaryRepresentation((codeObject.corners[0] as! CFDictionaryRef), &point)
        path.moveToPoint(point)

        // 2.2移动到其它的点
        while index < codeObject.corners.count
        {
            CGPointMakeWithDictionaryRepresentation((codeObject.corners[index] as! CFDictionaryRef), &point)
            path.addLineToPoint(point)
            index = index + 1
        }
        // 2.3关闭路径
        path.closePath()
        
        // 2.4绘制路径
        layer.path = path.CGPath
        
        // 3.将绘制好的图层添加到drawLayer上
        self.drawLayer.addSublayer(layer)
        
        //4.一秒后移除
        dispatch_after(1, dispatch_get_main_queue()) {
            self.clearDrawLayer()
        }
    }
    private func clearDrawLayer(){
        //清空图层
        if drawLayer.sublayers?.count > 0 {
            for layer in drawLayer.sublayers! {
                layer.removeFromSuperlayer()
            }
        }
    }

}






