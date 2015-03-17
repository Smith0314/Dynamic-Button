# Dynamic_Button
Dynamic Create Button and Arrange, built using Swift, without storyboard
        
        
        
*演示影片:操作 Slider 來改變數量及行列
-------------------------------------------------------------------



        
        
*自動對應不同螢幕尺寸
-------------------------------------------------------------------



        
        
*用廻圈建立跟初始化按鈕
-------------------------------------------------------------------

首先宣告一個 function 來實例化按鈕

        func createNewButton(buttonName: String, num: Int) -> UIButton {
         let myButton = UIButton()
         return myButton
        }


接著用 for 廻圈來 呼叫 function 取得 button 實體，再一一放入 button 類型的 array 裹

        for var i:Int = 0; i < currentNum; i++ {
            var buttonName = "buttonName" + String(i)
            var buttonCreate = createNewButton(buttonName, num: i)
            arrayBtn.append(buttonCreate)
        }


再用列舉一一將 arrayBtn 陣列元素，即 button 實體 initialize

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

  
        
        
  *用 Slider 控制數量及行列
-------------------------------------------------------------------

宣告兩個 Slider，sliderBtnNum 控制 button 數量，sliderColumnsNum 控制每行有幾列，再宣告兩個 function 來將 Slider 的值代入

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



        
        
* Colorful!
-------------------------------------------------------------------
  
在廻圈裹 colorValue 的值會隨著廻圈累加，進而改變 button 背景色 RGB 的值 

       var colorValue:CGFloat = 0.01 * CGFloat(index)
       value.backgroundColor = UIColor(red: 0.5 + colorValue, green:0.5, blue: 1.5 - colorValue, alpha: 1.0)
  
  
宣告一個 function 來將 RGB 轉為 16進位的 hex 色碼
  
       func hexFromUIColor(color: UIColor) -> String
        {
            let hexString = String(format: "%02X%02X%02X",
            Int(CGColorGetComponents(color.CGColor)[0] * 255.0),
            Int(CGColorGetComponents(color.CGColor)[1] * 255.0),
            Int(CGColorGetComponents(color.CGColor)[2] * 255.0))
            return hexString
        }
  
