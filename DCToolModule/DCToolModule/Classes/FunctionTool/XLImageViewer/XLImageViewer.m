//
//  XLImageViewer.m
//  XLImageViewerExample
//
//  Created by MengXianLiang on 2017/4/20.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "XLImageViewer.h"
#import "XLImageViewerItem.h"
#import "XLImageViewerTooBar.h"


static NSString* cellId = @"XLImageViewerItem";

//cell之间的间隔
static CGFloat lineSpacing = 10.0f;

@interface XLImageViewer ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    //滚动的ScrollView
    UICollectionView *_collectionView;
    //第一次加载的位置
    NSInteger _startIndex;
    //当前滚动位置
    NSInteger _currentIndex;
    //开始加载时的图片位置
    CGRect _anchorFrame;
    //图片地址
    NSArray *_imageUrls;
    //图片容器
    UIView *_imageContainer;
    //是否显示网络图片
    BOOL _showNetImages;
    //是否显示网络图片
    BOOL _showDataImages;
    //工具栏
    XLImageViewerTooBar *_toolBar;
}

@end

static dispatch_once_t onceToken;
static XLImageViewer * viewer;

@implementation XLImageViewer

+(XLImageViewer*)shareInstanse{
    
    //    static XLImageViewer *viewer = nil;
    //    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        viewer = [[XLImageViewer alloc] init];
    });
    return viewer;
}

-(instancetype)init{
    
    if (self = [super init]) {
        [self buildUI];
    }
    return self;
}

- (void)resetInstance{
    
    onceToken = 0;
    viewer =nil;
    
}

//初始化视图
-(void)buildUI{
    //设置ImageViewer属性
    self.frame = [UIScreen mainScreen].bounds;
    
    //初始化CollectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    layout.minimumLineSpacing = lineSpacing;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, lineSpacing);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGRect frame = self.bounds;
    frame.size.width += lineSpacing;
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = true;
    [_collectionView registerClass:[XLImageViewerItem class] forCellWithReuseIdentifier:cellId];
    _collectionView.showsHorizontalScrollIndicator = false;
    [self addSubview:_collectionView];
    
    _startIndex = 0;
    _currentIndex = 0;
    
    _toolBar = [[XLImageViewerTooBar alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - ToolBarHeight, self.bounds.size.width, ToolBarHeight)];
    __weak typeof(self)weekSelf = self;
    [_toolBar addSaveBlock:^{
        [weekSelf saveImage];
    }];
    
    [self addSubview:_toolBar];
    [UIView animateWithDuration:0.4 animations:^{
        
    } completion:^(BOOL finished) {
        [self addSubview:self.deletedBt];
    }];
}

#pragma mark -
#pragma mark CollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageUrls.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XLImageViewerItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    //设置属性
    cell.showNetImage = _showNetImages;
    cell.showDataImage  = _showDataImages;
    cell.isStart = indexPath.row == _startIndex;
    cell.collectionView = collectionView;
    cell.anchorFrame = _anchorFrame;
    cell.imageViewContentMode = [self imageViewContentMode];
    cell.imageUrl = _imageUrls[indexPath.row];
    //添加回调
    [cell addHideBlockStart:^{
        [_toolBar hide];
        self.deletedBt.alpha = 0;
    } finish:^{
        [self removeFromSuperview];
    } cancle:^{
        self.deletedBt.alpha = 1;
        [_toolBar show];
    }];
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _currentIndex = scrollView.contentOffset.x/scrollView.bounds.size.width;
    _toolBar.text = [NSString stringWithFormat:@"%zd/%zd",_currentIndex + 1,_imageUrls.count];
}

#pragma mark -
#pragma mark 功能方法

//显示网络图片方法
-(void)showNetImages:(NSArray <NSString *>*)imageUrls index:(NSInteger)index fromImageContainer:(UIView*)imageContainer{
    
    
    _showNetImages = true;
    
    [self showImages:imageUrls index:index container:imageContainer];
}

