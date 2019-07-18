//
//  RJVideoEditViewController.m
//  RJCategoryTool
//
//  Created by apple on 2019/7/15.
//  Copyright © 2019 Global Barter. All rights reserved.
//

#import "RJVideoEditViewController.h"

@interface RJVideoEditViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIVideoEditorControllerDelegate>

@property (nonatomic,strong)AVPlayer *player;//播放器对象
@property (nonatomic,strong)AVPlayerItem *currentPlayerItem;
@end

@implementation RJVideoEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"视频剪辑";
}

//-(void)rj_setUpSubviews{
//    [super rj_setUpSubviews];
//    //第二步:获取播放地址URL
//    //本地视频路径
//    NSString* localFilePath=[[NSBundle mainBundle]pathForResource:@"不能说的秘密" ofType:@"mp4"];
//    NSURL *localVideoUrl = [NSURL fileURLWithPath:localFilePath];
//    //网络视频路径
//    NSString *webVideoPath = @"http://api.junqingguanchashi.net/yunpan/bd/c.php?vid=/junqing/1129.mp4";
//    NSURL *webVideoUrl = [NSURL URLWithString:webVideoPath];
//
//    //第三步:创建播放器(四种方法)
//    //如果使用URL创建的方式会默认为AVPlayer创建一个AVPlayerItem
//    //self.player = [AVPlayer playerWithURL:localVideoUrl];
//    //self.player = [[AVPlayer alloc] initWithURL:localVideoUrl];
//    //self.player = [AVPlayer playerWithPlayerItem:playerItem];
//    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:webVideoUrl];
//    self.currentPlayerItem = playerItem;
//    self.player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
//
//    //第四步:创建显示视频的AVPlayerLayer,设置视频显示属性，并添加视频图层
//    //contentView是一个普通View,用于放置视频视图
//    /*
//     AVLayerVideoGravityResizeAspectFill等比例铺满，宽或高有可能出屏幕
//     AVLayerVideoGravityResizeAspect 等比例  默认
//     AVLayerVideoGravityResize 完全适应宽高
//     */
//    AVPlayerLayer *avLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
//    avLayer.videoGravity = AVLayerVideoGravityResizeAspect;
//    avLayer.frame = CGRectMake(10, 150, rj_kScreenWidth-20, rj_kScreenWidth-100);
//    [self.view.layer addSublayer:avLayer];
//
//    //第六步：执行play方法，开始播放
//    //本地视频可以直接播放
//    //网络视频需要监测AVPlayerItem的status属性为AVPlayerStatusReadyToPlay时方法才会生效
//    //[self.player play];
//
//
//}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.mediaTypes = [NSArray arrayWithObjects:@"public.movie",  nil];
    //mediaTypes = [NSArray arrayWithObjects:@"public.movie",  nil]; //picker中只显示视频
    //mediaTypes = [NSArray arrayWithObjects: @"public.image", nil];//picker中只显示图片
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        if([mediaType isEqualToString:@"public.movie"]) {
            NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
            
            UIVideoEditorController *editVC;
            // 检查这个视频资源能不能被修改
            if ([UIVideoEditorController canEditVideoAtPath:videoURL.path]) {
                editVC = [[UIVideoEditorController alloc] init];
                editVC.videoPath = videoURL.path;
                editVC.videoMaximumDuration = 10;
                editVC.videoQuality = UIImagePickerControllerQualityTypeMedium;
                editVC.delegate = self;
            }
            [self presentViewController:editVC animated:YES completion:nil];
        }
    }];
}
//编辑成功后的Video被保存在沙盒的临时目录中
- (void)videoEditorController:(UIVideoEditorController *)editor didSaveEditedVideoToPath:(NSString *)editedVideoPath {
    [editor dismissViewControllerAnimated:YES completion:^{
        NSLog(@"+++++++++++++++%@",editedVideoPath);
        self.player = [[AVPlayer alloc] initWithPlayerItem:[[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:editedVideoPath]]];
        
        //第四步:创建显示视频的AVPlayerLayer,设置视频显示属性，并添加视频图层
        //contentView是一个普通View,用于放置视频视图
        /*
         AVLayerVideoGravityResizeAspectFill等比例铺满，宽或高有可能出屏幕
         AVLayerVideoGravityResizeAspect 等比例  默认
         AVLayerVideoGravityResize 完全适应宽高
         */
        AVPlayerLayer *avLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        avLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        avLayer.frame = CGRectMake(10, 150, rj_kScreenWidth-20, rj_kScreenWidth-100);
        [self.view.layer addSublayer:avLayer];
        [self.player play];
    }];
}

// 编辑失败后调用的方法
- (void)videoEditorController:(UIVideoEditorController *)editor didFailWithError:(NSError *)error {
    NSLog(@"%@",error.description);
}

//编辑取消后调用的方法
- (void)videoEditorControllerDidCancel:(UIVideoEditorController *)editor {
    [editor dismissViewControllerAnimated:YES completion:^{
        NSLog(@"取消");
    }];
}

@end
