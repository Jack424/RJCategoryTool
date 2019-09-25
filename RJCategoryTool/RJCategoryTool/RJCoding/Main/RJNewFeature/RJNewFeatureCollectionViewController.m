//
//  RJNewFeatureCollectionViewController.m
//  BMCityCon
//
//  Created by apple on 2019/1/8.
//  Copyright © 2019年 Global Barter. All rights reserved.
//

#import "RJNewFeatureCollectionViewController.h"
#import "RJNewFeatureCollectionViewCell.h"

#define HCItemCount 4
@interface RJNewFeatureCollectionViewController ()
//上一个offsetX
@property (nonatomic, assign)CGFloat preOffsetX;

/** 注释*/
@property (nonatomic ,weak) UIImageView *guide;


@property (nonatomic ,weak) CALayer *animateLayer;
@property (nonatomic ,weak) CALayer *fistLayer;
@property (nonatomic ,weak) CALayer *fistLayer2;
@property (nonatomic ,weak) CALayer *fistLayer3;
@property (nonatomic ,weak) CALayer *fistLayer4;
@property (strong, nonatomic)  NSMutableArray *animateImageArray;
@property(nonatomic,strong)NSMutableArray<NSTimer *> *timerArray;



@property(nonatomic,strong)UIView *particleLoveView;
@property (nonatomic, strong) CAReplicatorLayer *loveLayer;
@end

@implementation RJNewFeatureCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init {
    //[[NSUserDefaults standardUserDefaults] setObject:curVersion forKey:XMGVersion];
    
    //1.UICollectionView创建时必须得要指定布局方式
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc] init];
    //设置每一个格子的大小
    flowL.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //设置最小的行间距
    flowL.minimumLineSpacing = 0;
    //设置每个格子之间的距离
    flowL.minimumInteritemSpacing = 0;
    //设置滚动的方向
    flowL.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:flowL];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[RJNewFeatureCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    //self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    
    
    
    
    [self settingAnimation];
    [self.view addSubview:self.particleLoveView];
}
#pragma mark <UICollectionViewDataSource>

//每一组有多个个格子(item)
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return HCItemCount;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RJNewFeatureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"rj_xishi_%ld",indexPath.row+1];//@"rj_xishi_1";
    
    cell.image = [UIImage imageNamed:imageName];
    cell.backgroundColor = [UIColor redColor];
    
    //添加立即体验
    [cell setStartBtn:indexPath count:HCItemCount];
    
    return cell;
}



