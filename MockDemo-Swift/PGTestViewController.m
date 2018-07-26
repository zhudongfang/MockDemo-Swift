//
//  PGTestViewController.m
//  MockDemo-Swift
//
//  Created by 朱东方 on 2018/7/24.
//  Copyright © 2018年 LuckyPig. All rights reserved.
//

#import "PGTestViewController.h"
#import <GYHttpMock/GYHttpMock.h>

@implementation PGTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mockRequest(@"GET", @"http://httpbin.org/get").
    withBody(@"name=ming").
    andReturn(200).
    withBody(@"get.json");
    
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"http://httpbin.org/get"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
            return ;
        }
        
        NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", content);
    }] resume];
}

@end
