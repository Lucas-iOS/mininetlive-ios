#import "UCloudGPUImageFilter.h"

@interface UCloudGPUImageFalseColorFilter : UCloudGPUImageFilter
{
    GLint firstColorUniform, secondColorUniform;
}

// The first and second colors specify what colors replace the dark and light areas of the image, respectively. The defaults are (0.0, 0.0, 0.5) amd (1.0, 0.0, 0.0).
@property(readwrite, nonatomic) UCloudGPUVector4 firstColor;
@property(readwrite, nonatomic) UCloudGPUVector4 secondColor;

- (void)setFirstColorRed:(GLfloat)redComponent green:(GLfloat)greenComponent blue:(GLfloat)blueComponent;
- (void)setSecondColorRed:(GLfloat)redComponent green:(GLfloat)greenComponent blue:(GLfloat)blueComponent;

@end