/***************************/
-(void)settingAnimation{
    //1 创建CALayer
    self.animateLayer = [self creatLayer];
    self.fistLayer    = [self creatLayer];
    self.fistLayer2   = [self creatLayer];
    self.fistLayer3   = [self creatLayer];
    self.fistLayer4   = [self creatLayer];
    
    
    //3 创建UIBezierPath
    UIBezierPath *path  = [RJCoreTool rj_bezierPathWithOvalInRect:CGRectMake(50, 50, 200, 400)];
    UIBezierPath *path1 = [RJCoreTool rj_bezierPathWithArcCenter:CGPointMake(150, 150) radius:100 startAngle:0 endAngle:M_2_PI clockwise:NO];
    UIBezierPath *path2 = [RJCoreTool rj_bezierPathMoveAndAddLineToPoint];
    UIBezierPath *path3 = [RJCoreTool rj_bezierPathWithRoundedRect:CGRectMake(100, 100, 100, 200) cornerRadius:20];
    UIBezierPath *path4 = [RJCoreTool rj_bezierPathWithRoundedRect:CGRectMake(100, 100, 50, 400) cornerRadius:20];
    
    //开启动画
    [self keyframeAnimationWithLayer:self.animateLayer imageArray:_animateImageArray selector:@selector(animateCycle) bezierPath:path];
    [self keyframeAnimationWithLayer:self.fistLayer imageArray:_animateImageArray selector:@selector(update) bezierPath:path1];
    [self keyframeAnimationWithLayer:self.fistLayer2 imageArray:_animateImageArray selector:@selector(update2) bezierPath:path2];
    [self keyframeAnimationWithLayer:self.fistLayer3 imageArray:_animateImageArray selector:@selector(update3) bezierPath:path3];
    [self keyframeAnimationWithLayer:self.fistLayer4 imageArray:_animateImageArray selector:@selector(update4) bezierPath:path4];
}
-(CALayer *)creatLayer{
    CALayer *animateLayer = [CALayer layer];
    animateLayer.frame = CGRectMake(100, 50, 44, 20);
    [self.view.layer addSublayer:animateLayer];
    //    animateLayer.backgroundColor = [UIColor yellowColor].CGColor;
    return animateLayer;
}
-(NSTimer *)keyframeAnimationWithLayer:(CALayer *)layer imageArray:(NSArray *)imageArray selector:(SEL)selector bezierPath:(UIBezierPath *)bezierPath {
    //添加定时器
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:selector userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [self.timerArray addObject:timer];
    //添加动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";// 设置动画属性
    anim.path = bezierPath.CGPath;//传入路径
    anim.duration  = 20;//动画时间
    anim.repeatCount = MAXFLOAT;//重复次数
    anim.calculationMode = @"cubicPaced";
    anim.rotationMode = @"autoReverse";
    [layer addAnimation:anim forKey:nil];
    
    return timer;
}
//2 加载图片
-(NSMutableArray *)animateImageArray{
    if (!_animateImageArray) {
        _animateImageArray = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"fish%d",i]];
            [_animateImageArray addObject:image];
        }
    }
    return _animateImageArray;
}
static int _animateImageIndex = 0;
- (void)animateCycle {
    [self updateImageWithLayer:self.animateLayer Index:_animateImageIndex];
    _animateImageIndex++;
    if (_animateImageIndex > 9) {
        _animateImageIndex = 0;
    }
}
static int _imageIndex = 0;
- (void)update {
    [self updateImageWithLayer:self.fistLayer Index:_imageIndex];
    _imageIndex++;
    if (_imageIndex > 9) {
        _imageIndex = 0;
    }
}
static int _imageIndex2 = 0;
- (void)update2 {
    [self updateImageWithLayer:self.fistLayer2 Index:_imageIndex2];
    _imageIndex2++;
    if (_imageIndex2 > 9) {
        _imageIndex2 = 0;
    }
}
static int _imageIndex3 = 0;
- (void)update3 {
    [self updateImageWithLayer:self.fistLayer3 Index:_imageIndex3];
    _imageIndex3++;
    if (_imageIndex3 > 9) {
        _imageIndex3 = 0;
    }
}
static int _imageIndex4 = 0;
- (void)update4 {
    [self updateImageWithLayer:self.fistLayer4 Index:_imageIndex4];
    _imageIndex4++;
    if (_imageIndex4 > 9) {
        _imageIndex4 = 0;
    }
}
-(void)updateImageWithLayer:(CALayer *)layer Index:(NSInteger)index{
    //从数组当中取出图片
    UIImage *image = self.animateImageArray[index];
    layer.contents = (id)image.CGImage;
//    index++;
//    if (index > 9) {
//        index = 0;
//    }
}
-(NSMutableArray *)timerArray{
    if (!_timerArray) {
        _timerArray = [NSMutableArray array];
    }
    return _timerArray;
}








/***************************/
-(UIView *)particleLoveView{
    _particleLoveView = [[UIView alloc]initWithFrame:CGRectMake(10, -120, rj_kScreenWidth-20, 200)];
    // love路径
    UIBezierPath *tPath = [UIBezierPath bezierPath];
    [tPath moveToPoint:CGPointMake(rj_kScreenWidth/2.0, 200)];
    [tPath addQuadCurveToPoint:CGPointMake(rj_kScreenWidth/2.0, 400) controlPoint:CGPointMake(rj_kScreenWidth/2.0 + 300, 50)];
    [tPath addQuadCurveToPoint:CGPointMake(rj_kScreenWidth/2.0, 200) controlPoint:CGPointMake(rj_kScreenWidth/2.0 - 300, 50)];
    [tPath closePath];
    
    // 具体的layer
    UIView *tView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    tView.center = CGPointMake(rj_kScreenWidth/2.0, 200);
    tView.layer.cornerRadius = 5;
    tView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
    // 动作效果
    CAKeyframeAnimation *loveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    loveAnimation.path = tPath.CGPath;
    loveAnimation.duration = 6;
    loveAnimation.repeatCount = MAXFLOAT;
    [tView.layer addAnimation:loveAnimation forKey:@"loveAnimation"];
    
    _loveLayer = [CAReplicatorLayer layer];
    _loveLayer.instanceCount = 60;                // 40个layer
    _loveLayer.instanceDelay = 0.1;               // 每隔0.2出现一个layer
    _loveLayer.instanceColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor;
    _loveLayer.instanceGreenOffset = -0.03;       // 颜色值递减。
    _loveLayer.instanceRedOffset = -0.02;         // 颜色值递减。
    _loveLayer.instanceBlueOffset = -0.01;        // 颜色值递减。
    [_loveLayer addSublayer:tView.layer];
    [_particleLoveView.layer addSublayer:_loveLayer];
    
    
    return _particleLoveView;
}
@end
