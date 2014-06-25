//
//  InterfaceUtil.h
//  Grid
//
//  Created by LinO_dska on 16.04.14.
//  Copyright (c) 2014 Auri. All rights reserved.
//

#ifndef The_Bad_Ass_Seven_Interface_h
#define The_Bad_Ass_Seven_Interface_h

#import <Foundation/Foundation.h>

#pragma mark -  Macros

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#define BLUECOLOR [UIColor colorWithRed:.07f green:.84f blue:.89f alpha:1.0f]
#define GREENCOLOR [UIColor greenColor]
#define REDCOLOR [UIColor redColor]
#define WHITECOLOR [UIColor whiteColor]
#define RETINA [[UIScreen mainScreen] scale]
#define KEYBOARD_HEIGHT 352

#define ICONWIDTH 22
#define ICONHEIGHT 1
#define ICONSIZE 50
#define ICONREALSIZE 22
#define ORBITSIZE 264

#define ICONROWCOUNT 25
#define ICONHEIGHTCOUNT 1


#pragma mark - Interface Constants

static const float sinx[360] = {0.000000,0.017452,0.034899,0.052336,0.069756,0.087156,0.104528,0.121869,0.139173,0.156434,0.173648,0.190809,0.207912,0.224951,0.241922,0.258819,0.275637,0.292372,0.309017,0.325568,0.342020,0.358368,0.374607,0.390731,0.406737,0.422618,0.438371,0.453990,0.469472,0.484810,0.500000,0.515038,0.529919,0.544639,0.559193,0.573576,0.587785,0.601815,0.615661,0.629320,0.642788,0.656059,0.669131,0.681998,0.694658,0.707107,0.719340,0.731354,0.743145,0.754710,0.766044,0.777146,0.788011,0.798636,0.809017,0.819152,0.829038,0.838671,0.848048,0.857167,0.866025,0.874620,0.882948,0.891007,0.898794,0.906308,0.913545,0.920505,0.927184,0.933580,0.939693,0.945519,0.951057,0.956305,0.961262,0.965926,0.970296,0.974370,0.978148,0.981627,0.984808,0.987688,0.990268,0.992546,0.994522,0.996195,0.997564,0.998630,0.999391,0.999848,1.000000,0.999848,0.999391,0.998630,0.997564,0.996195,0.994522,0.992546,0.990268,0.987688,0.984808,0.981627,0.978148,0.974370,0.970296,0.965926,0.961262,0.956305,0.951057,0.945519,0.939693,0.933580,0.927184,0.920505,0.913545,0.906308,0.898794,0.891007,0.882948,0.874620,0.866025,0.857167,0.848048,0.838671,0.829038,0.819152,0.809017,0.798636,0.788011,0.777146,0.766044,0.754710,0.743145,0.731354,0.719340,0.707107,0.694658,0.681998,0.669131,0.656059,0.642788,0.629320,0.615661,0.601815,0.587785,0.573576,0.559193,0.544639,0.529919,0.515038,0.500000,0.484810,0.469472,0.453990,0.438371,0.422618,0.406737,0.390731,0.374607,0.358368,0.342020,0.325568,0.309017,0.292372,0.275637,0.258819,0.241922,0.224951,0.207912,0.190809,0.173648,0.156434,0.139173,0.121869,0.104528,0.087156,0.069756,0.052336,0.034899,0.017452,0.000000,-0.017452,-0.034899,-0.052336,-0.069756,-0.087156,-0.104528,-0.121869,-0.139173,-0.156434,-0.173648,-0.190809,-0.207912,-0.224951,-0.241922,-0.258819,-0.275637,-0.292372,-0.309017,-0.325568,-0.342020,-0.358368,-0.374607,-0.390731,-0.406737,-0.422618,-0.438371,-0.453990,-0.469472,-0.484810,-0.500000,-0.515038,-0.529919,-0.544639,-0.559193,-0.573576,-0.587785,-0.601815,-0.615661,-0.629320,-0.642788,-0.656059,-0.669131,-0.681998,-0.694658,-0.707107,-0.719340,-0.731354,-0.743145,-0.754710,-0.766044,-0.777146,-0.788011,-0.798636,-0.809017,-0.819152,-0.829038,-0.838671,-0.848048,-0.857167,-0.866025,-0.874620,-0.882948,-0.891007,-0.898794,-0.906308,-0.913545,-0.920505,-0.927184,-0.933580,-0.939693,-0.945519,-0.951057,-0.956305,-0.961262,-0.965926,-0.970296,-0.974370,-0.978148,-0.981627,-0.984808,-0.987688,-0.990268,-0.992546,-0.994522,-0.996195,-0.997564,-0.998630,-0.999391,-0.999848,-1.000000,-0.999848,-0.999391,-0.998630,-0.997564,-0.996195,-0.994522,-0.992546,-0.990268,-0.987688,-0.984808,-0.981627,-0.978148,-0.974370,-0.970296,-0.965926,-0.961262,-0.956305,-0.951057,-0.945519,-0.939693,-0.933580,-0.927184,-0.920505,-0.913545,-0.906308,-0.898794,-0.891007,-0.882948,-0.874620,-0.866025,-0.857167,-0.848048,-0.838671,-0.829038,-0.819152,-0.809017,-0.798636,-0.788011,-0.777146,-0.766044,-0.754710,-0.743145,-0.731354,-0.719340,-0.707107,-0.694658,-0.681998,-0.669131,-0.656059,-0.642788,-0.629320,-0.615661,-0.601815,-0.587785,-0.573576,-0.559193,-0.544639,-0.529919,-0.515038,-0.500000,-0.484810,-0.469472,-0.453990,-0.438371,-0.422618,-0.406737,-0.390731,-0.374607,-0.358368,-0.342020,-0.325568,-0.309017,-0.292372,-0.275637,-0.258819,-0.241922,-0.224951,-0.207912,-0.190809,-0.173648,-0.156434,-0.139173,-0.121869,-0.104528,-0.087156,-0.069756,-0.052336,-0.034899,-0.017452};

