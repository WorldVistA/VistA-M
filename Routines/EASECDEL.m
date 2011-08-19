EASECDEL ;ALB/LBD - Delete a LTC Copay Test;  2 JUN 2003
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**34**;Mar 15, 2001
 ;
EN ; Entry point to delete a LTC copay test
 I '$D(^XUSEC("DG MTDELETE",+DUZ)) W !!,"ACCESS TO THIS OPTION IS RESTRICTED!!",*7 G EXIT
 ;
LKP ; Patient lookup
 N DIC,DTOUT,DUOUT,DGMTYPT,DGNAM,DGDOB,VA,Y
 S DGMTYPT=3
 D HOME^%ZIS S DIC="^DPT(",DIC(0)="AEQMZ" W ! D ^DIC G:$D(DTOUT)!($D(DUOUT))!(+Y<0) EXIT
 I '$O(^DGMT(408.31,"AD",DGMTYPT,+Y,0)) W !?5,$P(Y(0),U)," has no LTC copay (10-10EC) tests on file." G LKP
 S DFN=+Y,DGNAM=$P(Y(0),U),DGDOB=$P(Y(0),U,3)
 D HD
 ;
LKT ; LTC Copay Test lookup
 N D,DIC,DGMTI,DGMTDT,DIR,X,Y
 S DIC("W")="D ID^EASECDEL",DIC("S")="I $P(^(0),U,2)=DFN,$P(^(0),U,19)=DGMTYPT"
 W ! S DIC="^DGMT(408.31,",DIC(0)="EQZ",X=DFN,D="C" D IX^DIC K DIC
 I $D(DTOUT)!($D(DUOUT))!(+Y<0) G LKP
 I '$P($G(^DG(408.34,+$P(Y(0),U,23),0)),U,2) W !,?5,"This LTC Copay Test (10-10EC) is uneditable and cannot be deleted." G LKP
 S DGMTI=+Y,DGMTDT=$P(Y(0),U)
 S DIR(0)="Y",DIR("A")="Display test",DIR("B")="YES"
 D ^DIR K DIR I Y D HD,DISPLAY^EASECU23(DGMTI,DGMTYPT)
 S DIR(0)="Y",DIR("A")="Are you sure you want to delete the "_$$FMTE^XLFDT(DGMTDT,1)_" test",DIR("B")="NO"
 W ! D ^DIR K DIR I Y'=1 W !,"    <OK, nothing deleted!>" G LKP
 D DEL(DGMTI,DFN) W !,"  <LTC Copay Test deleted.>"
 G LKP
EXIT Q
 ;
DEL(DGMTI,DFN) ; Delete selected LTC Copay Test from Annual Means Test file
 ; #408.31 and all entries that point to it in the Individual Annual
 ; Income file #408.21 and the Income Relations file #408.22.
 ; INPUT - DGMTI  IEN of LTC Copay Test to delete from file #408.31
 ;         DFN  IEN of Patient file #2
 ; OUTPUT - none
 N DIK,DA,DGX,DGY,LTC4
 S LTC4=$P($G(^DGMT(408.31,DGMTI,2)),U,8)
 S DA=DGMTI,DIK="^DGMT(408.31," D ^DIK K DIK
 S DIK="^DGMT(408.22,",DGY=0
 F  S DGY=$O(^DGMT(408.22,"AMT",DGMTI,DFN,DGY)) Q:'DGY  S DGX=0 F  S DGX=$O(^DGMT(408.22,"AMT",DGMTI,DFN,DGY,DGX)) Q:'DGX  S DA=DGX D ^DIK
 S DGX=0
 F  S DGX=$O(^DGMT(408.21,"AM",DGMTI,DGX)) Q:'DGX  S DIK="^DGMT(408.21,",DA=DGX D ^DIK D
 .S DGY=0 F  S DGY=$O(^DGMT(408.22,"AIND",DGX,DGY)) Q:'DGY  S DIK="^DGMT(408.22,",DA=DGY D ^DIK
 ; Delete associated LTC Copay Exemption test (type 4) if it's
 ; not associated with any other LTC Copay test.
 Q:'LTC4  Q:$O(^DGMT(408.31,"AT",LTC4,""))
 D DEL4(LTC4)
 Q
 ;
DEL4(LTC4) ; Delete LTC Copay Exemption Test (type 4) associated with
 ; LTC Copay Test. Update IVM Patient file to send deletion to HEC.
 ; INPUT - LTC4   IEN of LTC Copay Exemption Test to delete from #408.31
 N DGMTDT,DGMTI,DGMTP,DGMTA,DGMTINF,DGMTACT,DGMTYPT
 S DGMTI=$G(LTC4) Q:'DGMTI
 S DGMTDT=$P($G(^DGMT(408.31,DGMTI,0)),U) Q:'DGMTDT
 S DGMTP=$G(^DGMT(408.31,DGMTI,0))
 D DELETE^IVMPLOG(DFN,DGMTDT,,,,4)
 S DA=DGMTI,DIK="^DGMT(408.31," D ^DIK
 S DGMTACT="DEL" D AFTER^DGMTEVT
 S DGMTYPT=4,DGMTINF=1 D EN^DGMTAUD
 D ^IVMPMTE
 Q
HD ; Writes patient header to the screen
 W @IOF,"Name: ",DGNAM,?40,"DOB: ",$$FMTE^XLFDT(DGDOB),?65,"Pat ID: ",$$PID(DFN),!!!
 Q
 ;
PID(DFN) ; Return PID
 ; INPUT  - DFN
 ; OUTPUT - PID or 'UNKNOWN'
 D PID^VADPT6
 Q $S(VA("PID")]"":VA("PID"),1:"UNKNOWN")
 ;
ID ; Write identifiers for test lookup
 N DGI,DGN
 S DGI=Y,DGN=$G(^DGMT(408.31,DGI,0))
 W "  LTC Copay Test Date   Status: ",$$S^DGMTAUD1($P(^(0),U,3))
 W !?36,"Source: ",$$SR^DGMTAUD1(DGN)
 Q
