//
//  NSMutableAttributedString+htmlContent.h
//  HalloVn
//
//  Created by Trung Nghiem Toan on 6/20/15.
//  Copyright (c) 2015 Khoa Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIFont+Traits.h"

@interface NSMutableAttributedString (htmlContent)
-(NSMutableAttributedString *)optimizeHTMLContentWithMinsize:(float)min;

@end
