//
//  YXPicChartGraphicsShowCollCell.m
//  YXGraphicsTest
//
//  Created by ios on 2020/6/12.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXPicChartGraphicsShowCollCell.h"

@interface YXPicChartGraphicsShowCollCell ()

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation YXPicChartGraphicsShowCollCell

- (void)reloadValueByIndexPath:(NSIndexPath *)indexPath arr:(NSMutableArray *)arr {
    
    _indexPath = indexPath;
    
    YXPicChartGraphicsModel *model = arr[indexPath.row];
    [self.showBtn setTitle:model.title forState:UIControlStateNormal];
    self.showBtn.backgroundColor = model.color;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
