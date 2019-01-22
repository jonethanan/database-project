set echo off
set feedback off
set verify off
set heading off

spool e:query.txt

prompt
prompt ** Show Order Details **
prompt

ACCEPT vOrdNum prompt 'Please enter the Order Number: '

select 'Order Number: ' ||OrdNum from SalesOrders where OrdNum = '&vOrdNum';
select 'Order Status: ' ||Status from SalesOrders where OrdNum = '&vOrdNum';
prompt

select 'Customer Number: ' || CustID from SalesOrders where SalesOrders.OrdNum = '&vOrdNum';
select '	' ||Last||', '||First from SalesOrders, Customers where SalesOrders.OrdNum = '&vOrdNum' and SalesOrders.CustID = Customers.CustID;
select '	' ||Address from SalesOrders, Customers where SalesOrders.OrdNum = '&vOrdNum' and SalesOrders.CustID = Customers.CustID;
select '	' ||City||', '||State||' '||Zip from SalesOrders, Customers where SalesOrders.OrdNum = '&vOrdNum' and SalesOrders.CustID = Customers.CustID;
select '	(' ||substr(PHONE,1,3)||') '||substr(PHONE,4,3)||'-'||substr(PHONE,7) from SalesOrders, Customers where SalesOrders.OrdNum = '&vOrdNum' and SalesOrders.CustID = Customers.CustID;

select 'Item Number: '||ProdID from SalesOrders where OrdNum = '&vOrdNum';
select '	Item Description: '||ProdDesc from SalesOrders, Products where OrdNum = '&vOrdNum' and SalesOrders.ProdID = Products.ProdID;
select '	Price: '||Price from SalesOrders where OrdNum = '&vOrdNum';
prompt

select 'Order Date: '||OrdDate from SalesOrders where OrdNum = '&vOrdNum';
select 'Ship Date: '||ShipDate from SalesOrders where OrdNum = '&vOrdNum';
prompt

select 'Quantity Ordered: '||OrdQty from SalesOrders where OrdNum = '&vOrdNum';
select 'Amount Ordered: '||OrdAmt from SalesOrders where OrdNum = '&vOrdNum';
select 'Quantity Shipped: '||ShipQty from SalesOrders where OrdNum = '&vOrdNum';
select 'Amount Shipped: '||ShipAmt from SalesOrders where OrdNum = '&vOrdNum';
prompt

select 'Shipping Warehouse: '||whID from SalesOrders where OrdNum = '&vOrdNum';
select '	'||Address from SalesOrders, Warehouse where OrdNum = '&vOrdNum' and SalesOrders.whID = Warehouse.whID;
select '	'||City||', '||State||' '||Zip from SalesOrders, Warehouse where OrdNum = '&vOrdNum' and SalesOrders.whID = Warehouse.whID;
select '	(' ||substr(PHONE,1,3)||') '||substr(PHONE,4,3)||'-'||substr(PHONE,7) from SalesOrders, Warehouse where OrdNum = '&vOrdNum' and SalesOrders.whID = Warehouse.whID;

spool off
