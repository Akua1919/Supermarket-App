close all
clear all 
db=Database;
pro=DatabaseProcessor;
ml = ManagerLoginUI;
el = EmployeeLoginUI;
 
pro.Database=db;
pro.mloginApp = ml;
pro.eloginApp = el;

ml.DatabaseProcessor = pro;
el.DatabaseProcessor = pro;
db.processor=pro;

% 以下为 Database 的一些基本初始信息， 以便测试
% 以下为员工信息
em = pro.createEmployee('boss',99999,'00000','boss','全天');
em = pro.createEmployee('夏苏安',66666,'12345','经理','全天');
em = pro.createEmployee('E1',12345,'54321','收营员','996');

% 以下为商品信息
me = pro.createMerchandise('麻婆豆腐炸鸡饭',11.50,5.00,'2019/12/31',100);
me = pro.createMerchandise('咖喱猪排饭',11.50,5.00,'2019/12/31',100);
me = pro.createMerchandise('奥尔良整只鸡腿饭',13.50,6.00,'2019/12/31',100);
me = pro.createMerchandise('咖啡',8.00,2.00,'2019/12/31',100);
me = pro.createMerchandise('牛奶',8.00,2.50,'2019/06/06',100);
me = pro.createMerchandise('可口可乐',4.00,1.00,'2019/06/22',100);
me = pro.createMerchandise('百事可乐',4.00,1.00,'2019/06/30',100);
me = pro.createMerchandise('冰红茶',4.00,0.50,'2019/06/30',100);
me = pro.createMerchandise('巧克力',5.00,1.50,'2019/06/30',100);
me = pro.createMerchandise('薯片',7.00,2.00,'2019/06/30',100);
me = pro.createMerchandise('USB线',15.00,5.00,'2020/12/31',100);
me = pro.createMerchandise('接线板',20.00,10.00,'2019/06/30',100);
me = pro.createMerchandise('牙膏',8.00,5.00,'2019/06/30',100);
me = pro.createMerchandise('牙刷',10.00,3.00,'2019/06/30',100);
