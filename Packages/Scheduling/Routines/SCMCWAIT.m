SCMCWAIT ;ALB/SCK - Broker Utilities for Placement on Wait List ; 30 Oct 2002  3:42 PM  ; Compiled May 25, 2007 09:07:17
 ;;5.3;Scheduling;**264,297,446**;AUG 13, 1993;Build 77
 ;
 Q
 ;
WAIT(SCOK,SC) ; Place patient on wait list
 ;  'SC BLD PAT CLN LIST'
 ;
 ;M ^JDS=SC
 N COMMENT,SDTM,SDCNT,SDINS,SDINTR,SDMTM,SDREJ,SDWLIN
 S TEAM=$G(SC("TEAM")),POS=$G(SC("POSITION")),DFN=$G(SC("DFN")),COMMENT=$G(SC("COMMENT")),SC=$G(SC("SC"))
 S SDWLIN=+$P($G(^SCTM(404.51,+$G(TEAM),0)),U,7),SDINTR=$G(SC("SDINTR")),SDREJ=$G(SC("SDREJ")),SDMTM=$G(SC("SDMTM"))
 ; check if transfer and if multiple teams in institution
 S SDCNT=0,SDINTR="",SDREJ="",SDMTM="",SDCC=TEAM
 ;identify INTRA-transfer
 ;- is patient assigned to PC provider?
 I 'POS&TEAM D PCPVER(DFN,.SDTM) D  ; return current PCP team or 0
 .I SDTM I $P($G(^SCTM(404.51,SDTM,0)),U,7)'=SDWLIN S SDINTR=1 ; inter transfer ; different institution
 .I 'SDTM S SDINS="" F  S SDINS=$O(^SCTM(404.51,"AINST",SDINS)) Q:SDINS=""  I SDINS'=SDWLIN D  Q:SDREJ
 ..;check available PCMM teams in other institutions and if so set up rejection flag
 ..N SDT S SDCNT=0,SDT=""
 ..F  S SDT=$O(^SCTM(404.51,"AINST",SDINS,SDT)) Q:SDT=""  D  Q:SDREJ
 ...I $$ACTTM^SCMCTMU(SDT)&($P($G(^SCTM(404.51,SDT,0)),U,5))&'$P($G(^SCTM(404.51,SDT,0)),U,10) D
 ...N SCTMCT S SCTMCT=$$TEAMCNT^SCAPMCU1(SDT) ;currently assigned
 ...N SCTMMAX S SCTMMAX=$P($$GETEAM^SCAPMCU3(SDT),"^",8) ;maximum set
 ...I SCTMCT<SCTMMAX S SDREJ=1
 ..;find all teams from institution SDWLIN
 .I SDINTR S SDCNT=0,SDT="" D
 ..F  S SDT=$O(^SCTM(404.51,"AINST",SDWLIN,SDT)) Q:SDT=""  I $P(^SCTM(404.51,SDT,0),U,5)=1 S TEAM(SDT)="",SDCNT=SDCNT+1
 I SDCNT>1 S SDMTM=1 S SDCC="" F  S SDCC=$O(TEAM(SDCC)) Q:SDCC=""  N DR,Y D WT Q
 I SDCNT'>1 D WT Q
WT N RES D INPUT^SDWLRP1(.RES,DFN_U_$S(POS:2,1:1)_U_SDCC_U_$S(POS:POS_U_DUZ,1:U_DUZ)_U_COMMENT_U_SC_U_SDINTR_U_SDREJ_U_SDMTM)
 I RES S SDWLRES=RES  ; 446
 Q
