SDRPA02 ;bp-oifo/swo pait utils ; 9/10/04 9:33am
 ;;5.3;Scheduling;**349,376**;AUG 13, 1993
 Q       ;no entry from top
DUP(RUNIEN,BATCHIDO) ;check for duplicate ACK response
 ;RUNIEN     :  the ien in file 409.6 of the run
 ;BATCHIDO   :  batchid pulled from the ACK message
 ;V3         :  returns 0 if dup ACK or error and 1 new ACK
 N V1,V2,V3,VNODE
 S V3=0
 I $G(RUNIEN)="" Q V3
 I $G(BATCHIDO)="" Q V3
 I $G(^SDWL(409.6,RUNIEN,2,0))="" Q V3
 S V1=$O(^SDWL(409.6,RUNIEN,2,"B",BATCHIDO,"")) I V1="" Q V3
 S VNODE=$G(^SDWL(409.6,RUNIEN,2,V1,0))
 I $P(VNODE,"^")'=BATCHIDO Q V3
 I $P(VNODE,"^",4)="" S V3=1
 Q V3
RSTAT ;check the status of the last run
 ;V1     :  last run ien
 ;VNODE  :  zero node of the run
 ;ZTSK   :  the task number
 N V1,V2,V3,VNODE,ZTSK
 S V1=$O(^SDWL(409.6,999999999),-1) Q:'V1
 S VNODE=$G(^SDWL(409.6,V1,0)) Q:VNODE=""
 I $P(VNODE,"^",7) Q  ;the run has finished
 S ZTSK=$P(VNODE,"^",2) Q:'ZTSK
 D STAT^%ZTLOAD
 I ZTSK(1)=1!(ZTSK(1)=2) Q  ;still running
 ;S V2=$$RPAIT^SDRPA03(V1) ADD MESSAGE TO HELP DESK THAT TASK ERRORED
 Q
RUNCK() ;date check for run start
 ;V1     :  ien file 19.2
 ;V2     :  returns 0=do not run, 1=okay to run
 ;V3     :  1st day of scheduling pattern
 ;V4     :  2nd day of scheduling pattern
 ;VNODE  :  zero node of 19.2
 ;VDAY   :  current day plussed
 ;run may be started on the 1st or 15th with a 3 day grace window
 ;if no entry in 19.2 allow to run anytime
 ;if scheduling pattern is not 1M(1,15) allow to run anytime
 N V1,V2,V3,V4,VNODE,VDAY
 S V2=0
 S V1=$O(^DIC(19,"B","SD-PAIT TASKED TRANSMISSION","")) ;is the option scheduled?
 S V1=$O(^DIC(19.2,"B",V1,""))
 I V1="" S V2=1 D NSMSG Q V2  ;not scheduled, allow to run anytime
 S VNODE=$G(^DIC(19.2,V1,0))
 I VNODE="" S V2=1 Q V2  ;b xref, but no entry, allow to run anytime
 I $P(VNODE,"^",6)'?1"1M("1.2N1","1.2N1")" S V2=1 D NSMSG Q V2  ;not our scheduling pattern, allow to run anytime
 S V3=+$P($P($P(VNODE,"^",6),"(",2),",") ;1st date in month to run
 S V4=+$P($P($P(VNODE,"^",6),",",2),")") ;2nd date in month to run
 S VDAY=+$E($$DT^XLFDT(),6,7)
 I VDAY'=V3,VDAY'=(V3+1),VDAY'=(V3+2),VDAY'=(V3+3),VDAY'=V4,VDAY'=(V4+1),VDAY'=(V4+2),VDAY'=(V4+3) D NRMSG Q V2
 S V2=1
 Q V2
NRMSG ;no run message
 N XMSUB,XMY,XMTEXT,XMDUZ,SDAMX,SDNOW,SDNAM
 S XMSUB="PAIT Transmission"
 S XMY("G.SD-PAIT")=""
 S XMTEXT="SDAMX("
 S XMDUZ="POSTMASTER"
 S SDNOW=$$HTE^XLFDT($H,)
 S SDNAM=$$GET1^DIQ(200,+$G(DUZ)_",",.01,"I")
 S SDAMX(1)=SDNAM_" (DUZ="_DUZ_") attempted to start the PAIT transmission"
 S SDAMX(2)="on "_SDNOW_", outside the authorized transmission dates."
 S SDAMX(3)="The job has been cancelled"
 D ^XMD
 Q
NSMSG ;non scheduled start-up
 N XMSUB,XMY,XMTEXT,XMDUZ,SDAMX,SDNOW,SDNAM
 S XMSUB="PAIT Transmission"
 S XMY("G.SD-PAIT")=""
 ;S XMY("VHACIONHD@MED.VA.GOV")
 S XMTEXT="SDAMX("
 S XMDUZ="POSTMASTER"
 S SDNOW=$$HTE^XLFDT($H,)
 S SDNAM=$$GET1^DIQ(200,+$G(DUZ)_",",.01,"I")
 S SDAMX(1)=SDNAM_" (DUZ="_DUZ_") started the PAIT transmission "
 S SDAMX(2)="on "_SDNOW_".  Option SD-PAIT TASKED TRANSMISSION has no "
 S SDAMX(3)="entry or an incorrect entry for scheduling frequency.  The correct frequency "
 S SDAMX(4)="is 1M(1,15).  The National Help Desk has been notified to initiate a NOIS"
 D ^XMD
 Q
