IPHCodeObfuscation
=============================================================
`IPHCodeObfuscation`用于项目工程的代码混淆，其原理非常简单，通过脚本的方式将类名，属性名，方法名等代码片段定义成很难阅读的宏，以对工程的关键代码进行混淆，防止代码被恶意窃取。

`IPHCodeObfuscation`可通过脚本或者手动的方式添加到工程，在每次添加新的代码混淆时需要对IPHCodeObfuscation重新编译，以便生成新的混淆宏。

>使用`IPHCodeObfuscation`前，请先参考[https://github.com/iPhuan/IPHCodeObfuscationTool.git](https://github.com/iPhuan/IPHCodeObfuscationTool.git)下载自动化脚本或手动将本工程添加到你需要进行代码混淆的工程中。

<br />

代码混淆脚本使用说明：
-------------------------------------------------------------


**1、打开`IPHCodeObfuscation`工程在`ObfuscationList.h`中添加需要混淆的类名，协议名，方法名，或者属性。**

示例：


```objc
    #pragma mark =========================== Class ============================

    #pragma mark - IPHTestViewController
    ///////////////////////////////////////////////////////////////////////////
    IPHTestViewController

    @testViewControllerBlock
    @userPassword
    @mobilePhone

    initWithUserID
    //login
    logout
    setUserInfoWithName
    @password

    IPHTestViewControllerProtocol
    testViewControllerDidGetPassWord
```


如上所示，类名，协议名，方法名，或者属性其填写规则按单行填写，需要注意的是：
* 枚举名，块名，方法的参数不需要进行混淆

* 如果是属性，则需要在属性名称前添加@，如：


```objc
    @userPassword
```

> @标识告诉脚本能够自动生成`userPassword`的`set`方法`setUserPassword`和私有变量`_userPassword`的宏；
> 如果属性已经添加到`ObfuscationList.h`列表，则其重写的`set`和`get`方法都不必再添加到列表，否则将导致编译错误

* 如果方法含两个参数及以上，需要将方法分段填写，如:

```objc
    - (void)setUserInfoWithName:(NSString *)name password:(NSString *)password
```


> 其正确填写方式为：

```objc
    setUserInfoWithName
    @password
```
> 这里`password`之所以通过@的方式例举，主要是为了防止其他地方也包含同名`password`的属性，避免未生成`set`或者私有变量宏导致编译错误
（某个方法的命名有可能或者已经被其他地方用作属性命名，应当用@的方式例举）


* 如果方法名或者属性名与系统的方法名或者属性名同名，请不要对其进行混淆

*  如果你打算使用`runtime`调用方法，或者使用使用`KVO`编程时，建议不要对类，方法和属性进行混淆，如果一定要，请用`@selector`等方式将方法或者属性包起来进行替换，如下所示，否则将导致程序运行崩溃

```objc
    //    [self addObserver:self
    //           forKeyPath:@"userPassword"
    //              options:NSKeyValueObservingOptionNew
    //              context:nil];
    
    // 修改成这样
    [self addObserver:self
           forKeyPath:NSStringFromSelector(@selector(userPassword))
              options:NSKeyValueObservingOptionNew
              context:nil];
```



*  不要对打成`Framework`的头文件进行混淆；或者如果你要混淆的代码名称与某个`Framework`中的头文件代码名称相同时，则不应该进行混淆。

*  如需让生成的宏定义分类清晰，可在`ObfuscationList.h`添加空行或者`#pragma mark`，`obfuscate.sh`在执行时会将`ObfuscationList.h`中的空行转化为`IPHObfuscationSymbols.h`中的空行，将`#pragma mark`内容直接填写到`IPHObfuscationSymbols.h`中，此举方便开发者对需要混淆的代码进行分类和查看。       

*  如`//login`所示，也可以对清单中已添加好的项进行注释操作，`obfuscate.sh`在执行混淆时将不对注释项进行处理。

<br />


**2、编译工程，更新包含宏定义的IPHObfuscationSymbols.h。**
编译后，`obfuscate.sh`会自动将`ObfuscationList.h`中的清单转化为对应的宏定义存储在`IPHObfuscationSymbols.h`

**3、打开主工程，clean，编译，查看是否报错。**

**4、运行主工程进行对应混淆模块的功能测试，确保混淆后不影响到功能使用。**

<br />

**`注意：`**
-------------------------------------------------------------
代码混淆在一定程度上妨碍了开发者的调试以及对Bug的追踪，因为每次追加混淆时，所有的宏都会重新生成，所以，对于要上线的版本，一定需要有相应的备份来记录，比如打Tag，防止线上混淆代码出现bug后无法定位问题。

<br />
<br />


版本记录：
-------------------------------------------------------------
### V1.0.0
更新日期：2018年1月22日  
更新说明：  
> * 发布`IPHCodeObfuscation`第一个版本。  

-------------------------------------------------------------    


### V1.0.1
更新日期：2018年4月20日  
更新说明：  
> * 修改`PodObfuscate.rb`打印输出；


-------------------------------------------------------------      


### V1.0.2
更新日期：2018年5月10日  
更新说明：  
> * 更新Git域名。  

-------------------------------------------------------------    


### V1.0.3
更新日期：2019年5月24日  
更新说明：  
> * 修复`obfuscate.sh`脚本`echo -e`输出字符`-e`的问题；
> * 优化文档说明；
> * 修改Test示例。

-------------------------------------------------------------    

