//
//  deliveryRecordViewController.m
//  project01
//
//  Created by 冷锐鹏 on 2022/3/21.
//

#import "deliveryRecordViewController.h"
#import "DataLoader.h"
#import "ListItem.h"
#import "TableViewCell.h"
@interface deliveryRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong,readwrite)UITableView *tableView;
@property(nonatomic,strong,readwrite)DataLoader *dataLoader;
@property(nonatomic,strong,readwrite)NSArray *dataArray;
@end

@implementation deliveryRecordViewController

-(instancetype)init{
    if ([super init]) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //_tableView.backgroundColor = [UIColor greenColor];
    self.dataLoader = [[DataLoader alloc]init];
    //从数据库获取数据
    __weak typeof(self)weakSelf = self;
    [self.dataLoader loadListData2WithFinishBlock:^(BOOL success, NSArray<ListItem *> *dataArray) {
        __strong typeof(self)strongSelf = weakSelf;
        strongSelf.dataArray = dataArray;
        [strongSelf.tableView reloadData];
    }];
    
    //_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if(!cell){
        //然后使用if判断，如果复用回收池没有cell，那么就新创建一个cell。
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        //cell.delegate = self;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell layoutWithItem:[_dataArray objectAtIndex:indexPath.item]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (197.5/667)* [UIScreen mainScreen].bounds.size.height;
}
@end