static const float cosx[360] = {1.000000,0.999848,0.999391,0.998630,0.997564,0.996195,0.994522,0.992546,0.990268,0.987688,0.984808,0.981627,0.978148,0.974370,0.970296,0.965926,0.961262,0.956305,0.951057,0.945519,0.939693,0.933580,0.927184,0.920505,0.913545,0.906308,0.898794,0.891007,0.882948,0.874620,0.866025,0.857167,0.848048,0.838671,0.829038,0.819152,0.809017,0.798635,0.788011,0.777146,0.766044,0.754710,0.743145,0.731354,0.719340,0.707107,0.694658,0.681998,0.669131,0.656059,0.642788,0.629320,0.615662,0.601815,0.587785,0.573576,0.559193,0.544639,0.529919,0.515038,0.500000,0.484810,0.469472,0.453991,0.438371,0.422618,0.406737,0.390731,0.374607,0.358368,0.342020,0.325568,0.309017,0.292372,0.275637,0.258819,0.241922,0.224951,0.207912,0.190809,0.173648,0.156434,0.139173,0.121869,0.104528,0.087156,0.069757,0.052336,0.034899,0.017452,-0.000000,-0.017452,-0.034899,-0.052336,-0.069756,-0.087156,-0.104529,-0.121869,-0.139173,-0.156434,-0.173648,-0.190809,-0.207912,-0.224951,-0.241922,-0.258819,-0.275637,-0.292372,-0.309017,-0.325568,-0.342020,-0.358368,-0.374607,-0.390731,-0.406737,-0.422618,-0.438371,-0.453991,-0.469472,-0.484810,-0.500000,-0.515038,-0.529919,-0.544639,-0.559193,-0.573576,-0.587785,-0.601815,-0.615661,-0.629320,-0.642788,-0.656059,-0.669131,-0.681998,-0.694658,-0.707107,-0.719340,-0.731354,-0.743145,-0.754710,-0.766044,-0.777146,-0.788011,-0.798635,-0.809017,-0.819152,-0.829038,-0.838671,-0.848048,-0.857167,-0.866025,-0.874620,-0.882948,-0.891006,-0.898794,-0.906308,-0.913545,-0.920505,-0.927184,-0.933580,-0.939693,-0.945519,-0.951056,-0.956305,-0.961262,-0.965926,-0.970296,-0.974370,-0.978148,-0.981627,-0.984808,-0.987688,-0.990268,-0.992546,-0.994522,-0.996195,-0.997564,-0.998630,-0.999391,-0.999848,-1.000000,-0.999848,-0.999391,-0.998630,-0.997564,-0.996195,-0.994522,-0.992546,-0.990268,-0.987688,-0.984808,-0.981627,-0.978148,-0.974370,-0.970296,-0.965926,-0.961262,-0.956305,-0.951057,-0.945519,-0.939693,-0.933580,-0.927184,-0.920505,-0.913545,-0.906308,-0.898794,-0.891006,-0.882948,-0.874620,-0.866025,-0.857167,-0.848048,-0.838671,-0.829038,-0.819152,-0.809017,-0.798635,-0.788011,-0.777146,-0.766044,-0.754710,-0.743145,-0.731354,-0.719340,-0.707107,-0.694658,-0.681998,-0.669131,-0.656059,-0.642788,-0.629320,-0.615662,-0.601815,-0.587785,-0.573576,-0.559193,-0.544639,-0.529919,-0.515038,-0.500000,-0.484810,-0.469472,-0.453991,-0.438371,-0.422618,-0.406737,-0.390731,-0.374607,-0.358368,-0.342020,-0.325568,-0.309017,-0.292372,-0.275637,-0.258819,-0.241922,-0.224951,-0.207912,-0.190809,-0.173648,-0.156435,-0.139173,-0.121869,-0.104528,-0.087156,-0.069757,-0.052336,-0.034899,-0.017452,0.000000,0.017452,0.034899,0.052336,0.069757,0.087156,0.104528,0.121869,0.139173,0.156435,0.173648,0.190809,0.207911,0.224951,0.241922,0.258819,0.275637,0.292371,0.309017,0.325568,0.342020,0.358368,0.374607,0.390731,0.406737,0.422618,0.438371,0.453991,0.469472,0.484810,0.500000,0.515038,0.529919,0.544639,0.559193,0.573576,0.587785,0.601815,0.615662,0.629320,0.642788,0.656059,0.669131,0.681998,0.694658,0.707107,0.719340,0.731354,0.743145,0.754710,0.766044,0.777146,0.788011,0.798635,0.809017,0.819152,0.829038,0.838671,0.848048,0.857167,0.866025,0.874620,0.882948,0.891006,0.898794,0.906308,0.913545,0.920505,0.927184,0.933580,0.939693,0.945519,0.951057,0.956305,0.961262,0.965926,0.970296,0.974370,0.978148,0.981627,0.984808,0.987688,0.990268,0.992546,0.994522,0.996195,0.997564,0.998630,0.999391,0.999848};

