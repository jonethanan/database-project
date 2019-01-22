set echo off
set feedback off
set verify off
set heading off

spool e:aging.txt

prompt
prompt ** Aging Report **
prompt

set linesize 300

set heading on

COLUMN Today HEADING 'Today''s Date';
select to_char(SYSDATE, 'Month dd, yyyy, Day') Today from DUAL;
prompt
prompt

ACCEPT vDays prompt 'Please enter number of days to query: '

COLUMN OrdNum HEADING 'Order Number';
COLUMN ProdDesc Heading 'Product Description';
COLUMN OrdDate HEADING 'Order Date';
COLUMN Status HEADING 'Status';
COLUMN ProdID HEADING 'Product ID';
COLUMN OrdQty HEADING 'Quantity';
COLUMN Price HEADING 'Price' format $9,999.99;
COLUMN OrderAmt HEADING 'Total' format $999,999.99;
COLUMN DAYSOPEN HEADING 'Days Open';


select OrdNum, ProdDesc, to_char(OrdDate, 'MM/DD/YYYY') OrdDate, Status, SalesOrders.ProdID, OrdQty,
	SalesOrders.Price, to_char(OrdAmt, '$99,999.99') OrderAmt, trunc(sysdate)-trunc(OrdDate) DaysOpen 
	from SalesOrders, Products where Status = 'OPEN' and '&vDays' < trunc(sysdate)-trunc(OrdDate) and SalesOrders.ProdID = Products.ProdID
	order by DaysOpen desc;

spool off



