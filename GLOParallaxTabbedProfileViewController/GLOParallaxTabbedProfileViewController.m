//
//  GLOParallaxTabbedProfileViewController.m
//  GLOParallaxTabbedProfileViewController
//
//  Created by Gabriel Otte on 8/15/15.
//  Copyright © 2015 Gabriel Otte. All rights reserved.
//

#import "GLOParallaxTabbedProfileViewController.h"

@interface GLOParallaxTabbedProfileViewController ()<GLOParallaxTabViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UIImageView *profileImageView;
@property (nonatomic) UITableView *scrollView;
@end

@implementation GLOParallaxTabbedProfileViewController

static const CGFloat GLOIndicatorArrowHeight = 6.0;
static const CGFloat GLOTabbedPagerViewHeight = 80.0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GLOParallaxTabView *tabView = [[GLOParallaxTabView alloc] initWithHeight:GLOTabbedPagerViewHeight];
    tabView.tabTitles = @[@"Friends (100)", @"Circles (2)", @"Settings"];
    tabView.tabColors = @[[UIColor lightGrayColor], [UIColor orangeColor], [UIColor purpleColor]];
    tabView.delegate = self;
    [self.view addSubview:tabView];
    
    _profileImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profileImage"]];
    _profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    _profileImageView.backgroundColor = [UIColor lightGrayColor];
    
    _profileImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    _scrollView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.scrollView setParallaxHeaderView:self.profileImageView mode:VGParallaxHeaderModeTopFill height:[UIScreen mainScreen].bounds.size.height + GLOIndicatorArrowHeight];
    self.scrollView.delegate = self;
    self.scrollView.dataSource = self;
    [self.scrollView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    self.scrollView.parallaxHeader.stickyViewPosition = VGParallaxHeaderStickyViewPositionBottom;
    [self.scrollView.parallaxHeader setStickyView:tabView withHeight:GLOTabbedPagerViewHeight];
    
    [self.view addSubview:_scrollView];
    [self.scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, 3000)];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabView:(GLOParallaxTabView *)tabView didSelectTab:(UIButton *)button {
    NSLog(@"%@ selected",[button titleForState:UIControlStateNormal]);
    NSLog(@"Offset: %f", self.scrollView.contentOffset.y);
    
    CGFloat offset = [UIScreen mainScreen].bounds.size.height/2;
    
    if (self.scrollView.contentOffset.y < offset) {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [self.scrollView setContentOffset:CGPointMake(0, offset) animated:YES];
        } completion:nil];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.scrollView shouldPositionParallaxHeader];
    
    //[scrollView.parallaxHeader.stickyView setAlpha:scrollView.parallaxHeader.progress];
//    self.headerView.backgroundColor = [UIColor colorForFadeBetweenFirstColor:[UIColor colorWithRed:0.59 green:0.85 blue:0.27 alpha:1]
//                                                                 secondColor:[UIColor colorWithRed:0.86 green:0.09 blue:0.13 alpha:1]
//                                                                     atRatio:ratio];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Row %@", @(indexPath.row)];
    
    return cell;
}


@end
