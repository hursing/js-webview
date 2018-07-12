//
//  DefaultHandler.h
//  JsWebView
//
//  Created by liuhx on 2018/7/12.
//  Copyright © 2018 hursing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsHandler.h"

@interface DefaultHandler : NSObject <JsHandler>

+ (instancetype)sharedInstance;

@end
