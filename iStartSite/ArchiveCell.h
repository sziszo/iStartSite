//
//  ArchiveCell.h
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.25..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MCSwipeTableViewCell/MCSwipeTableViewCell.h>

@interface ArchiveCell : MCSwipeTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;

@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *personLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderNrLabel;

@property (weak, nonatomic) IBOutlet UILabel *archivedAtLabel;

@end
