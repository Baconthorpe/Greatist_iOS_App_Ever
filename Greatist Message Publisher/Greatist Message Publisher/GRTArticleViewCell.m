//
//  GRTArticleViewCell.m
//  Greatist Message Publisher
//
//  Created by Anne Lindsley on 4/7/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTArticleViewCell.h"

#import "Article+Methods.h"


@implementation GRTArticleViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



+ (instancetype) cellConfiguredWithArticle: (Article *)article
{
    GRTArticleViewCell *cell = [GRTArticleViewCell new];
    [cell configureWithPost:nil];
    return cell;
}




- (instancetype) configureWithArticle: (Article *)article
{
    
    self.article= article;
    self.postLabel.text=self.article.headline;
    
    self.postLabel.font = [UIFont fontWithName:@"ArcherPro-Medium" size:18];
    NSLog(@"checking configurewithpost");
    NSString *grow = @"grow";
    
    self.postLabel.textColor = [UIColor blackColor];
    
    
    
    
    // self.articleLabel.tintColor = [UIColor greatistColorForCategory:(@"%@", grow)];
//    
//    NSString *imageUrl = @"http://greatist.com/sites/default/files/wp-content/uploads/2012/02/Microwave_NFS_featured.jpg";
//    // replace image url with real data once api is finished
//    
//    
//    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        self.featuredArticleImage.image = [UIImage imageWithData:data];}];
    
    
    
    return self;
}




@end
