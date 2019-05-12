# Supermarket-App
A simple supermarket app

简介：
这个系统共有两个主要UI，一个是Employee的UI，主要是login和cash；另一个是Manager的UI，主要是login，商品的采购，人员的调动，任意时间段内的经济的报告和操作的历史记录。
Database主要记录三个内容，一个是库存的商品，包括数量，价格和成本；另一个是人员的信息，包括工号，登录UI用的密码，姓名，职位，工作时间；最后一个是各项操作的历史记录，包括收银交易，人员的辞退和招募，商品的进货和丢弃情况，每一种情况都及记录了发生的时间，负责人的工号是多少，干了什么，都有哪些对象。

说明：
EmployeeLoginUI——————员工登录UI       ManagerLoginUI——————管理人员的登录UI
CashierUI————————————员工收银的UI     ManagerUI———————————管理人员操作的UI
ReceiptUI————————————结账时小票的UI

Database—————————————数据库，以类的形式的存储三类数据
DatabasePrecessor————连接数据库与UI的的处理软件，负责交换信息

Merchandise——————————商品类
Employee—————————————员工类
Operation————————————操作类

Supermarket——————————Requirement
reference————————————UI界面设计的参考