static const float tgx[360] = {0.000000,0.017455,0.034921,0.052408,0.069927,0.087489,0.105104,0.122785,0.140541,0.158384,0.176327,0.194380,0.212557,0.230868,0.249328,0.267949,0.286745,0.305731,0.324920,0.344328,0.363970,0.383864,0.404026,0.424475,0.445229,0.466308,0.487733,0.509525,0.531709,0.554309,0.577350,0.600861,0.624869,0.649408,0.674508,0.700208,0.726543,0.753554,0.781286,0.809784,0.839100,0.869287,0.900404,0.932515,0.965689,1.000000,1.035530,1.072369,1.110613,1.150368,1.191754,1.234897,1.279942,1.327045,1.376382,1.428148,1.482561,1.539865,1.600335,1.664279,1.732051,1.804048,1.880726,1.962610,2.050304,2.144507,2.246037,2.355853,2.475086,2.605089,2.747477,2.904211,3.077684,3.270853,3.487414,3.732050,4.010781,4.331476,4.704631,5.144556,5.671280,6.313751,7.115370,8.144348,9.514368,11.430044,14.300658,19.081131,28.636255,57.290039,-22877332.000000,-57.290142,-28.636282,-19.081142,-14.300665,-11.430049,-9.514360,-8.144350,-7.115371,-6.313752,-5.671281,-5.144553,-4.704629,-4.331477,-4.010781,-3.732051,-3.487414,-3.270852,-3.077683,-2.904211,-2.747478,-2.605089,-2.475087,-2.355852,-2.246037,-2.144506,-2.050304,-1.962610,-1.880726,-1.804048,-1.732051,-1.664280,-1.600334,-1.539865,-1.482561,-1.428148,-1.376382,-1.327045,-1.279942,-1.234897,-1.191754,-1.150369,-1.110612,-1.072369,-1.035530,-1.000000,-0.965689,-0.932515,-0.900404,-0.869287,-0.839100,-0.809784,-0.781286,-0.753554,-0.726542,-0.700208,-0.674508,-0.649408,-0.624869,-0.600861,-0.577350,-0.554309,-0.531709,-0.509526,-0.487733,-0.466308,-0.445229,-0.424475,-0.404026,-0.383864,-0.363970,-0.344328,-0.324920,-0.305731,-0.286745,-0.267949,-0.249328,-0.230868,-0.212556,-0.194380,-0.176327,-0.158384,-0.140541,-0.122784,-0.105104,-0.087489,-0.069927,-0.052408,-0.034921,-0.017455,0.000000,0.017455,0.034921,0.052408,0.069927,0.087489,0.105104,0.122785,0.140541,0.158384,0.176327,0.194380,0.212557,0.230868,0.249328,0.267949,0.286745,0.305731,0.324920,0.344328,0.363970,0.383864,0.404026,0.424475,0.445229,0.466308,0.487732,0.509525,0.531709,0.554309,0.577350,0.600860,0.624869,0.649408,0.674509,0.700207,0.726543,0.753554,0.781285,0.809784,0.839100,0.869287,0.900404,0.932515,0.965689,1.000000,1.035530,1.072369,1.110613,1.150368,1.191754,1.234897,1.279942,1.327044,1.376383,1.428148,1.482561,1.539865,1.600334,1.664280,1.732051,1.804048,1.880726,1.962610,2.050305,2.144507,2.246037,2.355852,2.475085,2.605090,2.747478,2.904211,3.077682,3.270850,3.487417,3.732052,4.010780,4.331473,4.704625,5.144558,5.671283,6.313749,7.115362,8.144361,9.514376,11.430057,14.300652,19.081076,28.636425,57.290325,-83858280.000000,-57.290249,-28.636406,-19.081066,-14.300647,-11.430053,-9.514374,-8.144360,-7.115361,-6.313748,-5.671283,-5.144557,-4.704635,-4.331473,-4.010780,-3.732051,-3.487416,-3.270855,-3.077682,-2.904211,-2.747478,-2.605090,-2.475085,-2.355852,-2.246037,-2.144507,-2.050305,-1.962610,-1.880726,-1.804048,-1.732051,-1.664280,-1.600334,-1.539865,-1.482561,-1.428148,-1.376383,-1.327044,-1.279941,-1.234897,-1.191754,-1.150369,-1.110612,-1.072369,-1.035530,-1.000000,-0.965688,-0.932515,-0.900404,-0.869287,-0.839100,-0.809784,-0.781285,-0.753554,-0.726543,-0.700208,-0.674508,-0.649407,-0.624869,-0.600861,-0.577351,-0.554309,-0.531709,-0.509525,-0.487733,-0.466308,-0.445228,-0.424475,-0.404026,-0.383864,-0.363970,-0.344327,-0.324920,-0.305731,-0.286746,-0.267949,-0.249328,-0.230868,-0.212557,-0.194380,-0.176327,-0.158384,-0.140541,-0.122785,-0.105104,-0.087488,-0.069927,-0.052408,-0.034921,-0.017455};

