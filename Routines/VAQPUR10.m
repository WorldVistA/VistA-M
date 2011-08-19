VAQPUR10 ;ALB/JRP - PURGING;15JUL93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
START ;START RESPONSE TIME MONITORING (TIME TO PURGE SINGLE TRANSACTION)
 I ($D(XRTL)) D T0^%ZOSV
 Q
 ;
STOP ;STOP RESPONSE TIME MONITORING
 I ($D(XRT0)) S XRTN=$T(+0) D T1^%ZOSV K XRTN,XRT0
 Q
 ;
JOB ;ENTRY POINT FOR PURGING THAT HAS BEEN JOBBED
 ;INPUT  : VAQDATE - Earliest date allowed for transactions (FileMan)
 ;         VAQINTR - Interactive flag
 ;           If 1, write purging information to current device
 ;           If 0, do not write purging information (default)
 ;OUTPUT : None
 ;NOTES  : See $$PURGER^VAQPUR10
 ;
 ;CHECK INPUT
 I ('$D(VAQDATE)) S ZTREQ="@" Q
 S:('$D(VAQINTR)) VAQINTR=0
 ;DECLARE VARIABLE
 N JUNK
 ;CALL PURGER
 S JUNK=$$PURGER(VAQDATE,VAQINTR)
 S ZTREQ="@"
 Q
 ;
PURGER(PURDATE,DBUG) ;PURGER
 ;INPUT  : PURDATE - Earliest date allowed for transactions (FileMan)
 ;         DBUG - Debug flag
 ;           If 1, write purging information to current device
 ;           If 0, do not write purging information (default)
 ;OUTPUT : N - Number of transactions purged
 ;NOTES  : Transactions that were created on or before PURDATE will
 ;         be purged.  Data that is associated with the transaction
 ;         will also be purged.
 ;       : Work-load information that relates to the transaction will
 ;         not be purged.
 ;       : Transactions that are missing critical data will have their
 ;         purge flag set.  This allows the transaction to be purged
 ;         the next time the purger is run and prevents transactions
 ;         that are currently being worked on from being deleted.
 ;
 ;CHECK INPUT
 Q:('(+$G(PURDATE))) 0
 S DBUG=+$G(DBUG)
 ;DECLARE VARIABLES
 N TRANPTR,PURGE,PRGCNT,ERROR,TMP,STOPJOB
 S ERROR="^TMP(""VAQ-PURGE"","_$J_")"
 K @ERROR
 S PRGCNT=0
 S STOPJOB=0
 W:(DBUG) !!,"- PDX Purger -"
 ;DELETE ALL TRANSACTIONS THAT HAVE PURGE FLAG SET
 W:(DBUG) !!!,"Deleting transactions with purge flag set"
 S TRANPTR=""
 F  S TRANPTR=$O(^VAT(394.61,"PURGE",1,TRANPTR)) Q:((TRANPTR="")!(STOPJOB))  D START D  D STOP
 .S STOPJOB=$$S^%ZTLOAD
 .Q:(STOPJOB)
 .S TMP=+$$DELTRAN^VAQFILE(TRANPTR)
 .I (TMP<0) D  Q
 ..S @ERROR@(TRANPTR)="Unable to delete entry"
 ..W:(DBUG) !,"Unable to delete entry number ",TRANPTR
 .S PRGCNT=PRGCNT+1
 .W:(DBUG) !,"Entry number ",TRANPTR," has been deleted"
 ;JOB HAS BEEN STOPPED
 I (STOPJOB) D  Q PRGCNT
 .S @ERROR@("STOPPED")=""
 .W:(DBUG) !!!,"*** Purger has been stopped ***",!!!
 .;SEND ERROR BULLETIN
 .S:('DBUG) TMP=$$PURGE^VAQBUL07(ERROR)
 .K @ERROR
 ;CHECK ALL TRANSACTIONS FOR POSSIBLE PURGING
 W:(DBUG) !!!,"Checking all transactions against purge criteria"
 S TRANPTR=0
 F  S TRANPTR=$O(^VAT(394.61,TRANPTR)) Q:((TRANPTR="")!(TRANPTR'?1.N)!(STOPJOB))  D START D  D STOP
 .S STOPJOB=$$S^%ZTLOAD
 .Q:(STOPJOB)
 .S PURGE=$$PRGCHK^VAQPUR11(TRANPTR,PURDATE,1)
 .Q:('PURGE)
 .I (PURGE<0) D  Q
 ..S @ERROR@(TRANPTR)="Could not determine if entry should be deleted"
 ..W:(DBUG) !,"Could not determine if entry number ",TRANPTR," should be deleted"
 .I ((+PURGE)=2) D  Q
 ..S TMP=$P(PURGE,"^",2)
 ..I (TMP=0) W:(DBUG) !,"Purge flag was not set for entry number ",TRANPTR S @ERROR@(TRANPTR)="Did not set purge flag" Q
 ..I (TMP=1) W:(DBUG) !,"Purge flag has been set for entry number ",TRANPTR Q
 ..I (TMP=-1) W:(DBUG) !,"Purge flag could not be set for entry number ",TRANPTR S @ERROR@(TRANPTR)="Could not set purge flag"
 .S TMP=+$$DELTRAN^VAQFILE(TRANPTR)
 .I (TMP<0) D  Q
 ..S @ERROR@(TRANPTR)="Unable to delete entry"
 ..W:(DBUG) !,"Unable to delete entry number ",TRANPTR
 .S PRGCNT=PRGCNT+1
 .W:(DBUG) !,"Entry number ",TRANPTR," has been deleted"
 ;JOB HAS BEEN STOPPED
 I (STOPJOB) D  Q PRGCNT
 .S @ERROR@("STOPPED")=""
 .W:(DBUG) !!!,"*** Purger has been stopped ***",!!!
 .;SEND ERROR BULLETIN
 .S:('DBUG) TMP=$$PURGE^VAQBUL07(ERROR)
 .K @ERROR
 W:(DBUG) !!!,"- Done -",!!!
 ;SEND ERROR BULLETIN IF NOT IN DEBUG MODE
 S:('DBUG) TMP=$$PURGE^VAQBUL07(ERROR)
 K @ERROR
 Q PRGCNT
