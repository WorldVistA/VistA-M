QACPST17 ;ALB/ERC -POST-INSTALL ROUTINE FOR QAC*2*17 ;3/21/02
 ;;2.0;Patient Representative;**17**;07/25/1995
 ;This routine will change the status of the Header Issue Codes that
 ;were exported with this patch to inactive and add the Inactivation Date
 ;They were exported as National codes to enable them to pass the data 
 ;screen in the build.  They are being changed because they should not
 ;be available for entering in Reports of Contact
 ;the routine will also call LOOP1^QACMAIL1, which will reset the "F"
 ;crossreference in 745.1 so that old records are re-evaluated for 
 ;re-transmission.  This should get the records that were edited after
 ;their first transmission that might have been re-edited but not re-
 ;transmitted.  These records will be transmitted with the regular daily
 ;rollup transmissions.
EN ;
 D LOOP1^QACMAIL1
 ;
 N DIE,QAC,QACC,QACFDA,QACH,QACHEAD
 S QACHEAD="ED^SC^AC^OP^PR^EM^PC^CO^TR^FI^RI^RE^LL^EV^RG^IF^CP"
 S DIE="^QA(745.2,"
 F QACC=1:1:17 S QACH=$P(QACHEAD,U,QACC) D
 . S QAC=0
 . S QAC=$O(^QA(745.2,"B",QACH,QAC)) Q:QAC'>0  D
 . . S QACFDA(745.2,QAC_",",4)=1
 . . S QACFDA(745.2,QAC_",",6)=DT
 . . D FILE^DIE(,"QACFDA","QACERR")
 Q
