

#import "BetterPSSliderTableCell.h"


@implementation BetterPSSliderTableCell

- (id)initWithStyle:(NSInteger)arg1 reuseIdentifier:(id)arg2 specifier:(id)arg3 {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:arg2 specifier:arg3];
    if (self) {
        CGRect frame = [self frame];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(frame.size.width-50, 0, 50, frame.size.height);
        button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [button setTitle:@"" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(presentPopup) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}

- (void)presentPopup {
    alert = [[UIAlertView alloc] initWithTitle:self.specifier.name
                          message:[NSString stringWithFormat:@"Please enter a value between %.01f and %.01f.", [[self.specifier propertyForKey:@"min"] floatValue], [[self.specifier propertyForKey:@"max"] floatValue]]
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"Enter"
                          , nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = 342879;
    [alert show];
    [[alert textFieldAtIndex:0] setDelegate:self];
    [[alert textFieldAtIndex:0] resignFirstResponder];
    [[alert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    BOOL needsNegate = [[self.specifier propertyForKey:@"min"] floatValue]<0;
    BOOL needsPoint = [[self.specifier propertyForKey:@"max"] floatValue] - [[self.specifier propertyForKey:@"min"] floatValue] <= 10;
    if( UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad && (needsNegate || needsPoint)) {
        UIToolbar* toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        UIBarButtonItem* buttonOne = [[UIBarButtonItem alloc] initWithTitle:@"Negate" style:UIBarButtonItemStylePlain target:self action:@selector(typeMinus)];
        UIBarButtonItem* buttonTwo = [[UIBarButtonItem alloc] initWithTitle:@"Point" style:UIBarButtonItemStylePlain target:self action:@selector(typePoint)];
        NSArray* buttons = nil;
        if(needsPoint && needsNegate) {
            buttons = [NSArray arrayWithObjects:buttonOne, buttonTwo, nil];
        }
        else if (needsPoint) {
            buttons = [NSArray arrayWithObjects: buttonTwo, nil];
        }
        else if (needsNegate) {
            buttons = [NSArray arrayWithObjects: buttonOne, nil];
        }
        [toolBar setItems:buttons animated:NO];
        [[alert textFieldAtIndex:0] setInputAccessoryView:toolBar];
    }
    [[alert textFieldAtIndex:0] becomeFirstResponder];
}

-(void) typeMinus {
    if (alert) {
        NSString* text = [alert textFieldAtIndex:0].text;
        if ([text hasPrefix:@"-"]) {
            [alert textFieldAtIndex:0].text = [text substringFromIndex:1];
        }
        else {
            [alert textFieldAtIndex:0].text = [NSString stringWithFormat:@"-%@", text];
        }
    }
}

-(void) typePoint {
    if (alert) {
        NSString* text = [alert textFieldAtIndex:0].text;
        [alert textFieldAtIndex:0].text = [NSString stringWithFormat:@"%@.", text];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 342879) {
        if(buttonIndex == 1) {
            CGFloat value = [[alertView textFieldAtIndex:0].text floatValue];
            if (value <= [[self.specifier propertyForKey:@"max"] floatValue] && value >= [[self.specifier propertyForKey:@"min"] floatValue]) {
                [self setValue:[NSNumber numberWithFloat:value]];
                [PSRootController setPreferenceValue:[NSNumber numberWithFloat:value] specifier:self.specifier];
                [[NSUserDefaults standardUserDefaults] synchronize];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    // notify after file write
                    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)[self.specifier propertyForKey:@"PostNotification"], NULL, NULL, YES);
                });
            }
            else {
                UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                      message:@"Ensure you enter a valid value."
                                                                     delegate:self
                                                            cancelButtonTitle:@"OK"
                                                            otherButtonTitles:nil
                                            , nil];
                errorAlert.tag = 85230234;
                [errorAlert show];
            }
        }
        [[alertView textFieldAtIndex:0] resignFirstResponder];
    }
    else if (alertView.tag == 85230234) {
        [self presentPopup];
    }
}

@end
