//
//  GLOParallaxTabView.m
//  GLOParallaxTabbedProfileViewController
//
//  Created by Gabriel Otte on 8/15/15.
//  Copyright (c) 2015 Gabriel Otte. All rights reserved.
//

#import "GLOParallaxTabView.h"
#import "GLOTabItemButton.h"

@interface GLOParallaxTabView ()

@property (nonatomic) NSMutableArray *tabButtons;

@end

@implementation GLOParallaxTabView

#pragma mark - Initializers

- (instancetype)init {
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    screenBounds.size.height = 80.0;
    
    return [self initWithFrame:screenBounds];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

- (instancetype)initWithHeight:(CGFloat)height {
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    screenBounds.size.height = height;
    self = [super initWithFrame:screenBounds];
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

#pragma mark - UI setup

- (void)setTabColors:(NSArray *)tabColors {
    if (self.tabButtons.count != tabColors.count) {
        NSLog(@"Number of colors must match the number of buttons");
        return;
    }
    else {
        NSInteger index = 0;
        for (UIButton *tabButton in self.tabButtons) {
            tabButton.backgroundColor = tabColors[index];
            index++;
        }
    }
}

- (void)setTabTitles:(NSArray *)tabTitles {
    _tabTitles = tabTitles;
    _tabButtons = nil;
    _tabButtons = [[NSMutableArray alloc] init];
    
    for (NSString *tabTitle in tabTitles) {
        GLOTabItemButton *currentButton = [self tabButtonWithTitle:tabTitle];
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
            
            NSString *vflVerticalString = [NSString stringWithFormat:@"V:|[%@(>=1,<=%f)]|",currentButtonString, self.bounds.size.height];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflVerticalString options:NSLayoutFormatAlignAllBottom metrics:nil views:@{currentButtonString:button}]];
            
            [viewsDict setObject:button forKey:currentButtonString];
            keyInteger++;
        }
        vflString = [NSString stringWithFormat:@"%@|",vflString];
//        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button0(>=50,<=80)]|" options:NSLayoutFormatAlignAllBottom metrics:nil views:@{@"button0":self.tabButtons[0]}]];
//        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button1(>=50,<=80)]|" options:NSLayoutFormatAlignAllBottom metrics:nil views:@{@"button1":self.tabButtons[1]}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflString options:NSLayoutFormatAlignAllBottom metrics:nil views:viewsDict]];
        

    }
    
    self.selectedIndex = 0;
    
}

- (GLOTabItemButton *)tabButtonWithTitle:(NSString *)title {
    GLOTabItemButton *button = [[GLOTabItemButton alloc] init];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.backgroundColor = [UIColor clearColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tabButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}
         
#pragma mark - UI Actions

- (void)tabButtonPressed:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(tabView:didSelectTab:)]) {
        [self.delegate tabView:self didSelectTab:button];
    }
    for (UIButton *currButton in self.tabButtons) {
        currButton.selected = NO;
    }
    button.selected = YES;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (selectedIndex > self.tabButtons.count - 1) {
        return;
    }
    else {
        [self tabButtonPressed:self.tabButtons[selectedIndex]];
    }
}

@end
