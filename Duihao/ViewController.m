//
//  ViewController.m
//  Duihao
//
//  Created by lidongfang on 17/4/6.
//  Copyright © 2017年 lidongfang. All rights reserved.
//

#import "ViewController.h"
//对号动画的创建
#import "sucessView.h"
//语音识别技术
#import <Speech/Speech.h>
// 文字转语音
#import <AVFoundation/AVFoundation.h>
// 进入swift 注释 ***** oc调用swift 1、import "工程名-Swift.h" 2、command + B 编译没问题就可以直接用了 http://www.cnblogs.com/mazhiqiang/p/5557002.html  *****
#import "Duihao-Swift.h"
@interface ViewController ()<SFSpeechRecognizerDelegate,AVSpeechSynthesizerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *macroPhoneButton;
//这个对象负责发起语音识别请求
@property (nonatomic ,strong) SFSpeechAudioBufferRecognitionRequest* recognitionRequest;
//这个对象用于保存发起语音识别请求后的返回值
@property (nonatomic ,strong) SFSpeechRecognitionTask* recognitionTask;
//这个对象引用了语音引擎
@property (nonatomic ,strong) AVAudioEngine* audioEngine;
@property (nonatomic ,strong) SFSpeechRecognizer *sf;
//创建一个语音分析转化器
@property (nonatomic ,strong) AVSpeechSynthesizer* av;
// 一个文字的承载器
@property (nonatomic ,strong) AVSpeechUtterance*utterance;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 对号的动画展示(贝塞尔曲线)
    [self showSuccessAnimation];
    // 针对UIView 层级的 layer层进行动画操作
    [self viewLayerShowAnnimation];
    // 除了UIView 自带animation、CABasicAnimation 动画意外 我们别忘了还有几本的  CGAffineTransform
    [self viewAffineShowAnimation];
    // ”本地化一段语音文件“进行识别
    [self configSpeechFuntion];
    // 文字转变为语音
    [self wordChangeToSpeech:nil];
    
   
}

//动画的创建
-(void)showSuccessAnimation {
    sucessView *view=[[sucessView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, 0, 100, 100)];
    view.backgroundColor=[UIColor redColor];
    [self.view addSubview:view];
    
}

-(void)viewLayerShowAnnimation{
//    1、透明度的创建动画   相关keypath backgroundColor  cornerRadius 等 这些都是api中的私有属性
    UIView *opacityView=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, 110, 100, 20)];
    opacityView.backgroundColor=[UIColor redColor];
    [self.view.layer addSublayer:opacityView.layer];
    // 透明度淡入
    CABasicAnimation* fadeIn=[CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeIn.fromValue=@(0);
    fadeIn.toValue=@(1);
    fadeIn.duration=3;
    fadeIn.fillMode=kCAFillModeBackwards;
    fadeIn.beginTime=CACurrentMediaTime()+0.5;
    [opacityView.layer addAnimation:fadeIn forKey:nil];
    
    // 左侧飞入
    CABasicAnimation *flyRight=[CABasicAnimation animationWithKeyPath:@"position.x"];
    flyRight.fromValue=@(-90);
    flyRight.toValue=@(self.view.frame.size.width/2-50);
    flyRight.duration=0.5;
    flyRight.beginTime=CACurrentMediaTime()+3.5;
    flyRight.fillMode=kCAFillModeBackwards;
    [opacityView.layer addAnimation:flyRight forKey:nil];
}
-(void)viewAffineShowAnimation{
    UIView *destinationView=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, 150, 100, 20)];
    [self.view addSubview:destinationView];
    destinationView.backgroundColor=[UIColor purpleColor];
    
    destinationView.transform=CGAffineTransformIdentity;
    
