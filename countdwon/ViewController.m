//
//  ViewController.m
//  countdwon
//
//  Created by 大氣 on 2015/03/25.
//  Copyright (c) 2015年 Taiki. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    float time ;
    float d;
    NSTimer *timer;
    UILabel *countDwonLabel;
    CAShapeLayer *l;
    CAShapeLayer *whiteLayer;
}

@end

@implementation ViewController
//http://syufuxsyufu.blog.fc2.com/blog-entry-84.html
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view, typically from a nib.
    // 扇形のlayerを３つ追加
    l = [CAShapeLayer layer];
    whiteLayer = [CAShapeLayer layer];

    [self drawPathGraph:0:360:[UIColor blackColor]:100:l];
    [self drawPathGraph:0:360:[UIColor whiteColor]:70:whiteLayer];
    
    countDwonLabel =[[UILabel alloc]initWithFrame:
                     CGRectMake(self.view.bounds.size.width/2-50,self.view.bounds.size.height/2-50,100,100)];
//    countDwonLabel.backgroundColor = [UIColor redColor];
    countDwonLabel.font =[UIFont boldSystemFontOfSize:80];
    countDwonLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:countDwonLabel];
    
    // [self drawPathGraph:0:d:[UIColor whiteColor]:100];
    //    [self drawPathGraph:60:60:[UIColor yellowColor]:100];

    [self.view.layer addSublayer:l];
    [self.view.layer addSublayer:whiteLayer];
    [self.view bringSubviewToFront:countDwonLabel];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                             target:self
                                           selector:@selector(up)
                                           userInfo:nil
                                            repeats:YES];
    time = 4 ;
    d =0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 扇形を描画するメソッド
- (void) drawFunShapeWithCenter:(CGPoint)center
                         radius:(CGFloat)radius
                     startAngle:(CGFloat)startAngle
                          angle:(CGFloat)angle
                          color:(UIColor*)color
                       casLayer:(CAShapeLayer*)casLayer
{
    // インスタンス生成
    UIBezierPath* path = [UIBezierPath bezierPath];
    
    
    // 終了角度を算出
    CGFloat endAngle = startAngle + angle;
    
    [path addArcWithCenter:center
                    radius:radius
                startAngle:startAngle
                  endAngle:endAngle
                 clockwise:YES];
    // 円弧から中心へ直線を引く
    [path addLineToPoint:center];
    
    
    // 描画実行
    casLayer.path = path.CGPath;
    if (color) {
        casLayer.strokeColor = color.CGColor;
        casLayer.fillColor = color.CGColor;
    }

    //[self.view.layer addSublayer:l];

    
    //[self.view.layer insertSublayer:l atIndex:0];
    
}

// pathに渡す値を作成するメソッド
- (void)drawPathGraph:(CGFloat)setStartAngle
                     :(CGFloat)setEndAngle
                     :(UIColor*)setColor
                     :(float)r
                     :(CAShapeLayer*)casLayer{
    // 円の中心点
    CGFloat centerX = self.view.bounds.size.width / 2;
    CGFloat centerY = self.view.bounds.size.height / 2;
    CGPoint center = CGPointMake(centerX, centerY);
    
    // 円の半径
    CGFloat radius = r;
    // 開始角度
    CGFloat startAngle = M_PI*2 * (90-setStartAngle)/360 * (-1);
    
    CGFloat angle = M_PI*2 * setEndAngle/360;
    UIColor* color = setColor;
    [self drawFunShapeWithCenter:center radius:radius startAngle:startAngle angle:angle color:color casLayer:casLayer];
}
-(void)up {
    
    time -= 0.01;
    NSLog(@"%f",time);
    d = d + 1 ;
    [self drawPathGraph:d*3.6:360-d*3.6:[UIColor blackColor]:100:l];
    countDwonLabel.text = [NSString stringWithFormat:@"%d",(int)time];
    // countDwonLabel.text = [NSString stringWithFormat:@"%d",(int)time ];
    if (time < 0.0) {
        [timer invalidate];
        [l removeFromSuperlayer];
        [countDwonLabel removeFromSuperview];
        [whiteLayer removeFromSuperlayer];
    }

}

@end
