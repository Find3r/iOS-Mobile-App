//
//  F3RCoolNavi.m
//  Pineapple
//
//  Created by user on 1/15/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "F3RCoolNavi.h"
#import "UIImageView+WebCache.h"



@interface F3RCoolNavi()


@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, assign) CGPoint prePoint;


@end


@implementation F3RCoolNavi

- (id)initWithFrame:(CGRect)frame backGroudImage:(NSString *)backImageName headerImageURL:(NSString *)headerImageURL title:(NSString *)title subTitle:(NSString *)subTitle
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -0.5*frame.size.height, frame.size.width, frame.size.height*2)];
        
        _backImageView.image = [UIImage imageNamed:backImageName];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width*0.5-70*0.5, 0.3*frame.size.height, 70, 70)];
        [_headerImageView sd_setImageWithURL:[NSURL URLWithString:headerImageURL]];
        [_headerImageView.layer setMasksToBounds:YES];
        _headerImageView.layer.cornerRadius = _headerImageView.frame.size.width/2.0f;
        _headerImageView.userInteractionEnabled = YES;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.4*frame.size.height, frame.size.width , frame.size.height*0.2)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.text = title;
        
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.6*frame.size.height, frame.size.width, frame.size.height*0.2)];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.font = [UIFont systemFontOfSize:14];
        _subTitleLabel.text = subTitle;
        _titleLabel.textColor = [UIColor whiteColor];
        _subTitleLabel.textColor = [UIColor whiteColor];
        
        NSArray *array = [[NSArray alloc] initWithObjects:@"Mis publicaciones",@"Seguimiento", nil];
        _segmentControl = [[UISegmentedControl alloc] initWithItems:array];
        
        [_segmentControl setFrame:CGRectMake(10, 0.87*frame.size.height, frame.size.width - 20, frame.size.height*0.1)];
        [_segmentControl setSelectedSegmentIndex:0];
        [_segmentControl setBackgroundColor:[UIColor colorWithRed:58 green:113 blue:255 alpha:1]];
       
   
        
        [self addSubview:_backImageView];
        [self addSubview:_headerImageView];
        [self addSubview:_titleLabel];
        [self addSubview:_subTitleLabel];
        [self addSubview:_segmentControl];
        
        self.clipsToBounds = YES;
        
    }
    return self;
    
}

- (void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew) context:Nil];
    self.scrollView.contentInset = UIEdgeInsetsMake(self.frame.size.height, 0 ,0 , 0);
    self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset;
}



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    CGPoint newOffset = [change[@"new"] CGPointValue];
    [self updateSubViewsWithScrollOffset:newOffset];
}

-(void)updateSubViewsWithScrollOffset:(CGPoint)newOffset
{
    
    //if (self.heightAnchor > -113) {
        
   
    CGFloat destinaOffset = -63;
    CGFloat startChangeOffset = -self.scrollView.contentInset.top;
    
    
        
        
    newOffset = CGPointMake(newOffset.x, newOffset.y<startChangeOffset?startChangeOffset:(newOffset.y>destinaOffset?destinaOffset:newOffset.y));
    if (newOffset.y < -102) {
    CGFloat subviewOffset = self.frame.size.height-40; // 子视图的偏移量
    CGFloat newY = -newOffset.y-self.scrollView.contentInset.top;
    CGFloat d = destinaOffset-startChangeOffset;
    CGFloat alpha = 1-(newOffset.y-startChangeOffset)/d;
    CGFloat imageReduce = 1-(newOffset.y-startChangeOffset)/(d*2);
    self.subTitleLabel.alpha = alpha;
    self.titleLabel.alpha = alpha;
    self.frame = CGRectMake(0, newY, self.frame.size.width, self.frame.size.height);
    self.backImageView.frame = CGRectMake(0, -0.5*self.frame.size.height+(1.5*self.frame.size.height-64)*(1-alpha), self.backImageView.frame.size.width, self.backImageView.frame.size.height);
    
    CGAffineTransform t = CGAffineTransformMakeTranslation(0,(subviewOffset-0.35*self.frame.size.height)*(1-alpha));
    _headerImageView.transform = CGAffineTransformScale(t,
                                                        imageReduce, imageReduce);
    
    self.titleLabel.frame = CGRectMake(0, 0.6*self.frame.size.height+(subviewOffset-0.45*self.frame.size.height)*(1-alpha), self.frame.size.width, self.frame.size.height*0.2);
    self.subTitleLabel.frame = CGRectMake(0, 0.75*self.frame.size.height+(subviewOffset-0.45*self.frame.size.height)*(1-alpha), self.frame.size.width, self.frame.size.height*0.1);
        
    }
}

- (void)tapAction:(id)sender
{
    if (self.imgActionBlock) {
        self.imgActionBlock();
    }
}




@end
