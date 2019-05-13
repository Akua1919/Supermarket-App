classdef DatabaseProcessor < handle
    
    properties
        cashierApp
        managerApp
        receiptApp
        mloginApp
        eloginApp
        Database
    end
    
    methods
        function op=createOperation(process,status,action,object)
            op=Operation;
            a = char(status);
            op.worknumber =a(4:8);
            op.action = action;
            op.object= object;
            op.Time=datestr(now,'yyyy/mm/dd HH:MM:SS');
            process.Database.opregister(op);
            if strcmp(action,'结算')
                process.Database.updatemerchaniseList(object);
            end
        end
        
        function em=createEmployee(process,name,worknumber,password,work,worktime)
            em = Employee;
            em.name = name;
            em.worknumber = worknumber;
            em.password = password;
            em.work = work;
            em.worktime = worktime;
            process.Database.emregister(em);
        end
        
        function me=createMerchandise(process,name,price,cost,duetime,aomunt)
            me = Merchandise;
            me.name = name;
            me.price = price;
            me.cost = cost;
            me.duetime = duetime;
            me.amount = aomunt;
            process.Database.meregister(me);
        end
        
        function em=deleteEmployee(process,name,worknumber,work,worktime)
            em = Employee;
            em.name = name;
            em.worknumber = worknumber;
            em.work = work;
            em.worktime = worktime;
            process.Database.emdismiss(em);
        end
        
        function me=deleteMerchandise(process,name,price,cost,duetime,aomunt)
            me = Merchandise;
            me.name = name;
            me.price = price;
            me.cost = cost;
            me.duetime = duetime;
            me.amount = aomunt;
            process.Database.medismiss(me);
        end
        
        function updateMerchandise(process)
            tempdata = [];
            process.managerApp.GoodTable.Data = tempdata;        
            for i =1:size(process.Database.merchandiseList(:,1))
                if isempty(tempdata)
                    tempdata = {process.Database.merchandiseList(i,1).name,process.Database.merchandiseList(i,1).price,process.Database.merchandiseList(i,1).cost,process.Database.merchandiseList(i,1).duetime,process.Database.merchandiseList(i,1).amount};
                else
                    tempdata = [tempdata;{process.Database.merchandiseList(i,1).name,process.Database.merchandiseList(i,1).price,process.Database.merchandiseList(i,1).cost,process.Database.merchandiseList(i,1).duetime,process.Database.merchandiseList(i,1).amount}];
                end
            end
            process.managerApp.GoodTable.Data = tempdata;
        end   %处理过期产品
        
        function updateEmployee(process)
            tempdata = [];           
            process.managerApp.EmployeeTable.Data = tempdata;
            for i =1:size(process.Database.employeeList(:,1))
                if isempty(tempdata)
                    tempdata = {process.Database.employeeList(i,1).worknumber,process.Database.employeeList(i,1).name,process.Database.employeeList(i,1).work,process.Database.employeeList(i,1).worktime};
                else
                    tempdata = [tempdata;{process.Database.employeeList(i,1).worknumber,process.Database.employeeList(i,1).name,process.Database.employeeList(i,1).work,process.Database.employeeList(i,1).worktime}];
                end
            end
            process.managerApp.EmployeeTable.Data = tempdata;
        end
        
        function updateOperation(process)
            process.managerApp.OperationListTable.Data = [];
            if size(process.Database.operationList) == 0
                return;
            end
            
            for i =1:size(process.Database.operationList(:,1))
                process.displayOperation(process.Database.operationList(i,1));
            end
        end
        
        function managerlogin(process,worknumber,password)
            for i=1:size(process.Database.employeeList(:,1))
                if process.Database.employeeList(i,1).worknumber == worknumber && ~strcmp(process.Database.employeeList(i,1).work,'收营员')
                    if strcmp(process.Database.employeeList(i,1).password,password)
                        ma = ManagerUI;
                        process.managerApp = ma;
                        ma.DatabaseProcessor = process;
                        original = ma.Bg.Title;
                        ma.Bg.Title = strcat(original,'-',num2str(worknumber));
                        delete(process.mloginApp);
                        return;
                    end
                end
            end
            process.mloginApp.Panel_2.Visible = 1;
        end
        
        function employeelogin(process,worknumber,password)
            for i=1:size(process.Database.employeeList(:,1))
                if process.Database.employeeList(i,1).worknumber == worknumber
                    if strcmp(process.Database.employeeList(i,1).password,password)
                        ca = CashierUI;
                        process.cashierApp = ca;
                        ca.DatabaseProcessor = process;
                        original = ca.Bg.Title;
                        ca.Bg.Title = strcat(original,'-',num2str(worknumber));
                        delete(process.eloginApp);
                        return;
                    end
                end
            end
            process.eloginApp.Panel_2.Visible = 1;
        end
        
        function displayMerchandise1(process,name)
            merchandise = process.Database.displayMerchandise(name);
            process.cashierApp.price1.Value = merchandise.price;
            process.cashierApp.remaining.Value = merchandise.amount;
        end
        
        function displayMerchandise2(process,name)
            merchandise = process.Database.displayMerchandise(name);
            process.cashierApp.price1.Value = merchandise.price;
            process.cashierApp.remaining_2.Value = merchandise.amount;
        end
        
        function displayOperation(process,op)
            tempdata = process.managerApp.OperationListTable.Data;
            name = '';
            
            for i=1:size(process.Database.employeeList)
                if process.Database.employeeList(i,1).worknumber == str2double(op.worknumber)
                    name = process.Database.employeeList(i,1).name;
                end
            end
            
            if isempty(tempdata)
                switch op.action
                    case '结算'
                        b = op.object{1,1};
                        c = '...';
                        d = size(op.object(:,1));
                        d = op.object{d,4};
                        e = strcat(b,c,num2str(d));
                        tempdata = {op.worknumber,name,op.Time,op.action,e};
                    case '新进商品'
                        tempdata = {op.worknumber,name,op.Time,op.action,op.object{1,1}};
                    case '新进干员'
                        tempdata = {op.worknumber,name,op.Time,op.action,op.object{1,2}};
                    case '辞退干员'
                        tempdata = {op.worknumber,name,op.Time,op.action,op.object{1,2}};
                    case '抛弃商品'
                        tempdata = {op.worknumber,name,op.Time,op.action,op.object{1,1}};
                end
            else
                switch op.action
                    case '结算'
                        b = op.object{1,1};
                        c = '...';
                        d = size(op.object(:,1));
                        d = op.object{d,4};
                        e = strcat(b,c,num2str(d));
                        tempdata = [tempdata;{op.worknumber,name,op.Time,op.action,e}];
                    case '新进商品'
                        tempdata = [tempdata;{op.worknumber,name,op.Time,op.action,op.object{1,1}}];
                    case '新进干员'
                        tempdata = [tempdata;{op.worknumber,name,op.Time,op.action,op.object{1,2}}];
                    case '辞退干员'
                        tempdata = [tempdata;{op.worknumber,name,op.Time,op.action,op.object{1,2}}];
                    case '抛弃商品'
                        tempdata = [tempdata;{op.worknumber,name,op.Time,op.action,op.object{1,1}}];
                end
            end    
            process.managerApp.OperationListTable.Data = tempdata;
        end
        
        function displayOrder(process,od)
            re = ReceiptUI;
            process.receiptApp = re;
            re.DatabaseProcessor = process;
            process.receiptApp.Bg.Title = strcat(process.receiptApp.Bg.Title,'-',process.cashierApp.Bg.Title(4:8));
            process.receiptApp.Listtable.Data = od;
        end
        
        function enquiry(process,start,due)
            tempdata = process.managerApp.Statistic.Data;
            for i =1:size(process.Database.operationList(:,1))
                time = process.Database.operationList(i,1).Time;
                b = 1;
                a1 = time - start;
                a2 = due - time;               
                for k = 1:19
                if  a1(k) >0
                    break;
                elseif a1(k) < 0
                    b = 0;
                    break
                end
                end                
                for k = 1:19
                if  a2(k) >0
                    break;
                elseif a2(k) < 0
                    b = 0;
                    break
                end
                end
                if b == 1    
                    if isempty(tempdata)
                        good = '';
                        amount = size(process.Database.operationList(i,1).object(:,1));
                        for j =1:(amount-1)
                            good = strcat(good,process.Database.operationList(i,1).object{j,1});
                            good = strcat(good,'.');
                        end
                        tempdata = {good,process.Database.operationList(i,1).Time,process.Database.operationList(i,1).worknumber,process.Database.operationList(i,1).object{amount,4}};
                    else
                        good = '';
                        amount = size(process.Database.operationList(i,1).object(:,1));
                        for j =1:(amount-1)                            
                            good = strcat(good,process.Database.operationList(i,1).object{j,1});
                            good = strcat(good,'.');
                        end
                        tempdata = [tempdata;{good,process.Database.operationList(i,1).Time,process.Database.operationList(i,1).worknumber,process.Database.operationList(i,1).object{amount,4}}];
                    end
                end
            end
            process.managerApp.Statistic.Data = tempdata;
        end
    end
    
    
end