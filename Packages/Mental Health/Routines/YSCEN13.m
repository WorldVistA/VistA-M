YSCEN13 ;ALB/ASF-CANCEL DISCHARGE; 4/3/90  08:19
 ;;5.01;MENTAL HEALTH;**52**;Dec 30, 1994
 ;
 ; Called by MENU option YSCENCAD [Cancel a MH Census Discharge]
V5ADD ;
 N DIR
 W !!!!!!,"All patient movements are now handled automatically.  The 'Cancel a MH Census"
 W !,"Discharge' option is no longer needed.  If a patient's inpatient status is"
 W !,"incorrect, please contact your local MAS service for assistance.",!!!!!!
 F  Q:(IOSL-$Y)'>2  W !
 S DIR(0)="EA",DIR("A")="Hit RETURN to continue... "
 D ^DIR
 QUIT
 ;
1 ;
 K DIC D UN^YSCEN2 G:Y<1 END1 S P1=0 D FS0^YSCEN,L1^YSCEN2
3 ;
 K DIC,DLAYGO,DR,DIE,DA,D S DIC("S")="I $P(^(7),U)=W1",DIC="^YSG(""INP"",",DIC(0)="AEQ",D="CP",DIC("W")="W:X="" "" $P(^DPT($P(^YSG(""INP"",+Y,0),U,2),0),U)" D IX^DIC G:Y'>0 END1 S DA=+Y K DIC S YSDFN=$P(^YSG("INP",DA,0),U,2)
 I $O(^YSG("INP","C",YSDFN,0))=DA W !,"No previous psychiatric admissions",!,$C(7) G END1
LP ;
 S (N,N1)=0 F ZZ=1:1 S N1=$O(^YSG("INP","C",YSDFN,N1)) Q:'N1  S N(ZZ)=N1,N=N1 K N(ZZ+4)
 S YSNN=N(I-2)
 I +$G(^YSG("INP",N,7))'=W1 W !!,"Last psychiatric admission does not match present ward",!,$C(7) G END1
 S X2=$P(^YSG("INP",N,7),U,2),X1=DT D ^%DTC I X>4 W !,"Over 4 Days since disharge",!,$C(7) G END1
SURE ;
 R !!,"Are you sure you want to cancel the previous discharge? N// ",X:DTIME S YSTOUT='$T,YSUOUT=X["^" S YSR1="X",YSR2="N",YSR3="YN" D ^YSCEN14 G SURE:X="?",END1:YSTOUT!YSUOUT!(X'="Y")
KK ;
 S DIE="^YSG(""INP"",",DR="23///@"
 L +^YSG("INP",DA):5 I '$T W !,"Record being updated" Q
 D ^DIE L -^YSG("INP",DA)
 S DIK="^YSG(""INP""," D ^DIK
 S DA=YSNN,T6=$P(^YSG("INP",DA,0),U,4),DR="23///"_T6
 L +^YSG("INP",DA):5 I '$T W !,"Record being updated" Q
 D ^DIE L -^YSG("INP",DA)
 S DIK="^YSG(""INP"",",DA=YSNN D IX1^DIK
END1 ;
 K DIK,G,I7,X1,X2,K,N,N1,YSNN G END^YSCEN1
 ;
ROT ; Called from MENU option YSCENROT
 ;
 D UN^YSCEN2 G:Y<1 END I '$D(^YSG("CEN",W1,"ROT")) W !,"NO ROTATION SYSTEM YET DEFINED",$C(7) G ROT2
ROT1 ;
 W !!,"TEAM ",W2," CURRENT ROTATION",! S ZZ(1)=0 F ZZ=1:1:25 S X=$P(^YSG("CEN",W1,"ROT"),U,ZZ) I X S ZZ(1)=ZZ(1)+1 W !,ZZ(1),". ",$P(^YSG("SUB",X,0),U)
ROT2 ;
 R !!,"Do you wish to change the current rotation? N// ",X:DTIME S YSTOUT='$T,YSUOUT=X["^" G END:YSTOUT
 S YSR1="X",YSR2="N",YSR3="YN" D ^YSCEN14 G ROT2:X="?",END:X'="Y"
 S DIE="^YSG(""CEN"",",DA=W1,DR="3:3.9"
 L +^YSG("CEN",DA):5 I '$T W !,"Record being updated" Q
 D ^DIE L -^YSG("CEN",DA) S YSTOUT=$D(DTOUT) I 'YSTOUT G ROT1
END ;
 K %,%Y,C,D,D0,DA,DIC,DIE,D0,DR,DIYS,I,W1,W2,X,Y Q
 ;
UNLST ; Called by routine YSCEN1
 ;
 Q:$P(^YSG("CEN",W1,0),U,8)  G:+$P(^(0),U,9)'>0 NTSET S T6=$P(^(0),U,9) I '$D(^YSG("INP","AWC",W1,T6)) W !,"No patients on ",$P(^YSG("SUB",T6,0),U) W ! Q
 W !,"Do you wish to see a list of patients on ",$P(^YSG("SUB",T6,0),U),"?" R " N// ",X:DTIME S YSTOUT='$T,YSUOUT=X["^" Q:YSTOUT!YSUOUT
 S YSR1="X",YSR2="N",YSR3="YN",YSR4="Enter YES if you wish to list patients not yet assigned to teams" D ^YSCEN14 G UNLST:X="?" Q:X=-1!(X="N")
 K ^UTILITY($J) W !,$P(^YSG("SUB",T6,0),U)," Patients",! S DA=0 F  S DA=$O(^YSG("INP","AWC",W1,T6,DA)) Q:'DA  S YSDFN=$P(^YSG("INP",DA,0),U,2),^UTILITY($J,$P(^DPT(YSDFN,0),U))=YSDFN_"^"_DA
 S YSNM="" F  S YSNM=$O(^UTILITY($J,YSNM)) Q:YSNM=""  S YSDFN=+^(YSNM) S DFN=YSDFN D DEM^VADPT,PID^VADPT W !,VADM(1),?30,"SSN: ",VA("PID"),?49,"ward admit: " S Y=$P(^YSG("INP",$P(^UTILITY($J,YSNM),U,2),0),U,3) D DD^%DT W $P(Y,"@")
 W ! K T6,^UTILITY($J),YSDFN Q
 ;
NTSET ;Response if Ward definition not setup correctly
 W $C(7)
 W !!,"  ***  Your MH Ward Definition menu must be setup correctly to continue  *** "
 W !,"  * Use the option Ward Definition [YSCENUNITUP] to enter TEAM information *"
 S YSTOUT=1 Q
 ;
SETDICS ;  Called by WARD LOC screen of MH Team file
 S DIC("S")="X ""K Z F  S Z=+$O(^YSG(""""CEN"""",+$G(Z))) Q:'Z  S Z(0)=^(Z,0),Z(1)=U_$G(^YSG(""""CEN"""",Z,""""ROT""""))_U I +DA=+$P(Z(0),U,9)!(Z(1)[(U_+DA_U)) S Z(2)=1"" I '$G(Z(2))"
 QUIT
 ;
