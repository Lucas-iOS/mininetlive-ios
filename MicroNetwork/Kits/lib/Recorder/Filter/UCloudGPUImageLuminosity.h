#import "UCloudGPUImageAverageColor.h"

@interface UCloudGPUImageLuminosity : UCloudGPUImageAverageColor
{
    UCloudGLProgram *secondFilterProgram;
    GLint secondFilterPositionAttribute, secondFilterTextureCoordinateAttribute;
    GLint secondFilterInputTextureUniform, secondFilterInputTextureUniform2;
    GLint secondFilterTexelWidthUniform, secondFilterTexelHeightUniform;
}

// This block is called on the completion of color averaging for a frame
@property(nonatomic, copy) void(^luminosityProcessingFinishedBlock)(CGFloat luminosity, CMTime frameTime);

- (void)extractLuminosityAtFrameTime:(CMTime)frameTime;
- (void)initializeSecondaryAttributes;

@end
