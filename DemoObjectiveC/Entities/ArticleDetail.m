//
//  ArticleDetail.m
//  Favor
//
//  Created by DUCDM on 6/10/15.
//  Copyright (c) 2015 pape. All rights reserved.
//

#import "ArticleDetail.h"
#import "ArticleComment.h"
#import "UserArticleE.h"
@implementation ArticleDetail

+(instancetype)articleDetail{
    return [[self alloc] init];
}


-(void)parseData:(NSDictionary *) data{
    [self parseThisArticleData:[data objectForKey:@"this_article"]];    
    NSMutableArray *arrProduct = [NSMutableArray array];
    if ([data objectForKey:@"product"] != [NSNull null] && [[data objectForKey:@"product"] count] > 0) {
//        NSDictionary *productData = [[data objectForKey:@"product"] firstObject];
        for (NSDictionary *productData in [data objectForKey:@"product"]) {
            ETProduct *product = [ETProduct product];
            product.prdId = [Util intValueForKey:@"id" fromDict:productData];
            product.prdName = [Util stringValueForKey:@"name" fromDict:productData];
            product.imageURL = [Util stringValueForKey:@"image" fromDict:productData];
            Brand *brand = [Brand brand];
            [brand parseData:[productData objectForKey:@"brand"]];
            product.brand = brand;
            ETCategory *category = [ETCategory etcategory];
            [category parseData:[productData objectForKey:@"big_category"]];
            product.category = category;
            product.rating =[Util floatValueForKey:@"rating" fromDict:productData];
            product.variations = [productData objectForKey:@"product_variations"];
            product.productURL = [Util stringValueForKey:@"product_url" fromDict:productData];
            product.urlType = ([Util intValueForKey:@"type_url" fromDict:productData] != 2)?SitePublic:OnlineStore;
            [arrProduct addObject:product];
        }
    }
    _relativeProducts = [NSArray arrayWithArray:arrProduct];
    NSMutableArray *arrSameAuthorArticle = [NSMutableArray array];
    for (NSDictionary *article in [data objectForKey:@"same_author"]) {
        ArticleE *articleE = [ArticleE article];
        articleE.articleId = [Util intValueForKey:@"id" fromDict:article];
        articleE.authorAvatar = [Util stringValueForKey:@"author_avatar" fromDict:article];
        articleE.authorName =[Util stringValueForKey:@"author_name" fromDict:article];
        articleE.imageURL =[Util stringValueForKey:@"image" fromDict:article];
        articleE.title =[Util stringValueForKey:@"name" fromDict:article];
        articleE.rating = [Util floatValueForKey:@"rating" fromDict:article];
        articleE.like = [Util intValueForKey:@"number_like" fromDict:article];
        [arrSameAuthorArticle addObject:articleE];
    }
    _sameAuthorArticle = [NSArray arrayWithArray:arrSameAuthorArticle];
    if ([data objectForKey:@"last_article"] != [NSNull null] && [[data objectForKey:@"last_article"] objectForKey:@"id"]) {
        if (_isUserArticle) {
            _prevUserArticle = [UserArticleE userArticle];
            [_prevUserArticle parseData:[data objectForKey:@"last_article"]];
        }else{
            _prevArticle = [[ArticleE alloc] init];
            [_prevArticle parseData:[data objectForKey:@"last_article"]];
            _prevArticle.authorName = [Util stringValueForKey:@"user_name" fromDict:[data objectForKey:@"last_article"]];
            _prevArticle.authorAvatar = [Util stringValueForKey:@"user_avatar" fromDict:[data objectForKey:@"last_article"]];
        }
        
    }
    
    if ([data objectForKey:@"next_article"] != [NSNull null] && [[data objectForKey:@"next_article"] objectForKey:@"id"]) {
        if (_isUserArticle) {
            _nextUserArticle = [UserArticleE userArticle];
            [_nextUserArticle parseData:[data objectForKey:@"next_article"]];
        }else{
            _nextArticle = [[ArticleE alloc] init];
            [_nextArticle parseData:[data objectForKey:@"next_article"]];
            _nextArticle.authorName = [Util stringValueForKey:@"user_name" fromDict:[data objectForKey:@"next_article"]];
            _nextArticle.authorAvatar = [Util stringValueForKey:@"user_avatar" fromDict:[data objectForKey:@"next_article"]];
        }
    }
    
    _tags = [[NSMutableArray alloc] init];
    NSMutableString *tagString = [[NSMutableString alloc] initWithString:@""];
    for(NSDictionary *tag in [data objectForKey:@"tagged"]){
        ETTag *tagE = [ETTag tag];
        tagE.tagId = [Util intValueForKey:@"tag_id" fromDict:tag];
        tagE.name = [Util stringValueForKey:@"tag_name" fromDict:tag];
        NSString *type = [Util stringValueForKey:@"type" fromDict:tag];
        if ([type isEqualToString:@"brand"]) {
            tagE.type = BrandTag;
        }else if([type isEqualToString:@"category"]){
            tagE.type = CategoryTag;
        }else if([type isEqualToString:@"special"]){
            tagE.type = SpecialTag;
        }else{
            tagE.type = OtherTag;
        }
        [_tags addObject:tagE];
        [tagString appendString:[NSString stringWithFormat:@" #%@", tagE.name]];
    }
    _tagString = tagString;
    _relatedArticles = [[NSMutableArray alloc] init];
    
    for(NSDictionary *tagBlock in [data objectForKey:@"related_articles"]){
        if ([tagBlock isEqual:[NSNull null]]) {
            continue;
        }
        
        ETTag *tag = [ETTag tag];
        [tag parseData:[tagBlock objectForKey:@"tag"]];
        
        NSMutableArray *articleList = [[NSMutableArray alloc] init];
        
        for(NSDictionary *articleInfos in [tagBlock objectForKey:@"articles"]){
            
            ArticleE *article = [ArticleE article];
            [article parseData:articleInfos];
            [articleList addObject:article];
        }
        
        NSDictionary *relatedArticle = [[NSDictionary alloc] initWithObjectsAndKeys:tag, @"tag", articleList, @"articles", nil];
        [_relatedArticles addObject:relatedArticle];
    }
    
    _relatedArticlesUser = [[NSMutableArray alloc] init];
    
    for(NSDictionary *tagUserBlock in [data objectForKey:@"related_articles_user"]){
        if ([tagUserBlock isEqual:[NSNull null]]) {
            continue;
        }
        
        ETTag *tag = [ETTag tag];
        [tag parseData:[tagUserBlock objectForKey:@"tag"]];
        
        NSMutableArray *articleList = [[NSMutableArray alloc] init];
        
        for(NSDictionary *articleInfos in [tagUserBlock objectForKey:@"articles"]){
            
            UserArticleE *article = [UserArticleE userArticle];
            [article parseData:articleInfos];
            [articleList addObject:article];
        }
        if (articleList.count > 0) {
            NSDictionary *relatedArticle = [[NSDictionary alloc] initWithObjectsAndKeys:tag, @"tag", articleList, @"articles", nil];
            [_relatedArticlesUser addObject:relatedArticle];
        }
    }
    
    [self parseComments:[data objectForKey:@"comments"]];
    [self parseSameComesticWriterArticle:data];
    [self parseSameComesticUserArticle:data];
    
    _breadCrumb = [BreadCrumbE breadCumb];
    [_breadCrumb parseData:[data objectForKey:@"breadcrumb"]];
    _breadCrumb.subject = _title;
    //Parse Ad Article boost
    if ([data objectForKey:@"ad_article_boost"]) {
        ArticleE *adArt = [[ArticleE alloc] init];
        [adArt parseData:[data objectForKey:@"ad_article_boost"]];
        if (adArt.articleId>0) {
            _adArticle = adArt;
        }else{
            _adArticle = nil;
        }
    }
}

