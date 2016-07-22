//
//  SigVC.m
//  TempSignatureCode
//
//  Created by User-81-Mac on 13/01/16.
//  Copyright © 2016 User-81-Mac. All rights reserved.
//

#import "SigVC.h"

@interface SigVC (){
    CGPoint lastpoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brushWidth;
    CGFloat opacity;
    BOOL swiped;
    NSArray *colorArray;
    
    
    
    float oldX, oldY;
    float newX, newY;
    BOOL dragging;
    
    
}

@end

@implementation SigVC
@synthesize mainImageView,tempImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    lastpoint= CGPointZero;
    red = 0.0;
    green = 0.0;
    blue = 0.0;
    brushWidth = 7.0;
    opacity = 1.0;
    swiped=false;
    
    [mainImageView setBackgroundColor:[UIColor whiteColor]];
    
    mainImageView.image=nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    swiped=false;
    UITouch *touch = [[event allTouches] anyObject];
    
    if (touch) {
        lastpoint= [touch locationInView:self.view];
    }
    
}

-(void)drawLineFrom:(CGPoint)fromPoint toPoint:(CGPoint)toPoint{
    // 1
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [tempImageView.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    // 2
    CGContextMoveToPoint(context, fromPoint.x, fromPoint.y);
    CGContextAddLineToPoint(context, toPoint.x, toPoint.y);
    
    // 3
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, brushWidth);
    CGContextSetRGBStrokeColor(context, red, green, blue, 1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    
    // 4
    CGContextStrokePath(context);
    
    // 5
    tempImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    tempImageView.alpha = opacity;
    UIGraphicsEndImageContext();
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    // 6
    swiped=true;
    UITouch *touch = [[event allTouches] anyObject];
    if (touch) {
        CGPoint touchLocation = [touch locationInView:self.view];
        [self drawLineFrom:lastpoint toPoint:touchLocation];
        // 7
        lastpoint=touchLocation;
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!swiped) {
        // draw a single point
        [self drawLineFrom:lastpoint toPoint:lastpoint];
    }
    
    // Merge tempImageView into mainImageView
    UIGraphicsBeginImageContext(mainImageView.frame.size);
    
    [mainImageView.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    
    [tempImageView.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
    
    mainImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    tempImageView.image = nil;
    
    
    //
}


#pragma mark - Image/Video Saving Info

- (void) image:(UIImage*)image didFinishSavingWithError:(NSError *)error contextInfo:(void*)info{
    
    if (error) {
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Image Saving Failed"  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil, nil];
        //        [alert show];
        NSLog(@"error in image saving");
    }else{
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Saved" message:@"Saved To Photo Album"  delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        //        [alert show];
        NSLog(@"Image Saved");
    }
    
    
}




- (IBAction)resetButtonPressed:(id)sender {
    [self viewDidLoad];
}

- (IBAction)doneButtonPressed:(id)sender {
    if ([self.sigDelegate respondsToSelector:@selector(getTheSignature:)]) {
        [self.sigDelegate getTheSignature:mainImageView.image];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
