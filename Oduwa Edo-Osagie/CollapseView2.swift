//
//  CollapseView2.swift
//  Oduwa Edo-Osagie
//
//  Created by Odie Edo-Osagie on 19/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

import UIKit

class CollapseView2: UIView {

    
    @IBOutlet weak var textLabel: UILabel!
    
    class func instanceFromNib() -> UIView {
        //return UINib(nibName: "CenterHomeView", bundle: NSBundle.mainBundle()).instantiateWithOwner(self, options: nil)[0] as! UIView
        return NSBundle.mainBundle().loadNibNamed("CollapseView2", owner: self, options: nil)[0] as! UIView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        self.textLabel.text = "To quote the rapper, Big Sean, \"even when its so late that its early, I remember the reason that I do what I do :- for the adrenaline rush of creating what I think about.\"";
        if(UIScreen.mainScreen().bounds.height == 480){
            self.textLabel.font = UIFont(name: "AvenirNext-Regular", size: 15.0);
        }
    }

}
