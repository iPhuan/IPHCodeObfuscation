//
//  IPHTestViewController.m
//  IPHCodeObfuscation
//
//  Created by iPhuan on 2017/11/23.
//  Copyright © 2017年 iPhuan. All rights reserved.
//

#import "IPHTestViewController.h"

@interface IPHTestViewController ()
@property (nonatomic, strong) NSString *userPassword;
@property (nonatomic, strong) NSString *mobilePhone;


@end

@implementation IPHTestViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self addObserver:self
//           forKeyPath:@"userPassword"
//              options:NSKeyValueObservingOptionNew
//              context:nil];

    // 修改成这样
    [self addObserver:self
           forKeyPath:NSStringFromSelector(@selector(userPassword))
              options:NSKeyValueObservingOptionNew
              context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(userPassword))];
}


#pragma mark - Public

- (instancetype)initWithUserID:(NSString *)userID {
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)login {
    
}

- (void)logout {
    
}


#pragma mark - Private


- (void)setUserInfoWithName:(NSString *)name password:(NSString *)password {
    _userPassword = [password copy];
}

- (void)setUserPassword:(NSString *)userPassword {
    
}

- (void)test {
    
}

- (void)testViewControllerDidGetPassWord:(NSString *)passWord {
    
}


@end
