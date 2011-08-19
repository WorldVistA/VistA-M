SDRPA00 ;BP-OIFO/OWAIN,ESW - Patient Appointment Information Transmission  ; 11/2/04 11:09am  ; 2/24/08 11:25am
 ;;5.3;Scheduling;**290,333,349,376,491**;Aug 13,1993;Build 53
 ;SD/491 - calling SRPA03 instead of SDRPA04  (dupl)
 Q
EN ;manual entry
 N SDI,Y,ZTSK,ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE,RUNID,REC
 I '$$RUNCK^SDRPA02() W !,"You attempted to start PAIT outside the authorized transmission dates.",!,"Job has been terminated.",! Q
 S RUNID=$O(^SDWL(409.6,":"),-1)
 I RUNID S ZTSK=$P(^SDWL(409.6,RUNID,0),"^",2) D STAT^%ZTLOAD I ZTSK(1)=1!(ZTSK(1)=2) W !,"A task is currently active." Q
 K ZTSK N SDCON S SDCON=1
 S %DT("A")="Queue to run:  "
 S %DT="AEFXR" W ! D ^%DT S DT=Y D:Y'=-1  Q:'SDCON
 .S ZTDTH=Y,ZTRTN="START^SDRPA00",ZTIO=""
 .S ZTDESC="PAIT"
 .I RUNID I $P(^SDWL(409.6,RUNID,0),U,7)="" S SDCON=0 D
 ..W !,"The previous run errored out, not repaired!",!,"Please address a problem and use SD-PAIT REPAIR to fix the run."
 .Q:'SDCON
 .F SDI=1:1:20 D ^%ZTLOAD Q:$G(ZTSK)
 .I $G(ZTSK) W !,"Task # "_ZTSK_" queued!"
 I '$G(ZTSK) W !!,"Task not queued, check Taskman",! Q
 W !!,"Task number: ",ZTSK,!
 Q
