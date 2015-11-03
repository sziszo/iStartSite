//
//  ReportFactory.m
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.29..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import "ReportFactory.h"

#import "CompanyReport.h"
#import "PersonReport.h"
#import "ProjectReport.h"
#import "EmployeeReport.h"


@implementation ReportFactory

+ (id<Report>)createReportByType:(enum ReportType) reportType {
    
    id<Report> report = nil;
    
    switch (reportType) {
        case ReportTypeCompany:
            report = [[CompanyReport alloc] init];
            break;
        case ReportTypePerson:
            report = [[PersonReport alloc] init];
            break;
        case ReportTypeProject:
            report = [[ProjectReport alloc] init];
            break;
        case ReportTypeEmployee:
            report = [[EmployeeReport alloc] init];
        default:
            break;
    }
    
    return report;
}
@end
