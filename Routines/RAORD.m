RAORD ;HISC/CAH,FPT,GJC AISC/RMO-Rad/NM Order Entry Main Menu ;3/13/98  12:16
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
2 ;;Schedule a Request
 N RAPTLOCK
21 ; Patient lookup
 S DIC="^DPT(",DIC(0)="AEMQ" W ! D ^DIC K DIC G Q2:Y<0
 I $$ORVR^RAORDU()'<3 D  G:'RAPTLOCK 21
 . S RAPTLOCK=$$LK^RAUTL19(+Y_";DPT(")
 . Q
 S RADFN=+Y,RANME=$S($D(^DPT(RADFN,0)):$P(^(0),"^"),1:"Unknown")
 S (RAOFNS,RAOPTN)="Schedule",RAOVSTS="3;5"
 W ! D ^RAORDS G Q2:'$D(RAORDS)
 S %DT("A")="Schedule Request Date/Time: ",%DT="AEFXT"
 W ! D ^%DT K %DT G Q2:Y<0 S RAOSCH=Y,RAOLP=0
 F  S RAOLP=+$O(RAORDS(RAOLP)) Q:'RAOLP!('+$G(RAORDS(RAOLP)))  D
 . S RAOIFN=$G(RAORDS(RAOLP)),RAOSTS=8 D ^RAORDU
 . Q
 D Q2 G 21
Q2 ; Unlock if appropriate, kill vars
 I $$ORVR^RAORDU()'<3,(+$G(RAPTLOCK)),(+$G(RADFN)) D
 . D ULK^RAUTL19(RADFN_";DPT(")
 K %DT,C,D,D0,DA,I,RADFN,RADIV,RANME,RAOFNS,RAOIFN,RAOLP,RAORDS,RAOSCH
 K RAOPTN,RAOSTS,RAOVSTS,X,Y
 K RAPARENT
 K A1,D1,DDER,DDH,DI,DIPGM,POP,^TMP($J,"PRO-ORD")
 Q
 ;
3 ;;Cancel a Request
 N RAPTLOCK,RAXIT S RAXIT=0,RAPKG=""
31 ; Patient lookup
 S DIC="^DPT(",DIC(0)="AEMQ" W ! D ^DIC K DIC G Q3:Y<0
 I $$ORVR^RAORDU()'<3 D  G:'RAPTLOCK 31
 . S RAPTLOCK=$$LK^RAUTL19(+Y_";DPT(")
 . Q
 S RADFN=+Y,RANME=$S($D(^DPT(RADFN,0)):$P(^(0),"^"),1:"Unknown")
 S (RAOFNS,RAOPTN)="Cancel"
 D CHKUSR^RAUTL2 S RAOVSTS=$S(RAMSG:"3;5;8",1:"5")
 W ! D ^RAORDS G Q3:'$D(RAORDS)
 D REASON G Q3:RAXIT!(+$G(OREND))
ENCAN ;OE/RR Entry Point for the CANCEL ACTION Option
 K ORSTRT,ORSTOP,ORTO,ORTX,ORIT,ORCOST,ORPURG
 I $D(RAPKG) W !?3,"...will now 'CANCEL' selected request(s)..."
 S RAOLP=0
 F  S RAOLP=+$O(RAORDS(RAOLP)) Q:'RAOLP!('+$G(RAORDS(RAOLP)))  D
 . S RAOIFN=$G(RAORDS(RAOLP)),RAOSTS=1 D ^RAORDU
 . I $D(RAPKG),$D(^RAO(75.1,RAOIFN,0)),$D(^RAMIS(71,+$P(^(0),"^",2),0)) W !?10,"...",$P(^(0),"^")," cancelled..."
 . ; Print Cancelled Requests if appropriate
 . K RA751,RA791 S RA751=$G(^RAO(75.1,RAOIFN,0))
 . S RA791=$G(^RA(79.1,+$P(RA751,"^",20),0))
 . I $P(RA791,"^",24)]""!(+$P($G(^RA(79.1,+$O(^RA(79.1,0)),0)),"^",24)) D
 .. K RACRHD,RAION,RAPGE,RAX S RAPGE=0,(RACRHD,RAX)=""
 .. ; RAOIFN already defined, RADFN may/maynot be defined!
 .. I '$D(RADFN) N RADFN S RADFN=+$P(RA751,"^")
 .. S RAION=$S($P(RA791,"^",24)]"":$P(RA791,"^",24),1:+$P($G(^RA(79.1,+$O(^RA(79.1,0)),0)),"^",24))
 .. S RAION=$$GET1^DIQ(3.5,RAION_",",.01)
 .. D PCR ; Print Cancelled Request subroutine
 .. K RACRHD,RAION,RAPGE,RAX
 .. Q
 . K RA751,RA791
 . Q
