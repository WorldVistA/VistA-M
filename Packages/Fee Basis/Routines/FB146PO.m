FB146PO ;BL/BL - POST-INSTALL ROUTINE FOR FB*3.5*146 ;26-APR-13
 ;;3.5;Fee Basis;**146**;26-APR-13;Build 57
 ;
 ;Purpose of this routine is to provide a filter for the data entries in file #161.99
 ;
NEW161(ANAME)
 ;
 I ANAME="C166" Q 1
 Q 0
