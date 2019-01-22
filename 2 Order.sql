set heading off
set feedback off
set echo off
set verify off

prompt
prompt ****** Place an Order ********
prompt

spool e:order.txt

create table new1 as select ProdID, Price from Products;

select sysdate from dual;
prompt;

accept vCustID prompt 'Please enter the customer number: '
select '	Customer Name: ' ||Last||', '||First from Customers where CustID = '&vCustID';
select '	Shipping Address: ' || Address from Customers where CustID = '&vCustID';
select '	City, State, Zip: ' ||City||', '||State||' '||Zip from Customers where CustID = '&vCustID';
select '	Phone: (' ||substr(PHONE,1,3)||') '||substr(PHONE,4,3)||'-'||substr(PHONE,7) from Customers where CustID = '&vCustID';
prompt

accept vProdID prompt 'Enter the item number: '
select '	Item Number: ' ||ProdID from Products where ProdID = '&vProdID';
select '	Item Description: ' ||ProdDesc from Products where ProdID = '&vProdID';
select '	Unit Price: ' || Price from Products where ProdID = '&vProdID';
prompt

accept vOrdQty prompt 'Enter the quantity ordered: '
select '	Amount ordered: ' ||Price * '&vOrdQty' OrdAmt from Products where ProdID = '&vProdID';
prompt

commit;

set heading on
prompt 'Please choose from the following warehouses: '
prompt
select Warehouse.whID, Warehouse.City, Warehouse.State, Inventory.Inv from Warehouse, Inventory where Warehouse.whID = Inventory.whID and Inventory.ProdID = '&vProdID';
prompt
accept vWhID prompt 'Enter the warehouse Code: '
prompt

insert into SalesOrders (OrdNum, Status, OrdDate, CustID, ProdID, whID, OrdQty, Price, OrdAmt) select maxnum, 'OPEN', sysdate, '&vCustID', '&vProdID',
			'&vWhID', '&vOrdQty', Price, Price * '&vOrdQty' from counter, new1 where new1.ProdID = '&vProdID';

commit;

update counter set MAXNUM = MAXNUM + 1;

set heading off

select '***** Order Status: ' || Status from SalesOrders, counter where SalesOrders.OrdNum = counter.maxnum - 1;

select '***** Order Number: ' || OrdNum from SalesOrders, counter where SalesOrders.OrdNum = counter.maxnum - 1;

prompt

drop table new1;

commit;

spool off




