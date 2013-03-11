//
//  ViewController.m
//  InstagramShare
//
//  Created by Willard Lin on 13-3-8.
//  Copyright (c) 2013年 Willard Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize docController = _docController;
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


//只需修改DocumentDirectory 和 image 的内容即可 . 但是只有装了Instagram的客户端才可以分享
- (IBAction)share:(id)sender
{
    //跳转到instagram程序
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        UIImage *image = [UIImage imageNamed:@"update.png"];
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //保存图片的地址
        NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"Image.igo"];
        //将image转换为png格式
        NSData   *imageData = UIImagePNGRepresentation(image);
        //写入到imageData中
        [imageData writeToFile:savedImagePath atomically:YES];
        NSURL *imageUrl = [NSURL fileURLWithPath:savedImagePath];
        
        //UIDocumentInteractionController用于两个App之间的跳转，并传递图片
        _docController = [[UIDocumentInteractionController alloc] init];
        _docController.delegate = self;
        _docController.UTI = @"com.instagram.exclusivegram";
        _docController.URL = imageUrl;
        //从底部弹出一个instagram按钮
        [_docController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
    }else{
        //如果没有安装Instagram，则弹出警告
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Instagram" message:@"You don't install the instagram" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }

}

//跳到Instagram软件后，程序会执行到这个方法，所以需要释放controller
- (void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application
{
    [controller release];
    
}


@end
