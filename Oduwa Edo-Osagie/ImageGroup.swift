//
//  ImageGroup.swift
//  Oduwa Edo-Osagie
//
//  Created by Odie Edo-Osagie on 24/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

import UIKit

class ImageGroup: UIView {

    @IBOutlet weak var topLeft: UIImageView!
    @IBOutlet weak var topRight: UIImageView!
    @IBOutlet weak var bottomLeft: UIImageView!
    @IBOutlet weak var bottomRight: UIImageView!
    
    class func instanceFromNib() -> UIView {
        //return UINib(nibName: "CenterHomeView", bundle: NSBundle.mainBundle()).instantiateWithOwner(self, options: nil)[0] as! UIView
        return NSBundle.mainBundle().loadNibNamed("ImageGroup", owner: self, options: nil)[0] as! UIView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        topLeft.layer.borderWidth = 4.0;
        topLeft.layer.borderColor = UIColor.whiteColor().CGColor;
        
        topRight.layer.borderWidth = 4.0;
        topRight.layer.borderColor = UIColor.whiteColor().CGColor;
        
        bottomLeft.layer.borderWidth = 4.0;
        bottomLeft.layer.borderColor = UIColor.whiteColor().CGColor;
        
        bottomRight.layer.borderWidth = 4.0;
        bottomRight.layer.borderColor = UIColor.whiteColor().CGColor;
    }

}