static const float ctgx[360] = {-22877332.000000,57.289967,28.636255,19.081137,14.300667,11.430054,9.514364,8.144346,7.115370,6.313751,5.671282,5.144554,4.704630,4.331476,4.010781,3.732051,3.487414,3.270853,3.077683,2.904211,2.747477,2.605089,2.475087,2.355852,2.246037,2.144507,2.050304,1.962610,1.880726,1.804048,1.732051,1.664279,1.600335,1.539865,1.482561,1.428148,1.376382,1.327045,1.279942,1.234897,1.191754,1.150368,1.110613,1.072369,1.035530,1.000000,0.965689,0.932515,0.900404,0.869287,0.839100,0.809784,0.781286,0.753554,0.726543,0.700208,0.674509,0.649408,0.624869,0.600861,0.577350,0.554309,0.531709,0.509526,0.487733,0.466308,0.445229,0.424475,0.404026,0.383864,0.363970,0.344328,0.324920,0.305731,0.286745,0.267949,0.249328,0.230868,0.212557,0.194380,0.176327,0.158384,0.140541,0.122785,0.105104,0.087489,0.069927,0.052408,0.034921,0.017455,-0.000000,-0.017455,-0.034921,-0.052408,-0.069927,-0.087489,-0.105104,-0.122785,-0.140541,-0.158384,-0.176327,-0.194380,-0.212557,-0.230868,-0.249328,-0.267949,-0.286745,-0.305731,-0.324920,-0.344328,-0.363970,-0.383864,-0.404026,-0.424475,-0.445229,-0.466308,-0.487733,-0.509526,-0.531709,-0.554309,-0.577350,-0.600861,-0.624870,-0.649408,-0.674508,-0.700208,-0.726543,-0.753554,-0.781286,-0.809784,-0.839100,-0.869287,-0.900404,-0.932515,-0.965689,-1.000000,-1.035530,-1.072369,-1.110613,-1.150369,-1.191754,-1.234897,-1.279942,-1.327045,-1.376382,-1.428148,-1.482561,-1.539865,-1.600334,-1.664280,-1.732051,-1.804048,-1.880726,-1.962610,-2.050304,-2.144506,-2.246037,-2.355852,-2.475088,-2.605089,-2.747477,-2.904211,-3.077683,-3.270854,-3.487414,-3.732049,-4.010782,-4.331475,-4.704632,-5.144554,-5.671278,-6.313752,-7.115366,-8.144351,-9.514361,-11.430066,-14.300667,-19.081104,-28.636292,-57.289795,11438667.000000,57.290001,28.636343,19.081127,14.300681,11.430043,9.514367,8.144339,7.115369,6.313755,5.671280,5.144556,4.704628,4.331476,4.010783,3.732050,3.487415,3.270852,3.077684,2.904210,2.747477,2.605090,2.475086,2.355853,2.246036,2.144507,2.050304,1.962610,1.880727,1.804047,1.732051,1.664280,1.600335,1.539865,1.482561,1.428148,1.376382,1.327045,1.279942,1.234897,1.191754,1.150368,1.110613,1.072369,1.035530,1.000000,0.965689,0.932515,0.900404,0.869287,0.839099,0.809784,0.781286,0.753554,0.726542,0.700207,0.674508,0.649408,0.624870,0.600860,0.577350,0.554309,0.531710,0.509526,0.487732,0.466308,0.445229,0.424475,0.404026,0.383864,0.363970,0.344328,0.324920,0.305731,0.286745,0.267949,0.249328,0.230868,0.212557,0.194380,0.176327,0.158384,0.140541,0.122784,0.105104,0.087489,0.069927,0.052408,0.034921,0.017455,-0.000000,-0.017455,-0.034921,-0.052408,-0.069927,-0.087489,-0.105104,-0.122784,-0.140541,-0.158385,-0.176327,-0.194380,-0.212556,-0.230868,-0.249328,-0.267949,-0.286745,-0.305730,-0.324920,-0.344328,-0.363970,-0.383864,-0.404027,-0.424475,-0.445229,-0.466308,-0.487732,-0.509526,-0.531710,-0.554309,-0.577350,-0.600860,-0.624870,-0.649408,-0.674509,-0.700207,-0.726542,-0.753554,-0.781286,-0.809784,-0.839099,-0.869286,-0.900404,-0.932515,-0.965689,-1.000000,-1.035531,-1.072369,-1.110613,-1.150368,-1.191753,-1.234898,-1.279942,-1.327045,-1.376382,-1.428147,-1.482561,-1.539865,-1.600335,-1.664279,-1.732050,-1.804049,-1.880727,-1.962610,-2.050303,-2.144506,-2.246038,-2.355853,-2.475086,-2.605088,-2.747475,-2.904212,-3.077684,-3.270852,-3.487412,-3.732054,-4.010783,-4.331476,-4.704628,-5.144549,-5.671289,-6.313756,-7.115371,-8.144341,-9.514348,-11.430078,-14.300686,-19.081135,-28.636169,-57.289299};

