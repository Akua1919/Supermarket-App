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

% ����Ϊ Database ��һЩ������ʼ��Ϣ�� �Ա����
% ����ΪԱ����Ϣ
em = pro.createEmployee('boss',99999,'00000','boss','ȫ��');
em = pro.createEmployee('���հ�',66666,'12345','����','ȫ��');
em = pro.createEmployee('E1',12345,'54321','��ӪԱ','996');

% ����Ϊ��Ʒ��Ϣ
me = pro.createMerchandise('���Ŷ���ը����',11.50,5.00,'2019/12/31',100);
me = pro.createMerchandise('������ŷ�',11.50,5.00,'2019/12/31',100);
me = pro.createMerchandise('�¶�����ֻ���ȷ�',13.50,6.00,'2019/12/31',100);
me = pro.createMerchandise('����',8.00,2.00,'2019/12/31',100);
me = pro.createMerchandise('ţ��',8.00,2.50,'2019/06/06',100);
me = pro.createMerchandise('�ɿڿ���',4.00,1.00,'2019/06/22',100);
me = pro.createMerchandise('���¿���',4.00,1.00,'2019/06/30',100);
me = pro.createMerchandise('�����',4.00,0.50,'2019/06/30',100);
me = pro.createMerchandise('�ɿ���',5.00,1.50,'2019/06/30',100);
me = pro.createMerchandise('��Ƭ',7.00,2.00,'2019/06/30',100);
me = pro.createMerchandise('USB��',15.00,5.00,'2020/12/31',100);
me = pro.createMerchandise('���߰�',20.00,10.00,'2019/06/30',100);
me = pro.createMerchandise('����',8.00,5.00,'2019/06/30',100);
me = pro.createMerchandise('��ˢ',10.00,3.00,'2019/06/30',100);