WAITS(DFN,TEAM,POS,SC) ; PLACE PATIENT ON WAIT LIST
 N SDCC,SDTEAM,SDINTR,SDMTM,SDREJ,SDWLIN,SDWLRES
 S SDTEAM=$G(TEAM)
 ; check if transfer and if multiple teams in institution
 S SDCNT=0,SDINTR="",SDREJ="",SDMTM="" I 'POS&TEAM D
 .S SDWLIN=$P($G(^SCTM(404.51,TEAM,0)),U,7)
 .;- is patient assigned to PC provider?
 I 'POS&TEAM D PCPVER(DFN,.SDTM) D  ; return current PCP team or 0
 .I SDTM I $P($G(^SCTM(404.51,SDTM,0)),U,7)'=SDWLIN S SDINTR=1 ; inter transfer ; different institution
 .I 'SDTM S SDINS="" F  S SDINS=$O(^SCTM(404.51,"AINST",SDINS)) Q:SDINS=""  I SDINS'=SDWLIN D  Q:SDREJ
 ..;check available PCMM teams in other institutions and if so set up rejection flag
 ..N SDT S SDCNT=0,SDT=""
 ..F  S SDT=$O(^SCTM(404.51,"AINST",SDINS,SDT)) Q:SDT=""  D  Q:SDREJ
 ...I $$ACTTM^SCMCTMU(SDT)&($P($G(^SCTM(404.51,SDT,0)),U,5))&'$P($G(^SCTM(404.51,SDT,0)),U,10) D
 ...N SCTMCT S SCTMCT=$$TEAMCNT^SCAPMCU1(SDT) ;currently assigned
 ...N SCTMMAX S SCTMMAX=$P($$GETEAM^SCAPMCU3(SDT),"^",8) ;maximum set
 ...I SCTMCT<SCTMMAX S SDREJ=1
 ..;find all teams from institution SDWLIN
 .I SDINTR S SDCNT=0,SDT="" D
 ..F  S SDT=$O(^SCTM(404.51,"AINST",SDWLIN,SDT)) Q:SDT=""  I $P(^SCTM(404.51,SDT,0),U,5)=1 S TEAM(SDT)="",SDCNT=SDCNT+1
 I SDCNT>1 S SDMTM=1 S SDCC="" F  S SDCC=$O(TEAM(SDCC)) Q:SDCC=""  S TEAM=SDCC N DR,Y S SDWLRES=$$WMT
 I SDCNT'>1 N DR,Y S SDWLRES=$$WMT
 S TEAM=$G(SDTEAM) Q $G(SDWLRES)
WMT() N RES
 D INPUT^SDWLRP1(.RES,DFN_U_$S(POS:2,1:1)_U_TEAM_U_$S(POS:POS_U_DUZ,1:U_DUZ)_"^^"_SC_U_SDINTR_U_SDREJ_U_SDMTM)
 I $G(RES) D
 .N DA,DIE,DIK,DR,OK
 .S SDWLRES=RES  ; 446
 .S OK=0,DA=+$P(RES,U,2),DIE="^SDWL(409.3,",DR="25;S OK=1"
 .D ^DIE
 .I 'OK S DIK=DIE D ^DIK W !,"Wait list entry deleted" S RES=0
 Q $G(RES)
TEAMRM(DFN,TEAM) ;
 N SDTM D PCPVER(DFN,.SDTM) I 'SDTM D CLONE(DFN,TEAM) Q  ;not PC panel assignment
 I SDTM'=TEAM D CLONE(DFN,TEAM) Q  ;TEAM IS NOT PCP
 ;close EWL entries only if assignment to PC panel, not necessarily to a team                                   
 N I
 F I=0:0 S I=$O(^SDWL(409.3,"B",+$G(DFN),I)) Q:'I  S A=$G(^SDWL(409.3,I,0)) D
 .I 12'[$P(A,U,5) Q
 .;I $P(A,U,6)'=$G(TEAM) Q
 .I $G(^SDWL(409.3,I,"DIS")) Q
 .;INACTIVATE I
 .N FDA S FDA(409.3,I_",",21)="SA"
 .S FDA(409.3,I_",",19)=DT,FDA(409.3,I_",",23)="C"
 .S FDA(409.3,I_",",20)=DUZ
 .D UPDATE^DIE("","FDA")
 Q
POSRM(TEAMP,POS) ;
 ; 
 S DFN=+$G(^SCPT(404.42,+$G(TEAMP),0))
 N SDTM D PCPVER(DFN,.SDTM) I 'SDTM D CLONE(DFN,TEAMP,POS) Q  ;not PC panel assignment
 I SDTM'=TEAMP D CLONE(DFN,TEAMP,POS) Q
 I $G(POS) I '$P($G(^SCPT(404.43,+POS,0)),U,5) Q   ;not pc
 I '$P($G(^SCPT(404.42,+$G(TEAMP),0)),U,8) Q   ;not pc
 ;S ^JDS("TEAMP")=TEAMP,^JDS("POS")=POS,^JDS("DFN")=DFN
 N I
 F I=0:0 S I=$O(^SDWL(409.3,"B",+$G(DFN),I)) Q:'I  S A=$G(^SDWL(409.3,I,0)) D
 .I 12'[$P(A,U,5) Q
 .;I $P(A,U,7)'=$G(POS) Q
 .I $G(^SDWL(409.3,I,"DIS")) Q
 .N FDA S FDA(409.3,I_",",21)="SA",FDA(409.3,I_",",23)="C"
 .S FDA(409.3,I_",",19)=DT
 .S FDA(409.3,I_",",20)=DUZ
 .D FILE^DIE("","FDA")
 .;INACTIVATE
 Q
