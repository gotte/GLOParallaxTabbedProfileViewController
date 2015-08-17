//
//  GLOParallaxTabView.m
//  GLOParallaxTabbedProfileViewController
//
//  Created by Gabriel Otte on 8/15/15.
//  Copyright (c) 2015 Gabriel Otte. All rights reserved.
//

#import "GLOParallaxTabView.h"

@interface GLOParallaxTabView ()

@property (nonatomic) NSMutableArray *tabButtons;

@end

@implementation GLOParallaxTabView

#pragma mark - Initializers

- (instancetype)init {
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    screenBounds.size.height = 44.0;
    
    return [self initWithFrame:screenBounds];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

#pragma mark - UI setup

- (void)setTabTitles:(NSArray *)tabTitles {
    _tabTitles = tabTitles;
    _tabButtons = nil;
    _tabButtons = [[NSMutableArray alloc] init];
    
    for (NSString *tabTitle in tabTitles) {
        UIButton *currentButton = [self tabButtonWithTitle:tabTitle];
        [self addSubview: currentButton];
        [self.tabButtons addObject: currentButton];
    }
    if (self.tabButtons.count > 0) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tabButtons[0] attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        
        NSString *vflString = @"H:|[button0]";
        NSInteger keyInteger = 0;
        NSMutableDictionary *viewsDict = [[NSMutableDictionary alloc] init];
        for (UIButton *button in self.tabButtons) {
            NSString *currentButtonString = [NSString stringWithFormat:@"button%ld",keyInteger];
            if (keyInteger > 0) { //Skip the first item
                vflString = [NSString stringWithFormat:@"%@[%@(==button0)]",vflString, currentButtonString];
            }
            [viewsDict setObject:button forKey:currentButtonString];
            keyInteger++;
        }
        vflString = [NSString stringWithFormat:@"%@|",vflString];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflString options:NSLayoutFormatAlignAllBottom metrics:nil views:viewsDict]];

    }
    
}

- (UIButton *)tabButtonWithTitle:(NSString *)title {
    UIButton *button = [[UIButton alloc] init];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tabButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}
         
#pragma mark - UI Actions

- (void)tabButtonPressed:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(tabView:didSelectTab:)]) {
        [self.delegate tabView:self didSelectTab:button];
    }
}

@end
