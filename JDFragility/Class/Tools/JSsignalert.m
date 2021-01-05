
//
//  JSsignalert.m
//  JingShiIpad
//
//  Created by 牛辉 on 2018/4/2.
//  Copyright © 2018年 京正. All rights reserved.
//

#import "JSsignalert.h"
@interface JSsignalertCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *titleLabel1;
@property (nonatomic, assign) BOOL isboole;
@end

@implementation JSsignalertCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithRed:0 green:127/255.0 blue:1 alpha:1];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end

@interface JSsignalert ()


@property (nonatomic, strong) UIView *alertView;//弹框视图
@property (nonatomic, strong) UITableView *selectTableView;//选择列表
@property (nonatomic, assign) NSUInteger indexPath;
@property (nonatomic, strong) UIButton *closeButton;//关闭按钮
@property (nonatomic, strong) UIButton *saveButton;//保存按钮

@property (nonatomic, strong) NSString *selectStr;//选择列表
@end

@implementation JSsignalert
{
    float alertHeight;//弹框整体高度，默认250
    float buttonHeight;//按钮高度，默认40
}
+ (JSsignalert *)showWithTitle:(NSString *)title
                        titles:(NSArray *)titles
                     selectStr:(NSString *)selectstr
                   selectValue:(SelectClick)selectValue{
    JSsignalert *alert = [[JSsignalert alloc] initWithTitle:title titles:titles selectStr:selectstr selectValue:selectValue];
  
    return alert;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 8;
        _alertView.layer.masksToBounds = YES;
    }
    return _alertView;
}
- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveButton.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        [_saveButton setTitle:@"确定" forState:UIControlStateNormal];
        [_saveButton setTitleColor:[UIColor colorWithRed:0 green:127/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
        _saveButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_saveButton addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}
- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor colorWithRed:0 green:127/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
        _closeButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UITableView *)selectTableView {
    if (!_selectTableView) {
        _selectTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _selectTableView.delegate = self;
        _selectTableView.dataSource = self;
    }
    return _selectTableView;
}

- (instancetype)initWithTitle:(NSString *)title titles:(NSArray *)titles selectStr:(NSString *)selectstr selectValue:(SelectClick)selectValue{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
        alertHeight = 250;
        buttonHeight = 40;
        self.titleLabel.text = title;
        _titles = titles;
        
        _selectValue = [selectValue copy];
        
        [self addSubview:self.alertView];
        [self.alertView addSubview:self.titleLabel];
        [self.alertView addSubview:self.selectTableView];
        //        if (_showCloseButton) {
        [self.alertView addSubview:self.closeButton];
        [self.alertView addSubview:self.saveButton];
        //        }
        [self initUI];
        
        [self show];
        
        for (NSString *str in _titles) {
            if([str isEqualToString:selectstr]){
                 ;
                self.indexPath=[_titles indexOfObject:str];
            }
            
        }
        self.selectStr=selectstr;
    }
    return self;
}

- (void)show {
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.alertView.alpha = 0.0;
    [UIView animateWithDuration:0.05 animations:^{
        self.alertView.alpha = 1;
    }];
}

- (void)initUI {
    self.alertView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/3, ([UIScreen mainScreen].bounds.size.height-alertHeight)/2.0, [UIScreen mainScreen].bounds.size.width/3, alertHeight);
    self.titleLabel.frame = CGRectMake(0, 0, _alertView.frame.size.width, buttonHeight);
    float reduceHeight = buttonHeight;
    
    self.closeButton.frame = CGRectMake(0, _alertView.frame.size.height-buttonHeight, _alertView.frame.size.width/2, buttonHeight);
    self.saveButton.frame = CGRectMake(CGRectGetMaxX(self.closeButton.frame), _alertView.frame.size.height-buttonHeight, _alertView.frame.size.width/2, buttonHeight);
    reduceHeight = buttonHeight*2;
    self.selectTableView.frame = CGRectMake(0, buttonHeight, _alertView.frame.size.width, _alertView.frame.size.height-reduceHeight);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.selectTableView scrollToRowAtIndexPath: [NSIndexPath indexPathForRow:self.indexPath inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
 
    });
}


#pragma UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float real = (alertHeight - buttonHeight*2)/(float)_titles.count;
    //    }
    return real<=40?40:real;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JSsignalertCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JSsignalertCellid"];
    if (!cell) {
        cell = [[JSsignalertCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JSsignalertCellid"];
    }
        if(self.indexPath==indexPath.row){
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
    
    
    cell.titleLabel.text = _titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JSsignalertCell *cell = [self.selectTableView cellForRowAtIndexPath:indexPath];
    
    [self.selectTableView reloadData];
    self.indexPath=indexPath.row;
    
    self.selectStr=cell.titleLabel.text;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    if (!CGRectContainsPoint([self.alertView frame], pt) ) {
        [self closeAction];
    }
}
- (void)saveAction {
 
    if (self.selectValue) {
        self.selectValue(self.selectStr);
    }
    [self closeAction];
}
- (void)closeAction {
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
