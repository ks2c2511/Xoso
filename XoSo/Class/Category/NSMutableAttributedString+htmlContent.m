//
//  NSMutableAttributedString+htmlContent.m
//  HalloVn
//
//  Created by Trung Nghiem Toan on 6/20/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import "NSMutableAttributedString+htmlContent.h"
#import <UIKit/UIKit.h>

@implementation NSMutableAttributedString (htmlContent)

-(NSMutableAttributedString *)optimizeHTMLContentWithMinsize:(float)min{
    [self beginEditing];
    [self enumerateAttribute:NSFontAttributeName
                    inRange:NSMakeRange(0, self.length)
                    options:0
                 usingBlock: ^(id value, NSRange range, BOOL *stop) {
                     if (value) {
                         UIFont *oldFont = (UIFont *)value;

                         
                         NSString *familyName;
                         if (oldFont.isBold && oldFont.isItalic) {
                             familyName = @"HelveticaNeue-BoldItalic";
                         }
                         else if (oldFont.isBold){
                             familyName = @"HelveticaNeue-Bold";
                         }
                         else if (oldFont.isItalic){
                             familyName = @"HelveticaNeue-Italic";
                         }
                         else{
                             familyName = @"HelveticaNeue";
                         }
                         UIFont *newFont  = [UIFont fontWithName:familyName size:oldFont.pointSize];
                         
                         if (newFont.pointSize < 14) {
                             newFont = [newFont fontWithSize:14];
                             if (newFont == nil) {
                                 newFont = [UIFont systemFontOfSize:14];
                             }
                             [self addAttribute:NSFontAttributeName value:newFont range:range];
                         }
                     }
                 }];
    [self endEditing];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.lineSpacing = 3;
//    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
    
    return self;
}

@end
