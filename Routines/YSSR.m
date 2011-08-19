YSSR ;SLC/AFE-SECLUSION/RESTRAINT - Lookup & Entry ; 1/27/04 2:35pm
 ;;5.01;MENTAL HEALTH;**82**;Dec 30, 1994;Build 3
 ;
ENLST ; Called from MENU option YSSR ENTRY
 ; Entry of basic S/R information
 W @IOF,!?IOM-$L("SECLUSION/RESTRAINT INFORMATION")\2,"SECLUSION/RESTRAINT INFORMATION",! S MSG1="No patients listed in Seclusion/Restraint." D LKUP
ENTER ;
 D ^YSLRP I YSDFN'>0 G END
 I $D(^YS(615.2,"AC",YSDFN)) W !!,"Patient shown in Seclusion/Restraint at this time.",! D WAIT^YSUTL G END
 W ! S DIC="^YS(615.2,",DIC(0)="L",X="""N""",DLAYGO=615 D ^DIC G:Y<1 END S FN=+Y
SQ ;
 S %=0 F  Q:$G(%)  W !,"Was patient searched" S %=1 D 
 .D YN^DICN S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT) I '% W !!,"If patient was not searched, a reason should be given for the omission.",!
 I YSTOUT!YSUOUT!(%=-1) D DELETE G END
 I %=1 S DA=FN,DIE=DIC,DR=".08////Y" L +^YS(615.2,DA) D ^DIE L -^YS(615.2,DA)
 I %=2 S DA=FN,DIE=DIC,DR=".08////N;.09" L +^YS(615.2,DA) D ^DIE L -^YS(615.2,DA) S YSTOUT=$D(DTOUT) I YSTOUT D DELETE G END
 D DXLKUP W ! S DIE="^YS(615.2,",DA=FN,DR=".02////"_YSDFN_";.03//NOW;.04:.07;25:27;4///^S X=""`""_DUZ;5:6;7//^S X=YSDX;10;15:20;30" L +^YS(615.2,DA) K Y D ^DIE L -^YS(615.2,DA)
 S YSTOUT=$D(DTOUT),YSUOUT=$O(Y(""))]""
 I YSTOUT!YSUOUT!('$O(^YS(615.2,DA,5,0)))!('$O(^YS(615.2,DA,6,0)))!($G(^YS(615.2,DA,7))']"")!('$O(^(10,0)))!('+$G(^YS(615.2,DA,25))) W !!?13,"INSUFFICIENT INFORMATION" D DELETE G END
REVIEW ;
 S %=0 F  Q:$G(%)  W !!,"Do you need to edit the above information" S %=1 D 
 .D YN^DICN S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT) I '% W !!,"After the information is filed, you may no longer edit it.",!,"You may alter the information now.",!
 I YSTOUT!YSUOUT D DELETE G END
 I %=1 D EDIT
FILE ;
 S %=0 F  Q:$G(%)  W !!,"Save this information" S %=1 D 
 .D YN^DICN S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT) I '% W !!,"NO, will delete this information from the record.",!,"YES, will file it under the patient's name."
 I %=1 W !!?5,"INFORMATION NOTED.",! Q
 D DELETE
END ; Called by routines YSSR1, YSSR2
 N YSDT,YSPDZ,YSTOUT,YSUOUT,XQT,YSDTM,YSLC,YSLCN,YSTM D KILL^XUSCLEAN
 Q
 ;
EDIT ;
 S DIE="^YS(615.2,",DA=FN,DR=".03:3;5:25:27;30" L +^YS(615.2,DA) D ^DIE L -^YS(615.2,DA) K DIE
 Q
 ;
DELETE ; Called by routine YSSR2
 S DIK="^YS(615.2,",DA=FN D ^DIK W !!?10,"< ENTRY FOR "_$P(YSNM,",",2)_" "_$P(YSNM,",")_" DELETED >",! Q
 ;
