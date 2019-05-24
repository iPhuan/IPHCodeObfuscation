//
//  IPHTestViewController.h
//  IPHCodeObfuscation
//
//  Created by iPhuan on 2017/11/23.
//  Copyright © 2017年 iPhuan. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol IPHTestViewControllerProtocol <NSObject>

- (void)testViewControllerDidGetPassWord:(NSString *)passWord;

@end

typedef void (^IPHTestViewControllerBlock)(void);

typedef NS_ENUM(NSInteger, IPHTestViewControllerType) {
    IPHTestViewControllerTypeOne = 0,
    IPHTestViewControllerTypeTwo
};

@interface IPHTestViewController : UIViewController <IPHTestViewControllerProtocol>
@property (nonatomic, copy) IPHTestViewControllerBlock testViewControllerBlock;

- (instancetype)initWithUserID:(NSString *)userID;


- (void)login;
- (void)logout;

@end