-(void)parseSameComesticWriterArticle:(NSDictionary *)data{
    NSMutableArray *sameWriterList = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in [[data objectForKey:@"same_articles_writer_product"] objectForKey:@"articles"]) {
        ArticleE *article = [ArticleE article];
        [article fillData:dic];
//        article.authorAvatar = [Util stringValueForKey:@"avatar" fromDict:dic];
//        article.authorName = [Util stringValueForKey:@"user_name" fromDict:dic];
        [sameWriterList addObject:article];
    }
    BOOL isLoadMore = NO;
    if ([[[data objectForKey:@"same_articles_writer_product"] objectForKey:@"total"] intValue] > 4) {
        isLoadMore = YES;
    }
    _sameWriterArticles = [[NSMutableDictionary alloc] initWithObjectsAndKeys:sameWriterList,@"articles",[NSNumber numberWithBool:isLoadMore],@"isLoadMore", nil];
}

-(void)parseSameComesticUserArticle:(NSDictionary *)data{
    NSMutableArray *sameUserList = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in [[data objectForKey:@"same_articles_user_product"] objectForKey:@"articles"]) {
        UserArticleE *article = [UserArticleE userArticle];
        [article fillData:dic];
        [sameUserList addObject:article];
    }
    BOOL isLoadMore = NO;
    int total = [[[data objectForKey:@"same_articles_user_product"] objectForKey:@"total"] intValue];
    if (total > 5) {
        isLoadMore = YES;
    }
    _sameUserArticles = [[NSMutableDictionary alloc] initWithObjectsAndKeys:sameUserList,@"articles",[NSNumber numberWithBool:isLoadMore],@"isLoadMore", [NSNumber numberWithInt:total], @"total", nil];
}

