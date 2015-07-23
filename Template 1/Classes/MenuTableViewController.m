//
//  MenuTableViewController.m
//  Template 1
//
//  Created by Rafael on 05/12/13.
//  Copyright (c) 2013 Rafael Colatusso. All rights reserved.
//

#import "MenuTableViewController.h"

@interface MenuTableViewController ()
@property (strong, nonatomic) NSArray *menuOptions;
@property (assign, nonatomic) CGFloat screenWidth;
@property (assign, nonatomic) CGFloat screenHeight;
@property (assign, nonatomic) BOOL sideMenuVisible;
@property (strong, nonatomic) ListViewController *listViewController;
@end

@implementation MenuTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sideMenuVisible = NO;
    self.menuOptions = [NSArray arrayWithObjects:@"COOL STUFF", @"APPLE", @"PIMP MY RIDE", @"AWESOME BOOKS", nil];
    self.tableView.backgroundColor = [UIColor colorWithRed:59/255.0 green:42/255.0 blue:58/255.0 alpha:1.0];
    
    UIImageView *navigationImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 79, 42)];
    navigationImage.image=[UIImage imageNamed:@"menu_logo.png"];
    
    UIImageView *workaroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 79, 42)];
    [workaroundImageView addSubview:navigationImage];
    self.navigationItem.titleView=workaroundImageView;
    
    UISwipeGestureRecognizer* right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight)];
    right.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:right];
    
    UISwipeGestureRecognizer* left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
    left.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:left];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.screenWidth = screenRect.size.width;
    self.screenHeight = screenRect.size.height;

    [self instantiateControllers];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.menuOptions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuCell";
    CustomMenuCell *customCell = (CustomMenuCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!customCell) {
        customCell = [[CustomMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    customCell.info.text = [self.menuOptions objectAtIndex:indexPath.row];

    switch (indexPath.row) {
        case 0:
            customCell.accessoryImage.image = [UIImage imageNamed:@"red"];
            break;
        case 1:
            customCell.accessoryImage.image = [UIImage imageNamed:@"orange"];
            break;
        case 2:
            customCell.accessoryImage.image = [UIImage imageNamed:@"green"];
            break;
        default:
            customCell.accessoryImage.image = [UIImage imageNamed:@"yellow"];
            break;
    }
    
    customCell.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    return customCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self showMenu:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        default:
            break;
    }
}

#pragma mark -
#pragma mark Helper methods

- (void)instantiateControllers {
    self.listViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                               instantiateViewControllerWithIdentifier:@"CollectionViewController"];
    self.listViewController.view.tag = 999;
    self.listViewController.view.frame = CGRectMake(0, 0, self.screenWidth, self.screenHeight);
    [self.view addSubview:self.listViewController.view];
}

- (void)removeSubviews {
    // remove the current subview loaded
    for (UIView *view in [self.view subviews]) {
        if (view.tag == 999) {
            [view removeFromSuperview];
        }
    }
}

- (void)swipeLeft {
    if (self.sideMenuVisible) {
        [self showMenu:nil];
    }
}

- (void)swipeRight {
    if (!self.sideMenuVisible) {
        [self showMenu:nil];
    }
}

- (IBAction)showMenu:(id)sender {
    for (UIView *view in [self.view subviews]) {
        if (view.tag == 999) {
            if (self.sideMenuVisible) {
                view.frame = CGRectMake((self.screenWidth * 0.8), 0, self.screenWidth, self.screenHeight);
                [UIView animateWithDuration:0.3f animations:^{
                    view.frame = CGRectMake(0, 0, self.screenWidth, self.screenHeight);
                }];
            }
            else {
                [UIView animateWithDuration:0.3f animations:^{
                    view.frame = CGRectMake((self.screenWidth * 0.8), 0, self.screenWidth, self.screenHeight);
                }];
            }
            self.sideMenuVisible = !self.sideMenuVisible;
        }
    }
}

@end
