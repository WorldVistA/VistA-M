SCRPW10 ;RENO/KEITH - Clinic Group Maintenance functionality ; 15 Jul 98  02:38PM
 ;;5.3;Scheduling;**139,144**;AUG 13, 1993
 N DIR
ASK D TITL^SCRPW50("Clinic Group Maintenance for Reports")
 S DIR(0)="SO^EG:EDIT CLINIC GROUPS;PG:PRINT CLINIC GROUPS;DG:DELETE CLINIC GROUP;EA:EDIT CLINIC GROUP ASSIGNMENTS;PA:PRINT CLINIC GROUP ASSIGNMENTS",DIR("A")="Select clinic group maintenance action"
 D ^DIR G:$D(DTOUT)!$D(DUOUT) END G:X="" END D @Y G ASK
 ;
END D END^SCRPW50 Q
 ;
EG N DIC,DIE,DLAYGO S DLAYGO=409.67,DIC="^SD(409.67,",DIC(0)="AEMQL" F  W ! D ^DIC Q:$D(DTOUT)!$D(DUOUT)  Q:Y<1  D:'$D(^SD(409.67,"AB",1,+Y)) MCGR(+Y) S DIE=DIC,DA=+Y,DR=.01 D ^DIE Q:$D(DTOUT)!$D(DUOUT)
 D EXIT Q
 ;
PG N ZTSAVE W ! D EN^XUTMDEVQ("PGP^SCRPW10","LIST OF CLINIC GROUPS",.ZTSAVE) Q
 ;
PGP N SDCG,SDCGN,SDOUT D HINI D:$E(IOST)="C" DISP0^SCRPW23 S SDTITL="LIST OF CLINIC GROUPS",SDOUT=0 D HDR Q:SDOUT  S SDCG=""
 I '$D(^SD(409.67,"AB",1)) W !!,"No 'report' type CLINIC GROUP records identified." D EXIT Q
 F  D:$Y>(IOSL-4) HDR Q:SDOUT  S SDCG=$O(^SD(409.67,"B",SDCG)) Q:SDCG=""  S SDCGN=$O(^SD(409.67,"B",SDCG,0)) I $D(^SD(409.67,"AB",1,SDCGN)) W !,SDCG
 I $E(IOST)="C",'SDOUT N DIR S DIR(0)="E" D ^DIR
 D EXIT Q
 ;
DG N DIR,DIC,DIK,DA
DG1 S DIC="^SD(409.67,",DIC(0)="AEMQ" W ! D ^DIC Q:$D(DTOUT)!$D(DUOUT)  Q:Y<1  S DA=+Y
 I $D(^SC("ASCRPW",+Y)) W !!,$C(7),"You cannot delete a clinic group that has clinics assigned to it!",! G DG1
 S DIR(0)="Y",DIR("A")="Are you sure you want to delete this clinic group",DIR("B")="NO",DIR("?")="Specify if you wish to remove this clinic group."
 D ^DIR Q:$D(DTOUT)!$D(DUOUT)  Q:'Y  S DIK=DIC D ^DIK W "   ...deleted." G DG1
 ;
EA K DIR S DIR(0)="SO^E:EDIT SELECTED CLINICS;A:ASSIGN SELECTED CLINICS;L:LOOP THROUGH CLINICS",DIR("A")="Edit by" D ^DIR Q:$D(DTOUT)!$D(DUOUT)  Q:X=""
 D @Y D EXIT Q
 ;
E N DIC,DIE,DA,DR S DIC="^SC(",DIC(0)="AEMQ" W ! D ^DIC Q:$D(DTOUT)!$D(DUOUT)  Q:Y<1  S DIE=DIC,DA=+Y,DR=31 D ^DIE G E
 ;
A K DIC,DIE,DA,DR,SDCL,SDCLNA S DIC="^SD(409.67,",DIC(0)="AEMQ",DIC("A")="Select CLINIC GROUP to assign clinics to: "
 F  Q:$D(DTOUT)!$D(DUOUT)  W ! D ^DIC Q:$D(DTOUT)!$D(DUOUT)  Q:Y<1  S SDCG="`"_+Y,SDCGNA=$P(Y,U,2) D S1
 Q
 ;