static int mod(int a) {
    if(a<0) return -a;
    return a;
}

static float modFloat(float a) {
    if(a<0) return -a;
    return a;
}
static CGRect   rectToCenter        (CGRect rect,CGPoint center) {
    float width = rect.size.width;
    float height = rect.size.height;
    return CGRectMake(center.x-width/2.0f, center.y-height/2.0f, width, height);
}

static UITextField *createTextField(CGRect frame,UIFont *font,UIColor *color, UIImage *background, BOOL clearsOnBeginEditing,UIReturnKeyType returnKeyType , UITextFieldViewMode leftViewMode,int leftViewBorder) {
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.font = font;
    textField.textColor = color;
    textField.background = background;
    textField.clearsOnBeginEditing = clearsOnBeginEditing;
    textField.returnKeyType = returnKeyType;
    textField.leftViewMode = leftViewMode;
    if(leftViewBorder>0) textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftViewBorder, frame.size.height)];
    return textField;
}

static UILabel *createLabel(CGRect frame,UIFont *font,UIColor *color, NSString *text) {
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = color;
    label.font = font;
    label.text = text;
    return label;
}

static UIImage *combineImages(NSArray *images, CGSize size) {
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for(int i=0;i<images.count;i++) {
        UIImage *image = [images objectAtIndex:i];
        CGRect centerRect = rectToCenter(CGRectMake(0, 0, image.size.width, image.size.height),CGPointMake(size.width/2, size.height/2));
        if(i==0) {
            [image drawInRect:centerRect];
        }
        else {
            [image drawInRect:centerRect blendMode:kCGBlendModeNormal alpha:1.0f];
        }
    }
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

static NSArray* cutImage (UIImage* image, float x, float y) {
    if(x>0&&y>0&&image) {
        float scale = [[UIScreen mainScreen] scale];
        float width = image.size.width;
        float height = image.size.height;
        int dw = width/x*scale;
        int dh = height/y*scale;
        
        NSMutableArray *xarray = [NSMutableArray new];
        if(y>1) {
            for(int i=0;i<x;i++) {
                NSMutableArray *yarray = [NSMutableArray new];
                for(int j=0;j<y;j++) {
                    CGImageRef imgC = [image CGImage];
                    CGRect rect = CGRectMake(dw*i, dh*j, dw, dh);
                    imgC = CGImageCreateWithImageInRect(imgC, rect);
                    UIImage*img = [UIImage imageWithCGImage:imgC scale:scale orientation:UIImageOrientationUp];
                    [yarray addObject:img];
                }
                [xarray addObject:yarray];
            }
        }
        else {
            for(int i=0;i<x;i++) {
                CGImageRef imgC = [image CGImage];
                CGRect rect = CGRectMake(dw*i, 0, dw, dh);
                imgC = CGImageCreateWithImageInRect(imgC, rect);
                UIImage*img = [UIImage imageWithCGImage:imgC scale:scale orientation:UIImageOrientationUp];
                [xarray addObject:img];
            }
        }
        return xarray;
    }
    return nil;
}

static UIImage* negativeImage(UIImage *image) {
    float scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(image.size, NO, scale);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeCopy);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeDifference);
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(),[UIColor whiteColor].CGColor);
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, image.size.width, image.size.height));
    UIImage *negativeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return negativeImage;
}