Q3 ; unlock if appropriate, kill variables
 I $$ORVR^RAORDU()'<3,(+$G(RAPTLOCK)),(+$G(RADFN)) D
 . D ULK^RAUTL19(RADFN_";DPT(")
 K %,%DT,C,D,D0,DA,POP,RADFN,RADIV,RAMSG,RANME,RAOFNS,RAOIFN,RAOLP
 K RAOPTN,RAORDS,RAOSTS,RAOVSTS I $D(RAPKG) K OREND,RAPKG
 I '$D(N)!($D(RAOREA)<10) K RAPARENT,X,Y
 I '$D(N)!($D(RAOREA)<10) K RAOREA G Q35
 I $D(RAOREA)>1,$G(N) K RAOREA(N),N I $D(RAOREA)<10 K RAOREA
 K RAPARENT,X,Y
Q35 K DIPGM,I
 Q
CHECK ; Check on the status of the order
 S OREND=$S(ORSTS=5:0,ORSTS=11:0,1:1) W:OREND !!,"Only orders in a Pending or Unreleased status can be cancelled.",$C(7)
 Q
REASON ; Select a Cancel Reason
 S DIC("A")="Select CANCEL REASON: ",DIC("S")="I $P(^(0),U,2)=1!($P(^(0),U,2)=9)",DIC="^RA(75.2,",DIC(0)="AEMQ"
 W ! D ^DIC K DIC
 I +Y<0,(X["^") S RAXIT=1 Q
 I +Y<0 W !!?3,"A Cancel Reason is required to proceed." G REASON
 S OREND=0,RAOREA($S($D(ORPK):ORPK,$D(ORIFN):ORIFN,1:1))=+Y
 Q
4 ;;Hold a Request
 N RAPTLOCK
40 ; Patient lookup
 S DIC="^DPT(",DIC(0)="AEMQ" W ! D ^DIC K DIC G Q4:Y<0
 I $$ORVR^RAORDU()'<3 D  G:'RAPTLOCK 40
 . S RAPTLOCK=$$LK^RAUTL19(+Y_";DPT(")
 . Q
 S RADFN=+Y,RANME=$S($D(^DPT(RADFN,0)):$P(^(0),"^"),1:"Unknown")
 S (RAOFNS,RAOPTN)="Hold",RAOVSTS="5;8"
 W ! D ^RAORDS G Q4:'$D(RAORDS)
41 ; Select a Hold Reason
 S DIC("A")="Select HOLD REASON: ",DIC("S")="I $P(^(0),U,2)=3!($P(^(0),U,2)=9)",DIC="^RA(75.2,",DIC(0)="AEMQ" W ! D ^DIC K DIC
 I +Y<0,(X["^") D Q4 Q
 I +Y<0 W !!?3,"A Hold Reason is required to proceed." G 41
 S RAOREA=+Y
 W !?3,"...will now 'HOLD' selected request(s)..." S RAOLP=0
 F  S RAOLP=+$O(RAORDS(RAOLP)) Q:'RAOLP!('+$G(RAORDS(RAOLP)))  D
 . S RAOIFN=$G(RAORDS(RAOLP)),RAOSTS=3 D ^RAORDU
 . I $D(^RAO(75.1,RAOIFN,0)),$D(^RAMIS(71,+$P(^(0),"^",2),0)) W !?10,"...",$P(^(0),"^")," held..."
 . Q
 D Q4 G 40
Q4 ; unlock if appropriate, kill variables
 I $$ORVR^RAORDU()'<3,(+$G(RAPTLOCK)),(+$G(RADFN)) D
 . D ULK^RAUTL19(RADFN_";DPT(")
 K %DT,C,D,D0,DA,I,POP,RADFN,RADIV,RANME,RAOFNS,RAOIFN,RAOLP,RAORDS
 K RAOPTN,RAOREA,RAOSTS,RAOVSTS,X,Y
 K D1,DDER,DI,DIPGM,DISYS,DUOUT,RAPARENT,^TMP($J,"PRO-ORD"),^("XQALSET")
 Q
 ;
9 ;;Print Selected Requests by Patient
 K ^TMP($J,"RA PRINT HS BY PAT")
 S DIC="^DPT(",DIC(0)="AEMQ" W ! D ^DIC K DIC G Q9:Y<0 S RADFN=+Y,RANME=$S($D(^DPT(RADFN,0)):$P(^(0),"^"),1:"Unknown"),RAOFNS="Print",RAOVSTS="1;2;3;5;6;8" W ! D ^RAORDS G Q9:'$D(RAORDS)
 S RAOIFNS="" F RAOLP=1:1 Q:'$D(RAORDS(RAOLP))  S RAOIFNS=RAOIFNS_+RAORDS(RAOLP)_";"
 W ! K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="Y",DIR("B")="No"
 S DIR("?")="Answer 'Y'es to print the report, 'N'o to quit."
 S DIR("A")="Do you wish to generate a Health Summary Report"
 D ^DIR G:$D(DIRUT) Q9 S RAGMTS=+Y
 S ZTRTN="START9^RAORD",ZTSAVE("RADFN")="",ZTSAVE("RAOIFNS")=""
 S ZTSAVE("RAGMTS")="" S:$D(RAOPT) ZTSAVE("RAOPT(")=""
 W ! D ZIS^RAUTL G Q9:RAPOP
 ;
START9 ; Start printing requests
 U IO S RAX="" N RA751
 F RAOLP=1:1 S RAOIFN=$P(RAOIFNS,";",RAOLP) Q:'RAOIFN!(RAX["^")  D
 . S RAPGE=0 D ^RAORD5 Q:RAX["^"
 . D CRCHK^RAORD6 Q:RAX["^"
 . Q:'RAGMTS  ; quit if 'No' to 'generate a Health Summary Report'.
 . S RA751(0)=$G(^RAO(75.1,RAOIFN,0)),RA751(2)=$P(RA751(0),"^",2)
 . S GMTSTYP=$P($G(^RAMIS(71,+RA751(2),0)),"^",13)
 . I GMTSTYP>0,('$D(^TMP($J,"RA PRINT HS BY PAT",GMTSTYP,RADFN))) D
 .. W:$Y>0 @IOF D ENX^GMTSDVR(RADFN,GMTSTYP)
 .. S ^TMP($J,"RA PRINT HS BY PAT",GMTSTYP,RADFN)=""
 .. Q
 . Q
Q9 K %DT,C,D,D0,DA,DFN,GMTSTYP,I,POP,RACNI,RADFN,RADIV,RADTI,RANME,RAOFNS
 K RAOIFN,RAOIFNS,RAOLP,RAORDS,RAOSTS,RAOVSTS,RAPARENT,RAPGE,RAPOP,RAX
 K RAGMTS,VAI,VAIN,X,Y,Z,^TMP($J,"RA PRINT HS BY PAT")
 K RAMES,ZTDESC,ZTRTN,ZTSAVE
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 K DIPGM,DISYS,DIW,DIWT,DN,RA6,RA7,^TMP($J,"PRO-ORD")
 W ! D CLOSE^RAUTL
 Q
KILL ; kill variables - called from RAORD1
 K %,%DT,D,D0,D1,DA,DFN,DIC,DIK,DIROUT,DIRUT,DIV,DR,DTOUT,DUOUT,DWPK,J,OREND,RABLNK,RACNT,RACT,RADIV,RAEXMUL,RAFIN,RAFIN1,RAI,RAILOC,RAIMGTYI,RAIP,RAJ,RAL0,RALOC,RALIFN,RALOCFLG
 K RAMOD,RAMT,RANUM,RAOIFN,RAORD0,RAOUT,RAPIFN,RAPRC,RAPRI,RAPREG,RAPREOP1,RAREASK,RAREQDT,RAREQPRT,RARU,RARX,RASEQ,RAS3,RASEX,RASKPREG,RASTOP,RASX,RAWHEN,RAX,VAERR,VA200,VAI,VAIP,X,Y
 K RAACI
 I '$D(RAPKG),$G(XQORS)>1,$G(^TMP("XQORS",$J,XQORS-1,"ITM"))'=$G(^("TOT")) Q  ;don't kill clin hist if order entry quick orders not all proccessed
 K ^TMP($J,"RAWP")
 Q
PCR ; Print Cancelled Requests.  Called from the 'Cancel A Request' option.
 N I,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S ZTDESC="Rad/Nuc Med Cancelled Request Print",ZTDTH=$H,ZTIO=RAION
 S ZTRTN="^RAORD5"
 F I="RACRHD","RADFN","RAOIFN","RAPGE","RAX" S ZTSAVE(I)=""
 D ^%ZTLOAD W:$D(ZTSK) !!?3,$C(7),"Task "_ZTSK_": cancellation queued to print on device ",RAION,!
 D HOME^%ZIS
 Q