CLONE(DFN,TEAM,POS) ;clean one entry only or two if position
 N I,SDONE S SDONE=0
 F I=0:0 S I=$O(^SDWL(409.3,"B",+$G(DFN),I)) Q:'I  S A=$G(^SDWL(409.3,I,0)) D  Q:SDONE
 .I 12'[$P(A,U,5) Q
 .I $P(A,U,5)=1 I $P(A,U,6)'=$G(TEAM) Q
 .I $P(A,U,5)=2 I $P(A,U,6)'=$G(POS) Q
 .I $G(^SDWL(409.3,I,"DIS")) Q
 .;INACTIVATE I
 .N FDA S FDA(409.3,I_",",21)="SA"
 .S FDA(409.3,I_",",19)=DT,FDA(409.3,I_",",23)="C"
 .S FDA(409.3,I_",",20)=DUZ
 .D UPDATE^DIE("","FDA")
 .S SDONE=1
 Q
PCPVER(DFN,SDTM) ;verify if PCP assignment
 S SDTM=0 ; return 0 if no PCP assignment
 K ^TMP("SDPCP",$J)
 N SDATE,SDPCP
 N SDI F SDI="BEGIN","END" S SDATE(SDI)=DT
 S SDATE="SDATE",SDPCP="^TMP(""SDPCP"",$J)"
 ;
 N SDI S SDI=$$GETALL^SCAPMCA(DFN,.SDATE,SDPCP)
 N SDII S SDII=0
 F  S SDII=$O(^TMP("SDPCP",$J,DFN,"PCPOS",SDII)) Q:'SDII  D
 .N SDX S SDX=^TMP("SDPCP",$J,DFN,"PCPOS",SDII)
 .I +$P(SDX,U,7)'=2 Q  ;PCP role
 .I +$P(SDX,U,6)>0&(+$P(SDX,U,6)<DT) Q
 .S SDTM=$P(SDX,U,3)
 Q
ONWAIT(DFN) ;is patient on wait list
 D DEM^VADPT I $G(VADM(6)) Q 9  ;Patient is dead
 N I,X
 S X=0
 F I=0:0 S I=$O(^SDWL(409.3,"B",+$G(DFN),I)) Q:'I  S A=$G(^SDWL(409.3,I,0)) D  Q:X
 .I 12'[$P(A,U,5) Q
 .I $G(^SDWL(409.3,I,"DIS")) Q
 .S X="3;ON WAITLIST TEAM: "_$P($G(^SCTM(404.51,+$P(A,U,6),0)),U)
 .I $P(A,U,7) S X=X_" POSITION: "_$P($G(^SCTM(404.57,+$P(A,U,7),0)),U)
 I X Q X
 ;Q X
 ;CHECK IF ON TEAM
 N SCD,SCDT,SCOK S SCOK=$$TMPT^SCAPMC3(DFN,"SCDT","","SCD","SCER1") I $D(SCD(1)) S X=1
 N SCPOS S SCOK=$$TPPT^SCAPMC(DFN,.SCDT,"","","","","","SCPOS","SCBKERR") I $D(SCPOS(1)) S X=2
 Q X
 ;CHECK IF ON POSITION
SORT ;From sort template
 S X=0
 Q
PC(RESULT,POS) ;rpc to see if provider can be pc
 N POENT,RES
 D ROLE(.RES,POS) I RES=1 S RESULT(0)=0 Q
 S POENT=+$O(^SCTM(404.52,"AIDT",+$G(POS),1,-(DT+.1))),POENT=$O(^(POENT,0))
 ;S PROV=+$P($G(^SCTM(404.52,+$G(POENT),0)),U,3)
 I 'POENT S RESULT(0)=1 Q
 N D0 S D0=+$G(POENT) D SORT S RESULT(0)=X
 Q
ROLE(RESULT,POS) ;rpc to see if role of position is resident
 N ZERO S ZERO=$G(^SCTM(404.57,+$G(POS),0))
 I $P(ZERO,U,4) S RESULT=0 Q  ;Already pc let them change it.
 S RESULT=0
 I $P($G(^SD(403.46,+$P(ZERO,U,3),0)),U)="RESIDENT (PHYSICIAN)" S RESULT=1
 Q
SC(DFN) ;Is patient 0-50 sc%
 N TEAM,INST S TEAM=$P(DFN,U,2),INST=+$P($G(^SCTM(404.51,+TEAM,0)),U,7)
 S X=0,DFN=+DFN
 N A D ELIG^VADPT S A=$G(VAEL(3)) I $P(A,U)'="Y" Q 0
 I $P(A,U,2)<50 Q $P(A,U,2)
 Q 0
SCLI(RESULT,SC) ;sc sc list
 K RESULT N RES
 S DFN=+$G(SC("DFN"))
 D SDSC^SDWLRP3(.RES,DFN) I RES=-1 S RESULT(0)=-1 Q
 S RESULT(0)="<RESULTS>" N CNT,I S CNT=1 F I=0:0 S I=$O(^TMP("SDWLRP3",$J,I)) Q:'I  S RESULT(CNT)=^(I),CNT=CNT+1
