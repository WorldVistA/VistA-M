FHBIR ; HISC/REL - Birthday List ;1/23/98  16:06
 ;;5.5;DIETETICS;**5**;Jan 28, 2005;Build 53
 ;patch #5 - adding outpt room-bed.
 S FHP=$O(^FH(119.73,0)) I FHP'<1,$O(^FH(119.73,FHP))<1 S FHP=0 G R1
R0 ;
 R !!,"Select COMMUNICATION OFFICE (or ALL): ",X:DTIME G:'$T!("^"[X) KIL D:X="all" TR^FH I X="ALL" S FHP=0
 E  K DIC S DIC="^FH(119.73,",DIC(0)="EMQ" D ^DIC G:Y<1 R0 S FHP=+Y
R1 ;
 S %DT="AEP",%DT("A")="Birthday DATE: " W ! D ^%DT G:Y<1 KIL S DAT=Y
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHBIR",FHLST="DAT^FHP" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; Process Printing Birthday List
 K ^TMP($J) S PG=0,TYP=$E(DAT,6,7)="00" D NOW^%DTC S NOW=% K %,%H,%I
 F FHWRD=0:0 S FHWRD=$O(^FH(119.6,FHWRD)) Q:FHWRD'>0  S DP=$P(^(FHWRD,0),"^",8) I 'FHP!(DP=FHP) S WRD=$P(^(0),"^",1) F FHDFN=0:0 S FHDFN=$O(^FHPT("AW",FHWRD,FHDFN)) Q:FHDFN<1  D Q2
 S PATTYP="INPATIENTS" D HDR S NAM="" F K=0:0 S NAM=$O(^TMP($J,NAM)) Q:NAM=""  F FHDFN=0:0 S FHDFN=$O(^TMP($J,NAM,FHDFN)) Q:FHDFN<1  D Q3
 D OUTP
 Q
Q2 ;
 D PATNAME^FHOMUTL I DFN="" Q
 Q:'$D(^DPT(DFN,.1))
 S Y0=$G(^DPT(DFN,0)),X=$P(Y0,"^",3) Q:'X
 I 'TYP Q:$E(X,4,7)'=$E(DAT,4,7)
 Q:$E(X,4,5)'=$E(DAT,4,5)
 S BD=$E(X,4,7)_$E($P(Y0,"^",1),1,26),^TMP($J,BD,FHDFN)=X_"^"_WRD Q
Q3 ;
 D PATNAME^FHOMUTL I DFN="" Q
 S X1=^TMP($J,NAM,FHDFN),DTP=$P(X1,"^",1),WRD=$P(X1,"^",2)
 S RM=$G(^DPT(DFN,.101))
 S DTP=$J(+$E(DTP,6,7),2)_"-"_$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",+$E(DTP,4,5))_"-"_(1700+$E(DTP,1,3))
 D:$Y>(IOSL-10) HDR
 W !,$E(NAM,5,30),?32,$E(WRD,1,10),?44,$E(RM,1,10),?56,DTP Q
HDR ;
 N DTP
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1,DTP=NOW D DTP^FH W !,DTP,?27,"B I R T H D A Y   L I S T",?74,"Page ",PG
 S DTP=DAT D DTP^FH S DTP=$P(DTP,"-",$S(TYP:2,1:1),2) S:FHP DTP=$P(^FH(119.73,FHP,0),"^",1)_"  "_DTP W !!,PATTYP,?(79-$L(DTP)\2),DTP
 ;I $G(FHOPFLG)=1 W !!,"Name",?32,"Location",?57,"Birthday",! Q
 W !!,"Name",?32,"Ward",?44,"Room",?57,"Birthday",! Q
KIL K ^TMP($J),FHOPFLG G KILL^XUSCLEAN
 Q
