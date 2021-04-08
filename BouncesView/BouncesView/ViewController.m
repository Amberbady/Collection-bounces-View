//
//  ViewController.m
//  BouncesView
//
//  Created by liaoshen on 2021/4/8.
//

#import "ViewController.h"
#import "LSBouncesView.h"
#import "TestCollectionViewCell.h"
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define w self.view.frame.size.width
@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UIBezierPath *_path;
}
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) LSBouncesView *bomView;
@property (nonatomic, strong) UIImageView *animationView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self scrollViewFootBounceView];
}

#pragma mark - 侧滑弹簧效果
- (void)scrollViewFootBounceView{
    self.backView = [UIView new];
    self.backView.frame = CGRectMake(0, 200, w, 200);
    self.backView.layer.borderWidth = .5f;
    self.backView.layer.borderColor = UIColor.whiteColor.CGColor;
    [self.view addSubview:self.backView];
     
    LSBouncesView *bomView = [[LSBouncesView alloc] initWithFrame:CGRectMake(0, 0, w-60, 200)];
    bomView.backgroundColor = UIColor.whiteColor;
    [self.backView addSubview:bomView];
    self.bomView = bomView;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.backView.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.directionalLockEnabled = YES;
    self.collectionView.backgroundColor = UIColor.clearColor;
    [self.collectionView registerClass:TestCollectionViewCell.class forCellWithReuseIdentifier:@"TestCollectionViewCell"];
    [self.backView addSubview:self.collectionView];
    
    self.datas = @[@"1",@"1",@"1"];
    [self.collectionView reloadData];
    
    UIImageView *animationView = [[UIImageView alloc] initWithFrame:CGRectMake(w, 0, 60, 200)];
    animationView.backgroundColor = RGBACOLOR(210,177,246,1);
    animationView.image = [UIImage imageNamed:@"super_topic_Icon_footer"];
    animationView.alpha = 0;
    [self.backView addSubview:animationView];
    self.animationView = animationView;
    UILabel *label = [UILabel new];
    label.frame = animationView.bounds;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [animationView addSubview:label];
    label.text = @"更\n多\n话\n题";
    label.textColor = UIColor.whiteColor;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat sizeWidth = scrollView.contentSize.width;
    CGFloat offset = scrollView.contentOffset.x;
    CGFloat scrollMaxX= offset + w;
    //NSLog(@"%.f, %.f", offset + w, scrollView.contentSize.width);
    if ((sizeWidth - scrollMaxX - 20 + 20) < 60) {
        if ((sizeWidth - scrollMaxX - 20 + 20) < 0) {
            // 快速拉动时，产生偏差，检查一次
            if ((self.animationView.frame.origin.x + self.animationView.frame.size.width) != w) {
                self.animationView.frame = CGRectMake(w-self.animationView.frame.size.width, 0, self.animationView.frame.size.width, 200);
            }
            
            // 最大张力 100
            if ((sizeWidth - scrollMaxX - 20 + 20) < -100) {
                return;
            }
            
            CGPoint controlPoint = CGPointMake((sizeWidth - scrollMaxX - 20 + 20), self.animationView.frame.size.height/2.0);
            self.bomView.point = controlPoint;
            self.bomView.alpha = 1;
            return;
        }
        
        self.bomView.alpha = 0;
        self.animationView.alpha = 1;
        CGFloat animatX = 60 - (sizeWidth - scrollMaxX - 20 + 20);
        CGRect frame = self.animationView.frame;
        frame.origin.x = w-animatX;
        self.animationView.frame = frame;
    }else{
        self.animationView.alpha = 0;
        self.animationView.frame = CGRectMake(w, 0, 60, 200);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 20, 0, 60+20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(self.view.frame.size.width-20-20-60, 200);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TestCollectionViewCell" forIndexPath:indexPath];
    return cell;
}


@end
