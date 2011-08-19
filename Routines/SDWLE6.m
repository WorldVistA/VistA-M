SDWLE6 ;;IOFO BAY PINES/OG - WAITING LIST-ENTER/EDIT - INTER-FACILITY TRANSFER  ; Compiled January 25, 2007 09:47:40
 ;;5.3;scheduling;**446**;AUG 13 1993;Build 77
 ;
 ;  ******************************************************************
 ;  CHANGE LOG
 ;       
 ;   DATE         PATCH    DESCRIPTION
 ;   ----         -----    -----------
 ;   
 ;
EN(SDWLDFN,SDWLERR) ; Entry Point
 ; Extrinsic function. Quit back one of the following values
 ;  0 : Inter-Facility Transfer not selected, continue with standard processing
 ;  1 : Inter-Facility selected, all processing performed here, quit out on return.
 ;  
 ;  SDWLERR passed back by reference, indicates to the calling routine 
 ;  whether to announce that the update to 409.3 was performed.
 ;  
 N ICN,SDWLIFTN,SDWLONSY,SDWLTY,SSN
 S SDWLIFTN=0,SDWLERR=1,SDWLONSY=0
 S ICN=$$GET1^DIQ(2,SDWLDFN,991.01),SSN=$$GET1^DIQ(2,SDWLDFN,.09)
 I ICN'="",$D(^SDWL(409.36,"AICN",ICN)) S SDWLONSY=1
 I SSN'="",$D(^SDWL(409.36,"SSN",SSN)) S SDWLONSY=1
 D:SDWLONSY
 .N DIR,SDWLARR,SDWLI,SDWLIFN0,SDWLILM,TMP
 .S SDWLIFN0="",SDWLILM=23
 .I ICN'="" F  S SDWLIFN0=$O(^SDWL(409.36,"AICN",ICN,SDWLIFN0)) Q:SDWLIFN0=""  S TMP(SDWLIFN0)=""
 .I SSN'="" F  S SDWLIFN0=$O(^SDWL(409.36,"SSN",SSN,SDWLIFN0)) Q:SDWLIFN0=""  S TMP(SDWLIFN0)=""
 .F  S SDWLIFN0=$O(TMP(SDWLIFN0)) Q:SDWLIFN0=""  D
 ..N SDWLIL,SDWLINS,SDWLINSX,SDWLINX,TMP
 ..D GETS^DIQ(409.36,SDWLIFN0_",",".1;1;4",,"TMP")
 ..Q:"P"'[$E(TMP(409.36,SDWLIFN0_",",1))
 ..S SDWLINS=TMP(409.36,SDWLIFN0_",",.1),SDWLINSX=$$GET1^DIQ(4,SDWLINS,.01)
 ..S SDWLIL=$L(SDWLINSX) S:SDWLIL>SDWLILM SDWLILM=SDWLIL
 ..S SDWLARR(0)=$G(SDWLARR(0))+1
 ..S SDWLARR(SDWLARR(0),0)=SDWLINSX_U_TMP(409.36,SDWLIFN0_",",4)_U_SDWLIFN0_U_$$GET1^DIQ(4,SDWLINS,4,"I")
 ..Q
 .Q:'$D(SDWLARR)
 .W !,"This patient has the following pending Inter-Facility Transfer entr"_$S(SDWLARR(0)=1:"y",1:"ies")_":"
 .W !?5,"Requesting Facility",?SDWLILM+5,"Wait List Type"
 .F SDWLI=1:1:SDWLARR(0) W !,SDWLI,?5,$P(SDWLARR(SDWLI,0),U),?SDWLILM+5,$P(SDWLARR(SDWLI,0),U,2)
 .S DIR("A")="Enter a number"
 .S DIR("A",1)="Select to associate this EWL entry with a transfer from the listed facility "
 .S DIR("A",2)="or ^ to continue without selecting."
 .S DIR(0)="N^1:"_SDWLARR(0) D ^DIR
 .Q:Y="^"
 .S SDWLIFTN=$P(SDWLARR(Y,0),U,3),SDWLTY=$P(SDWLARR(Y,0),U,2)
 .Q
 Q:'SDWLIFTN 0  ; Continue with normal EWL enter/edit.
 D EN2(SDWLIFTN,SDWLDFN,SDWLTY)
 Q 1  ; Return true: user chose to process transfer.
 ;
