//
//  CenterHomeView.swift
//  Oduwa Edo-Osagie
//
//  Created by Odie Edo-Osagie on 18/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

import UIKit

class CenterHomeView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileTextView: UITextView!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    class func instanceFromNib() -> UIView {
        //return UINib(nibName: "CenterHomeView", bundle: NSBundle.mainBundle()).instantiateWithOwner(self, options: nil)[0] as! UIView
        return NSBundle.mainBundle().loadNibNamed("CenterHomeView", owner: self, options: nil)[0] as! UIView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        /* Name Labels */
        //self.firstNameLabel.font = UIFont(name: "KozGoPro-ExtraLight", size: 17.0);
        self.firstNameLabel.sizeToFit();
        //self.lastNameLabel.font = UIFont(name: "KozGoPro-ExtraLight", size: 17.0);
        self.lastNameLabel.sizeToFit();
        
        /* "More" button */
        self.moreButton.titleLabel?.font = UIFont(name: "MyriadPro-Regular", size: 15.0);
        
        /* Rounding Image View */
        self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.height/2.0;
        self.profileImageView.layer.borderWidth = 1.0;
        self.profileImageView.layer.borderColor = UIColor.redColor().CGColor;
        self.profileImageView.layer.masksToBounds = false;
        self.profileImageView.clipsToBounds = true;
        
        /* Description text view */
        //self.profileTextView.font = UIFont(name: "MyriadPro-Regular", size: 14.0);
        //self.profileTextView.font = UIFont(name: "AvenirNext-Bold", size: 14.0);
        //self.profileTextView.text = "Tilt your device left and right to navigate.\n\nWelcome to my WWDC app! My name is Oduwa Edo-Osagie. I am in my third year at the University of East Anglia. I like to build quality software that is aestetically pleasing and used by lots of people.\n\nTilt your device to the left to view my projects and experiences. Tilt you device to the right to view some of my Interests.\n\nPress the \"more\" button below to get to know me a little better.";
    }

}
