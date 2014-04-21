//
//  mamFirstViewController.m
//  uploadImage
//
//  Created by macpps on 14-4-21.
//  Copyright (c) 2014年 paopaosa. All rights reserved.
//

#import "mamFirstViewController.h"
#import <AFNetworking.h>

@interface mamFirstViewController ()

@property (nonatomic,strong) UIImage *avatarImage;

@end

@implementation mamFirstViewController
#pragma mark - Origin
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - PublicMethods
- (IBAction)uploadImage:(id)sender {
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://mimikj.com:6543/"]];
    self.avatarImage = [UIImage imageNamed:@"avatar.jpg"];
//    NSURL *filePath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"avatar.jpg" ofType:nil]];
    
    NSData *imageData = UIImageJPEGRepresentation(self.avatarImage, 1.0);
    NSDictionary *parameters = @{@"avatar": @""};
    
    NSMutableURLRequest *request = [manager.requestSerializer
                                    multipartFormRequestWithMethod:@"POST"
                                    URLString:@"http://mimikj.com:6543/"
                                    parameters:parameters
                                    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                        [formData appendPartWithFileData:imageData
                                                                    name:@"avatar"
                                                                fileName:@"avatar.jpg"
                                                                mimeType:@"image/jpeg"];
                                    }
                                    error:nil];
    NSDictionary *sheaders = @{@"Cookie" : @"auth_tkt=\"bd681aa4b8f64f4e4a635c4c1aa8de38b355038b0a34577a48109a92bfcede8652d837d2207b8546433142446b011458717af667a612b2dc9ac07e508a265301534e38d4MTU2MDAwMDExMTE%3D!userid_type:b64unicode\"; auth_tkt=\"bd681aa4b8f64f4e4a635c4c1aa8de38b355038b0a34577a48109a92bfcede8652d837d2207b8546433142446b011458717af667a612b2dc9ac07e508a265301534e38d4MTU2MDAwMDExMTE%3D!userid_type:b64unicode\"; auth_tkt=\"bd681aa4b8f64f4e4a635c4c1aa8de38b355038b0a34577a48109a92bfcede8652d837d2207b8546433142446b011458717af667a612b2dc9ac07e508a265301534e38d4MTU2MDAwMDExMTE%3D!userid_type:b64unicode\""};
    [request setAllHTTPHeaderFields:sheaders];
    
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"success. upload,%@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure. upload....");
    }];
    [manager.operationQueue addOperation:operation];
}
@end
