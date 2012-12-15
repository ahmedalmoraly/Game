//
//  ViewController.m
//  Game
//
//  Created by Ahmad al-Moraly on 12/12/12.
//  Copyright (c) 2012 Innovaton. All rights reserved.
//

#import "ViewController.h"
#import "MessagesCell.h"
#import "MessageViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet MessagesCell *messagesCell;

@property (strong, nonatomic) NSArray *messagesArray;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // hide navigationbar
    self.navigationController.navigationBarHidden = YES;
    
    [self loadMessages];
}

-(void)loadMessages
{
    NSDictionary *message = @{@"title" : @"Message title", @"sender" : @"Ahmad al-Moraly", @"date" : @"12/12/2012", @"body" : @"Message body message body message body message body message body message body message body", @"count" : @"3"};
    
    self.messagesArray = @[message, message, message, message, message, message, message, message, message, message, message,  message, message, message, message, message, message, message, message, message, message, message, message, message,  message, message];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    static NSString *cellIdentifier = @"MessagesCell";
    MessagesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        [[NSBundle mainBundle] loadNibNamed:@"MessagesCell" owner:self options:nil];
        cell = self.messagesCell;
    
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.row % 2)
    {
        [cell setMessageBackgroundHidden:NO];
        [cell setMessageRead:YES];
    }
    else
    {
        [cell setMessageBackgroundHidden:YES];
        [cell setMessageRead:NO];
    }
    NSDictionary *message = self.messagesArray[indexPath.row];
    
    [cell setMessageSender:message[@"sender"]];
    [cell setMessageTitle:message[@"title"]];
    [cell setMessageDate:message[@"date"]];
    [cell setMessageBody:message[@"body"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageViewController *controller = [[MessageViewController alloc] initWithNibName:@"MessageViewController" bundle:nil];
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
