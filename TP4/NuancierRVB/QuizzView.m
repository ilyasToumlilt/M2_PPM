#import "QuizzView.h"

@interface QuizzView(){
}
@end


@implementation QuizzView

const CGFloat HORIZ_GUIDELINE = 20.0;
const CGFloat VERTI_GUIDELINE = 20.0;
const CGFloat PADDING_BETW_ELEM = 5;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self)
    {
        /* myButtonPrec */
        self.myButtonPrec = [[UIButton alloc] init];
        
        /* myLabelPrec */
        self.myLabelPrec = [[UILabel alloc] init];
        self.myLabelPrec.text = @"Précédent";

        /* myButtonPenu */
        self.myButtonPenu = [[UIButton alloc] init];

        /* myLabelPenu */
        self.myLabelPenu = [[UILabel alloc] init];
        self.myLabelPenu.text = @"Pénultième";

        /* myLabelActuel */
        self.myLabelActuel = [[UILabel alloc] init];
        self.myLabelActuel.text = @"Actuel";
        self.myLabelActuel.textAlignment = NSTextAlignmentCenter;

        /* myActualColorView */
        self.myActualColorView = [[UIView alloc] init];

        /* myRLabel */
        self.myRLabel = [[UILabel alloc] init];

        /*myRSlider*/
        self.myRSlider = [[UISlider alloc] init];

        /* myVLabel */
        self.myVLabel = [[UILabel alloc] init];
        
        /*myVSlider*/
        self.myVSlider = [[UISlider alloc] init];
        
        /* myRLabel */
        self.myBLabel = [[UILabel alloc] init];
        
        /*myRSlider*/
        self.myBSlider = [[UISlider alloc] init];
        
        /*myButtonSave*/
        self.myButtonSave = [[UIButton alloc] init];
        [self.myButtonSave setTitle:@"Enregistrer" forState:UIControlStateNormal];
        [self.myButtonSave setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        /*myButtonRaz*/
        self.myButtonRaz = [[UIButton alloc] init];
        [self.myButtonRaz setTitle:@"Raz" forState:UIControlStateNormal];
        [self.myButtonRaz setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        /* mySwitch */
        self.mySwitch = [[UISwitch alloc] init];
        
        [self addSubview:self.myButtonPrec];
        [self addSubview:self.myLabelPrec];
        [self addSubview:self.myButtonPenu];
        [self addSubview:self.myLabelPenu];
        [self addSubview:self.myLabelActuel];
        [self addSubview:self.myActualColorView];
        [self addSubview:self.myRLabel];
        [self addSubview:self.myRSlider];
        [self addSubview:self.myVLabel];
        [self addSubview:self.myVSlider];
        [self addSubview:self.myBLabel];
        [self addSubview:self.myBSlider];
        [self addSubview:self.myButtonSave];
        [self addSubview:self.myButtonRaz];
        [self addSubview:self.mySwitch];
        
        /* dessiner */
        [self adaptSizeElements:frame.size];
        
        /* release */
        [self.myButtonPrec release];
        [self.myLabelPrec release];
        [self.myButtonPenu release];
        [self.myLabelPenu release];
        [self.myLabelActuel release];
        [self.myActualColorView release];
        [self.myRLabel release];
        [self.myRSlider release];
        [self.myBLabel release];
        [self.myBSlider release];
        [self.myVLabel release];
        [self.myVSlider release];
        [self.myButtonSave release];
        [self.myButtonRaz release];
        [self.mySwitch release];
    }
    return self;
}


-(void)adaptSizeElements:(CGSize)format
{
    //if(format.width < format.height){
        const CGFloat prevPenuHeight = 40;
        CGFloat curY;
        CGSize txtSize = [[self.myLabelPenu text] sizeWithAttributes:@{NSFontAttributeName: [self.myLabelPenu font]}];
        CGSize txtAct =[[self.myLabelPenu text] sizeWithAttributes:@{NSFontAttributeName: [self.myLabelPenu font]}];

        curY = HORIZ_GUIDELINE;
        [self.myLabelPrec setFrame:CGRectMake(format.width-VERTI_GUIDELINE-txtSize.width, curY, txtSize.width, txtSize.height)];
        [self.myButtonPrec setFrame:CGRectMake(VERTI_GUIDELINE, curY, format.width-txtSize.width-((2*HORIZ_GUIDELINE) + PADDING_BETW_ELEM), prevPenuHeight)];

        curY += prevPenuHeight + PADDING_BETW_ELEM;
        [self.myLabelPenu setFrame:CGRectMake(format.width-VERTI_GUIDELINE-txtSize.width, curY, txtSize.width, txtSize.height)];
        [self.myButtonPenu setFrame:CGRectMake(VERTI_GUIDELINE, curY, format.width-txtSize.width-((2*HORIZ_GUIDELINE) + PADDING_BETW_ELEM), prevPenuHeight)];

        curY+= prevPenuHeight + PADDING_BETW_ELEM;
        [self.myLabelActuel setFrame:CGRectMake(VERTI_GUIDELINE, curY, format.width, txtAct.height)];
    
        //curY+=txtAct.height+PADDING_BETW_ELEM;
    
        [self.myButtonSave setFrame:CGRectMake(VERTI_GUIDELINE, format.height-txtAct.height-HORIZ_GUIDELINE, (format.width-(3*PADDING_BETW_ELEM))/3, txtAct.height)];
        [self.myButtonRaz setFrame:CGRectMake((format.width-(3*PADDING_BETW_ELEM))/3, format.height-txtAct.height-HORIZ_GUIDELINE, (format.width-(3*PADDING_BETW_ELEM))/3, txtAct.height)];
        [self.mySwitch setFrame:CGRectMake( (2*(format.width-(3*PADDING_BETW_ELEM))/3), format.height-txtAct.height-HORIZ_GUIDELINE, ((format.width-(3*PADDING_BETW_ELEM))/3), txtAct.height)];
    
        [self.myRLabel ;
        
        self.myRSlider = [[UISlider alloc] init];
        
        self.myVLabel = [[UILabel alloc] init];
        
        self.myVSlider = [[UISlider alloc] init];
        
        self.myBLabel = [[UILabel alloc] init];
        
        self.myBSlider = [[UISlider alloc] init];
    
    
        //curY+= txtAct.height+PADDING_BETW_ELEM;
        //[self.myActualColorView setBounds:CGRectMake(VERTI_GUIDELINE, curY, format.width, )];
    //}
}
@end


