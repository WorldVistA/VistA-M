SCDXSUP2 ;ALB/JRP - PURGE ERROR FILE;22-APR-97 ; 12/20/01 4:49pm
 ;;5.3;Scheduling;**121,247**;AUG 13, 1993
 ;
PRGCO ;Purge TRANSMITTED OUTPATIENT ENCOUNTER ERROR file (#409.75) of
 ; rejections for encounters that can not be transmitted due to
 ; NPCD Database Close-Out
 ;
 ;Input  : None
 ;Output : None
 ;
 ;Declare variables
 N ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSK,DIR,Y,X,DTOUT,DUOUT,DIRUT
 ;'Are you sure' prompt
 S DIR("A",1)=" "
 S DIR("A",2)="This option will purge entries in the TRANSMITTED OUTPATIENT"
 S DIR("A",3)="ENCOUNTER ERROR file (#409.75) of rejections for encounters that"
 S DIR("A",4)="can not be transmitted due to close-out of the National Patient"
 S DIR("A",5)="Care Database for database credit."
 S DIR("A",6)=" "
 S DIR("A")="Ok to continue"
 S DIR("B")="NO"
 S DIR(0)="Y"
 D ^DIR
 Q:('Y)
 ;Task (no device needed)
 S ZTRTN="PRGCOT^SCDXSUP2"
 S ZTDESC="Purge file #409.75 of encounters that won't get database credit"
 S ZTIO=""
 S ZTDTH=""
 D ^%ZTLOAD
 W:($G(ZTSK)) !!,"Scheduled as task number ",ZTSK
 W:('$G(ZTSK)) !!,"** Unable to schedule correctly **"
 Q
 ;
PRGCOT ;Task entry point (self contained)
 ;Declare variables
 N XMITPTR
 ;Loop through 'B' x-ref
 S XMITPTR=0
 F  S XMITPTR=+$O(^SD(409.75,"B",XMITPTR)) Q:('XMITPTR)  D  Q:($$S^%ZTLOAD())
 .;Determine if encounter can be transmitted for database credit
 .Q:+$$XMIT4DBC^SCDXFU04(XMITPTR)<4  ;SD*5.3*247
 .;Won't received database credit - delete all errors for encounter
 .D DELAERR^SCDXFU02(XMITPTR)
 ;Done
 S:($D(ZTQUEUED)) ZTREQ="@"
 Q