static UIImage* imageWithWhiteBackground(UIImage *image) {
    UIImage *negative = negativeImage(image);
    float scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(negative.size, NO, scale);
    CGContextSetRGBFillColor (UIGraphicsGetCurrentContext(), 1, 1, 1, 1);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width = negative.size.width;
    thumbnailRect.size.height = negative.size.height;
    
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0.0, negative.size.height);
    CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1.0, -1.0);
    CGContextFillRect(UIGraphicsGetCurrentContext(), thumbnailRect);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), thumbnailRect, negative.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

static UIImage* drawCircle(CGSize size, UIColor* strokeColor, UIColor* fillColor, int lineWidth) {
    float scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    int indent = ceilf(lineWidth/2.0f);
    if(strokeColor) {
        CGContextSetLineWidth(context, lineWidth);
        CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    }
    if(fillColor) {
        CGContextSetFillColorWithColor(context, fillColor.CGColor);
    }
    CGContextAddEllipseInRect(context, CGRectMake(indent, indent, size.width-indent*2, size.height-indent*2));
    if(strokeColor && fillColor) CGContextDrawPath(context, kCGPathFillStroke);
    else if(strokeColor) CGContextDrawPath(context, kCGPathStroke);
    else if(fillColor) CGContextDrawPath(context, kCGPathFill);
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

static UIImage* colorImage(UIImage*img,CGSize size,UIColor *color, int glow) {
    
    UIImage *formattedImage = imageWithWhiteBackground(img);
    
    CGRect rect = {0, 0, formattedImage.size.width, formattedImage.size.height};
    float scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, scale);
    [color setFill];
    UIRectFill(rect);
    UIImage *tempColor = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef maskRef = [formattedImage CGImage];
    CGImageRef maskcg = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                          CGImageGetHeight(maskRef),
                                          CGImageGetBitsPerComponent(maskRef),
                                          CGImageGetBitsPerPixel(maskRef),
                                          CGImageGetBytesPerRow(maskRef),
                                          CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef maskedcg = CGImageCreateWithMask([tempColor CGImage], maskcg);
    CGImageRelease(maskcg);
    UIImage *result = [UIImage imageWithCGImage:maskedcg];
    CGImageRelease(maskedcg);
    
    if(glow) {
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, scale);;
        CGRect imageRect = CGRectMake(0,0,size.width,size.height);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetShadowWithColor(context, CGSizeMake(0,0), glow, color.CGColor);
        [result drawInRect:imageRect];
        result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return result;
    
}

