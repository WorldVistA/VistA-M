VAQADM5 ;ALB/JRP - GENERATE PDX TRANSMISSIONS;20-MAY-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
GENTASK(TRANARR) ;TASK TRANSMISSION GENERATION
 ;INPUT  : TRANARR - Array of pointers to transactions that
 ;                   should be transmit (full global ref)
 ;OUTPUT : ZTSK - Task number transmission(s) queued as
 ;         -1^Error_Text - Error
 ;NOTES  : TRANARR will have the following format
 ;           TRANARR(X)=""  where X is a pointer to the transaction
 ;       : Transmission(s) will be queued for NOW
 ;       : Some over-head may be saved by using VAQTRN as input
 ;
 ;CHECK INPUT
 Q:($G(TRANARR)="") "-1^Did not pass reference to transaction array"
 Q:($O(@TRANARR@(""))="") "-1^Transaction array did not contain any information"
 ;DECLARE VARIABLES
 N ZTSK,ZTRTN,ZTDESC,ZTDTH,ZTSAVE,ZTIO,TMP
 ;COPY TRANSACTIONS INTO VAQTRN (INPUT FOR GENXMIT^VAQADM50)
 I (TRANARR'="VAQTRN") N VAQTRN D
 .S TMP=""
 .F  S TMP=$O(@TRANARR@(TMP)) Q:(TMP="")  S VAQTRN(TMP)=""
 ;SET UP TASK
 S ZTRTN="GENXMIT^VAQADM50"
 S ZTDESC="Generation of PDX transmission"
 S ZTDTH=$H
 S ZTSAVE("VAQTRN(")=""
 S ZTIO=""
 ;TASK
 D ^%ZTLOAD
 ;NOT QUEUED
 Q:($G(ZTSK)="") "-1^Could not queue transmission(s)"
 Q ZTSK
