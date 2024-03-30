--------------------------------------------------------
--  File created - Saturday-March-30-2024   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table ADDRESS
--------------------------------------------------------

  CREATE TABLE "CUSUSER"."ADDRESS" 
   (	"ADDRESSID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"CUSTOMERID" NUMBER, 
	"ADDRESSNAME" VARCHAR2(500 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table CUSTOMER
--------------------------------------------------------

  CREATE TABLE "CUSUSER"."CUSTOMER" 
   (	"CUSTOMERID" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"ISHIDDEN" NUMBER(*,0), 
	"CUSTOMERNAME" VARCHAR2(50 BYTE), 
	"SEX" VARCHAR2(1 BYTE), 
	"DOB" DATE, 
	"POB" VARCHAR2(500 BYTE), 
	"PHONE" VARCHAR2(500 BYTE), 
	"EMAIL" VARCHAR2(500 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into CUSUSER.ADDRESS
SET DEFINE OFF;
Insert into CUSUSER.ADDRESS (ADDRESSID,CUSTOMERID,ADDRESSNAME) values (7,1,'Btt');
Insert into CUSUSER.ADDRESS (ADDRESSID,CUSTOMERID,ADDRESSNAME) values (8,1,'Svay Reang');
Insert into CUSUSER.ADDRESS (ADDRESSID,CUSTOMERID,ADDRESSNAME) values (9,1,'KK');
Insert into CUSUSER.ADDRESS (ADDRESSID,CUSTOMERID,ADDRESSNAME) values (5,1,'Siem Reap');
Insert into CUSUSER.ADDRESS (ADDRESSID,CUSTOMERID,ADDRESSNAME) values (6,1,'PP');
REM INSERTING into CUSUSER.CUSTOMER
SET DEFINE OFF;
Insert into CUSUSER.CUSTOMER (CUSTOMERID,ISHIDDEN,CUSTOMERNAME,SEX,DOB,POB,PHONE,EMAIL) values (2,0,'No Pro','M',to_date('30-MAR-00','DD-MON-RR'),'sr','0973839393','procode.com');
Insert into CUSUSER.CUSTOMER (CUSTOMERID,ISHIDDEN,CUSTOMERNAME,SEX,DOB,POB,PHONE,EMAIL) values (3,0,'Makara','F',to_date('30-MAR-00','DD-MON-RR'),'Sr','097838493','makara@gmail.com');
Insert into CUSUSER.CUSTOMER (CUSTOMERID,ISHIDDEN,CUSTOMERNAME,SEX,DOB,POB,PHONE,EMAIL) values (4,0,'Test','M',to_date('30-MAR-00','DD-MON-RR'),'sr','099938393','t@gmail.com');
Insert into CUSUSER.CUSTOMER (CUSTOMERID,ISHIDDEN,CUSTOMERNAME,SEX,DOB,POB,PHONE,EMAIL) values (1,0,'Tida Edit','F',to_date('30-MAR-02','DD-MON-RR'),'Siem Reap','097838374','tida@gmail.com');
--------------------------------------------------------
--  DDL for Procedure ADDRESSADD
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "CUSUSER"."ADDRESSADD" (
     P_CustomerId		Address.CustomerId%Type,
     P_AddressName		Address.AddressName%Type
)
As
Begin
    Insert Into Address(CustomerId, AddressName) 
    Values(P_CustomerId, P_AddressName);
    Commit;
End;

/
--------------------------------------------------------
--  DDL for Procedure ADDRESSDELETE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "CUSUSER"."ADDRESSDELETE" 
(
    P_CustomerId        Address.CustomerId%Type
)
As
Begin
    Delete From Address Where CustomerId = P_CustomerId;
    Commit;
End;

/
--------------------------------------------------------
--  DDL for Procedure ADDRESSGET
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "CUSUSER"."ADDRESSGET" 
(
    P_CustomerId    Address.CustomerId%Type Default 0
)
As
    C_Address Sys_RefCursor;
Begin
    If(P_CustomerId = 0) Then
        Open C_Address For Select * From Address;
    Else
        Open C_Address For Select * From Address Where CustomerId = P_CustomerId;
    End If;
    DBMS_SQL.return_result(C_Address);
End;

/
--------------------------------------------------------
--  DDL for Procedure CUSTOMERADD
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "CUSUSER"."CUSTOMERADD" (
     P_CustomerName		Customer.CustomerName%Type,
     P_Sex		Customer.Sex%Type,
     P_DoB		Customer.DoB%Type,
     P_POB		Customer.POB%Type,
     P_Phone		Customer.Phone%Type,
     P_Email		Customer.Email%Type,
     P_CustomerId    out Customer.CustomerId%Type
)
As
Begin
    Insert Into Customer( CustomerName, Sex, DoB, POB, Phone, Email,ishidden) 
    Values( P_CustomerName, P_Sex, P_DoB, P_POB, P_Phone, P_Email, 0)
    Returning CustomerId into P_CustomerId;
    Commit;
End;

/
--------------------------------------------------------
--  DDL for Procedure CUSTOMERDELETE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "CUSUSER"."CUSTOMERDELETE" 
(
    P_CustomerId        Customer.CustomerId%Type
)
As
Begin
    update Customer set ishidden = 1 Where CustomerId = P_CustomerId;
    Commit;
End;

/
--------------------------------------------------------
--  DDL for Procedure CUSTOMERGET
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "CUSUSER"."CUSTOMERGET" 
(
    P_CustomerId    Customer.CustomerId%Type Default 0
)
As
    C_Customer Sys_RefCursor;
Begin
    If(P_CustomerId = 0) Then
        Open C_Customer For Select * From Customer where ishidden = 0;
    Else
        Open C_Customer For Select * From Customer Where CustomerId = P_CustomerId and ishidden = 0;
    End If;
    DBMS_SQL.return_result(C_Customer);
End;

/
--------------------------------------------------------
--  DDL for Procedure CUSTOMERUPDATE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "CUSUSER"."CUSTOMERUPDATE" ( 
     P_CustomerId		Customer.CustomerId%Type,
     P_Ishidden		Customer.Ishidden%Type,
     P_CustomerName		Customer.CustomerName%Type,
     P_Sex		Customer.Sex%Type,
     P_DoB		Customer.DoB%Type,
     P_POB		Customer.POB%Type,
     P_Phone		Customer.Phone%Type,
     P_Email		Customer.Email%Type
)
As
Begin
    Update Customer   Set Ishidden = P_Ishidden, CustomerName = P_CustomerName, Sex = P_Sex, DoB = P_DoB, POB = P_POB, Phone = P_Phone, Email = P_Email Where CustomerId =  P_CustomerId;
Commit;
End;

/
--------------------------------------------------------
--  Constraints for Table ADDRESS
--------------------------------------------------------

  ALTER TABLE "CUSUSER"."ADDRESS" MODIFY ("ADDRESSID" NOT NULL ENABLE);
  ALTER TABLE "CUSUSER"."ADDRESS" ADD PRIMARY KEY ("ADDRESSID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table CUSTOMER
--------------------------------------------------------

  ALTER TABLE "CUSUSER"."CUSTOMER" MODIFY ("CUSTOMERID" NOT NULL ENABLE);
  ALTER TABLE "CUSUSER"."CUSTOMER" ADD PRIMARY KEY ("CUSTOMERID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ADDRESS
--------------------------------------------------------

  ALTER TABLE "CUSUSER"."ADDRESS" ADD FOREIGN KEY ("CUSTOMERID")
	  REFERENCES "CUSUSER"."CUSTOMER" ("CUSTOMERID") ON DELETE CASCADE ENABLE;