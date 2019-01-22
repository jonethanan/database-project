set echo on

spool e:setup.txt

drop table Counter;
drop table SalesOrders;
drop table Inventory;
drop table Warehouse;
drop table Products;
drop table Customers;

create table Customers (CustID varchar2(5), Last varchar2(20), First varchar2(20),
			Address varchar2 (30), City varchar2 (20), State char (2),
			Zip Number(5), Phone varchar2(17), primary key (CustID));

create table Products (ProdID Number(3), ProdDesc varchar2(30), Price varchar2(6),
			primary key (ProdID));

create table Warehouse (whID varchar2(5), Address varchar2 (30), City varchar2(20),
			State varchar2(13), ZIP char(5), Phone varchar2(17), primary key (whID));

create table Inventory (whID varchar2(5), ProdID Number(3), Inv varchar2(5),
			primary key (whID, ProdID),
			constraint In1 foreign key (whID) references Warehouse (whID),
			constraint In2 foreign key (ProdID) references Products (ProdID));

create table SalesOrders (OrdNum Number(5), Status Varchar2(10), OrdDate DATE, CustID varchar2(5), ProdID Number(3), whID varchar2(5), OrdQty varchar2 (5),
			Price varchar2(6), OrdAmt varchar2(10), ShipDate DATE, ShipQty varchar2(5), ShipAmt varchar2(10), 
			constraint Or1 foreign key (CustID) references Customers (CustID),
			constraint Or2 foreign key (ProdID) references Products (ProdID),
			constraint Or3 foreign key (whID) references Warehouse (whID));

create table Counter (MAXNUM number(5));

insert into Customers values ('1', 'Allen', 'Jonathan', '12345 Melody Lane', 'Garden Grove', 'CA', '92840', '7145326912');
insert into Customers values ('2', 'Thompson', 'Nathan', '34123 Test Lane', 'Garden Grove', 'CA', '92841', '7142120943');
insert into Customers values ('3', 'Clark', 'Steve', '10023 Jolene Ave', 'Anaheim', 'CA', '92801', '7140638734');

insert into Products values ('101', 'Pen', '1.50');
insert into Products values ('102', 'Pencil', '1.00');
insert into Products values ('103', 'Mechanical Pencil', '2.00');

insert into Warehouse values ('w1', '12983 Patrick Ln', 'City of Industry', 'CA', '90601', '6194320954');
insert into Warehouse values ('w2', '83210 Montana Dr', 'Tucson', 'AZ', '85641', '7638470192');
insert into Warehouse values ('w3', '43223 Corn Dr', 'Lincoln', 'NE', '68501', '39223135439');

insert into Inventory values ('w1', '101', '2000');
insert into Inventory values ('w1', '102', '1000');
insert into Inventory values ('w2', '102', '1500');
insert into Inventory values ('w3', '103', '2500');

insert into Counter values (10000);

commit;

spool off