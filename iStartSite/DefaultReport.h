//
//  DefaultReport.h
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.29..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Report.h"

@interface DefaultReport : NSObject <Report> {
    
@protected
    NSMutableArray* _content;
    
}


@end
