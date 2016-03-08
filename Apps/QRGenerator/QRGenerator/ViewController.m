//
//  ViewController.m
//  QRGenerator
//
//  Created by Rosario Conti on 07/03/16.
//
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *iv;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _iv.image = [self qrCodeImageWithContents:@"prova testo" andFrame:CGRectMake(0, 0, 640, 480)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)qrCodeImageWithContents:(NSString *)contents andFrame:(CGRect)frame
{
    @autoreleasepool {
        NSData *stringData = [contents dataUsingEncoding:NSISOLatin1StringEncoding];
        CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        [qrFilter setDefaults];
        [qrFilter setValue:stringData forKey:@"inputMessage"];
        
        CGFloat widthScale = frame.size.width / qrFilter.outputImage.extent.size.width;
        CGFloat heightScale = frame.size.height / qrFilter.outputImage.extent.size.height;
        
        CGAffineTransform transform = CGAffineTransformMakeScale(widthScale, heightScale);
        CIImage *output = [qrFilter.outputImage imageByApplyingTransform: transform];
        CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:output fromRect:[output extent]];
        UIImage *image = [UIImage imageWithCGImage:cgImage scale:1. orientation:UIImageOrientationUp];
        CGImageRelease(cgImage);
        return image;
    }
}

@end
