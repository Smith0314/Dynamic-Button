//
//  ViewController.swift
//  Dynamic_Button
//
//  Created by Smith on 2015/3/10.
//  Copyright (c) 2015 Smith-Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIAlertViewDelegate  {
    
    var buttonNames: [String] = []
    var arrayBtn: [UIButton] = []
    var currentNum:Int = 1
    var btnPosY:Int = 0
    var btnPosX:Int = 0
    var btnWidth:CGFloat = 0
    var btnSpace:CGFloat = 10
    var btnIndex:Int = 0
    var btnVspace:CGFloat = 0
    var columnsNum:Int = 1
    var rowSpace:CGFloat = 0
    var vSpace:Int = 60
    var sliderBtnNum: UISlider!
    var sliderColumnsNum: UISlider!
    var sliderTrackColor: UIColor!
    var showBtnNum: UILabel!
    var showColumnsNum:UILabel!
    var titleBtnNum: UILabel!
    var titleColumnsNum: UILabel!
    var logo:UILabel!
    var colorArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0.1, green:0.1, blue: 0.2, alpha: 1.0)
        
        sliderTrackColor = UIColor(red: 0.5, green:0.5, blue: 1.5, alpha: 1.0)
        
        sliderBtnNum = UISlider(frame: CGRect(x: 5, y: 30, width: 120, height: 23))
        sliderBtnNum.minimumValue = 1
        sliderBtnNum.maximumValue = 60
        sliderBtnNum.value = sliderBtnNum!.minimumValue
        sliderBtnNum.addTarget(self, action: "startArrange:", forControlEvents: .ValueChanged)
        sliderBtnNum.maximumTrackTintColor = UIColor(red: 0.3, green:0.3, blue: 0.4, alpha: 1.0)
        sliderBtnNum.minimumTrackTintColor = sliderTrackColor
        sliderBtnNum.setThumbImage(UIImage(named: "ThumbNormal"), forState: .Normal)
        sliderBtnNum.setThumbImage(UIImage(named: "ThumbHighlighted"), forState: .Highlighted)
        sliderBtnNum.continuous=false
        
        var colPosX:Int = Int(self.view.bounds.width) - 125
        
        sliderColumnsNum = UISlider(frame: CGRect(x: colPosX, y: 30, width: 120, height: 23))
        sliderColumnsNum.minimumValue = 1
        sliderColumnsNum.maximumValue = 6
        sliderColumnsNum.value = sliderColumnsNum!.minimumValue
        sliderColumnsNum.addTarget(self, action: "changeColumnsNum:", forControlEvents: .ValueChanged)
        sliderColumnsNum.maximumTrackTintColor = UIColor(red: 0.3, green:0.3, blue: 0.4, alpha: 1.0)
        sliderColumnsNum.minimumTrackTintColor = sliderTrackColor
        sliderColumnsNum.setThumbImage(UIImage(named: "ThumbNormal"), forState: .Normal)
        sliderColumnsNum.setThumbImage(UIImage(named: "ThumbHighlighted"), forState: .Highlighted)
        
        showBtnNum = UILabel()
        showBtnNum.frame = CGRect(x: 55, y: 15, width: 20, height: 20)
        showBtnNum.font = UIFont(name:"AvenirNext-Regular", size:14.0)
        showBtnNum.textColor = UIColor(red: 0.3, green:0.3, blue: 0.4, alpha: 1.0)
        showBtnNum.textAlignment = .Center
        
        showColumnsNum = UILabel()
        showColumnsNum.frame = CGRect(x: colPosX + 50, y: 15, width: 20, height: 20)
        showColumnsNum.font = UIFont(name:"AvenirNext-Regular", size:14.0)
        showColumnsNum.textColor = UIColor(red: 0.3, green:0.3, blue: 0.4, alpha: 1.0)
        showColumnsNum.textAlignment = .Center
        
        titleBtnNum = UILabel()
        titleBtnNum.frame = CGRect(x: 15, y: 45, width: 100, height: 20)
        titleBtnNum.font = UIFont(name:"AvenirNext-Regular", size:10.0)
        titleBtnNum.textColor = UIColor(red: 0.3, green:0.3, blue: 0.4, alpha: 1.0)
        titleBtnNum.textAlignment = .Center
        titleBtnNum.text = "BLOCK NUMBER"
        
        titleColumnsNum = UILabel()
        titleColumnsNum.frame = CGRect(x: colPosX + 11, y: 45, width: 100, height: 20)
        titleColumnsNum.font = UIFont(name:"AvenirNext-Regular", size:10.0)
        titleColumnsNum.textColor = UIColor(red: 0.3, green:0.3, blue: 0.4, alpha: 1.0)
        titleColumnsNum.textAlignment = .Center
        titleColumnsNum.text = "COLUMNS NUMBER"
        
        var logoPosX:Int = Int(self.view.bounds.width / 2) - 50
        
        logo = UILabel()
        logo.frame = CGRect(x: logoPosX, y: 15, width: 100, height: 50)
        logo.font = UIFont(name:"untitled-font-1", size:35.0)
        logo.textColor = UIColor(red: 0.3, green:0.3, blue: 0.4, alpha: 1.0)
        logo.textAlignment = .Center
        logo.text = "s"
        
        view.addSubview(sliderBtnNum)
        view.addSubview(sliderColumnsNum)
        view.addSubview(showBtnNum)
        view.addSubview(showColumnsNum)
        view.addSubview(titleBtnNum)
        view.addSubview(titleColumnsNum)
        view.addSubview(logo)
    }
    
    func changeColumnsNum(slider: UISlider){
        columnsNum = Int(slider.value)
        sliderBtnNum.minimumValue = slider.value
        showColumnsNum.text = "\(Int(slider.value))"
    }
    
    func startArrange(slider: UISlider){
        
        sliderBtnNum.minimumTrackTintColor = sliderTrackColor
        sliderColumnsNum.minimumTrackTintColor = sliderTrackColor
        showBtnNum.textColor = sliderTrackColor
        showColumnsNum.textColor = sliderTrackColor
        showBtnNum.text = "\(Int(slider.value))"
        titleBtnNum.textColor = sliderTrackColor
        titleColumnsNum.textColor = sliderTrackColor
        logo.textColor = sliderTrackColor
        
        if slider.value != 0 {
            arrayBtn = []
            let subviews = self.view.subviews as [UIView]
            for v in subviews {
                if let button = v as? UIButton {
                    button.removeFromSuperview()
                }
            }
        }
        
        currentNum = Int(slider.value)
        
        btnSpace = self.view.bounds.width / 100
        btnVspace = CGFloat(currentNum / columnsNum)
        rowSpace = (self.view.bounds.height / 100)
        
        for var i:Int = 0; i < currentNum; i++ {
            var buttonName = "buttonName" + String(i)
            var buttonCreate = createNewButton(buttonName, num: i)
            arrayBtn.append(buttonCreate)
        }
        
        if currentNum % columnsNum != 0 {
            btnVspace = CGFloat(currentNum / columnsNum) + 1
        }
        
        for (index, value) in enumerate(arrayBtn){
            
            var btnCount = CGFloat(arrayBtn.count + 1) * btnSpace
            var btnHeight:CGFloat = (self.view.bounds.height / btnVspace) - rowSpace - CGFloat(vSpace / (currentNum / columnsNum))
            
            if index % columnsNum == 0 {
                btnIndex = 0
                btnPosY = (Int(btnHeight) * (index / columnsNum) + Int(rowSpace) * (index / columnsNum)) + Int(rowSpace)
                btnPosY += vSpace
            }else{
                btnIndex += 1
            }
            
            var btnPosX = Int(btnWidth) * btnIndex + Int(btnSpace) * (btnIndex + 1)
            
            if currentNum < columnsNum {
                btnWidth = (self.view.bounds.width - btnCount) / CGFloat(currentNum)
            }else{
                btnWidth = (self.view.bounds.width - (btnSpace * CGFloat(columnsNum + 1))) / CGFloat(columnsNum)
            }
            
            var colorValue:CGFloat = 0.01 * CGFloat(index)
            
            value.frame = CGRect(x: btnPosX + 2, y: btnPosY, width: Int(btnWidth), height: Int(btnHeight))
            arrayBtn[index] = UIButton.buttonWithType(.Custom) as UIButton
            value.backgroundColor = UIColor(red: 0.5 + colorValue, green:0.5, blue: 1.5 - colorValue, alpha: 1.0)
            sliderTrackColor = value.backgroundColor
            value.setTitle("NO.\(index+1)", forState: UIControlState.Normal)
            value.titleLabel!.font = UIFont(name:"AvenirNext-Regular", size:13.0)
            value.addTarget(self, action: "processButton:", forControlEvents: UIControlEvents.TouchUpInside)
            value.tag = index
            
            var theColor:String = hexFromUIColor(value.backgroundColor!)
            
            colorArray.append(theColor)
            
            view.addSubview(value)
        }
    }
    
    func hexFromUIColor(color: UIColor) -> String
    {
        let hexString = String(format: "%02X%02X%02X",
            Int(CGColorGetComponents(color.CGColor)[0] * 255.0),
            Int(CGColorGetComponents(color.CGColor)[1] * 255.0),
            Int(CGColorGetComponents(color.CGColor)[2] * 255.0))
        return hexString
    }
    
    func textFieldShouldReturn(paramTextField: UITextField) -> Bool{
        paramTextField.resignFirstResponder()
        return true
    }
    
    func createNewButton(buttonName: String, num: Int) -> UIButton {
        let myButton = UIButton()
        return myButton
    }
    
    func processButton(button: UIButton) {
        var theAlert:UIAlertView = UIAlertView(title: "COLOR \(button.tag+1)", message: "#\(colorArray[button.tag])", delegate: self, cancelButtonTitle: "OK")
        
        theAlert.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

