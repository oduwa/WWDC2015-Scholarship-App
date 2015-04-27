//
//  VPRubberCell.h
//  VPRubberTable
//
//  Created by Vitalii Popruzhenko on 5/27/14.
//  Copyright (c) 2014 Vitaliy Popruzhenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPRubberSettings.h"

@interface VPRubberCell : UICollectionViewCell {
    CGFloat heightNew;
}
@property (strong, nonatomic) UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView2;


- (void)setNewHeight:(CGFloat)h;

@end
