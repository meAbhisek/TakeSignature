//
//  SigVC.h
//  TempSignatureCode
//
//  Created by User-81-Mac on 13/01/16.
//  Copyright © 2016 User-81-Mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SigProtocol;

@interface SigVC : UIViewController

@property (nonatomic, weak) id <SigProtocol> sigDelegate;

@property (strong, nonatomic) IBOutlet UIImageView *mainImageView;
@property (strong, nonatomic) IBOutlet UIImageView *tempImageView;

- (IBAction)resetButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;

@end


@protocol SigProtocol <NSObject>

@optional

-(void)getTheSignature:(UIImage*)signature;

@end