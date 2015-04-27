//
//  RightHomeView.swift
//  Oduwa Edo-Osagie
//
//  Created by Odie Edo-Osagie on 18/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

import UIKit

class RightHomeView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var middleLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    
    class func instanceFromNib() -> UIView {
        //return UINib(nibName: "CenterHomeView", bundle: NSBundle.mainBundle()).instantiateWithOwner(self, options: nil)[0] as! UIView
        return NSBundle.mainBundle().loadNibNamed("RightHomeView", owner: self, options: nil)[0] as! UIView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        self.topLabel.font = UIFont(name: "KozGoPro-ExtraLight", size: 22.0);
        self.topLabel.sizeToFit();
        
        self.middleLabel.font = UIFont(name: "KozGoPro-ExtraLight", size: 22.0);
        self.middleLabel.sizeToFit();
        
        self.bottomLabel.font = UIFont(name: "KozGoPro-ExtraLight", size: 22.0);
        self.bottomLabel.sizeToFit();
    }

}
