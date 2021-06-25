//
//  YXProbabilityAllSecView.m
//  YXProbabilityTest
//
//  Created by ios on 2021/6/21.
//  Copyright © 2021 August. All rights reserved.
//

#import "YXProbabilityAllSecView.h"
#import "YXProbabilityAllPossibleModel.h"

@interface YXProbabilityAllSecView () <UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, assign) NSInteger textfieldLenth;
@property (nonatomic, strong) NSMutableArray *textFieldEndArr; //筛选结果数组
@property (nonatomic, assign) NSInteger textFieldEndPage; //筛选结果页码
@property (nonatomic, assign) NSInteger textFieldEndCurrent; //筛选结果当前显示
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation YXProbabilityAllSecView

- (void)awakeFromNib {
    [super awakeFromNib];

    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)reloadValueBySec:(NSInteger)sec arr:(NSMutableArray *)arr tableView:(UITableView *)tableView {
    
    _dataSourceArr = arr;
    _tableView = tableView;
}

#pragma mark - 搜索数据回调
- (void)searchValueBlock {
    
    if (self.yxProbabilityAllSecViewBlock) {
        self.yxProbabilityAllSecViewBlock(_textFieldEndCurrent, _textFieldEndArr);
    }
}

#pragma mark - progress
#pragma mark - 搜索按钮事件
- (IBAction)progressSearchBtn:(UIButton *)sender {
    
    [self endEditing:YES];
    if (_textFieldEndArr.count == 0) {
        [self.searchBtn setTitle:[NSString stringWithFormat:@"%@", @"搜索"] forState:UIControlStateNormal];
        return;
    }

    if (_textFieldEndPage <= (_textFieldEndArr.count - 1)) {
        _textFieldEndCurrent = [_textFieldEndArr[_textFieldEndPage] integerValue];
        [self searchValueBlock];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_textFieldEndCurrent inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        _textFieldEndPage++;
    }
    else {
        _textFieldEndPage = 0;
        _textFieldEndCurrent = [_textFieldEndArr[_textFieldEndPage] integerValue];
        [self searchValueBlock];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_textFieldEndCurrent inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }

    [self.searchBtn setTitle:[NSString stringWithFormat:@"%@/%@", @(_textFieldEndPage), @(_textFieldEndArr.count - 1)] forState:UIControlStateNormal];
}

#pragma mark - 综合排序按钮事件
- (IBAction)progressAllSortingBtn:(UIButton *)sender {
    
    
}

#pragma mark - <UITextFieldDelegate>
- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField.text.length > _textfieldLenth) { //06 07 08 13 16 29 05
        if (textField.text.length == 3 || textField.text.length == 6 || textField.text.length == 9 || textField.text.length == 12 || textField.text.length == 15 || textField.text.length == 18) {
            NSMutableString *str = [[NSMutableString alloc ] initWithString:textField.text];
            [str insertString:@" " atIndex:(textField.text.length - 1)];
            textField.text = str;
        }
        if (textField.text.length >= 20) {
            textField.text = [textField.text substringToIndex:20];
            [textField resignFirstResponder];
        }
        _textfieldLenth = textField.text.length;
    }
    else if (textField.text.length < _textfieldLenth) {
        if (textField.text.length == 3 || textField.text.length == 6 || textField.text.length == 9 || textField.text.length == 12 || textField.text.length == 15 || textField.text.length == 18) {
            textField.text = [NSString stringWithFormat:@"%@", textField.text];
            textField.text = [textField.text substringToIndex:(textField.text.length - 1)];
        }
        _textfieldLenth = textField.text.length;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    NSInteger i = 0;
    _textFieldEndArr = [[NSMutableArray alloc] init];
    for (YXProbabilityAllPossibleModel *model in _dataSourceArr) {
        if ([model.item containsString:textField.text]) {
            [_textFieldEndArr addObject:@(i)];
        }
        i++;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [self endEditing:YES];
    return YES;
}

@end