EN2(SDWLIFTN,SDWLDFN,SDWLTY) ; Entry point if transfer record is selected elsewhere.
 N DFN,SDWLCM,SDWLCP1,SDWLCP2,SDWLCP3,SDWLCP4,SDWLCP5,SDWLCP6,SDWLDDA,SDWLIN,SDWLOPT,SDWLPCMM,SDWLPN,SDWLPOS,SDWLSCO,SDWLSPO,SDWLSSO,SDWLSTO,SDWLTEM,SDWLTM
 I $G(SDWLDFN)="" W !,"Patient not entered on the system. Use Load/edit" S DIR(0)="E" D ^DIR Q
 L +^SDWL(409.36,SDWLIFTN):1
 I '$T W !,"Unable to acquire lock on transfer file" S DIR(0)="E" D ^DIR Q
 S DFN=SDWLDFN D PCM^SDWLE1
 ; Call each "P" subroutine for Wait List data items. Controlled by the value of SDWLOPT.
 S SDWLOPT=1,(SDWLIN,SDWLTM,SDWLPN,SDWLDDA,SDWLCM)=""
 F  D @("P"_SDWLOPT) Q:'SDWLOPT
 L -^SDWL(409.36,SDWLIFTN)
 Q
 ;
P1 ; Wait List Type
 N DIR
 S DIR(0)="SO^1:PCMM TEAM ASSIGNMENT;2:PCMM POSITION ASSIGNMENT"
 S DIR("L",1)="     Select Wait List Type:"
 S DIR("L",2)="     1. "_$P($P(DIR(0),U,2),":",2)
 S DIR("L",3)="     2. "_$P($P(DIR(0),U,3),":",2)
 I SDWLTY'="" S DIR("B")=SDWLTY
 D ^DIR
 I "^"[Y S SDWLOPT=0 Q
 S SDWLTY=Y,SDWLOPT=SDWLOPT+1
 Q
 ;
P2 ; Institution
 N DIC,SDWLINL,SDWLTM
 I SDWLTY=1 S DIC("S")="I $D(^SCTM(404.51,""AINST"",+Y))"
 I SDWLTY=2 D
 .N SDWLI
 .I 'SDWLCP3 S SDWLI=0 F  S SDWLI=$O(^SCTM(404.57,SDWLI)) Q:'SDWLI  D
 ..N SDWLL
 ..S SDWLL=+$P($G(^SCTM(404.57,SDWLI,0)),U,2)
 ..S SDWLINL=+$P($G(^SCTM(404.51,+SDWLL,0)),U,7)
 ..S SDWLINL(SDWLINL)=""
 ..Q
 .S DIC("S")="I $D(SDWLINL(+Y))"
 .Q
 S DIC("S")=DIC("S")_",$$GET1^DIQ(4,+Y_"","",11,""I"")=""N"",$$TF^XUAF4(+Y)"
 I SDWLIN'="" S DIC("B")=$$EXTERNAL^DILFD(4,.01,,SDWLIN)
 S DIC(0)="AEQNM",DIC="4",DIC("A")="Select Institution: "
 D ^DIC
 I Y="^" S SDWLOPT=0 Q
 I Y<1 S SDWLOPT=SDWLOPT-1 Q
 I SDWLTY=1 D GETTEAMS(+Y,.SDWLTM) I '$D(SDWLTM) W !,"No TEAMS are available for this INSTITUTION." Q
 S SDWLIN=+Y,SDWLOPT=SDWLOPT+1
 Q
 ;
P3 ; Team or Team Position
 N DIR,SDWLPNS
 I $G(SDWLCP3)'="" D  I Y["^"!'Y S SDWLOPT=0 Q
 .N DIR
 .W !,"This patient is already on the ",SDWLCP3,"."
 .S DIR(0)="Y^A0",DIR("B")="NO",DIR("A")="Are you sure you want to continue"
 .D ^DIR
 .Q
 I SDWLTY=1 D  Q
 .N DIR
 .I $G(SDWLTM)'="" S DIR("B")=$$EXTERNAL^DILFD(404.58,.01,,SDWLTM)  ; Not sure this is ever true.
 .D GETTEAMS(SDWLIN,.SDWLTM)
 .S DIR(0)="PAO^SCTM(404.51,:EMNZ",DIR("A")="Select Team: "
 .S DIR("S")="I $D(SDWLTM(+Y))"
 .D ^DIR
 .I Y="^" S SDWLOPT=0 Q
 .I Y<1 S SDWLOPT=2 Q
 .S SDWLTM=+Y,SDWLOPT=SDWLOPT+1
 .Q
 I $G(SDWLPN)'="" S DIR("B")=$$EXTERNAL^DILFD(404.57,.01,,SDWLPN)  ; Not sure this is ever true.
 D GETPSNS(.SDWLPNS) I '$D(SDWLPNS) W !,"No Positions Meet Wait List Criteria" S SDWLOPT=1 Q
 S DIR(0)="PAO^SCTM(404.57,:EMNZ",DIR("A")="Select Team Position: "
 S DIR("S")="I $D(SDWLPNS(+Y))"
 D ^DIR
 I Y="^" S SDWLOPT=0 Q
 I Y<1 S SDWLOPT=SDWLOPT-1 Q
 S SDWLPN=+Y,SDWLOPT=SDWLOPT+1
 Q
 ;
P4 ; Comment
 N DIR
 S DIR(0)="FAOU^^",DIR("A")="Comments: ",DIR("B")=SDWLCM
 D ^DIR
 I Y="^" S SDWLOPT=0 Q
 I X="@" S SDWLOPT=SDWLOPT-1 Q
 S SDWLCM=$E(Y,1,60),SDWLOPT=SDWLOPT+1
 Q
 ;
P5 ; Update database
 N DA,DIC,DIE,X,DR,SDWLDA,SDWLSCPE,SDWLSCPR,SDWLTMP
 ; Create new EWL entry
 S DIC(0)="LX",X=SDWLDFN,DIC="^SDWL(409.3," D FILE^DICN
 L +^SDWL(409.3,DA):1  ; This file has just been created. Is it neurotic to code for the possibility of a lock from elsewhere?
 I '$T W !,"Unable to acquire a lock on the Wait List file" S SDWLOPT=5 Q
 ; Update EWL variables.
 D GETS^DIQ(409.36,SDWLIFTN_",",".301;.302","I","SDWLTMP")
 S SDWLSCPR=$G(SDWLTMP(409.36,SDWLIFTN_",",.301,"I"))="Y"
 S SDWLSCPE=$G(SDWLTMP(409.36,SDWLIFTN_",",.302,"I"))
 S SDWLDA=DA,DIE=DIC,DR="1////^S X=DT;2////^S X=SDWLIN;4////^S X=SDWLTY"
 I SDWLTY=1 S DR=DR_";5////^S X=SDWLTM"
 I SDWLTY=2 S DR=DR_";6////^S X=SDWLPN"
 S DR=DR_";9////^S X=DUZ"
 S DR=DR_";14////^S X=SDWLSCPE"
 S DR=DR_";15////^S X=SDWLSCPR"
 S DR=DR_";22////^S X=SDWLDDA"
 S DR=DR_";23////O"
 S DR=DR_";25////^S X=SDWLCM"
 S DR=DR_";27////^S X="""_$$GETENRST^SDWLE6(SDWLDFN)_""""
 D ^DIE
 L -^SDWL(409.3,DA)
 ; Update 409.36
 S DIE="^SDWL(409.36,",DA=SDWLIFTN,DR="1////E;409.3////^S X=SDWLDA" D ^DIE
 ; Pass message back to sending facility
 D SENDST^SDWLIFT6(SDWLIFTN)
 S SDWLOPT=0,SDWLERR=0
 Q
 ;
GETTEAMS(SDWLIN,SDWLTM) ; Get teams for an institution ; NB this is reworking of code in SDWLE3.
 N Y,SDWLST,SDWLINE,SDWLPLST,TMHSID K SDWLTM
 S SDWLINE=SDWLIN
 D GETLIST^SDWLE3
 S TMHSID=""  ; Team history
 F  S TMHSID=$O(^SCTM(404.58,"B",TMHSID)) Q:TMHSID=""  D:$P($G(^SCTM(404.51,TMHSID,0)),U,7)=SDWLIN
 .N TMID  ; Team
 .S TMID=$O(^SCTM(404.58,"B",TMHSID,":"),-1) Q:TMID=""
 .Q:$D(SDWLPLST(1,TMID,SDWLIN))
 .Q:$P($G(^SCTM(404.58,TMID,0)),U,3)=0
 .Q:'$$ACTTM^SCMCTMU(TMID)
 .I $$TEAMCNT^SCAPMCU1(TMHSID,DT)>$P($G(^SCTM(404.51,TMHSID,0)),U,8) S SDWLTM(TMHSID)=""
 .Q
 Q
 ;
GETPSNS(SDWLPN) ; Get positions ; NB this is reworking of code in SDWLE5.
 N SDWLPSS,SDWLPDA,SDWLX,SDWLA,SDWLCPP,SDWLCPT K SDWLPN
 D GETLIST^SDWLE5
 Q:'$D(SDWLCPP)
 S SDWLA=0
 F  S SDWLA=$O(^SCTM(404.57,SDWLA)) Q:'SDWLA  D:$D(SDWLCPP(SDWLA))&'$D(SDWLPSS(SDWLA))
 .N X
 .S X=$G(^SCTM(404.57,SDWLA,0))
 .Q:$P(X,U,2)'=SDWLCPT
 .S:$P(X,U,8)'<$$PCPOSCNT^SCAPMCU1(SDWLA,DT,0)&$P(X,U,4) SDWLPN(SDWLA)=""
 .Q
 Q
 ;
GETENRST(SDWLDFN) ; Determine enrollee status ; NB this is reworking of code in SDWLE11.
 N SDWLE
 S SDWLE=1 D
 .N SDWLX,SDWLY,%H
 .I '$D(^DGCN(391.91,"B",SDWLDFN)) S SDWLE=3 Q
 .; Loop backwards through the B cross reference of TREATING FACILITY LIST until there is a DATE LAST TREATED entry.
 .; If that is less than 730 days ago, SDWLE=2; otherwise, SDWLE=3. Then quit from the loop.
 .S SDWLX=""
 .F  S SDWLX=$O(^DGCN(391.91,"B",SDWLDFN,SDWLX),-1) Q:SDWLX=""  S SDWLY=$G(^DGCN(391.91,SDWLX,0)) I $P(SDWLY,U,3) S X=$P(SDWLY,U,3) D H^%DTC S SDWLE=$H-%H'<730+2 Q
 .Q
 D:SDWLE'=2
 .N SDWLRNE,%H
 .S SDWLRNE=$$ENROLL^EASWTAPI(SDWLDFN)
 .I $P(SDWLRNE,U,3) S X=$P(SDWLRNE,U,3) D H^%DTC S SDWLE=$H-%H>365*2+1  ; If number of days is greater than a year, SDWLE=3; otherwise, SDWLE=1.
 .I 'SDWLRNE S SDWLE=4
 .Q
 Q $S(SDWLE=1:"N",SDWLE=2:"E",SDWLE=3:"P",SDWLE=4:"U")
 ;
DIS(SDWLDA) ; Action on disposition
 N DIE,DR,SDWLDIS,SDWLIFTN,SDWLSTA,X
 S SDWLIFTN=$O(^SDWL(409.36,"C",SDWLDA,"")) Q:'SDWLIFTN
 S SDWLDIS=$$GET1^DIQ(409.3,SDWLDA,21,"I")
 ; If disposition is because entered in error, reset to pending. Otherwise, set to closed.
 S SDWLSTA=$S(SDWLDIS="ER":"P",1:"C")
 S DIE="^SDWL(409.36,",DA=SDWLIFTN,DR="1///"_SDWLSTA D ^DIE
 ; Pass message back to sending facility
 D SENDST^SDWLIFT6(SDWLIFTN)
 Q
