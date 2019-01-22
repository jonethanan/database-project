set heading off
set feedback off
set echo off
set verify off

spool e:shipped.txt

prompt
prompt ***** UPDATE SHIPPING *****
prompt

ACCEPT vOrdNum prompt 'Please enter the Order Number: '

select 'Order Number: ' ||OrdNum from SalesOrders where OrdNum = '&vOrdNum';
prompt

select 'Order Date: ' ||OrdDate from SalesOrders where OrdNum = '&vOrdNum';

select 'Customer Number: ' || CustID from SalesOrders where SalesOrders.OrdNum = '&vOrdNum';
select '	' ||Last||', '||First from SalesOrders, Customers where SalesOrders.OrdNum = '&vOrdNum' and SalesOrders.CustID = Customers.CustID;
select '	' ||Address from SalesOrders, Customers where SalesOrders.OrdNum = '&vOrdNum' and SalesOrders.CustID = Customers.CustID;
select '	' ||City||', '||State||' '||Zip from SalesOrders, Customers where SalesOrders.OrdNum = '&vOrdNum' and SalesOrders.CustID = Customers.CustID;
select '	(' ||substr(PHONE,1,3)||') '||substr(PHONE,4,3)||'-'||substr(PHONE,7) from SalesOrders, Customers where SalesOrders.OrdNum = '&vOrdNum' and SalesOrders.CustID = Customers.CustID;
prompt

select 'Item Number: '||ProdID from SalesOrders where OrdNum = '&vOrdNum';
select '	Item Description: '||ProdDesc from SalesOrders, Products where OrdNum = '&vOrdNum' and SalesOrders.ProdID = Products.ProdID;
select '	Price: '||Price from SalesOrders where OrdNum = '&vOrdNum';
prompt

select 'Quantity Ordered: '||OrdQty from SalesOrders where OrdNum = '&vOrdNum';
select 'Amount Ordered: '||OrdAmt from SalesOrders where OrdNum = '&vOrdNum';
prompt

select 'Shipping Warehouse: '||whID from SalesOrders where OrdNum = '&vOrdNum';
select '	'||Address from SalesOrders, Warehouse where OrdNum = '&vOrdNum' and SalesOrders.whID = Warehouse.whID;
select '	'||City||', '||State||' '||Zip from SalesOrders, Warehouse where OrdNum = '&vOrdNum' and SalesOrders.whID = Warehouse.whID;
select '	(' ||substr(PHONE,1,3)||') '||substr(PHONE,4,3)||'-'||substr(PHONE,7) from SalesOrders, Warehouse where OrdNum = '&vOrdNum' and SalesOrders.whID = Warehouse.whID;
prompt

ACCEPT vShipDate prompt 'Please enter the shipping date (mm/dd/yyyy): ' 
update SalesOrders set ShipDate = to_date('&vShipDate', 'mm/dd/yyyy') where OrdNum = '&vOrdNum';

accept vShipQty prompt 'Please enter the shipping quantity: ';
update SalesOrders set ShipQty ='&vShipQty' where OrdNum = '&vOrdNum';
prompt
prompt ***************

update SalesOrders set Status = 'Shipped' where OrdNum = '&vOrdNum';
prompt Order is now ----> Shipped

select 'Date Shipped: ' || ShipDate from SalesOrders where OrdNum = '&vOrdNum';
select 'Quantity Shipped: ' ||ShipQty from SalesOrders where OrdNum = '&vOrdNum'; 
update SalesOrders set ShipAmt = (Price * ShipQty) where OrdNum = '&vOrdNum';
Select 'Amount Shipped: ' || ShipAmt from SalesOrders where OrdNum = '&vOrdNum';
prompt
commit;

update Inventory set Inv = Inv - '&vShipQty' where ProdID = (select ProdID from SalesOrders where OrdNum = '&vOrdNum');
commit;


spool off


