# QYTextView


## 使用方法:
### 像正常使用UITextView一样。在原有系统类的基础上拓展了两个属性，占位文字和限制字数。
* 无需担心设置属性的先后顺序，赋值则生效；
* 占位文本会根据字体的大小，自动调整居中显示；
* 输入内容超出UITextView高度时，限制字数文本是悬浮在原本位置的，不会受到滚动影响；
* 不给这些属性赋值则无效果。
```
/**
The text of the placeholder text.
*/
@property (nonatomic, copy) NSString *placeholder;
/**
The color of the placeholder text. Default is lightGray.
*/
@property (nonatomic, strong) UIColor *placeholderColor;
/**
The font of the placeholder text. Default is 12-point system font.
*/
@property (nonatomic, strong) UIFont *placeholderFont;
/**
The limit of the text. Default is hidden.
when you use 'xx.imitNumber = ' the limitNumber text is show.
*/
@property (nonatomic, assign) NSUInteger limitNumber;
/**
The color of the limitNumber text. Default is lightGray.
*/
@property (nonatomic, strong) UIColor *limitColor;
/**
The font of the limitNumber text. Default is 12-point system font.
*/
@property (nonatomic, strong) UIFont *limitFont;
```

## Example
```
CGRect rect = CGRectMake(0, 40, self.view.bounds.size.width, 240);
QYTextView *textView = [[QYTextView alloc] initWithFrame:rect];
textView.returnKeyType = UIReturnKeyDone;
textView.backgroundColor = [UIColor cyanColor];
textView.font = [UIFont systemFontOfSize:16];
textView.textColor = [UIColor blackColor];
textView.placeholder = @"请输入您的内容。。。";
textView.placeholderFont = [UIFont systemFontOfSize:14];
textView.placeholderColor = [UIColor grayColor];
textView.limitNumber = 100;
textView.limitFont = [UIFont systemFontOfSize:14];
[self.view addSubview:textView];
```               

## Requirements

## Installation

QYTextView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'QYTextView'
```

## Author

Joeyoung, 393098486@qq.com

## License

QYTextView is available under the MIT license. See the LICENSE file for more info.
