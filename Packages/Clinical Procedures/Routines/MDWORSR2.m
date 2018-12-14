MDWORSR2 ; SLC OIFO/GDU - CONFIRM AUTO CHECK IN;8/22/18 6:10 pm ; 8/29/18 10:52am
 ;;1.0;CLINICAL PROCEDURES;**54**;Apr 01,2004;Build 14
 ;
 ;Added by patch MD*1.0*54 for SDM R6900025FY16
 ;This is to prevent the auto check-in of a new CP order on the same
 ;day as a CP order already scheduled.
 ;
 ;Variables passed in:
 ; MDY1 = The patient's IEN
 ; MDDX = The CP Transaction record IEN
 ; MDSCHD = The date/time of the appointment
 ;Value returned:
 ; Returns 1 if auto check-in is to continue
 ; Returns 0 if auto check-in is not to continue
 ;
 ;Integration Areemements used:
 ; IA# 2051 [Supported] FIND^DIC
 ; IA# 2056 [Supported] $$GET1^DIQ
 ;
 ;Not intended for interactive use.
 Q
CACI(MDY1,MDDX,MDSCHD) ;CONFIRM AUTO CHECK IN
 N MDCHKDT,MDERR,MDFLDS,MDFND,MDNAME,MDRECS,MDRTN,MDSTEP,MDTS,MDX
 ;Pull patient's CP Transaction records
 S MDNAME=$$GET1^DIQ(2,MDY1_",",.01,"E")
 S MDFLDS="@;.01I;.02I;.09I;.14I"
 D FIND^DIC(702,"",MDFLDS,"P",MDNAME,"*","B","","","MDRECS","MDERR")
 S MDSTEP=+MDRECS("DILIST",0)
 I MDSTEP=1 Q 1 ;Only one record found, quit, continue check-in
 ;Check records found for a CP Transaction for same day as appointment
 S MDFND=0
 F MDX=1:1:MDSTEP D
 . S MDTS=$P(MDRECS("DILIST",MDX,0),U,4)
 . S MDCHKDT=$P(MDRECS("DILIST",MDX,0),U,5)
 . I MDTS=6 Q  ;IF CANCELLED QUIT
 . I MDTS=0 Q  ;IF NEW QUIT
 . I MDCHKDT="" Q  ;IF NOT SCHEDULED SAME DAY QUIT
 . I $P(MDCHKDT,".")=$P(MDSCHD,".") S MDFND=1 Q
 S:MDFND=1 MDRTN=0 ;A record found for today, stop check-in
 S:MDFND=0 MDRTN=1 ;No record found for today, continue check-in
 Q MDRTN
