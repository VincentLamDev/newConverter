//
//  ViewController.swift
//  OneConverter
//
//  Created by Vincent Lam on 2017-02-17.
//  Copyright © 2017 Vincent Lam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var homeTitle: UILabel!
    
    @IBOutlet weak var distanceButton: UIButton!
    @IBOutlet weak var currencyButton: UIButton!
    @IBOutlet weak var volumeButton: UIButton!
    @IBOutlet weak var tempButton: UIButton!
    @IBOutlet weak var weightButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha:0.95)
            
            //UIColor(red: 200, green: 200, blue: 200,alpha:0.5)
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        let btnWidth = screenWidth * 0.425
        let btnHeight = (screenHeight * 0.6)/3
        let column1X = screenWidth * 0.05
        let column2X = screenWidth * 0.525
        let verticalGap = screenHeight * 0.05
        
        homeTitle.frame.origin = CGPoint(x: column1X * 2, y: verticalGap)
        homeTitle.frame.size.width = screenWidth * 0.8
        homeTitle.frame.size.height = screenHeight * 0.1
        homeTitle.font = UIFont(name: homeTitle.font.fontName, size: CGFloat(100))
        homeTitle.adjustsFontSizeToFitWidth = true
        homeTitle.baselineAdjustment = .alignCenters
        homeTitle.textColor = UIColor.black
        
        distanceButton.frame.size.width = btnWidth
        distanceButton.frame.size.height = btnHeight
        distanceButton.frame.origin = CGPoint(x: column1X, y: screenHeight * 0.20)
        addImageToButton(button: distanceButton, imageName: "distance.png", btnHeight: btnHeight, btnWidth: btnWidth, title: "Distance")
        distanceButton.backgroundColor = UIColor.white
        
        tempButton.frame.size.width = btnWidth
        tempButton.frame.size.height = btnHeight
        tempButton.frame.origin = CGPoint(x: column2X, y: btnHeight)
        addImageToButton(button: tempButton, imageName: "temp.png", btnHeight: btnHeight, btnWidth: btnWidth, title: "Temperature")
        tempButton.backgroundColor = UIColor.white

        weightButton.frame.size.width = btnWidth
        weightButton.frame.size.height = btnHeight
        weightButton.frame.origin = CGPoint(x: column1X, y: btnHeight * 2 + verticalGap)
        addImageToButton(button: weightButton, imageName: "weight.png", btnHeight: btnHeight, btnWidth: btnWidth, title: "Weight")
        weightButton.backgroundColor = UIColor.white

        volumeButton.frame.size.width = btnWidth
        volumeButton.frame.size.height = btnHeight
        volumeButton.frame.origin = CGPoint(x: column2X, y: btnHeight * 2 + verticalGap)
        addImageToButton(button: volumeButton, imageName: "volume.png", btnHeight: btnHeight, btnWidth: btnWidth, title: "Volume")
        volumeButton.backgroundColor = UIColor.white

        currencyButton.frame.size.width = btnWidth
        currencyButton.frame.size.height = btnHeight
        currencyButton.frame.origin = CGPoint(x: column1X, y: btnHeight * 3 + verticalGap * 2)
        addImageToButton(button: currencyButton, imageName: "currency.png", btnHeight: btnHeight, btnWidth: btnWidth, title: "Currency")
        currencyButton.backgroundColor = UIColor.white

        // Do any additional setup after loading the view, typically from a nib.
    }

    func addImageToButton(button: UIButton, imageName: String, btnHeight: CGFloat, btnWidth: CGFloat, title: String){
        let imageSize: CGFloat = btnHeight * 0.6
        let borderSize : CGFloat = 2
        let textHeight : CGFloat = btnHeight * 0.2
        let imageOrigin : CGFloat = btnHeight * 0.1
        let imageLeft : CGFloat = (btnWidth - imageSize)/2
        let textTop : CGFloat = imageOrigin * 2 + imageSize
        let textBottom : CGFloat = borderSize + btnHeight * 0.1
        let imageBottom : CGFloat = textBottom + textHeight
        
        //Border
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = borderSize
        
        //Image
        let myImage = UIImage(named: imageName)
        let size = CGSize(width: imageSize, height: imageSize)
        let resizedImage = resizeImage(image: myImage!, targetSize: size)
        button.setImage(resizedImage, for: UIControlState.normal)
        button.setImage(resizedImage, for: UIControlState.highlighted)
        button.imageEdgeInsets = UIEdgeInsets(top: imageOrigin, left: imageLeft, bottom: imageBottom, right: imageLeft)
        
        //Text
        button.setTitle(title, for: UIControlState.normal)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.titleEdgeInsets = UIEdgeInsets(top: textTop, left: -resizedImage.size.width, bottom: textBottom, right: 0.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x:0, y:0, width:newSize.width, height:newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

}

