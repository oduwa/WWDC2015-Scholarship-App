//
//  LeftHomeView.swift
//  Oduwa Edo-Osagie
//
//  Created by Odie Edo-Osagie on 18/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

import UIKit

class LeftHomeView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    @IBOutlet weak var interestsLabel: UILabel!
    
    @IBOutlet weak var northImageView: UIImageView!
    @IBOutlet weak var eastImageView: UIImageView!
    @IBOutlet weak var southImageView: UIImageView!
    @IBOutlet weak var westImageView: UIImageView!
    @IBOutlet weak var northEastImageView: UIImageView!
    @IBOutlet weak var northWestImageView: UIImageView!
    @IBOutlet weak var southWestImageView: UIImageView!
    @IBOutlet weak var southEastImageView: UIImageView!
    
    
    
    
    
    
    
    class func instanceFromNib() -> UIView {
        //return UINib(nibName: "CenterHomeView", bundle: NSBundle.mainBundle()).instantiateWithOwner(self, options: nil)[0] as! UIView
        return NSBundle.mainBundle().loadNibNamed("LeftHomeView", owner: self, options: nil)[0] as! UIView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        self.interestsLabel.font = UIFont(name: "KozGoPro-ExtraLight", size: 22.0);
        
        self.setTranslatesAutoresizingMaskIntoConstraints(false);
        
        /* Layout NW,SW,NE,SW image views */
        self.addConstraint(NSLayoutConstraint(item: self.northWestImageView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 0.5, constant: 0));
        
        self.addConstraint(NSLayoutConstraint(item: self.southWestImageView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 0.5, constant: 0));
        
        self.addConstraint(NSLayoutConstraint(item: self.northEastImageView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.5, constant: 0));
        
        self.addConstraint(NSLayoutConstraint(item: self.southEastImageView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.5, constant: 0));
        
        
        /* Initialize image views */
        //self.northImageView.image = UIImage(named: "woods.jpg");
        self.roundImageView(self.northImageView);
        //self.northWestImageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        //self.southImageView.image = UIImage(named: "woods.jpg");
        self.roundImageView(self.southImageView);
        
        //self.eastImageView.image = UIImage(named: "woods.jpg");
        self.roundImageView(self.eastImageView);
        
        //self.westImageView.image = UIImage(named: "woods.jpg");
        self.roundImageView(self.westImageView);
        
        //self.northEastImageView.image = UIImage(named: "woods.jpg");
        self.roundImageView(self.northEastImageView);
        
        //self.northWestImageView.image = UIImage(named: "woods.jpg");
        self.roundImageView(self.northWestImageView);
        
        //self.southEastImageView.image = UIImage(named: "woods.jpg");
        self.roundImageView(self.southEastImageView);
        
        //self.southWestImageView.image = UIImage(named: "woods.jpg");
        self.roundImageView(self.southWestImageView);
        
        self.northImageView.hidden = true;
        self.southImageView.hidden = true;
        self.eastImageView.hidden = true;
        self.westImageView.hidden = true;
        self.northEastImageView.hidden = true;
        self.northWestImageView.hidden = true;
        self.southEastImageView.hidden = true;
        self.southWestImageView.hidden = true;
    }
    
    private func roundImageView(imageView: UIImageView){
        imageView.layer.cornerRadius = imageView.bounds.height/2.0;
        imageView.layer.borderWidth = 2.0;
        imageView.layer.borderColor = UIColor.whiteColor().CGColor;
        //imageView.layer.masksToBounds = false;
        //imageView.clipsToBounds = true;
    }
    
}
