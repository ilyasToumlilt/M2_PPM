//
//  PrefViewController.m
//  
//
//  Created by ilyas TOUMLILT on 26/10/2015.
//
//

#import "PrefViewController.h"
#import "PrefView.h"

@interface PrefViewController () {
    PrefView* myView;
    NSArray *_pickerData;
}

@end

@implementation PrefViewController

#define DEFAULT_LEVEL 1

- (instancetype)init
{
    self = [super init];
    
    if(self) {
        _level = DEFAULT_LEVEL;
        _pickerData = [[NSArray alloc] initWithObjects:@"Niveau 1", @"Niveau 2", @"Niveau 3", @"Niveau 4", @"Niveau 5", nil];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myView = [[PrefView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:myView]; [myView release];
    
    myView.levelsPickerView.dataSource = self;
    myView.levelsPickerView.delegate = self;
    
    [myView.doneButton addTarget:self
                          action:@selector(onClickDoneButton:)
                forControlEvents:UIControlEventTouchDown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showView
{
    [self.view setHidden:false];
}

- (void)hideView
{
    [self.view setHidden:true];
}

- (void)onClickDoneButton:(id)sender
{
    [_delegate retain];
    if([_delegate respondsToSelector:@selector(endedPrefAction)]) {
        [_delegate endedPrefAction];
    }
    [_delegate release];
}

/**** I am a UIPickerView delegate 8D ****/
// Le nombre de colonnes des données
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// Le nombre de lignes des données
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// Les données à retourner pour la ligne et le composant (colonne) qui est passé en entrée
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[(int)row];
}

// Détecter l'élément sélectionné dans le picker view
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _level = (int)row + 1;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
