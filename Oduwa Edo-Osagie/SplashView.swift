//
//  SplashView.swift
//  Oduwa Edo-Osagie
//
//  Created by Odie Edo-Osagie on 24/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

import UIKit

class SplashView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var filterView: UIView!
    
    class func instanceFromNib() -> UIView {
        //return UINib(nibName: "CenterHomeView", bundle: NSBundle.mainBundle()).instantiateWithOwner(self, options: nil)[0] as! UIView
        return NSBundle.mainBundle().loadNibNamed("SplashView", owner: self, options: nil)[0] as! UIView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        self.roundImageView(self.imageView);
    }
    
    private func roundImageView(imageView: UIImageView){
        imageView.layer.cornerRadius = imageView.bounds.height/2.0;
        imageView.layer.borderWidth = 2.0;
        imageView.layer.borderColor = UIColor.blackColor().CGColor;
        imageView.layer.masksToBounds = false;
        imageView.clipsToBounds = true;
    }

}
