//
//  TrackerViewController.m
//  LifeTracker
//
//  Created by daren taylor on 05/04/2013.
//  Copyright (c) 2013 daren taylor. All rights reserved.
//

#import "TrackerViewController.h"
#import "PSAnalogClockView.h"
#import "KTOneFingerRotationGestureRecognizer.h"


@interface TrackerViewController ()
@property (weak, nonatomic) IBOutlet SimpleHScroller *hScroller;
@property (weak, nonatomic) IBOutlet UIView *clockContainerView;



@property (nonatomic) CGFloat duration;

@end

@implementation TrackerViewController{
  PSAnalogClockView *_analogClockView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setupScroller
{
  
  NSArray *scrollerArray = @[@"Work", @"Rest", @"Nothing", @"Play", @"Sleep"];
  [self.hScroller setupWithItems:scrollerArray delegate:self];
  [self.hScroller setPage:3];
  const CGFloat leftInset = _hScroller.frame.origin.x;
  const CGFloat rightInset = self.view.frame.size.width - (_hScroller.frame.origin.x + _hScroller.frame.size.width);
  _hScroller.responseInsets = UIEdgeInsetsMake(0, leftInset, 0, rightInset);
}


- (CGFloat) degreesToRadians:(CGFloat) degrees
{
  return degrees * M_PI / 180;
}

- (CGFloat) radiansToDegrees:(CGFloat) radians
{
  return radians * 180 / M_PI;
}

- (void)rotating:(KTOneFingerRotationGestureRecognizer *)recognizer
{
  CGFloat rotation =  [recognizer rotation];
  
  CGFloat degrees = [self radiansToDegrees:rotation];
  
  if (degrees > 300) degrees-=360;
  
  if (degrees < -300) degrees+=360;
  
  (self.duration+= (degrees/6)) ;
  
  NSLog(@"self.duration = %f degrees = %f", self.duration, degrees);
  
 _analogClockView.totalMinutes = self.duration;
}


- (void)setupClock
{
  _analogClockView = [[PSAnalogClockView alloc] initWithFrame:CGRectMake(90,0,140,140)];
  _analogClockView.clockFaceImage  = [UIImage imageNamed:@"ClockFace"];
  _analogClockView.hourHandImage   = [UIImage imageNamed:@"clock_hour_hand"];
  _analogClockView.minuteHandImage = [UIImage imageNamed:@"clock_minute_hand"];
 // _analogClockView.secondHandImage = [UIImage imageNamed:@"clock_second_hand"];
  _analogClockView.centerCapImage  = [UIImage imageNamed:@"clock_centre_point"];
  [self.clockContainerView addSubview:_analogClockView];
  
  
  KTOneFingerRotationGestureRecognizer *rotation = [[KTOneFingerRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotating:)];
  [_analogClockView addGestureRecognizer:rotation];
  
  // [self.clockView start];

  
  [_analogClockView start];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self setupScroller];
  [self setupClock];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