//    // 1 、位移变换
//    [UIView animateWithDuration:2.0 animations:^{
//        //在原基础上偏移的横纵坐标的偏移量
////        destinationView.transform=CGAffineTransformMakeTranslation(0, 50);  a b c d 为1 0 0 1 矩阵  跟下面的效果一样
//        destinationView.transform=CGAffineTransformMake(1, 0, 0, 1, 0, 50);
//    }];
    
    
    
    
//    // 2、 缩放变换 在原基础上进行的缩放变化
//    [UIView animateWithDuration:1.0 delay:0.5 options:0 animations:^{
//        // 在原基础上横纵坐标的size 的缩放
////        destinationView.transform =CGAffineTransformMakeScale(3, 3)//CGAffineTransformIdentity默认是 [ 1 0 0 1 0 0 ]  跟下面的效果一样
//         destinationView.transform=CGAffineTransformScale(CGAffineTransformIdentity,3, 3);
//        
//        
//    } completion:^(BOOL finished) {
//        // 再次变换回去
//        [UIView animateWithDuration:0.3 animations:^{
//            destinationView.transform=CGAffineTransformScale(CGAffineTransformIdentity,1, 1);
//        }];
//    }];
    
    
    
    
//    // 3 、 旋转动画
//    [UIView animateWithDuration:1.0f animations:^{
//        destinationView.transform = CGAffineTransformMakeRotation(M_PI);
//    }]0.5
    
    
    
    // 4 、 组合动画
    
    //仿射变换的组合使用
    [UIView animateWithDuration:1.0f animations:^{
        CGAffineTransform transform1 = CGAffineTransformMakeRotation(M_PI);
        CGAffineTransform transform2 = CGAffineTransformScale(transform1, 0.5, 0.5);
        destinationView.transform = CGAffineTransformTranslate(transform2, 100, 50);
    }];
}
-(void)configSpeechFuntion {
    /** 语音识别同样的需要真机进行测试 ，因为需要硬件的支持，还需要访问权限 */
    //1.创建本地化标识符
    NSLocale *local =[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    //2.创建一个语音识别对象
    self.sf =[[SFSpeechRecognizer alloc] initWithLocale:local];
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        switch (status) {
            case SFSpeechRecognizerAuthorizationStatusAuthorized:
               NSLog(@"Speech recognition Authorized on this device");
                
            case SFSpeechRecognizerAuthorizationStatusDenied:
                NSLog(@"User denied access to speech recognition");
                
            case SFSpeechRecognizerAuthorizationStatusRestricted:
                NSLog(@"Speech recognition restricted on this device");
                
            case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                NSLog(@"Speech recognition not yet authorized");
        }

    }];
    //3.将bundle 中的资源文件加载出来返回一个url
    NSURL *url =[[NSBundle mainBundle] URLForResource:@"red_pocket" withExtension:@"caf"];
    //4.将资源包中获取的url 传递给 request 对象
    SFSpeechURLRecognitionRequest *res =[[SFSpeechURLRecognitionRequest alloc] initWithURL:url];
    res.shouldReportPartialResults=YES;
    //5.发送一个请求
    [self.sf recognitionTaskWithRequest:res resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        if (error!=nil) {
            NSLog(@"语音识别解析失败,%@",error);
            }else{
            NSLog(@"---%@",result.bestTranscription.formattedString);
            } 
    }];
}
//  模仿siri 进行语音搜索功能
-(void) startRecording{
    if (self.recognitionTask!=nil) {
        [self.recognitionTask cancel];
        self.recognitionTask=nil;
    }
    AVAudioSession *autoSession=[AVAudioSession sharedInstance];
    
    
    @try {
        [autoSession setCategory:AVAudioSessionCategoryRecord error:nil];
        [autoSession setMode:AVAudioSessionModeMeasurement error:nil];
        [autoSession setActive:YES error:nil];
    } @catch (NSException *exception) {
        NSLog(@"语音配置处理出异常了，请坚持重新配置！");
    }
    self.recognitionRequest=[[SFSpeechAudioBufferRecognitionRequest alloc]init];
    self.audioEngine=[[AVAudioEngine alloc]init];
    if (self.audioEngine.inputNode==nil) {
        NSLog(@"设备没有录制语音功能！");
    }
    self.recognitionRequest.shouldReportPartialResults=YES;
    //5.发送一个请求
    [self.sf recognitionTaskWithRequest:self.recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        if (error!=nil) {
            NSLog(@"没有听清，能大声一点吗？");
            [self.audioEngine stop];
            [self.audioEngine.inputNode removeTapOnBus:0];
            self.recognitionRequest=nil;
            self.recognitionTask=nil;
        }else{
            NSLog(@"---%@",result.bestTranscription.formattedString);
            self.textView.text=result.bestTranscription.formattedString;
//            // 如果想在你说的话后面一直拼接就不需要endAudio
//            [self.recognitionRequest endAudio];
            [self performSelectorOnMainThread:@selector(wordChangeToSpeech:) withObject:self.textView.text waitUntilDone:YES];
            }
    }];
    AVAudioFormat * recordingFormat=[self.audioEngine.inputNode outputFormatForBus:0];
    [self.audioEngine.inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        [self.recognitionRequest appendAudioPCMBuffer:buffer];
    }];
   
    @try {
        [self.audioEngine prepare];
        [self.audioEngine startAndReturnError:nil];
    } @catch (NSException *exception) {
        NSLog(@"麦克风启动出问题了，请检查硬件是否支持！");
    }
    // 一切准备就绪开始讲话
     self.textView.text=@"Ready！Say something, I'm listening";
}
-(void)wordChangeToSpeech:(NSString *)wordString{
    NSLog(@"current thread ----%@",[NSThread currentThread]);
    
    // 初始化语音分析器
    self.av=[[AVSpeechSynthesizer alloc]init];
    self.av.delegate=self;
    // 初始化文字承载器以及相关的设置
    self.utterance=[[AVSpeechUtterance alloc]initWithString:@"锦瑟无端五十弦，一弦一柱思华年。"];
    self.utterance.rate=0.5;// 设置语速，范围0-1，注意0最慢，1最快；AVSpeechUtteranceMinimumSpeechRate最慢，AVSpeechUtteranceMaximumSpeechRate最快
    AVSpeechSynthesisVoice*voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh_CN"];//设置发音，这是中文普通话
    self.utterance.voice= voice;
    [self.av speakUtterance:self.utterance];//开始

    
}
#pragma  mark --- AVSpeechSynthesizerDelegate
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didStartSpeechUtterance:(AVSpeechUtterance*)utterance{
    NSLog(@"---开始播放");
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance*)utterance{
    NSLog(@"---完成播放");
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance*)utterance{
    NSLog(@"---播放中止");
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance*)utterance{
    NSLog(@"---恢复播放");
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance*)utterance{
    NSLog(@"---播放取消");
    
}
// 采用touch 是模仿微信按下去的时候可以一直说话
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textView resignFirstResponder];
    [self startRecording];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 如果想在你说的话后面一直拼接就不需要endAudio
    [self.recognitionRequest endAudio];
}

#pragma  mark  learn SWift
- (IBAction)enterSwift:(id)sender {
    firstClassController *firstClass=[[firstClassController alloc]init];
    [firstClass setPersonMesWithPerAddress:@"河南 信阳市" perName:@"EAST"];
    [firstClass logPerMes];
    [self presentViewController:firstClass animated:YES completion:nil];
}

@end