START ;Tasked entry
 N SDOUT,DFN,DFNEND,SDCNT,SDCNT0,RUNID,RUNDT,SDPREV,FIRST,SDDAM,TODAY,SD6A,SD8A,SD68,RUNIDP,SDPR,ZTSKN
 I '$$RUNCK^SDRPA02() Q  ;check scheduling
 I $G(ZTSK)="" D  Q
 . W !,"NOT AN INTERACTIVE OPTION...schedule through TaskMan",!!
 S ZTSKN=ZTSK
 S SDPR=$O(^SDWL(409.6,":"),-1) ;previous run
 I SDPR N SD1 S SD1=0 D  Q:SD1  ;finish if task is still running
 .I $P(^SDWL(409.6,SDPR,0),U,7)'="" Q  ; previous task finished
 .N ZTSK
 .S ZTSK=$P(^SDWL(409.6,SDPR,0),"^",2) D STAT^%ZTLOAD I ZTSK(1)=1!(ZTSK(1)=2) S SD1=1
 .;send message
 .N SDAMX,XMSUB,XMY,XMTEXT,XMDUZ
 .S XMSUB="PAIT BACKGROUND JOB"
 .S XMY("G.SD-PAIT")=""
 .S XMTEXT="SDAMX("
 .S XMDUZ="POSTMASTER"
 .S SDAMX(1)="The PAIT requested task has been terminated."
 .S SDAMX(2)="The previous task #: "_ZTSK_" run #: "_SDPR_" has not been completed."
 .I SD1=1 S SDAMX(3)="It is still running.",SDAMX(4)=""
 .E  S SD1=2 D
 ..S SDAMX(3)="The previous run errored out, not repaired!"
 ..S SDAMX(4)="Address a problem and use option SD-PAIT REPAIR to fix the run."
 .D ^XMD
 S DIC=409.6,DIC(0)="X"
 D NOW^%DTC S TODAY=X
 K DO D FILE^DICN
 S DA=+Y,DIE=DIC,DR="1///"_ZTSK D ^DIE
 ;send START message
 D STMES
 S (SDOUT,SDCNT)=0
 K ^TMP("SDDPT",$J)
 N CRUNID S CRUNID=$O(^SDWL(409.6,"AD",ZTSK,""))
 S RUNDT=$P(^SDWL(409.6,CRUNID,0),"^")
 I SDPR=0 S SDPREV=3020831,FIRST=1 ;first run
 E  S SDPREV=$P(^SDWL(409.6,SDPR,0),U,4),FIRST=0 ;
 N SDFIN,SDPEN,SDF,SDTR S (RUNID,SDFIN,SDPEN,SDTR,SDF)=0
 S SDDAM=SDPREV ;creation date
 D NOW^%DTC S TODAY=X
 F  S SDDAM=$O(^DPT("ASADM",SDDAM)) Q:SDDAM=""  Q:SDDAM=TODAY!SDOUT  D
 .N DFN S DFN=0
 .F  S DFN=$O(^DPT("ASADM",SDDAM,DFN)) Q:+DFN'=DFN!SDOUT  D
 ..N SDADT S SDADT=0 ;appt date/time
 ..S SDADT=0
 ..F  S SDADT=$O(^DPT("ASADM",SDDAM,DFN,SDADT)) Q:+SDADT'=SDADT!SDOUT  D
 ...I SDADT'>3030000 Q  ;only appointment scheduled for 2003 and later; sd/491
 ...I SDDAM'=$$GET1^DIQ(2.98,SDADT_","_DFN_",",20,"I") Q  ;compare creation dates
 ...; Check for 'stop task' request
 ...S SDCNT=SDCNT+1 I SDCNT#500=0 S SDOUT=$$S^%ZTLOAD I SDOUT D  N SDBCID,SDMCID,SDSTOP D SNDS19^SDRPA07(ZTSK,.SDBCID,.SDMCID) S SDSTOP=1 D MSGT^SDRPA04(CRUNID,SDPEN,SDFIN,,SDSTOP) K ^TMP("SDDPT",$J) Q
 ....N DA,DIE,DR,SDD,SDLAST D
 ....S SDLAST=$O(^SDWL(409.6,CRUNID,1,"B"),-1) S SDD=$P(^SDWL(409.6,CRUNID,1,SDLAST,0),U,7)-1
 ....S DA=CRUNID,DIE=409.6,DR="1.2///"_SDD D ^DIE
 ...N SDCL,SDSTAT,SDSTTY
 ...S SDCL=$$GET1^DIQ(2.98,SDADT_","_DFN_",",.01,"I")
 ...Q:SDCL=""  ; If this happens, there's something wrong.
 ...;
 ...; Check status.
 ...; Appoinment made only before Sep 1, 2003
 ...; If it is not the first run, send but don't create a pending file
 ...; Otherwise add to pending file.
 ...D NOW^%DTC N STODAY S STODAY=X
 ...S SDSTAT=$$STATUS^SDRPA05(DFN,SDADT,SDCL,STODAY,1)
 ...I $P(SDSTAT,"^")=0 Q
 ...N SDCLL S SDCLL=$P(SDSTAT,U,6) I SDCLL'="" S SDCL=SDCLL ;assign a new clinic if from matching non count with encounter
 ...S SDSTTY=$P(SDSTAT,U,2),SD6A=$P(SDSTAT,U,3),SD8A=$P(SDSTAT,U,4)
 ...I SDSTTY="F" Q:'$$GT90DAYS(SDDAM,3030831)  ; pending and final from 09/01/2003, previously 90 days
 ...I SDSTTY="F",SD6A="NM",SD8A="NC" Q  ; skip non-count if not matching count and scheduled date already expired
 ...N SDCOA,SDMSHA S SDCOA=$P(SDSTAT,U,5) S SDMSHA=$P(SDSTAT,U)
 ...N SDCE Q:'$$DPT^SDRPA08(DFN,.SDCE)  ; Create demographic node of ^TMP file. Quit if this failed.
 ...N DIC,DA,X,SDRET D
 ....N SDRET S SDRET=$S(SDSTTY="F":"N",1:"Y")
 ....S DIC="^SDWL(409.6,"_CRUNID_",1,",DA(1)=CRUNID,DIC("P")=409.69,DIC(0)="X"
 ....K DO S X=DFN D FILE^DICN
 ....S DA=+Y,DIE=DIC,DR="1///"_SDADT_";4///"_SDRET_";5///"_SD6A_";6///"_SDDAM_";8///"_SD8A_";9////"_SDCL D ^DIE
 ....Q
 ...D APPT^SDRPA08(DFN,SDADT,$$DTCONV^SDRPA08(SDDAM),SDCL,SDSTAT)
 ...S SDFF=$P(SDSTAT,"^",4) D STAT(SDSTTY,SDFF,.SDFIN,.SDPEN,.SDF)
 ...S SDTR=SDTR+1 I SDTR=5000 D SNDS19^SDRPA07(ZTSK,.SDBCID,.SDMCID) K ^TMP("SDDPT",$J) S SDTR=0
 Q:SDOUT
 N SDD S SDD=$O(^DPT("ASADM",TODAY),-1) ;enter the last scanned day
 S DA=CRUNID,DIE=409.6,DR="1.2///"_SDD D ^DIE
 ; scan the previous runs
 S RUNID=0
 F  S RUNID=$O(^SDWL(409.6,RUNID)) Q:+RUNID=CRUNID!SDOUT  D
 .N APPTID,SDADT,REC
 .S APPTID=0
 .;scanning only appointments that were sent as 'pending'
 .F  S APPTID=$O(^SDWL(409.6,"AE","Y",RUNID,APPTID)) Q:APPTID=""!SDOUT  S REC=$G(^SDWL(409.6,RUNID,1,APPTID,0)) D
 ..IF REC="" K ^SDWL(409.6,"AE","Y",RUNID,APPTID) Q  ;anticipate
 ..S DFN=$P(REC,"^"),SDADT=$P(REC,"^",2)
 ..;evaluate SDADT - appt date/time for possible removal from sending
 ..I SDADT'>3030000 N DIK S DIK="^SDWL(409.6,"_RUNID_",1,",DA(1)=RUNID,DA=APPTID D ^DIK ;delete entry; not to be sent; sd/491
 ..; Check for 'stop task'
 ..S SDCNT=SDCNT+1 I SDCNT#500=0 S SDOUT=$$S^%ZTLOAD I SDOUT N SDBCID,SDMCID,SDSTOP D SNDS19^SDRPA07(ZTSK,.SDBCID,.SDMCID) S SDSTOP=1 D MSGT^SDRPA04(CRUNID,SDPEN,SDFIN,,SDSTOP) K ^TMP("SDDPT",$J) Q  ;
 ..N SDCL,SDCLO,SDCE,SDSTAT,SDREJ,SDDAM,SDDAMO
 ..S SDCLO=$P(REC,"^",10)
 ..S SDREJ=$P(REC,"^",8),SDDAMO=$P(REC,"^",7) ;esw
 ..I SDDAMO="" D
 ...N SDD S SDD=9999999 F  S SDD=$O(^DPT("ASADM",SDD),-1) Q:SDD'>0  I $D(^DPT("ASADM",SDD,DFN,SDADT)) S SDDAMO=SDD Q
 ..Q:SDDAMO=""  ;cannot determine what was original creation date
 ..;evaluate if the same creation date
 ..S SDDAM=$$GET1^DIQ(2.98,SDADT_","_DFN_",",20,"I")
 ..S SDCL=$$GET1^DIQ(2.98,SDADT_","_DFN_",",.01,"I")
 ..Q:SDCL=""  ;
 ..I SDCLO="" S SDCLO=SDCL
 ..I SDDAM'?7N!(SDDAM'>3020831) S SDDAM=SDDAMO ; need to finalize the previously sent
 ..; Check status. If it is a termination, continue.
 ..Q:$D(^TMP("SDDPT",$J,DFN,SDADT))  ; overridden to be process next time
 ..;anothercross reference entry will be created; do not need to quit
 ..;Q:$D(^SDWL(409.6,"AC",DFN,SDADT,+$G(CRUNID)))  ;see above
 ..S SDSTAT=""
 ..I SDDAM'=SDDAMO!(SDCL'=SDCLO) D
 ...; create CT status; the current SDADT has different creation date
 ...S SDSTAT="S15"_U_"F"_U_"CT"_U_U_U_U_U S SDDAM=SDDAMO,SDCL=SDCLO
 ..I SDSTAT="" D NOW^%DTC N SDTODAY S SDTODAY=X S SDSTAT=$$STATUS^SDRPA05(DFN,SDADT,SDCL,SDTODAY,0)
 ..I $P(SDSTAT,"^")=0 Q
 ..N SDCOA,SDMSHA S SDCOA=$P(SDSTAT,U,5) S SDMSHA=$P(SDSTAT,U),SD6A=$P(SDSTAT,U,3),SD8A=$P(SDSTAT,U,4)
 ..N SDCLL S SDCLL=$P(SDSTAT,U,6) I SDCLL'="" S SDCL=SDCLL
 ..S SDSTTY=$P(SDSTAT,U,2)
 ..I SDSTTY="P"&(SDREJ="") Q  ;do not send in pending status if not rejected ;esw
 ..N SDCE Q:'$$DPT^SDRPA08(DFN,.SDCE)  ; Create demographic node of ^TMP file. Quit if this failed.
 ..N DIC,DA,X D
 ...N SDRET S SDRET=$S(SDSTTY="F":"N",1:"Y")
 ...S DIC="^SDWL(409.6,"_CRUNID_",1,",DA(1)=CRUNID,DIC("P")=409.69,DIC(0)="X"
 ...K DO S X=DFN D FILE^DICN
 ...S DA=+Y,DIE=DIC,DA=+Y,DR="1///"_SDADT_";4///"_SDRET_";5///"_SD6A_";6///"_SDDAM_";8///"_SD8A_";9////"_SDCL D ^DIE
 ..N DIC,DA D
 ...; not rejected can be sent only as 'S'- sent as final
 ...N SDRET S SDRET=$S(SDREJ'="":"R",1:"S") ; indicates that it was: R - sent as rejected, S - sent as final
 ...S DIC="^SDWL(409.6,"_RUNID_",1,",DA(1)=RUNID
 ...S DA=APPTID,DIE=DIC,DR="4////"_SDRET D ^DIE
 ..D APPT^SDRPA08(DFN,SDADT,$$DTCONV^SDRPA08(SDDAM),SDCL,SDSTAT)
 ..S SDFF=$P(SDSTAT,"^",4) D STAT(SDSTTY,SDFF,.SDFIN,.SDPEN,.SDF)
 ..S SDTR=SDTR+1 I SDTR=5000 D SNDS19^SDRPA07(ZTSK,.SDBCID,.SDMCID) K ^TMP("SDDPT",$J) S SDTR=0
 .Q
 Q:SDOUT
 I $O(^TMP("SDDPT",$J,"")) D SNDS19^SDRPA07(ZTSK,.SDBCID,.SDMCID)
 K ^TMP("SDDPT",$J)
 D MSGT^SDRPA04(CRUNID,SDPEN,SDFIN)
 Q
STMES ;generate start message
 N SDS,SD870,SD87
 S SD870=$O(^HLCS(870,"B","SD-PAIT",""))
 N ARRAY D GETS^DIQ(870,SD870_",",4,"I","ARRAY")
 N SD87 S SD87=SD870_","
 S SDSTAT=ARRAY(870,SD87,4,"I")
 D NOW^%DTC
 N SDDT,SDST S SDDT=%
 S SDST=$P($$SITE^VASITE(),"^",3)
 N SDAMX,XMSUB,CMY,XMTEXT,XMDUZ
 S XMSUB=$G(SDST)_" - PAIT START JOB"
 S XMY("G.SD-PAIT")=""
 S XMY("S.SD-PAIT-SERVER@FORUM.VA.GOV")=""
 S XMTEXT="SDAMX("
 S XMDUZ="POSTMASTER"
 S SDAMX(1)="The PAIT job has started - TASK #: "_ZTSK
 S SDAMX(2)="Site   Started       SD-PAIT status    Task #"
 S SDAMX(3)=SDST_"  |"_SDDT_" |"_SDSTAT_"    |"_ZTSK
 ;
 I SDSTAT="Shutdown" S XMY("VHACIONHD@MED.VA.GOV")="" D
 .S SDAMX(4)=" Please start a REMEDY ticket for station "_SDST
 .S SDAMX(5)="SD-PAIT Logical Link has to be started."
 .S SDAMX(6)="Refer the ticket to Scheduling PAIT."
 .S SDAMX(7)=""
 D ^XMD
 Q
 ;
GT90DAYS(X1,X2) ; Date is older than Sep 1st 2003, see specs.
 ; X1 - creation date. More efficient to have it set at the top instead of every time this subroutine is called.
 ; X2 - comparison date, now sent as Sep 1 2003, both in Vista format cyymmdd
 D ^%DTC
 Q X>0  ;
STAT(SDSTTY,SDFF,SDFIN,SDPEN,SDF) ;summarize pending and finals
 I SDSTTY="F" S SDFIN=SDFIN+1 Q
 I SDSTTY="P" S SDPEN=SDPEN+1 I SDFF="F" S SDF=SDF+1
 Q
