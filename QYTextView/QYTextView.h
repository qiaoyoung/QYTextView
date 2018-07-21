//
//  QYTextView.h
//   
//
//  Created by Joeyoung on 2018/7/20.
//  Copyright © 2018年 Joeyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYTextView : UITextView

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

@end
