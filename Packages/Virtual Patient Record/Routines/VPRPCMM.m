VPRPCMM ;SLC/MKB/BLJ -- PCMM Utilities ;2/20/20  14:58
 ;;1.0;VIRTUAL PATIENT RECORD;**24,28**;Sep 01, 2011;Build 6
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References                          DBIA#
 ; -------------------                          -----
 ; SCMC PATIENT TEAM CHANGES                    7012
 ; SCMC PATIENT TEAM POSITION                   7013
 ; ^SCTM(404.52                                 7174
 ; %DTC
 ; %ZTLOAD                                     10063
 ; DIQ                                          2056
 ; SCAPMC                                       1916
 ; SDUTL3                                       1252
 ;
PCP ; -- get DLIST(#)=ien^role of PCP, team members
 ; Expects DFN, VPRTEAM = ien^name of PCTeam
 N PCP,ALL S PCP=$$OUTPTPR^SDUTL3(DFN)
 S:PCP>0 DLIST(1)=+PCP_"^PRIMARY CARE PROVIDER"
 S ALL=$$PRPT^SCAPMC(DFN,,,,,,"VPRPTP")     ;all prov's assigned to pt
MBRS ; -- enter here for just team members [expects VPRTEAM, VPRPTP]
 N VPRTM,VPRN,PRV,ROLE
 Q:'$G(VPRTEAM)                             ;set by *TeamName property
 Q:'$$PRTM^SCAPMC(+$G(VPRTEAM),,,,"VPRTM")  ;team members
 S VPRN=+$O(DLIST("A"),-1)
 S PRV=0 F  S PRV=$O(VPRTM("SCPR",PRV)) Q:PRV<1  I PRV'=+$G(PCP) D
 . S ROLE=+$O(VPRTM("SCPR",PRV,0))
 . Q:'$D(VPRPTP("SCPR",PRV,ROLE))           ;not assigned to pt
 . S VPRN=VPRN+1,DLIST(VPRN)=PRV_U_$$GET1^DIQ(404.57,ROLE,.01)
 . ; provider #200 ien ^ position name
 Q
 ;
MHTEAM(DFN) ; -- returns ien^name of MH Team, or ""
 N X,Y,VPRP,VPRTM
 S VPRP(4)="",X=$$TMPT^SCAPMC(DFN,,"VPRP","VPRTM"),Y=""
 I X S Y=$G(VPRTM(1))
 Q Y
 ;
PTEVT ; -- SCMC PATIENT TEAM CHANGES protocol listener
 ;I '$G(SCPCTM) Q  ;not pc change
 N DFN S DFN=$S($G(SCPTTMAF):+SCPTTMAF,1:+$G(SCPTTMB4)) Q:'DFN
 D QUE^VPRHS(DFN) ;POST^VPRHS(DFN,"Patient",DFN_";2")
 Q
 ;
PTPEVT ; -- SCMC PATIENT TEAM POSITION CHANGES protocol listener
 ;I '$G(SCPCTP) Q  ;not pc change
 N TM,DFN
 S TM=$S($G(SCPTTPAF):+SCPTTPAF,1:+$G(SCPTTPB4)) Q:'TM
 S DFN=+$$GET1^DIQ(404.42,TM_",",.01,"I")
 D QUE^VPRHS(DFN) ;POST^VPRHS(DFN,"Patient",DFN_";2")
 Q
 ;
PTPCEVT ; -- PROVIDER TEAM POSITION change tasked job.
 N U S U="^"
 N DFN,DATE,EFFDATE,POSITION,%
 S EFFDATE=9999999
 D NOW^%DTC S DATE=%-1 ; Get the last 24 hrs of changes.
 F  S EFFDATE=$O(^SCTM(404.52,"ADP",EFFDATE),-1) Q:EFFDATE<DATE  D
 .S POSITION=""
 .F  S POSITION=$O(^SCTM(404.52,"ADP",EFFDATE,POSITION)) Q:'POSITION  D
 ..K ^TMP("SC TMP LIST",$J)
 ..Q:'$$PTTP^SCAPMC(POSITION)
 ..S DFN=0
 ..F  S DFN=$O(^TMP("SC TMP LIST",$J,"SCPTA",DFN))  Q:+DFN<1  D QUE^VPRHS(DFN)
 K ^TMP("SC TMP LIST",$J)
 Q