-(void)showLocalImages:(NSArray <NSString *>*)imagePathes index:(NSInteger)index fromImageContainer:(UIView*)imageContainer{
    
    _showNetImages = false;
    
    [self showImages:imagePathes index:index container:imageContainer];
}

/**
 * 显示本地图片方法
 * @param imagePathes    本地图片路径
 * @param index          显示第几张图片
 * @param imageContainer 图片容器
 */
-(void)showDataImages:(NSArray *)imagePathes index:(NSInteger)index fromImageContainer:(UIView*)imageContainer {
    _showDataImages = YES;
    //设置图片容器
    _imageContainer = imageContainer;
    //设置数据源
    _imageUrls = imagePathes;
    //设置起始位置
    _startIndex = index;
    //初始化锚点
    _anchorFrame = [_imageContainer convertRect:_imageContainer.bounds toView:self];
    //更新显示
    _toolBar.text = [NSString stringWithFormat:@"%zd/%zd",_currentIndex + 1,_imageUrls.count];
    [_toolBar show];
    self.deletedBt.alpha = 1;
    //刷新CollectionView
    [_collectionView reloadData];
    //滚动到指定位置
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:false];
    //找到指定Cell执行放大动画
    [_collectionView performBatchUpdates:nil completion:^(BOOL finished) {
        XLImageViewerItem *item = (XLImageViewerItem *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        [item showEnlargeAnimation];
        //添加到屏幕上
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }];
}

-(void)showImages:(NSArray<NSString *> *)images index:(NSInteger)index container:(UIView *)container{
    //设置图片容器
    _imageContainer = container;
    //设置数据源
    _imageUrls = images;
    //设置起始位置
    _startIndex = index;
    //初始化锚点
    _anchorFrame = [_imageContainer convertRect:_imageContainer.bounds toView:self];
    //更新显示
    _toolBar.text = [NSString stringWithFormat:@"%zd/%zd",_currentIndex + 1,_imageUrls.count];
    [_toolBar show];
    self.deletedBt.alpha = 1;
    //刷新CollectionView
    [_collectionView reloadData];
    //滚动到指定位置
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:false];
    //找到指定Cell执行放大动画
    dispatch_async(dispatch_get_main_queue(), ^{
        [_collectionView performBatchUpdates:nil completion:^(BOOL finished) {
            XLImageViewerItem *item = (XLImageViewerItem *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
            [item showEnlargeAnimation];
            //添加到屏幕上
            [[UIApplication sharedApplication].keyWindow addSubview:self];
        }];
    });
}

#pragma mark -
#pragma mark 获取上级ImageView的ContentMode

-(UIViewContentMode)imageViewContentMode{
    UIViewContentMode contentMode = UIViewContentModeScaleToFill;
    if ([_imageContainer isKindOfClass:[UIImageView class]]) {
        contentMode = _imageContainer.contentMode;
    }else{
        for (UIView *subView in _imageContainer.subviews) {
            if ([subView isKindOfClass:[UIImageView class]]) {
                contentMode = subView.contentMode;
            }else{
                for (UIView *subView2 in subView.subviews) {
                    if ([subView2 isKindOfClass:[UIImageView class]]) {
                        contentMode = subView2.contentMode;
                    }
                }
            }
        }
    }
    return contentMode;
}

- (UIButton *)deletedBt{
    if (!_deletedBt) {
        CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
        _deletedBt = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-40, rectOfStatusbar.size.height+5, 25, 25)];
        [_deletedBt setImage:[UIImage imageNamed:@"close-1"] forState:UIControlStateNormal];
        [_deletedBt addTarget:self action:@selector(clickDeletedButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deletedBt;
}

#pragma mark -
#pragma mark 存储图片方法
-(void)saveImage{
    XLImageViewerItem *item = (XLImageViewerItem *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0]];
    [item saveImage];
}

- (void)clickDeletedButton{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickDeletedButtonIndex:)]) {
        [self.delegate clickDeletedButtonIndex:_currentIndex];
    }
    [self removeFromSuperview];
}

@end
