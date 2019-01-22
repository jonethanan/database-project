set echo off
set feedback off
set verify off
set heading off

spool e:salesreport.txt

prompt
prompt ***** Sales report *****

set heading on

set linesize 300

COLUMN ProdID HEADING 'Product ID';
COLUMN ProdDesc Heading 'Product Description';
COLUMN OrdMonth HEADING 'Month';
COLUMN count(OrdNum) HEADING 'No. of Orders';
COLUMN sum(OrdQty) HEADING 'Total Units';
COLUMN Ord_Amt HEADING 'Total';

select SalesOrders.ProdID, ProdDesc, to_char(OrdDate, 'MM-YYYY') OrdMonth, count(OrdNum), sum(OrdQty), to_char(sum(OrdAmt), '$99,999.99') Ord_Amt
	from SalesOrders, Products where SalesOrders.ProdID = Products.ProdID
	group by SalesOrders.ProdID, Products.ProdDesc, to_char(OrdDate, 'MM-YYYY')
	order by SalesOrders.ProdID;

spool off