SCMCTMU2 ;ALB/REW - Team-Patient Utilities ; 1 Apr 96
 ;;5.3;Scheduling;**41,51,148**;AUG 13, 1993
 ;1
RESTENR ;call when pt is set to 'restrict consults' & he is enrolled in clinic
 G:'$G(DFN) END
 S SCCL=0
 F  S SCCL=$O(^TMP($J,"SC CED","AFTER","B",SCCL)) Q:'SCCL  D
 .W !,SCCL
END Q
 ;
YSPTTMPC(DFN,SCACT) ;is it ok to give patient a new pc team?
 ;  Return [OK:1,Not OK: 0^Message]
 N SCOK,SCX,SCTM
 ;does pt have a current pc team?
 S SCTM=$$GETPCTM^SCAPMCU2(DFN,DT,1)
 IF SCTM>0 S SCOK="0^Pt has current PC Team Assignment"_U_SCTM G QTOKPC
 ;does pt have a future pc team?
 S SCX=$O(^SCPT(404.42,"APCTM",DFN,1,SCACT))
 IF SCX D  G QTOKPC
 .S SCTM=$O(^SCPT(404.42,"APCTM",DFN,1,+SCX,0))
 .S SCOK="0^Patient has future PC Assignment to the "_$P($G(^SCTM(404.51,+SCTM,0)),U,1)_" team."_U_SCTM
 S SCOK=1
QTOKPC Q SCOK
 ;
OKACPTTM(DFN,SCTM,SCDATE,SCACTIVE) ;is patient active from now till forever?
 ; Returned: 1: Not active from now till forever, 0 = Active sometime
 ;   DFN     - Pointer to Patient File
 ;   SCTM    - Team File ien of interest
 ;   SCDATE  - Start Date
 ;   SCACTIVE- Must Team be active on date or just sometime in future?
 N SCTMDT,SCOK,SCACERR,SCACLST
 S SCOK=1
 S SCTMDT("BEGIN")=$G(SCDATE,DT)
 S SCTMDT("END")=3990101 ;forever
 S SCTMDT("INCL")=0
 S SCACTIVE=$G(SCACTIVE,1)
 ; if checking for active teams
 IF SCACTIVE&('$$ACTHIST^SCAPMCU2(404.58,.SCTM,.SCTMDT,"SCACERR","SCACLST")) S SCOK=0 G ENDOKTM
 S SCOK=$$TMPT^SCAPMC(DFN,"SCTMDT",,"SCACLST","SCACERR")
 S:SCOK>0&($D(SCACLST("SCTM",SCTM))) SCOK=0
ENDOKTM Q SCOK
 ;
OKPTTMPC(DFN,SCTM,DATE) ;
 N SCOK,SCPCTM
 S SCOK=1
 ;is this a possible pc team?
 IF '$P($G(^SCTM(404.51,+$G(SCTM),0)),U,5) S SCOK=0 G QTOKTM
 S SCPCTM=$$GETPCTM^SCAPMCU2(DFN,DATE,1)
 IF SCPCTM D  G QTOKTM
 .IF SCPCTM'=SCTM D
 ..S SCOK=0
 ELSE  D
 .S SCOK=$$YSPTTMPC(DFN,DATE)
QTOKTM Q SCOK
 ;
OKINPTTM(DFN,SCTM,SCINACT) ;no future pt-position assignments?
 Q:'($G(DFN)&($G(SCTM))&($G(SCINACT))) 0
 N SCTP,SCPTTPDT,SCPTTPI,SCPTTP0,OK
 S SCTP=0,OK=1
 F  S SCTP=$O(^SCPT(404.43,"ADFN",DFN,SCTP)) Q:'SCTP  D  Q:'OK
 .F SCPTTPDT=0:0 S SCPTTPDT=$O(^SCPT(404.43,"ADFN",DFN,SCTP,SCPTTPDT)) Q:'SCPTTPDT  D
 ..S SCPTTPI=$O(^SCPT(404.43,"ADFN",DFN,SCTP,SCPTTPDT,0))
 ..S SCPTTP0=$G(^SCPT(404.43,SCPTTPI,0))
 ..Q:$P($G(^SCTM(404.57,+$P(SCPTTP0,U,2),0)),U,2)'=SCTM  ;ignore other teams
 ..S:'$P(SCPTTP0,U,4) OK=0  ;all ptpos assignments must have inact date
 ..S:$P(SCPTTP0,U,4)>SCINACT OK=0  ;all ptpos inact dates after tm inact
 Q OK
