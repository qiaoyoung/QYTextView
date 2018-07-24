//
//  QYTextView.m
//
//
//  Created by Joeyoung on 2018/7/20.
//  Copyright © 2018年 Joeyoung. All rights reserved.
//

#import "QYTextView.h"

#define kDefaultColor [UIColor lightGrayColor]
static CGFloat const kDefaultFont = 12.f;
static CGFloat const kLimitLabMargin = 8.f;
static CGFloat const kLimitLabWidth = 60.f;

@interface QYTextView ()

/** placeholderLabel */
@property (nonatomic, strong) UILabel *placeHolderLab;
/** limitLabel */
@property (nonatomic, strong) UILabel *limitLab;

@end

@implementation QYTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initPlaceholderLabelWithFrame:frame];
    }
    return self;
}

- (instancetype)init {
    if (self == [super init]) {
        [self initPlaceholderLabelWithFrame:CGRectZero];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.limitLab.hidden) return;
    CGRect frame = self.limitLab.frame;
    frame.origin.y = self.frame.size.height-kDefaultFont-kLimitLabMargin;
    if (self.contentOffset.y > 0) frame.origin.y = (self.frame.size.height+self.contentOffset.y) - (kDefaultFont+kLimitLabMargin);
    self.limitLab.frame = frame;
}

- (void)initPlaceholderLabelWithFrame:(CGRect)frame {
    self.placeHolderLab.frame = CGRectMake(4, 8, frame.size.width-8, kDefaultFont);
    [self addSubview:self.placeHolderLab];
    [self sendSubviewToBack:self.placeHolderLab];
    self.limitLab.frame = CGRectMake(frame.size.width-kLimitLabWidth-kLimitLabMargin,
                                     frame.size.height-kDefaultFont-kLimitLabMargin,
                                     kLimitLabWidth,
                                     kDefaultFont);
    [self addSubview:self.limitLab];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(tapAction)];
    [self.placeHolderLab addGestureRecognizer:tap];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidChange)
                                                 name:UITextViewTextDidChangeNotification
                                               object:nil];
}

- (void)setup_placeholderLabelFrame {
    if (self.font.pointSize == 0) return;
    CGRect frame = _placeHolderLab.frame;
    CGSize size = [_placeHolderLab sizeThatFits:CGSizeMake(_placeHolderLab.frame.size.width, CGFLOAT_MAX)];
    CGFloat placeHolderLab_y = (self.font.pointSize-_placeHolderLab.font.pointSize)/2 + 8;
    frame.origin.y = placeHolderLab_y >0 ? placeHolderLab_y:0;
    frame.size.height = size.height;
    _placeHolderLab.frame = frame;
}

#pragma mark - event
- (void)tapAction {
    if (self.superview) [self becomeFirstResponder];
}

- (void)textDidChange {
    if (self.text.length > 0) {
        _placeHolderLab.hidden = YES;
    } else {
        _placeHolderLab.hidden = NO;
    }
    if (self.limitLab.hidden) return;
    if (self.text.length > self.limitLab.tag) self.text = [self.text substringToIndex:self.limitLab.tag];
    self.limitLab.text = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)self.text.length,(unsigned long)self.limitLab.tag];
}

#pragma mark - QYTextView setter
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if (frame.size.height < kDefaultFont) return;
    self.placeHolderLab.frame = CGRectMake(4, 8, frame.size.width-8, kDefaultFont);
    [self setup_placeholderLabelFrame];
    self.limitLab.frame = CGRectMake(frame.size.width-kLimitLabWidth-kLimitLabMargin,
                                     frame.size.height-kDefaultFont-kLimitLabMargin,
                                     kLimitLabWidth,
                                     kDefaultFont);
}
- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setup_placeholderLabelFrame];
}

#pragma mark - placeHolderLab setter
- (void)setPlaceholder:(NSString *)placeholder {
    if (_placeHolderLab.text != placeholder) _placeHolderLab.text = placeholder;
    [self setup_placeholderLabelFrame];
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    if (_placeHolderLab.textColor != placeholderColor) _placeHolderLab.textColor = placeholderColor;
}
- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    if (_placeHolderLab.font != placeholderFont) _placeHolderLab.font = placeholderFont;
    [self setup_placeholderLabelFrame];
}

#pragma mark - limitLab setter
- (void)setLimitNumber:(NSUInteger)limitNumber {
    if (!limitNumber) return;
    _limitLab.text = [NSString stringWithFormat:@"0/%lu",(unsigned long)limitNumber];
    _limitLab.hidden = NO;
    // Record the number of limits
    _limitLab.tag = limitNumber;
}
- (void)setLimitColor:(UIColor *)limitColor {
    if (_limitLab.textColor != limitColor) _limitLab.textColor = limitColor;
}
- (void)setLimitFont:(UIFont *)limitFont {
    if (_limitLab.font != limitFont) _limitLab.font = limitFont;
    CGRect frame = _limitLab.frame;
    frame.size.height = limitFont.pointSize;
    _limitLab.frame = frame;
}

#pragma mark - getter
- (UILabel *)placeHolderLab {
    if (!_placeHolderLab) {
        _placeHolderLab = [[UILabel alloc] init];
        _placeHolderLab.numberOfLines = 0;
        _placeHolderLab.textColor = kDefaultColor;
        _placeHolderLab.font = [UIFont systemFontOfSize:kDefaultFont];
    }
    return _placeHolderLab;
}
- (UILabel *)limitLab {
    if (!_limitLab) {
        _limitLab = [[UILabel alloc] init];
        _limitLab.textColor = kDefaultColor;
        _limitLab.font = [UIFont systemFontOfSize:kDefaultFont];
        _limitLab.textAlignment = NSTextAlignmentRight;
        _limitLab.text = @"0/0";
        _limitLab.hidden = YES;
    }
    return _limitLab;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