S1 N DIC F  D CLIN("Select CLINIC to assign: ") Q:'$G(SDCL)  K DIE S DIE="^SC(",DA=SDCL,DR="31///^S X=SDCG" D ^DIE W !,"Assigned to ",SDCGNA
 Q
 ;
CLIN(A)    K DIC,SDCL S:$L(A) DIC("A")=A S DIC="^SC(",DIC(0)="AQEMZ"
CL1 W ! D ^DIC Q:$D(DTOUT)!$D(DUOUT)  Q:Y<1  I $P(Y(0),U,3)'="C" W !!,$C(7),"Only clinics can be selected!" K Y G CL1
 S SDCL=+Y,SDCLN=$P(Y,U,2) Q
 ;
L D CLIN("Select clinic to begin with: ") Q:'$G(SDCL)  S SDCLN=$O(^SC("B",SDCLN),-1) D L1 Q
 ;
L1 N SDC,SDI,Y S SDC=0
 F  S SDCLN=$O(^SC("B",SDCLN)) Q:SDCLN=""!$D(DTOUT)!$D(DUOUT)  S SDCL=$O(^SC("B",SDCLN,0)) D L2 Q:$D(Y)
 W:'SDC !!,"No active clinics found in this range." W !!,"End of loop." H 1
 K SDCL,SDCLN,DTOUT,DUOUT Q
 ;
L2 I SDCL,$P(^SC(SDCL,0),U,3)="C" S SDI=$P($G(^SC(SDCL,"I")),U)  W:SDI "." I 'SDI S SDC=SDC+1 W !!,"Clinic: ",SDCLN D EDIT(SDCL)
 Q
 ;
EDIT(DA) N DIE,DR S DIE="^SC(",DR=31 D ^DIE Q
 ;
PA N DIR,ZTSAVE,SDORD,SDINAC,SDUNAS
 S DIR(0)="SO^CG:CLINIC GROUP;CN:CLINIC NAME",DIR("A")="Sort output by" D ^DIR Q:$D(DTOUT)!$D(DUOUT)  Q:X=""  S SDORD=Y,ZTSAVE("SDORD")=""
 S DIR(0)="Y",DIR("A")="Include clinics that are inactive",DIR("B")="NO",DIR("?")="Indicate if clinics that are currently inactive should be included." W ! D ^DIR Q:$D(DTOUT)!$D(DUOUT)  S SDINAC=Y,ZTSAVE("SDINAC")=""
 S DIR("A")="Include clinics that are unassigned",DIR("?")="Indicate if clinics not assigned to a clinic group should be included." W ! D ^DIR Q:$D(DTOUT)!$D(DUOUT)  S SDUNAS=Y,ZTSAVE("SDUNAS")=""
 W ! D EN^XUTMDEVQ("PAP^SCRPW10","PRINT CLINIC GROUP ASSIGNMENTS",.ZTSAVE) Q
 ;
