SCDXPRG0 ;ALB/JRP - ACRP PURGING;04-SEP-97 ; 19 Oct 98  1:16 PM
 ;;5.3;Scheduling;**128,163**;AUG 13, 1993
 ;
MAIN ;Main entry point (used by option)
 ;Declare variables
 N SCDXBEG,SCDXEND,SCDXH,X
 N ZTSK,ZTIO,ZTDESC,ZTDTH,ZTRTN,ZTSAVE
 ;Get date range for purge
 ; Earliest purge date allowed is ACRP cut-over date
 S SCDXBEG=2961001
 ; Latest purge date allowed is last day of month prior to previous FY
 ;  database close-out date
 S SCDXEND=$E(DT,1,3)_"0930"
 S SCDXEND=$S(DT>SCDXEND:SCDXEND-10000,1:SCDXEND-20000)
 ;Begin date help text
 S SCDXH("B",1)="Enter encounter date to begin purging from"
 S SCDXH("B",2)=" "
 S SCDXH("B",3)=$$FMTE^XLFDT(SCDXBEG)_" is the earliest date allowed"
 S SCDXH("B",4)=$$FMTE^XLFDT(SCDXEND)_" will be the latest date allowed"
 S SCDXH("B",5)=" "
 S SCDXH("B",6)="Note: The latest date allowed is the last day of the"
 S SCDXH("B")="      month prior to the previous Fiscal Year."
 ;End date help text
 S SCDXH("E",1)="Enter encounter date to end purging at"
 S SCDXH("E",2)=" "
 S SCDXH("E",3)=$$FMTE^XLFDT(SCDXEND)_" is the latest date allowed"
 S SCDXH("E",4)=$$FMTE^XLFDT(SCDXBEG)_" was the earliest date allowed"
 S SCDXH("E",5)=" "
 S SCDXH("E",6)="Note: The latest date allowed is the last day of the"
 S SCDXH("E")="      month prior to the previous Fiscal Year."
 S X=$$GETDTRNG^SCDXUTL1(SCDXBEG,SCDXEND,$NA(SCDXH("B")),$NA(SCDXH("E")))
 ;User aborted - quit
 I (X<0) W !!,"** Purging of ACRP files not queued **",!! Q
 K SCDXH
 S SCDXBEG=+$P(X,"^",1)
 S SCDXEND=+$P(X,"^",2)
 ;Task purging
 S ZTDESC="Purging of ACRP files from "_$$FMTE^XLFDT(SCDXBEG,2)_" to "_$$FMTE^XLFDT(SCDXEND,2)
 S ZTRTN="TASK^SCDXPRG0"
 S ZTSAVE("SCDXBEG")=SCDXBEG
 S ZTSAVE("SCDXEND")=SCDXEND
 S ZTIO=""
 S ZTDTH=""
 S ZTSK=""
 D ^%ZTLOAD
 S ZTSK=+$G(ZTSK)
 ;Error tasking
 W:('ZTSK) !!,"** Purging of ACRP files not queued **",!!
 ;Tasked
 W:(ZTSK) !!,"Purging of ACRP files queued as task number ",ZTSK,!!
 ;Done
 Q
 ;
TASK ;Task entry point
 ;
 ;Input  : SCDXBEG - Begin date (FileMan)
 ;         SCDXEND - End date (FileMan)
 ;Output : None
 ;Notes  : Existance and validity of input is assumed
 ;
 ;Don't purge if task was asked to stop
 I ('$$S^%ZTLOAD()) D PURGE(SCDXBEG,SCDXEND)
 ;Done
 S:($D(ZTQUEUED)) ZTREQ="@"
 Q
 ;
PURGE(BEGDATE,ENDDATE) ;Purge ACRP files over a given date range
 ;
 ;Input  : BEGDATE - Encounter date to begin purging from (FileMan)
 ;                   Defaults to beginning of last fiscal year
 ;         ENDDATE - Encounter date to end purging at (FileMan)
 ;                   Defaults to end of last fiscal year
 ;Output : None
 ;Notes  : Purging affects the following files
 ;          - Transmitted Outpatient Encounter file (#409.73)
 ;          - Deleted Outpatient Encounter file (#409.74)
 ;          - Transmitted Outpatient Encounter Error file (#409.75)
 ;          - ACRP Transmission History file (#409.77)
 ;
 ;Check input
 S BEGDATE=+$G(BEGDATE)
 S:('BEGDATE) BEGDATE=+$P($$DR4FY^SCDXPRGD($$PREVFY^SCDXPRGD()),"^",1)
 S ENDDATE=+$G(ENDDATE)
 S:('ENDDATE) ENDDATE=+$P($$DR4FY^SCDXPRGD($$PREVFY^SCDXPRGD()),"^",2)
 ;Declare variables
 N TMP,DATE,ENCPTR,XMITPTR,DELPTR,ENCPRG,DELPRG
 ;Initialize purge counts
 S (ENCPRG,DELPRG)=0
 ;Make begin and end dates opposing midnights
 S BEGDATE=$P(BEGDATE,".",1)
 S ENDDATE=$P(ENDDATE,".",1)_".235959"
 ;Loop through Outpatient Encounter file (#409.68)
 S DATE=BEGDATE
 F  S DATE=+$O(^SCE("B",DATE)) Q:(('DATE)!(DATE>ENDDATE))  D  Q:($$S^%ZTLOAD())
 .S ENCPTR=0
 .F  S ENCPTR=+$O(^SCE("B",DATE,ENCPTR)) Q:('ENCPTR)  D
 ..;Find associated entry in Transmitted Outpatient Encounter file
 ..S XMITPTR=+$$FINDXMIT^SCDXFU01(ENCPTR)
 ..Q:('XMITPTR)
 ..;Increment purge count
 ..S ENCPRG=ENCPRG+1
 ..;Delete from Transmitted Outpatient Encounter file
 ..S TMP=$$DELXMIT^SCDXFU03(XMITPTR)
 ;Task asked to stop (jump to message generation)
 I ($$S^%ZTLOAD()) G MSG
 ;Loop through Deleted Outpatient Encounter file (#409.74)
 S DATE=BEGDATE
 F  S DATE=+$O(^SD(409.74,"B",DATE)) Q:(('DATE)!(DATE>ENDDATE))  D  Q:($$S^%ZTLOAD())
 .S DELPTR=0
 .F  S DELPTR=+$O(^SD(409.74,"B",DATE,DELPTR)) Q:('DELPTR)  D
 ..;Find associated entry in Transmitted Outpatient Encounter file
 ..S XMITPTR=+$$FINDXMIT^SCDXFU01(0,DELPTR)
 ..Q:('XMITPTR)
 ..;Increment purge count
 ..S DELPRG=DELPRG+1
 ..;Delete from Transmitted Outpatient Encounter file
 ..S TMP=$$DELXMIT^SCDXFU03(XMITPTR)
MSG ;Generate completion message
 K TMP
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ
 ;Build message text
 I ($$S^%ZTLOAD()) D
 .;Asked to stop
 .S TMP(1,0)="** Purging was asked to stop **"
 .S TMP(2,0)=" "
 S TMP(3,0)=(ENCPRG+DELPRG)_" entries were purged from the Transmitted Outpatient Encounter file"
 S TMP(4,0)="(#409.73).  "_ENCPRG_" of them pointed to entries in the Outpatient Encounter"
 S TMP(5,0)="file (#409.68) and "_DELPRG_" of them pointed to entries in the Deleted Outpatient"
 S TMP(6,0)="Encounter file (#409.74)."
 ;Send to current user
 S XMSUB="Purging of ACRP files from "_$$FMTE^XLFDT(BEGDATE,"2D")_" to "_$$FMTE^XLFDT(ENDDATE,"2D")
 S XMTEXT="TMP("
 S XMDUZ="ACRP PURGER"
 S XMY(DUZ)=""
 D ^XMD
 ;Done
 Q