static UIImage *tileImage(UIImage *image,CGSize size, float alpha) {
    float scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGImageRef imageRef = image.CGImage;
    CGRect imageRect = CGRectMake(0,0,image.size.width,image.size.height);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, alpha);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawTiledImage(context, imageRect, imageRef);
    UIImage*tiledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tiledImage;
}

static UIImage* renderImage(UIImage*img,CGSize size, bool aa,bool filtration, bool shadow, bool tile) {
    CGImageRef imageRef = img.CGImage;
    float scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGRect imageRect;
    if(tile) imageRect = CGRectMake(0,0,img.size.width/scale,img.size.height/scale);
    else imageRect = CGRectMake(0,0,size.width,size.height);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if(!filtration) CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    if(shadow) CGContextSetShadowWithColor(context, CGSizeMake(0,0), size.width/8, [UIColor colorWithRed:.3f green:.3f blue:.3f alpha:1.0f].CGColor);
    if(!aa) CGContextSetShouldAntialias(context, NO);
    if(tile) CGContextDrawTiledImage(context, imageRect, imageRef);
    else [img drawInRect:imageRect];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

static CGImageRef createMask(CGImageRef image, CGImageRef mask) {
    
    CGImageRef imageMask = CGImageMaskCreate(CGImageGetWidth(mask),
                                             CGImageGetHeight(mask),
                                             CGImageGetBitsPerComponent(mask),
                                             CGImageGetBitsPerPixel(mask),
                                             CGImageGetBytesPerRow(mask),
                                             CGImageGetDataProvider(mask),
                                             NULL,
                                             YES
                                             );
    CGImageRef maskedImage = CGImageCreateWithMask(image, imageMask);
    CGImageRelease(imageMask);
    return maskedImage;
}

static UIImage *createMaskUI(UIImage* image, UIImage* mask) {
    float scale = [[UIScreen mainScreen] scale];
    CGImageRef imageRef = image.CGImage;
    CGImageRef maskRef = mask.CGImage;
    
    CGImageRef imageMask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                             CGImageGetHeight(maskRef),
                                             CGImageGetBitsPerComponent(maskRef),
                                             CGImageGetBitsPerPixel(maskRef),
                                             CGImageGetBytesPerRow(maskRef),
                                             CGImageGetDataProvider(maskRef),
                                             NULL,
                                             YES
                                             );
    
    CGImageRef maskedImage = CGImageCreateWithMask(imageRef, imageMask);
    CGImageRelease(imageMask);
    UIImage *result = [UIImage imageWithCGImage:maskedImage scale:scale orientation:UIImageOrientationUp];
    return result;
}

static CGImageRef pointsToMask(const CGPoint *points, int count, CGPoint indent, CGSize size, BOOL revert, UIColor *color) {
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    if(revert) {
        CGContextMoveToPoint(context,points[count-1].x - indent.x, size.height - points[count-1].y + indent.y);
        CGContextAddLineToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, size.width, 0);
        CGContextAddLineToPoint(context, size.width, size.height);
        CGContextAddLineToPoint(context, 0, size.height);
        CGContextAddLineToPoint(context, points[0].x - indent.x, size.height - points[0].y + indent.y);
    }
    else {
        CGContextMoveToPoint(context,points[0].x - indent.x, size.height - points[0].y + indent.y);
    }
    
    for(int i = 1; i<count; i++) {
        CGContextAddLineToPoint(context, points[i].x - indent.x, size.height - points[i].y + indent.y);
    }
    CGContextDrawPath(context, kCGPathFill);
    
    
    UIImage*pathImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef mask = pathImage.CGImage;
    
    return mask;
}

