//
//  MessageViewController.m
//  Game
//
//  Created by Artgin on 12/15/12.
//  Copyright (c) 2012 Innovaton. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageViewCell.h"

#define DISMISS_OPTION_MENU_BUTTON_TAG 999

@interface MessageViewController ()

@property (strong, nonatomic) NSArray *messagesArray;
@property (weak, nonatomic) IBOutlet UIView *optionsView;

@property (weak, nonatomic) IBOutlet MessageViewCell *messageCell;

- (IBAction)toggleOptionsMenuView:(id)sender;

@end

@implementation MessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadMessages];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleOptionsMenuView:(id)sender
{
    if (CGAffineTransformIsIdentity(self.optionsView.transform))
    {
        UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        dismissBtn.tag = DISMISS_OPTION_MENU_BUTTON_TAG;
        dismissBtn.frame = self.view.frame;
        [dismissBtn addTarget:self action:@selector(hideOptionsMenu) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view insertSubview:dismissBtn belowSubview:self.optionsView];
        [self showOptionsMenu];
    }
    else
    {
        [[self.view viewWithTag:DISMISS_OPTION_MENU_BUTTON_TAG] removeFromSuperview];
        [self hideOptionsMenu];
    }
    
}

-(void)showOptionsMenu
{
    [UIView animateWithDuration:0.25 animations:^{
        self.optionsView.transform = CGAffineTransformMakeTranslation(-58, 0);
    }];
}

-(void)hideOptionsMenu
{
    [UIView animateWithDuration:0.25 animations:^{
        self.optionsView.transform = CGAffineTransformIdentity;
    }];
}

-(void)loadMessages
{
    NSDictionary *message = @{@"title" : @"Message title", @"sender" : @"Ahmad al-Moraly", @"date" : @"12/12/2012", @"body" : @"Message body message body message body message body message body", @"sent" : @(YES)};
    NSDictionary *message2 = @{@"title" : @"Message title", @"sender" : @"BODY", @"date" : @"12/12/2012", @"body" : @"Message body message body message body message body message body message body message body Message body message body message body message body message body message body message body Message body message body message body message body message body message body message body", @"sent" : @(NO)};
    
    self.messagesArray = @[message, message2, message, message2, message, message, message, message, message2, message, message,  message2, message, message2, message, message, message, message, message2, message, message2, message, message, message,  message2, message2];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messagesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"LeftMessageViewCell";
    NSDictionary *message = self.messagesArray[indexPath.row];
    if (message[@"sent"] == @(YES))
    {
        cellIdentifier = @"RightMessageViewCell";
    }
    else
    {
        cellIdentifier = @"LeftMessageViewCell";
    }
    
    MessageViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = self.messageCell;
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *message = self.messagesArray[indexPath.row];
    
    CGSize size = [message[@"body"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:(CGSize){290, MAXFLOAT}];
    
    return size.height + 80.0f;
    
}

-(void)configureCell:(MessageViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *message = self.messagesArray[indexPath.row];
    [cell setupWithData:message];
}


@end
