//
//  SwiftAppUtils.swift
//  OduwaEdo-Osagie
//
//  Created by Odie Edo-Osagie on 16/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

import UIKit
import CoreMotion

private let _AppUtilsharedInstance = SwiftAppUtils()

let kCenterOnPersonal = "kCenterOnPersonal"

class SwiftAppUtils: NSObject {
    
    class var sharedInstance: SwiftAppUtils {
        return _AppUtilsharedInstance;
    }
    
    var sharedMotionManager : CMMotionManager = CMMotionManager();
    var currentProjectPageIndex : Int = 0
    var currentInterestColour : UIColor = UIColor.whiteColor();
    var currentInterestText = "";
    
    override init(){
        
    }
    
    class func isIOS7OrHigher() -> Bool {
        var versionNumber = floor(NSFoundationVersionNumber);
        return versionNumber > NSFoundationVersionNumber_iOS_6_1;
    }
    
    class func isIOS8OrHigher() -> Bool {
        var versionNumber = floor(NSFoundationVersionNumber);
        return versionNumber > NSFoundationVersionNumber_iOS_7_1;
    }
    
    class func printFonts() {
        let fontFamilyNames = UIFont.familyNames()
        for familyName in fontFamilyNames {
            println("------------------------------")
            println("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNamesForFamilyName(familyName as! String)
            println("Font Names = [\(names)]")
        }
    }
    
    class func getScreenResolutionSize() -> CGSize {
        let width : CGFloat = UIScreen.mainScreen().bounds.width * UIScreen.mainScreen().scale;
        let height : CGFloat = UIScreen.mainScreen().bounds.height * UIScreen.mainScreen().scale;
        return CGSizeMake(width, height);
    }
    
    class func calculateHeight(forWidth: CGFloat, andAspectRatio : CGFloat) -> CGFloat {
        return forWidth*andAspectRatio;
    }
    
    class func calculateWidth(forHeight: CGFloat, andAspectRatio : CGFloat) -> CGFloat {
        return forHeight/andAspectRatio;
    }
    
    
}