static UIImage* pointsToMaskUI(const CGPoint *points, int count, CGPoint indent, CGSize size, BOOL revert) {
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetAllowsAntialiasing(context, NO);
    if(revert) {
        CGContextMoveToPoint(context,points[count-1].x - indent.x, size.height - points[count-1].y + indent.y);
        CGContextAddLineToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, size.width, 0);
        CGContextAddLineToPoint(context, size.width, size.height);
        CGContextAddLineToPoint(context, 0, size.height);
        CGContextAddLineToPoint(context, points[0].x - indent.x, size.height - points[0].y + indent.y);
    }
    else {
        CGContextMoveToPoint(context,points[0].x - indent.x, size.height - points[0].y + indent.y);
    }
    
    for(int i = 1; i<count; i++) {
        CGContextAddLineToPoint(context, points[i].x - indent.x, size.height - points[i].y + indent.y);
    }
    CGContextDrawPath(context, kCGPathFill);
    
    
    UIImage*pathImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return pathImage;
}

static UIImage* roundedMask(UIImage*image) {
    
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1, 1, 1, 1);
    CGContextFillEllipseInRect(context, CGRectMake(0, 0, image.size.width, image.size.height));
    UIImage*round = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(image.size);
    context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1, 1, 1, 1);
    CGContextFillRect(context, CGRectMake(0, 0, image.size.width, image.size.height));
    UIImage*rect = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *mask = createMaskUI(rect, round);
    
    
    UIImage *result = createMaskUI(image, mask);
    
    return result;
}

static UIImage* drawGrid(CGSize size, int indent, BOOL roundedFill, BOOL edges) {
    int wFirstIndent = ((int)size.width%indent)/2;
    int hFirstIndent = ((int)size.height%indent)/2;
    int w = ceilf(size.width/(float)indent);
    int h = ceilf(size.height/(float)indent);
    int centerx = size.width/2;
    int centery = size.height/2;
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(context, NO);
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);
    CGContextSetLineWidth(context, 1);
    for(int i=!edges;i<w-!edges;i++) {
        int length = centery;
        int fy = 0;
        int sy = size.width;
        int x = wFirstIndent + i*indent;
        if(roundedFill) {
            float distance = ((float)x-centerx)/(centerx-wFirstIndent);
            int angle = acosf(distance)/M_PI*180.0f;
            length = sinx[angle] * centery - 1;
            fy = centery - length;
            sy = centery + length;
        }
        CGContextMoveToPoint(context, x,fy);
        CGContextAddLineToPoint(context, x,sy);
    }
    for(int i=!edges;i<h-!edges;i++) {
        int length = centerx;
        int fx = 0;
        int sx = size.width;
        int y = hFirstIndent + i*indent;
        if(roundedFill) {
            float distance = ((float)y-centery)/(centery-hFirstIndent);
            int angle = mod(asinf(distance)/M_PI*180.0f);
            length = cosx[angle] * centerx - 1;
            fx = centerx - length;
            sx = centerx + length;
        }
        CGContextMoveToPoint(context, fx, y);
        CGContextAddLineToPoint(context, sx, y);
    }
    CGContextDrawPath(context, kCGPathStroke);
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}

static int      rdm                 (int min,int max) {
    int random = arc4random()%(int)(max-min);
    return random+min;
}
static int      normalizeAngle360   (int alpha) {
    if( alpha >= 360 )
        alpha %= 360;
    if(alpha<0)
        alpha = 360 - (-alpha) % 360;
    
    return alpha;
}
static float    normalizeAnglePi    (float angle) {
    float angle_2_PI = angle / M_2_PI;
    float newangle = (angle_2_PI - (int)angle_2_PI) * M_2_PI;
    return newangle;
}

static float findTimeToPoint(float fx,float sx, float vx) {
    return (sx-fx)/vx;
}

static CGPoint findDirection(CGPoint f,CGPoint s) {
    float dx = s.x - f.x;
    float dy = s.y - f.y;
    float dist2 = dx*dx + dy*dy;
    float x = dx/sqrtf(dist2);
    float y = dy/sqrtf(dist2);
    return CGPointMake(x, y);
}
static float findDistanse(CGPoint f,CGPoint s) {
    float dx = f.x - s.x;
    float dy = f.y - s.y;
    float dist2 = dx*dx + dy*dy;
    float distanse = sqrtf(dist2);
    
    return distanse;
}

#endif
