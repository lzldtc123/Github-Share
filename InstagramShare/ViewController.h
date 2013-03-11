//
//  ViewController.h
//  InstagramShare
//
//  Created by Willard Lin on 13-3-8.
//  Copyright (c) 2013年 Willard Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIDocumentInteractionControllerDelegate>
@property (retain, nonatomic) UIDocumentInteractionController *docController;



//分享Instagram按钮
- (IBAction)share:(id)sender;


@end
