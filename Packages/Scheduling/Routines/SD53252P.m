SD53252P ;ALB/JKT - ACRP TEMP FIX FOR RETRANS TO AUSTIN;19-SEP-2001 ; 9/24/01 12:30pm
 ;;5.3;Scheduling;**252**;Aug 13, 1993
 ;
MAIN ;Main entry point
 ;Queue marking of encounters and quit
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK
 S ZTRTN="MARKENC^SD53252P"
 S ZTDESC="Mark July 26-29 2001 encounters for retransmission"
 S ZTDTH=$H
 S ZTIO=""
 D ^%ZTLOAD
 I $G(ZTSK) D BMES^XPDUTL("Queued as task number "_ZTSK)
 I '$G(ZTSK) D BMES^XPDUTL("** Unable to queue task **")
 Q
 ;
MARKENC ;Mark encounters for transmission
 N XMITPTR,EVNTDATE,NODE,ENCPTR,DELPTR,XMITCNT,ENCDATE
 N ZMDUZ,ZTREQ,ZTSTOP
 ;Scan transmission file (#409.73) looking for encounters that were
 ;transmitted between July 26 and July 29, 2001.
 ;Mark those found for retransmission.
 S XMITPTR=0
 S ZTSTOP=$$S^%ZTLOAD("Starting check") Q:ZTSTOP
 F XMITCNT=1:1 S XMITPTR=+$O(^SD(409.73,XMITPTR)) Q:'XMITPTR  D  Q:ZTSTOP
 .S NODE=$G(^SD(409.73,XMITPTR,0))
 .Q:NODE=""
 .S EVNTDATE=+$P(NODE,"^",6)
 .Q:(EVNTDATE<3010726)!(EVNTDATE>3010729)
 .D STREEVNT^SCDXFU01(XMITPTR,0)
 .D XMITFLAG^SCDXFU01(XMITPTR)
 .S:'(XMITCNT#20) ZTSTOP=$$S^%ZTLOAD("Just checked entry #"_XMITPTR)
 ;User asked task to stop
 I ZTSTOP S ZTSTOP=$$S^%ZTLOAD("Task stopped after entry #"_XMITPTR) Q
TST ;Send completion message to user
 N XMTEXT,XMZ,XMY,XMSUB,SDTEXT,OFFSET
 F OFFSET=1:1 S NODE=$T(MSGTXT+OFFSET) Q:$P(NODE,";",2)="END"  S SDTEXT(OFFSET,0)=$P(NODE,";;",2)
 S XMTEXT="SDTEXT("
 S XMSUB="Marking of July 26-29 2001 encounters completed"
 S XMDUZ="AmbCare"
 S XMY(DUZ)=""
 D ^XMD
 ;Done
 S ZTREQ="@"
 Q
MSGTXT ;Message text for task completion
 ;;
 ;;Marking of encounters for retransmission has run to completion.
 ;;Schedule the option SCDX AMBCAR NIGHTLY XMIT [Ambulatory Care Nightly
 ;;Transmission to NPCDB] so that transmission of these encounters to
 ;;Austin can begin.  This option should already be scheduled to run
 ;;daily but starting it now will give as much time as possible for
 ;;transmission to occur since data submitted after 10/19/01 will not
 ;;be included in this year's snapshot.
 ;;
 ;;Reminder: The option SCDX AMBCAR NIGHTLY XMIT [Ambulatory Care Nightly
 ;;Transmission to NPCDB] should be scheduled to run on a daily basis.
 ;;
 ;END
 ;
