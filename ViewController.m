//
//  ViewController.m
//  cal
//
//  Created by 杨泽奇 on 16/3/14.
//  Copyright © 2016年 杨泽奇. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController



@synthesize button,label,string,num1,num2,num3,num4;//string保存字符，显示数值。num1是存输入的数值，num2是存运算符前的数值，num3是运算结果，num4是判断进行何种运算
(void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置背景图片
    NSBundle *bundle=[NSBundle mainBundle];
    NSData *data=[[NSData alloc]initWithContentsOfFile:[bundle pathForResource:@"1" ofType:@"jpg"]];//找到NSBundle的某一资源
    UIImage *img=[UIImage imageWithData:data];//创建了可用的图像对象
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:img]];//UIColor colorWithPatternImage:方法是把图片转化为color类型  将背景换做提供的图片
    
    //添加提示性文字
    UIAlertView *alex=[[UIAlertView alloc]initWithTitle:@"使用说明" message:@"只支持两数的计算以及在此基础上的计算，不支持连算。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alex show];
    [alex release];
    
    //创建标签
    self.label=[[UILabel alloc]initWithFrame:CGRectMake(90, 40, 200, 50)];
    [self.view addSubview:label];
    self.label.backgroundColor=[UIColor clearColor];//清空背景颜色
    self.label.textColor=[UIColor blueColor];//字体颜色
    self.label.textAlignment=UITextAlignmentRight;//字体居右
    self.label.font=[UIFont systemFontOfSize:32.4];
    
    //添加1-9数字
    NSArray *array=[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    int n=0;
    for (int i=0; i<3; i++)
    {
        for (int j=0; j<3; j++)
        {
            self.button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            self.button.frame=CGRectMake(30+65*j, 150+65*i, 60, 60);
            [self.button setTitle:[array objectAtIndex:n++] forState:UIControlStateNormal];
            [self.view addSubview:button];
            [self.button addTarget:self action:@selector(one:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    //单独添加0
    UIButton *button0=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [button0 setFrame:CGRectMake(30, 345, 60, 60)];
    
    [button0 setTitle:@"0" forState:UIControlStateNormal];
    
    [button0 addTarget:self action:@selector(one:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button0];
    
    
    //添加运算符
    NSArray *array1=[NSArray arrayWithObjects:@"+",@"-",@"*",@"/",nil];
    for (int i=0; i<4; i++)
    {
        UIButton *button1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button1 setFrame:CGRectMake(225, 150+65*i, 60, 60)];
        [button1 setTitle:[array1 objectAtIndex:i] forState:UIControlStateNormal];
        [self.view addSubview:button1];
        [button1 addTarget:self action:@selector(two:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //添加=
    
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [button2 setFrame:CGRectMake(160, 410, 125, 35)];
    
    [button2 setTitle:@"=" forState:UIControlStateNormal];
    
    [button2 addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    //添加清除键
    
    UIButton *button3=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button3 setFrame:CGRectMake(30, 410, 125, 35)];
    [button3 setTitle:@"AC" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(clean:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    //添加.
    
    UIButton *button4=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button4 setFrame:CGRectMake(95, 345, 60, 60)];
    [button4 setTitle:@"." forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(one:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    //后退
    
    UIButton *button5=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button5 setFrame:CGRectMake(160, 345, 60, 60)];
    [button5 setTitle:@"back" forState:UIControlStateNormal];
    [button5 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button5];
    
    
    self.string=[[NSMutableString alloc]init];//初始化可变字符串，分配内存
    // Do any additional setup after loading the view, typically from a nib.
}

(void)one:(id)sender
{
    //保证是符号时在输入数字时隐藏
    if ([self.string hasPrefix:@"+"]||[self.string hasPrefix:@"-"]||[self.string hasPrefix:@"*"]||[self.string hasPrefix:@"/"])//判断是否为运算符
    {
        [self.string setString:@""];//字符串清零
    }
    [self.string appendString:[sender currentTitle]];//数字连续输入
    self.label.text=[NSString stringWithString:string];//显示数值
    self.num1=[self.label.text doubleValue];//保存输入的数值
    NSLog(@"%f",self.num1);
    
}

(void)two:(id)sender
{
    [self.string setString:@""];//字符串清零
    [self.string appendString:[sender currentTitle]];
    self.label.text=[NSString stringWithString:string];
    
    //判断输入是+号
    if ([self.string hasPrefix:@"+"])//hasPrefix:判断字符串以加号开头
    {
        self.num2=self.num1;//将前面的数值保存在num2里
        self.num4=1;
    }
    //判断输入是-号
    else if([self.string hasPrefix:@"-"])//hasPrefix:判断字符串以减号开头
    {
        self.num2=self.num1;
        self.num4=2;
    }
    //判断输入是*号
    else if([self.string hasPrefix:@"*"])//hasPrefix:判断字符串以乘号开头
    {
        self.num2=self.num1;
        self.num4=3;
    }
    //判断输入是/号
    else if([self.string hasPrefix:@"/"])//hasPrefix:判断字符串以除号开头
    {
        self.num2=self.num1;
        self.num4=4;
    }
}

(void)go:(id)sender
{
    //判断输入是+号
    if (self.num4==1)
    {
        self.num3=self.num2+[self.label.text doubleValue];//[self.label.text doubleValue]是每次后输入的数字
        self.label.text=[NSString stringWithFormat:@"%f",self.num3];//显示结果
        self.num1=[self.label.text doubleValue];//为了可以连加。保存结果
        self.num3=0;
        [self.string setString:@""];//保证每次结果正确输出后，再次计算，不用按清除键
    }
    //判断输入是-号
    else if(self.num4==2)
    {
        self.num3=self.num2-[self.label.text doubleValue];
        self.label.text=[NSString stringWithFormat:@"%f",self.num3];
        self.num1=[self.label.text doubleValue];
        self.num3=0;
        [self.string setString:@""];
    }
    //判断输入是*号
    else if(self.num4==3)
    {
        self.num3=self.num2*[self.label.text doubleValue];
        self.label.text=[NSString stringWithFormat:@"%f",self.num3];
        self.num1=[self.label.text doubleValue];
        self.num3=0;
        [self.string setString:@""];
    }
    //判断输入是/号
    else if(self.num4==4)
    {
        self.num3=self.num2/[self.label.text doubleValue];
        self.label.text=[NSString stringWithFormat:@"%f",self.num3];//计算结果显示出来
        self.num1=[self.label.text doubleValue];//把计算的结果保存一下
        self.num3=0;
        [self.string setString:@""];
    }
}

//当按下清除建时，所有数据清零
(void) clean:(id) sender {
    [self.string setString:@""];//清空字符串
    self.num3=0;
    self.num2=0;
    self.label.text=@"0";//保证下次输入时清零
    
}

//返回键
void back:(id)sender
{
    if (![self.label.text isEqualToString:@""])//判断不是空
    {
        [self.string deleteCharactersInRange:NSMakeRange([self.string length]-1,1)];//删除最后一个字符
        self.label.text=[NSString stringWithString:string];//显示结果
    }
}

(void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


@end
@end

