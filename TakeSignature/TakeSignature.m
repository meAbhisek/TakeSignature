//
//  TakeSignature.m
//  TakeSignature
//
//  Created by Abhisek Kumar Singh on 13/01/16.
//  Copyright © 2016 Abhisek Kumar Singh. All rights reserved.
//

#import "TakeSignature.h"

@implementation TakeSignature

-(void)showTheSignatureView{
   
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SigVC" bundle:[NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"TakeSignatureLibraryResources" withExtension:@"bundle"]]];
    SigVC *myVC = (SigVC *)[storyboard instantiateViewControllerWithIdentifier:@"mySigVC"];
    
    myVC.sigDelegate=self;
    
    if ([self.takeSignatureDelegate respondsToSelector:@selector(showTheSignatureVC:)]) {
        [self.takeSignatureDelegate showTheSignatureVC:myVC];
    }
    
}

-(void)getTheSignature:(UIImage *)signature{
    
    if ([self.takeSignatureDelegate respondsToSelector:@selector(returenTheSignatureImage:)]) {
        [self.takeSignatureDelegate returenTheSignatureImage:signature];
    }
    
}

@end
