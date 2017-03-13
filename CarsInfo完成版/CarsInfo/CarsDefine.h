//
//  CarsDefine.h
//  CarsInfo
//
//  Created by qianfeng000 on 15/9/18.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#ifndef CarsInfo_CarsDefine_h
#define CarsInfo_CarsDefine_h


#define kScreenSize   [UIScreen mainScreen].bounds.size
#define kScreenWidth  kScreenSize.width
#define kScreenHeight kScreenSize.height

//新闻
#define kMainNews @"http://sitemap.chexun.com/chexun/getDataIntoJson.do?category=1&page=%d_%d"

//导购
#define KMainShoping_Url @"http://sitemap.chexun.com/chexun/getDataIntoJson.do?category=3&page=%d_%d"

//导购详情
#define KMainDes_Url @"http://wap.tool.chexun.com/API/GetNewsDetail.ashx?id=102676437"
//评价
#define KMainEvaluation_Url @"http://sitemap.chexun.com/chexun/getDataIntoJson.do?category=2&page=%d_%d"



//车型
#define ModelCar_Url @"http://api.tool.chexun.com/mobile/downBrandInfo.do"
//按品牌选车
#define PinPaiCar_Url @"http://api.tool.chexun.com/mobile/downSeriesInfo.do?brandId=%@"
#define TypeCarDesc @"http://auto.chexun.com/public/companyModelJsonForApp/load.do?id=%@"

//按条件选车
#define SelectCar_Url @"http://api.tool.chexun.com/mobile/downSeriesInfo.do?brandId=46"


//拆车坊
#define DissovleCar_Url @" http://sitemap.chexun.com/m/ccvideojson.do?count=6&page=2"

//拆车坊文章
#define DissovleWZCar_Url @"http://sitemap.chexun.com/m/ccfnewsjson.do?count=10&page=1"

//拆车坊文章2
#define DissovleWZ_Url @"http://wap.tool.chexun.com/API/GetNewsDetail.ashx?id=102655327"

//拆车坊视频
#define DissovleVideo_Url @"http://sitemap.chexun.com/m/ccvideojson.do?count=6&page=1"

//拆车坊视频2
#define DissovleVideoCar_Url @"http://sitemap.chexun.com/m/videonewsjson.do?id=102654196"

//图片美女车模
#define PictrueModelCar_Url @"http://api.tool.chexun.com/mobile/downEventAlbumList.do?type=3"

//图片
#define PictrueCar_Url @"http://m.chexun.com/coopdata/www_content4.inc"



//拆车坊
#define DissovleCar_Url @"http://sitemap.chexun.com/chexun/getDataIntoJson.do?category=1&page=2_2"



//介绍
#define Include_Url @"http://auto.chexun.com/public/companyModelJsonForApp/load.do?id=103425"

//按价格选
#define SelectPriceCar_Url @"http://app.api.autohome.com.cn/autov4.4/cars/brandsdealer-a2-pm2-v4.4.0-ts0.html"


//热门推荐
#define HotViewController_Url @"http://api.tool.chexun.com/mobile/downMobileClientProgramInfo.do?type=2"

//车型1
#define CarModel_Url @"http://api.tool.chexun.com/mobile/downSeriesInfo.do?priceInterval=1"

//车型2
#define CarModel2_Url @"http://auto.chexun.com/public/companyModelJsonForApp/load.do?id=104660";

//车型3
#define CarModel3_Url @"http://api.tool.chexun.com/mobile/downSeriesInfo.do?priceInterval=1&level=100020"



#endif