OUTP ;Add Outpatient Display Here - RTK
 ;Only birthdays with Recurring, Special, Guest Meals for date selected
 ;
 K ^TMP($J) S PATTYP="OUTPATIENTS",FHOPFLG=1
 I TYP=1 S FHDTQ=$E(DAT,1,5)_"99.999999",FHRM=DAT-.0001
 I TYP=0 S FHDTQ=DAT_".999999" S X1=DAT,X2=-1 D C^%DTC S FHRM=X
 S RM=""
 F FHOMDT=FHRM:0 S FHOMDT=$O(^FHPT("RM",FHOMDT)) Q:FHOMDT=""!(FHOMDT'<FHDTQ)  D
 .F FHDFN=0:0 S FHDFN=$O(^FHPT("RM",FHOMDT,FHDFN)) Q:FHDFN=""  D
 ..F FHRNUM=0:0 S FHRNUM=$O(^FHPT("RM",FHOMDT,FHDFN,FHRNUM)) Q:FHRNUM=""  D
 ...S FHLOC=$P($G(^FHPT(FHDFN,"OP",FHRNUM,0)),U,3) Q:FHLOC=""
 ...S RM=$P($G(^FHPT(FHDFN,"OP",FHRNUM,0)),U,18)
 ...I $G(RM),$D(^DG(405.4,RM,0)) S RM=$P(^DG(405.4,RM,0),U,1)
 ...D CHECK
 F FHOM=DAT:0 S FHOM=$O(^FHPT("SM",FHOM)) Q:FHOM=""!(FHOM>FHDTQ)  D
 .F FHDFN=0:0 S FHDFN=$O(^FHPT("SM",FHOM,FHDFN)) Q:FHDFN=""  D
 ..S FHLOC=$P($G(^FHPT(FHDFN,"SM",FHOM,0)),U,3) Q:FHLOC=""
 ..S RM=$P($G(^FHPT(FHDFN,"SM",FHOM,0)),U,13)
 ..I $G(RM),$D(^DG(405.4,RM,0)) S RM=$P(^DG(405.4,RM,0),U,1)
 ..D CHECK
 F FHOM=DAT:0 S FHOM=$O(^FHPT("GM",FHOM)) Q:FHOM=""!(FHOM>FHDTQ)  D
 .F FHDFN=0:0 S FHDFN=$O(^FHPT("GM",FHOM,FHDFN)) Q:FHDFN=""  D
 ..S FHLOC=$P($G(^FHPT(FHDFN,"GM",FHOM,0)),U,5) Q:FHLOC=""
 ..S RM=$P($G(^FHPT(FHDFN,"GM",FHOM,0)),U,11)
 ..I $G(RM),$D(^DG(405.4,RM,0)) S RM=$P(^DG(405.4,RM,0),U,1)
 ..D CHECK
 ;
 D HDR S NAM="" F K=0:0 S NAM=$O(^TMP($J,NAM)) Q:NAM=""  F FHDFN=0:0 S FHDFN=$O(^TMP($J,NAM,FHDFN)) Q:FHDFN<1  D
 .S X1=^TMP($J,NAM,FHDFN),DTP=$P(X1,"^",1),WRD=$P(X1,"^",2),RM=$P(X1,"^",3)
 .S DTP=$J(+$E(DTP,6,7),2)_"-"_$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",+$E(DTP,4,5))_"-"_(1700+$E(DTP,1,3))
 .D:$Y>(IOSL-10) HDR
 .W !,$E(NAM,5,30),?32,$E(WRD,1,10),?44,$E(RM,1,10),?56,DTP Q
 W ! K FHOPFLG Q
CHECK ;
 D PATNAME^FHOMUTL
 I 'TYP Q:$E(FHDOB,4,7)'=$E(DAT,4,7)
 Q:$E(FHDOB,4,5)'=$E(DAT,4,5)
 S FHCOM=$P($G(^FH(119.6,FHLOC,0)),U,8)
 I FHP'=0,FHCOM'=FHP Q
 S FHLNM=$P($G(^FH(119.6,FHLOC,0)),U,1)
 S:'$D(RM) RM=" "
 S BD=$E(FHDOB,4,7)_$E(FHPTNM,1,26),^TMP($J,BD,FHDFN)=FHDOB_"^"_FHLNM_"^"_RM Q
