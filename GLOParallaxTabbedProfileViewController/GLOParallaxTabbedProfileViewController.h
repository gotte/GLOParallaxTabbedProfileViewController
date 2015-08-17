//
//  GLOParallaxTabbedProfileViewController.h
//  GLOParallaxTabbedProfileViewController
//
//  Created by Gabriel Otte on 8/15/15.
//  Copyright © 2015 Gabriel Otte. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GLOParallaxTabView.h"
#import "UIScrollView+VGParallaxHeader.h"

@interface GLOParallaxTabbedProfileViewController : UIViewController

- (void)tabView:(GLOParallaxTabView *)tabView didSelectTab:(UIButton *)button;

@end

