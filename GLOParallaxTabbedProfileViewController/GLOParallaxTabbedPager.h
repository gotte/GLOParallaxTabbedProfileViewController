//
//  GLOParallaxTabbedPager.h
//  GLOParallaxTabbedProfileViewController
//
//  Created by Gabriel Otte on 8/15/15.
//  Copyright (c) 2015 Gabriel Otte. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GLOParallaxTabbedPager;

@protocol GLOParallaxTabbedPagerDelegate <NSObject>

@optional

- (void)tabbedPager:(GLOParallaxTabbedPager *)tabbedPager didSelectView:(UIView *)view;

@end

@protocol GLOParallaxTabbedPagerDataSource <NSObject>

@required

- (NSInteger)numberOfPagesInTabbedPager:(GLOParallaxTabbedPager *)tabbedPager;

- (UIView *)tabbedPager:(GLOParallaxTabbedPager *)tabbedPager viewForTabAtIndex:(NSInteger)index;

- (NSString *)tabbedPager:(GLOParallaxTabbedPager *)tabbedPager titleForTabAtIndex:(NSInteger)index;



@end


@interface GLOParallaxTabbedPager : UIView

@property (nonatomic) id<GLOParallaxTabbedPagerDelegate> delegate;

@property (nonatomic) id<GLOParallaxTabbedPagerDataSource> dataSource;

@end
