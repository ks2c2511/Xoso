//
//  NapquaSMS.m
//  XoSo
//
//  Created by Khoa Le on 8/23/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "NapquaSMS.h"
#import <MessageUI/MessageUI.h>
#import "NaptheStore.h"

@interface NapquaSMS () <MFMessageComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labelMataikhoan;
@property (weak, nonatomic) IBOutlet UILabel *labelNoidung;
@property (strong,nonatomic) NSString *dauso;
- (IBAction)Gui:(id)sender;
- (IBAction)Thoat:(id)sender;
@end

@implementation NapquaSMS

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageBackGround.hidden = YES;
    self.navigationItem.title = @"Nạp xu qua SMS";
    
    [NaptheStore getNoiDungWithDone:^(BOOL success, NSString *noidung, NSString *dauso, NSString *cuphap) {
        self.labelNoidung.text = noidung;
        _dauso = dauso;
    }];
    
    self.labelMataikhoan.text = [NSString stringWithFormat:@"Mã tài khoản của bạn là: %@",self.userId];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showSMS:(NSString*)file {
    
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    NSArray *recipents = @[self.dauso];
    NSString *message = [NSString stringWithFormat:@"%@", file];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Gui:(id)sender {
    
    [self showSMS:[NSString stringWithFormat:@"IOS %@",self.userId]];
}

- (IBAction)Thoat:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSString *)dauso {
    if (!_dauso) {
        return @"";
    }
    return _dauso;
}
@end
