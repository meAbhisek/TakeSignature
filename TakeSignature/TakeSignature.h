//
//  TakeSignature.h
//  TakeSignature
//
//  Created by Abhisek Kumar Singh on 13/01/16.
//  Copyright © 2016 Abhisek Kumar Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SigVC.h"

@protocol TakeSignatureDelegate;

@interface TakeSignature : NSObject <SigProtocol>

@property (nonatomic, weak) id <TakeSignatureDelegate> takeSignatureDelegate;

-(void)showTheSignatureView;

@end

@protocol TakeSignatureDelegate <NSObject>

@optional

-(void)showTheSignatureVC:(SigVC*)vObj;
-(void)returenTheSignatureImage:(UIImage*)sigImage;

@end