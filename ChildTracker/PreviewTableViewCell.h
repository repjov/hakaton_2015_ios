//
//  PreviewTableViewCell.h
//  ChildTracker
//
//  Created by dev on 21/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreviewTableViewCell : UITableViewCell

@property (strong, nonatomic) NSDictionary *listDict;
@property (strong, nonatomic) NSDictionary *videoDict;

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIImageView *image;

@end