PAP K ^TMP("SCRPW",$J) D HINI S (SDSTOP,SDOUT)=0,SDCLN="",SDTITL="CLINIC GROUPS ASSIGNED TO CLINICS",SDTITLX="W !,""Clinic:"",?40,""Clinic Group:"",!,SDLINE",SDOUT=0
 I SDUNAS,SDINAC S SDTITL(1)="Including inactive and unassigned clinics"
 I 'SDUNAS,'SDINAC S SDTITL(1)="Excluding inactive and unassigned clinics"
 I '$D(SDTITL(1)) S SDTITL(1)=$S(SDINAC:"In",1:"Ex")_"cluding inactive, "_$S(SDUNAS:"in",1:"ex")_"cluding unassigned clinics"
 F  S SDCLN=$O(^SC("B",SDCLN)) Q:SDCLN=""  D  Q:SDOUT
 .S SDSTOP=SDSTOP+1 I SDSTOP#500=0 D STOP Q:SDOUT
 .S SDCL=$O(^SC("B",SDCLN,0)) I $$OK() S SDCG=$P($G(^SC(SDCL,0)),U,31),^TMP("SCRPW",$J,$S(SDORD="CN"!'SDCG:"~",1:$P($G(^SD(409.67,SDCG,0)),U)_"~"),SDCLN,SDCL)=""
 .Q
 D:$E(IOST)="C" DISP0^SCRPW23 D HDR Q:SDOUT  I '$D(^TMP("SCRPW",$J)) W !!,"No clinic group assignments found!" Q
 S SDCG="" F  S SDCG=$O(^TMP("SCRPW",$J,SDCG)) Q:SDCG=""!SDOUT  D:SDORD="CG" CGH S SDCLN="" F  S SDCLN=$O(^TMP("SCRPW",$J,SDCG,SDCLN)) Q:SDCLN=""!SDOUT  D CLP
 I $E(IOST)="C",'SDOUT N DIR S DIR(0)="E" D ^DIR
EXIT D KVA^VADPT K %,%H,%I,A,SDI,SDINAC,SDUNAS,SDPNOW,SDCG,SDCGNA,SDCLN,SDCLNA,SDLINE,SDORD,SDOUT,SDSTOP,SDPAGE,SDTITL,SDTITLX,DA,DIC,DIE,DIR,DR,DTOUT,DUOUT,X,Y,ZTSAVE D END^SCRPW50 Q
 ;
OK() ;Ok to include in report?
 ;Output: 1=include, 0=exclude
 Q:$P($G(^SC(SDCL,0)),U,3)'="C" 0
 N SDX S SDX=$P(^SC(SDCL,0),U,31)
 Q:'SDUNAS&('SDX!'$D(^SD(409.67,+SDX))) 0  Q:SDINAC 1
 S SDX=$G(^SC(SDCL,"I")) I SDX,SDX'>DT,('$P(SDX,U,2)!($P(SDX,U,2)>DT)) Q 0
 Q 1
 ;
CGH D:$Y>(IOSL-4) HDR Q:SDOUT  W !!,"Clinic group: ",$S(SDCG="~":"(not assigned)",1:$P(SDCG,"~")) Q
 ;
CLP D:$Y>(IOSL-3) HDR Q:SDOUT  S SDCL=$O(^TMP("SCRPW",$J,SDCG,SDCLN,0)) W !,$P($G(^SC(SDCL,0)),U),?40,$S(SDORD="CG":$S(SDCG="~":"(not assigned)",1:$P(SDCG,"~")),1:$P($G(^SD(409.67,+$P($G(^SC(SDCL,0)),U,31),0)),U)) Q
 ;
HINI ;Initialize header variables
 D NOW^%DTC S Y=% X ^DD("DD") S SDPNOW=$P(Y,":",1,2),SDPAGE=1,SDLINE="",$P(SDLINE,"-",(IOM+1))="" Q
 ;
HDR ;Print report headers
 I $E(IOST)="C",SDPAGE>1 N DIR S DIR(0)="E" D ^DIR S SDOUT=Y'=1 Q:SDOUT
 D STOP Q:SDOUT  W:SDPAGE>1!($E(IOST)="C") $$XY^SCRPW50(IOF,1,0) W:$X $$XY^SCRPW50("",0,0)
 W SDLINE,!?(IOM-10-$L(SDTITL)\2),"<*>  ",SDTITL,"  <*>" S SDI=0 F  S SDI=$O(SDTITL(SDI)) Q:'SDI  W !?(IOM-$L(SDTITL(SDI))\2),SDTITL(SDI)
 W !,SDLINE,!,"Date printed: ",SDPNOW,?(IOM-6-$L(SDPAGE)),"Page: ",SDPAGE,!,SDLINE X:$D(SDTITLX) SDTITLX S SDPAGE=SDPAGE+1 Q
 ;
STOP ;Check for stop task request
 S:$G(ZTQUEUED) (SDOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
MCGR(SDN) ;Mark CLINIC GROUP record as type="report
 ;Required input: SDN=CLINIC GROUP record IFN
 N DIC,DINUM,Y,X,SDA D FIELD^DID(409.67,1,,"SPECIFIER","SDA") S X=1,DIC="^SD(409.67,"_SDN_",1,",DIC(0)="L",DIC("P")=SDA("SPECIFIER"),DA(1)=SDN D FILE^DICN Q
