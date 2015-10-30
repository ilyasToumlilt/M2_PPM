#import "ScoreView.h"

@implementation ScoreView

const NSInteger NBR_SCORES_MAX = 5;//TODO constructeur

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        NSLog(@"ScoreView.initWithFrame");
        
        int scLab;
        UILabel*curLab;
        
        UIVisualEffect *blurEffect;
        blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];

        self.scoresLabels = [[NSMutableArray alloc]init];
        
        self.blurBkg = [[UIVisualEffectView alloc] initWithEffect:blurEffect];

        self.bestScLab = [[UILabel alloc]init];
        [self.bestScLab setText:@"Meilleurs scores"];
        self.bestScLab.textAlignment = NSTextAlignmentCenter;
        [self.bestScLab setTextColor : [UIColor whiteColor]];

        self.yourScore = [[UILabel alloc]init];
        [self.yourScore setText:@"Votre score"];
        self.yourScore.textAlignment = NSTextAlignmentCenter;
        [self.yourScore setTextColor : [UIColor whiteColor]];

        self.doneBtn = [[UIButton alloc] init];
        [self.doneBtn setTitle:@"Done" forState:UIControlStateNormal];
        
        self.typeName =[[UITextField alloc]init];
        self.typeName.text = @"Votre nom";
        self.typeName.textColor = [UIColor lightGrayColor];
        [self.typeName setBackgroundColor:[UIColor whiteColor]];
        self.yourScore.textAlignment = NSTextAlignmentCenter;
        
        self.yourScoreVal=[[UILabel alloc]init];
        [self.yourScoreVal setText:@"0"];
        self.yourScoreVal.textAlignment = NSTextAlignmentCenter;
        [self.yourScoreVal setTextColor : [UIColor whiteColor]];
        
        for (scLab=0; scLab<NBR_SCORES_MAX; scLab++)
        {
            curLab =[[UILabel alloc]init];
            [curLab setText:@"0 : ???"];
            curLab.textAlignment = NSTextAlignmentCenter;
            [curLab setTextColor : [UIColor whiteColor]];
            
            [self.blurBkg addSubview:curLab];
            [self.scoresLabels addObject:curLab];
        }
        
        [self addSubview:self.blurBkg];[self.blurBkg release];
        
        [self.blurBkg addSubview:self.bestScLab];   [self.bestScLab release];
        [self.blurBkg addSubview:self.yourScore];   [self.yourScore release];
        [self.blurBkg addSubview:self.yourScoreVal];[self.yourScoreVal release];
        [self.blurBkg addSubview:self.doneBtn];     [self.doneBtn release];
        [self.blurBkg addSubview:self.typeName];    [self.typeName release];
        
        [self drawSubviews:frame.size];
    }
    
    return self;
}

- (void)drawSubviews:(CGSize)frame
{
    const CGFloat PADDING = 5;
    const CGFloat ELTS_HEIGHT = 20;
    CGFloat curY = PADDING;
    
    self.frame = CGRectMake(0, 0, frame.width, frame.height);
    self.blurBkg.frame = CGRectMake(0, 0, frame.width, frame.height);
    
    self.bestScLab.frame = CGRectMake(0, curY, frame.width, ELTS_HEIGHT);
    curY+= ELTS_HEIGHT+PADDING;
    
    for (UILabel *curLab in self.scoresLabels)
    {
        [curLab setFrame:CGRectMake(0, curY, frame.width, ELTS_HEIGHT)];
        curY+=ELTS_HEIGHT + PADDING;
    }

    self.yourScore.frame = CGRectMake(0, curY, frame.width, ELTS_HEIGHT);
    curY+= ELTS_HEIGHT+PADDING;
    
    self.yourScoreVal.frame = CGRectMake(0, curY, frame.width, ELTS_HEIGHT);
    curY+= ELTS_HEIGHT+PADDING;
    
    self.typeName.frame = CGRectMake(
            (frame.width/4),
            curY,
            (frame.width/2),
            ELTS_HEIGHT
    );
}

-(void)drawScores:(NSMutableArray*)scores{
    NSUInteger i=0;
    UILabel* curLab;

    for (NSDictionary *scoreName in scores)
    {
        curLab=[self.scoresLabels objectAtIndex:i];
        curLab.text = [NSMutableString stringWithFormat:@"%@ : %@", [scoreName allKeys][0],[scoreName allValues][0]];
        i++;
    }
}

-(void)clearPlaceHolderTypeName
{
    self.typeName.text=@"";
}

-(void)setCurrentScore:(NSInteger)curScore
{
    [self.yourScoreVal setText:[NSMutableString stringWithFormat:@"%ld", (long)curScore] ];
}

@end
