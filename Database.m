classdef Database < handle
    
    properties
        operationList
        employeeList
        merchandiseList
        processor
    end
    
    methods
        function opregister(DB,operation)
            DB.operationList=[DB.operationList;operation];
        end
        
        function emregister(DB,employee)
            DB.employeeList=[DB.employeeList;employee];
        end
        
        function meregister(DB,merchandise)
            DB.merchandiseList=[DB.merchandiseList;merchandise];
        end
        
        function emdismiss(DB,employee)
            for i = 1:size(DB.employeeList(:,1))
                if DB.employeeList(i,1).worknumber == employee.worknumber
                    DB.employeeList(i,:) = [];
                end
            end
        end
        
        function medismiss(DB,merchandise)
            for i = 1:size(DB.merchandiseList(:,1))
                if DB.merchandiseList(i,1).duetime == merchandise.duetime
                    DB.merchandiseList(i,:) = [];
                    break;
                end
            end
        end
        
        function updatemerchaniseList(DB,od)
            for i = 1:(size(od(:,1))-1)
                for j = 1:size(DB.merchandiseList(:,1))
                    if strcmp(od{i,1},DB.merchandiseList(j,1).name)
                     DB.merchandiseList(j,1).amount = DB.merchandiseList(j,1).amount - od{i,2};
                     if DB.merchandiseList(j,1).amount <= 0
                         DB.merchandiseList(j,:) = [];
                     end
                    end
                    break;
                end
            end
        end
        
        function merchandise = displayMerchandise(DB,name)
            merchandise = Merchandise;
            merchandise.price = 0;
            merchandise.amount = 0;
            for i = 1:size(DB.merchandiseList(:,1))
                if strcmp(DB.merchandiseList(i,1).name,name)
                    merchandise = DB.merchandiseList(i,1);
                end
            end
        end
        
    end
end