- (void)parseThisArticleData:(NSDictionary *)data
{
    
    self.youtube_url = [Util stringValueForKey:@"youtube_url" fromDict:data];
    self.isYoutube = [Util intValueForKey:@"youtube_video" fromDict:data] == 1;
    self.articleId = [Util intValueForKey:@"id" fromDict:data];
    self.title = [Util stringValueForKey:@"title" fromDict:data];
    self.lead = [Util stringValueForKey:@"lead" fromDict:data];
    self.imageURL = [Util stringValueForKey:@"image" fromDict:data];
    self.body = [Util stringValueForKey:@"body" fromDict:data];
    self.shortenURL = [Util stringValueForKey:@"shorten_url" fromDict:data];
    self.publishedAt = [Util stringValueForKey:@"published_at" fromDict:data];
    self.author = [Author author];
    self.thumbnailURL = [Util stringValueForKey:@"list_image" fromDict:data];
    for (NSDictionary *value in [data objectForKey:@"authors"]) {
        [self.author parseData:value];
    }
    self.video = [Util intValueForKey:@"video" fromDict:data] == 1;
    self.ratio = [Util intValueForKey:@"ratio" fromDict:data];
    self.likeNumer = [Util intValueForKey:@"favorite" fromDict:data];
    self.commentNumer = [Util intValueForKey:@"comment" fromDict:data];
    self.isLike = [Util intValueForKey:@"current_user_favorited" fromDict:data] == 1;
    if ([[Util stringValueForKey:@"type" fromDict:data] isEqualToString:@"user"]) {
        self.isUserArticle = YES;
        [self parseProductData:data];
    }else{
        self.isUserArticle = NO;
    }
    self.isCuration = [Util intValueForKey:@"curation" fromDict:data];
    self.typeArticle = [Util intValueForKey:@"type_writer" fromDict:data];
    if ([data objectForKey:@"bookmark"]) {
        self.isBookmark = [Util intValueForKey:@"bookmark" fromDict:data] == 1;
    }
}

-(void)parseProductData:(NSDictionary *)data{
    NSDictionary *productDic = [data objectForKey:@"tag_product"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *brandDic in [productDic objectForKey:@"brands"]) {
        Brand *brand = [Brand brand];
        brand.brandId = [Util intValueForKey:@"brand_id" fromDict:brandDic];
        brand.name = [Util stringValueForKey:@"brand_name" fromDict:brandDic];
        [array addObject:brand];
    }
    if (array.count > 0) {
        self.productBrand = [NSArray arrayWithArray:array];
    }
    array = [NSMutableArray array];
    for (NSDictionary *catDic in [productDic objectForKey:@"categories"]) {
        ETCategory *cat = [ETCategory etcategory];
        cat.catId = [Util intValueForKey:@"category_id" fromDict:catDic];
        cat.catName = [Util stringValueForKey:@"category_name" fromDict:catDic];
        [array addObject:cat];
    }
    if (array.count > 0) {
        self.productCat = [NSArray arrayWithArray:array];
    }
    array = [NSMutableArray array];
    for (NSDictionary *prdDic in [productDic objectForKey:@"products"]) {
        ETProduct *prd = [ETProduct product];
        prd.prdId = [Util intValueForKey:@"product_id" fromDict:prdDic];
        prd.prdName = [Util stringValueForKey:@"product_name" fromDict:prdDic];
        [array addObject:prd];
    }
    if (array.count > 0) {
        self.product = [NSArray arrayWithArray:array];
    }
    if (([productDic objectForKey:@"rating"]  == [NSNull null]) || ![productDic objectForKey:@"rating"]) {
        self.rating = 0;
    }else{
         self.rating = [[productDic objectForKey:@"rating"] floatValue];
    }
   
}

- (void)parseComments:(NSArray *)comments{
    NSMutableArray *all = [NSMutableArray array];
    for (NSDictionary *data in comments) {
        ArticleComment *comment = [[ArticleComment alloc] init];
        [comment parseData:data];
        [all addObject:comment];
    }
    _articleComments = [NSArray arrayWithArray:all];
}

-(NSString *)description{
    return [NSString stringWithFormat:@"articleId: %d\ntitle: %@\nlead: %@\nimageURL: %@\nbody: %@\nauthor: %@",self.articleId, self.title,self.lead,self.imageURL,self.body,self.author.description];
}

@end
