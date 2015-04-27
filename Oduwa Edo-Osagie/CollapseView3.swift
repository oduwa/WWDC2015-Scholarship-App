//
//  CollapseView3.swift
//  Oduwa Edo-Osagie
//
//  Created by Odie Edo-Osagie on 19/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

import UIKit

class CollapseView3: UIView {

    
    
    @IBOutlet weak var textLabel: UILabel!
    

    class func instanceFromNib() -> UIView {
        //return UINib(nibName: "CenterHomeView", bundle: NSBundle.mainBundle()).instantiateWithOwner(self, options: nil)[0] as! UIView
        return NSBundle.mainBundle().loadNibNamed("CollapseView3", owner: self, options: nil)[0] as! UIView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        if(UIScreen.mainScreen().bounds.height == 480){
            self.textLabel.font = UIFont(name: "AvenirNext-Regular", size: 15.0);
        }
    }
    
}