PTNAME ; Called by routine YSSR1
 ; Patient look-up.
 W ! D ^YSLRP I $G(X)["^" S YSQT=1 Q
 I YSDFN<1 W !!,"Patient Name Required.",! S YSQT=1 Q
 S YSN=$P(YSNM,",",2)_" "_$P(YSNM,",")
 Q
LKUP ; Called as ENTRY action from MENU option YSSR SEC/RES
 ; Called by routine YSSR1
 ; Lists patients in currently in S/R.  May pass YSQT.
 S:'$D(MSG1) MSG1="No patients currently listed in seclusion/restraint." I '$O(^YS(615.2,"AC",0)) W !?IOM-$L(" ** "_MSG1_" ** ")\2," ** "_MSG1_" ** ",!! Q 
 W !!,"The following patient(s) are currently listed as being in Seclusion/Restraint:  ",!
 D HEADER S A=0 F  S A=$O(^YS(615.2,"AC",A)) Q:'A  S A1=0 F  S A1=$O(^YS(615.2,"AC",A,A1)) Q:'A1  D PNAMES
 I $D(YS02) W !!," * Written order required.",!
 I $D(YS04) W:'$D(YS02) !! W " # Record incomplete, please contact IRM.",!
 I '$D(C1) W !?5," ** ",MSG1," ** " K C1 I $D(OPT) S YSQT=1
 S %DT="T",X="N" D ^%DT
 K YS02,YS04
 Q
PNAMES ; Called by routine YSSR1
 K YS01,YS03 S DFN=A D DEM^VADPT,PID^VADPT S B=VADM(1),SSN=VA("BID") S C1=+1
 S Y=$P($G(^YS(615.2,A1,0)),"^",3) D DD^%DT
 D TTIME
 S JRBY=$P($G(^YS(615.2,A1,25)),"^")
 S JRBYN="" I JRBY S JRBYN=$P(^VA(200,JRBY,0),"^",1)
 S Y=$P($G(^YS(615.2,A1,0)),"^",3) D DD^%DT
 I $D(^YS(615.2,"AF",A)) S (YS01,YS02)="*"
 I '$O(^YS(615.2,A1,5,0))!('$O(^YS(615.2,A1,6,0)))!($G(^YS(615.2,A1,7))']"")!('$O(^(10,0)))!('+$G(^YS(615.2,A1,25))) S (YS03,YS04)="#"
 W !?0,$E(B,1,20),?22,SSN W:$D(YS01) ?28,YS01 I $D(YS03) W ?29,YS03
 W ?31,Y,?52,$E(JRBYN,1,18) I $D(JRTT) W ?71,JRTT
 K JRTT
 K VADM,VA,DFN
 Q
DXLKUP ; Checks ^YSD(627.8 DIAGNOSTIC RESULTS for most recent diagnosis.
 S YSDX="UNKNOWN" I '$D(^YSD(627.8,"AF",YSDFN)) Q
 S K=0,K=$O(^YSD(627.8,"AF",YSDFN,K)),L="",L=$O(^YSD(627.8,"AF",YSDFN,K,L)) S M1=$P(L,";"),M2=$P(L,";",2) K K,L
 I M2["ICD" S N1="^"_M2_M1_","_0_")",YSDX=$P(@N1,"^",1)_" "_$E($P(@N1,"^",3),1,60) Q
 I M2["DIC" S N1="^"_M2_M1_","_0_")",N2=$P(@N1,"^",2),N3="^"_M2_M1_","_3_")",N4=$P(@N3,"^",1),YSDX=N2_" "_$E(N4,1,60)
 K M1,M2,N1,N2,N3,N4
 Q
HEADER ; Write header
 W !?31,"DATE & TIME",?72,"TOTAL",!
 W ?0,"PATIENT",?23,"SSN",?31,"INITIATED",?52,"ORDERED BY",?72,"TIME",!
 F I=1:1:IOM W "="
 W !
 Q
TTIME ;calculate total time
 I $D(^YS(615.2,A1,0)),$P(^(0),"^",3)'="" S R1=$P(^YS(615.2,A1,0),"^",3)
 I $D(^(40)),$P(^(40),"^",3)'="" S R2=$P(^YS(615.2,A1,40),"^",3)
 I '$D(^(40)) D NOW^%DTC W ! S R2=%
 I $D(R1),$D(R2) S Y=R2 D DD^%DT S JROSR=$P(Y,"@",2),Y=R1 D DD^%DT S JRISR=$P(Y,"@",2)
 I $D(R1),$D(R2) S JRVAR=$O(^DD("FUNC","B","MINUTES",0)),X=R1,X1=R2 X ^DD("FUNC",JRVAR,1) S R3=X,JRH=X\60,R4=JRH*60,JRMIN=R3-R4 S JRH=$S($L(JRH)=1:"  "_JRH,$L(JRH)=2:" "_JRH,1:JRH) S JRH=" "_JRH,JRTT=JRH_":"_JRMIN
 K R1,R2,R3,R4,JROSR,JRISR,JRH,JRMIN,Y,X,%
 Q
