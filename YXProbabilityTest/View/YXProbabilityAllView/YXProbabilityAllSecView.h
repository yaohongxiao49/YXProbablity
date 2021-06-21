//
//  YXProbabilityAllSecView.h
//  YXProbabilityTest
//
//  Created by ios on 2021/6/21.
//  Copyright © 2021 August. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YXProbabilityAllSecViewBlock)(NSInteger current, NSMutableArray *endArr);

@interface YXProbabilityAllSecView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *searchBgV;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIView *sortingBgV;
@property (weak, nonatomic) IBOutlet UIButton *allSortingBtn;

@property (nonatomic, copy) YXProbabilityAllSecViewBlock yxProbabilityAllSecViewBlock;

- (void)reloadValueBySec:(NSInteger)sec arr:(NSArray *)arr tableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
