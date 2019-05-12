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
                end
            end
        end
        
        function price = displayPrice(DB,name)
            price = 0;
            for i = 1:size(DB.merchandiseList(:,1))
                if strcmp(DB.merchandiseList(i,1).name,name)
                    price = DB.merchandiseList(i,1).price;
                end
            end
        end
    end
end