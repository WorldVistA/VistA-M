SDCOM ;ALB/RMO - Process Completion - Check Out ;12 MAR 1993 11:10 am ; 1/19/07 1:37pm
 ;;5.3;Scheduling;**15,60,105,132,466,495**;Aug 13, 1993;Build 50
 ;
EN(SDOE,SDMOD,SDCPHDL,SDCOMF) ;Complete Check Out Process
 ; Input  -- SDOE     Outpatient Encounter file IEN
 ;           SDMOD    1=Interactive and 0=Non-interactive
 ;           SDCPHDL  Check Out Completion Handle  [Optional]
 ; Output -- SDCOMF   0=Incomplete, 1=Complete, 2=Already Complete
 N SDEVTF
 I $P($G(^SCE(+SDOE,0)),"^",7) S SDCOMF=2 G Q
 I '$$CHK(SDOE) S SDCOMF=0 W:$G(SDMOD) !!,*7,">>> ",$$ORG^SDCOU($P($G(^SCE(+SDOE,0)),"^",8))," not checked out.  Required information missing." G Q
 I '$G(SDCPHDL) N SDATA,SDCPHDL S SDEVTF=1 D EVT^SDCOU1(SDOE,"BEFORE",.SDCPHDL,.SDATA)
 D UPD(SDOE) S SDCOMF=1 I $G(SDMOD) D MSG
 I $G(SDEVTF),$G(SDCPHDL) D EVT^SDCOU1(SDOE,"AFTER",SDCPHDL,.SDATA)
Q Q
 ;
CHK(SDOE) ;Check if Process is Complete for Check Out
 ; Input  -- SDOE     Outpatient Encounter file IEN
 ; Output -- Process is Complete for Check Out
 ;           1=Yes and 0=No
 N DFN,SDCHK,SDCL,SDCLOEY,SDCOQUIT,SDCTI,SDDA,SDOE0,SDOEP,SDORG,SDSCDI,SDT,SCPROCA
 S SDOE0=$G(^SCE(+SDOE,0)),SDT=+SDOE0,DFN=+$P(SDOE0,"^",2),SDSCDI=$P(SDOE0,"^",3),SDCL=+$P(SDOE0,"^",4),SDOEP=+$P(SDOE0,"^",6),SDORG=+$P(SDOE0,"^",8),SDDA=+$P(SDOE0,"^",9)
 S SDCHK=1
 I SDOEP S SDCHK=0 G CHKQ
 I SDORG=1,'$$CODT^SDCOU(DFN,SDT,SDCL) D  G CHKQ:'SDCHK
 .I $$REQ^SDM1A(SDT)="CO" S SDCHK=0 Q
 .D DT^SDCO1(DFN,SDT,SDCL,SDDA,0,"",.SDCOQUIT)
 I $$REQ^SDM1A(SDT)'="CO" G CHKQ
 I SDORG=1,'$$CLINIC^SDAMU(SDCL) G CHKQ
 ;I "^1^2^"[("^"_SDORG_"^"),$$INP^SDAM2(DFN,SDT)="I" G CHKQ  ;SD*5.3*466 allow checks for inpatients as outpatients
 D CLASK^SDCO2(SDOE,.SDCLOEY)
 I $D(SDCLOEY) D  G CHKQ:'SDCHK
 .S SDCTI=0 F  S SDCTI=$O(SDCLOEY(SDCTI)) Q:'SDCTI  I $G(SDCLOEY(SDCTI))="" S SDCHK=0
 ;sent encounter to ASCD for review
 I $D(SDCLOEY(3)) D
 .N SCDXS,SCAMDX,DXS D GETDX^SDOE(SDOE,"SCDXS")
 .S DXS=0 F  S DXS=$O(SCDXS(DXS)) Q:'DXS  S SCAMDX(+SCDXS(DXS))=""
 .I $O(SCAMDX(0)) D ST^SDSCAPI(SDOE,.SCAMDX)
 I $$PRASK^SDCO3(SDOE),'$$PRV^SDOE(SDOE) S SDCHK=0 G CHKQ
 I $$DXASK^SDCO4(SDOE),'$$GETPDX^SDOE(SDOE) S SDCHK=0 G CHKQ
 I '$$CPT^SDOE(SDOE) S SDCHK=0 G CHKQ
CHKQ Q +$G(SDCHK)
 ;
UPD(SDOE) ;Update Check Out Process Completion Date
 ; Input  -- SDOE     Outpatient Encounter file IEN
 ; Output -- Update Check Out Process Completion Date
 N DA,DE,DIE,DQ,DR
 G UPDQ:'$D(^SCE(+SDOE,0))
 S DA=+SDOE,DIE="^SCE(",DR=".07///NOW"
 D ^DIE
UPDQ Q
 ;
MSG ;Check Out Message
 W !!?8,"...checked out ",$$FTIME^VALM1($P($G(^SCE(+SDOE,0)),"^",7))
 Q
