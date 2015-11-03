//
//  MessageCell.h
//  iStartSite
//
//  Created by Szilard Antal on 2013.05.04..
//  Copyright (c) 2013 Szilard Antal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MCSwipeTableViewCell/MCSwipeTableViewCell.h>

@interface MessageCell : MCSwipeTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *senderLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *senderDateLabel;

@end
