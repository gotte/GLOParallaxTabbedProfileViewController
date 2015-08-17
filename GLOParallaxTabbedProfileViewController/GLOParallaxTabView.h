//
//  GLOParallaxTabView.h
//  GLOParallaxTabbedProfileViewController
//
//  Created by Gabriel Otte on 8/15/15.
//  Copyright (c) 2015 Gabriel Otte. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GLOParallaxTabView;

@protocol GLOParallaxTabViewDelegate <NSObject>

@optional

- (void)tabView:(GLOParallaxTabView *)tabView didSelectTab:(UIButton *)button;

@end

@interface GLOParallaxTabView : UIView

@property (nonatomic) NSArray *tabTitles;
@property (nonatomic) id<GLOParallaxTabViewDelegate> delegate;
@property (nonatomic) NSInteger selectedIndex;

@end
