YSDX3 ;SLC/DJP-Entry of Axis 1 & 2 Diagnoses for the Mental Health Medical Record ;1/15/91  11:07 ;07/07/93 15:03
 ;;5.01;MENTAL HEALTH;**33**;Dec 30, 1994
 ;
 ; Called from the top by MENU option YSDIAGE
 ;
DRIVER ;Controls flow of routine
 ;D RECORD^YSDX0001("DRIVER^YSDX3") ;Used for testing.  Inactivated in YSDX0001...
 D ENTRY I $D(YSQT) D END^YSDX3U Q
 D ^YSDX3A I $D(YSQT) D END^YSDX3U Q
 D AXIS4^YSDX3B I $D(YSQT) D END^YSDX3U Q
 D AXIS5^YSDX3B D END^YSDX3U Q
ENTRY ;Initial entry of DSM diagnosis
 ;D RECORD^YSDX0001("ENTRY^YSDX3") ;Used for testing.  Inactivated in YSDX0001...
 S:'$D(YSDUZ) YSDUZ=$P(^VA(200,DUZ,0),U) W @IOF,!!?IOM-$L("ENTRY OF DIAGNOSIS")\2,"ENTRY OF DIAGNOSIS",!! K YSQT D ^YSLRP Q:$D(YSPLIC)  I YSTOUT!YSUOUT!(YSDFN'>0) Q
 ;
OLD ;  Called by routine YSCEN1
 ;Check for diagnosis formulated under DSM-III (File ^MR)
 ;D RECORD^YSDX0001("OLD^YSDX3") ;Used for testing.  Inactivated in YSDX0001
 I $D(^MR(YSDFN,"DX")) D OLDP
AGAIN ;  called from routine YSDX3UA
 ;D RECORD^YSDX0001("AGAIN^YSDX3") ;Used for testing.  Inactivated in YSDX0001...
 S P1=0,YSAX=1,YSDTY="A" W !!,"ACTIVE DSM (Axes 1 and 2): ",! D LIST^YSDX3U G:$D(YSNO) QUES1 I '$D(YSDXN) W !!?5,"No active DSM diagnoses on file for ",YSNM,".",!
 K % D INQ^YSDX3U Q:$D(YSQT)
 ;
QUES1 ;Subroutine presents questions for Axes 1&2
 ;D RECORD^YSDX0001("QUES1^YSDX3") ;Used for testing.  Inactivated in YSDX0001...
 I '$D(^XUSEC("YSQ",DUZ)) W !!,"You must hold correct security key to enter DSM diagnosis." H 3 Q
 K YSQT W !!,"Enter DSM DIAGNOSIS:  " R X1:DTIME S YSTOUT='$T,YSUOUT=X1["^" I YSTOUT!YSUOUT S YSQT=1 Q
 Q:X1=""  I X1?.N I X1<(P1+1) G:X1<1 QUES1 W ! D DSMP^YSDX3UA G:'$D(YSY) QUES1 S:$D(S2) YSDXDA=+S2
 I '$D(YSY) S X=$$UP^XLFSTR(X1) D DSMLK^YSDX3UA G:Y<0 QUES1
 ;
DUPLCK ;Checks for and displays possible duplicate entries
 ;D RECORD^YSDX0001("DUPLCK^YSDX3") ;Used for testing.  Inactivated in YSDX0001...
 S:'$D(YSDXDA) YSDXDA=+Y S:'$D(S2) S2=+Y S W2="",W1=S2_";"_"YSD(627.7," F  S W2=$O(^YSD(627.8,"AG","D",YSDFN,W1,W2)) Q:W2=""  S YSDUPDA=W2 D DUPL^YSDX3UA
CORR ;
 ;D RECORD^YSDX0001("CORR^YSDX3") ;Used for testing.  Inactivated in YSDX0001...
 S YSWN=$P(^YSD(627.7,+YSDXDA,0),U),YSW=$G(^YSD(627.7,+YSDXDA,"D"))
 S %=0 F  Q:$G(%)  W !!?10,YSWN_" "_YSW,!!,"Is this the DSM Dx you wish to select" S %=2 D
 .D YN^DICN S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT) I YSTOUT!YSUOUT Q 
 .I '% W !!,"""YES"" indicates the diagnosis entered applies to ",YSNM,"."
 I %=2 K YSDXDA,X1,YSDXST,YSLC,YSLCN,YSW,YSWN,YSY,S1,S2,S3,YSDXD,YSDXDA1,YSDXDT,YSDXND,YSDTY,W1,W2,W3,W4,W5 G QUES1
 I %=-1 Q
FILE ;
 ;D RECORD^YSDX0001("FILE^YSDX3") ;Used for testing.  Inactivated in YSDX0001...
 ;S DIC="^YSD(627.8,",DIC(0)="L",X="""N""",DLAYGO=627 D ^DIC D:Y<0 END^YSDX3U S YSDA=+Y,YSDXDA=YSDXDA_";YSD(627.7,"
 K DD,DO,DA,DINUM
 S X="NOW",%DT="TR" D ^%DT S X=Y
 S DIC="^YSD(627.8,",DIC(0)="L",DLAYGO=627.8 D FILE^DICN D:Y<0 END^YSDX3U S YSDA=+Y,YSDXDA=YSDXDA_";YSD(627.7,"
 S YSDXDA1=$P(YSDXDA,";") D MODIF^YSDX3UB G:$D(YSQT) QUES1
 D FILE^YSDX3UA
 K YSDXDA,YSDA,YSDTY,YSDXDA1,YSDXDT,YSDXN,YSDXNN,YSDXST,YSMOD,YSW,YSWN,YSY,F1,F2,F3,K1,K2,K3,K4,K5,K6,L2,L3,L4,L5,L7,P2,P3,P4,P5,S2,W1,W2,W3,W4,W5,W6,X,X1 G QUES1
OLDP ;
 ;D RECORD^YSDX0001("OLDP^YSDX3") ;Used for testing.  Inactivated in YSDX0001...
 S %=0 F  Q:$G(%)  W !!,"This patient has diagnoses formulated under DSM-III criteria.",!,"Do you wish to review" S %=2 D
 .D YN^DICN S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT)
 .I '% W !!,"""YES"" provides a list of diagnoses which you may want to reformulate under",!," DSM criteria.  ""NO"" will permit the option to continue.",!
 Q:YSTOUT!YSUOUT  I %'=1 Q
 W !!,"The following may require reformulation under DSM criteria.",! D ^YSDXR
 Q
 ;
EN ;The following are entry points used for accessing the DSM routines from options other than YSDIAG.
 ;
ENPLDX ; Called by MENU option YSPLDX
 ; Called by routines YSPROB, YSPROB1, YSPROB3
 ;D RECORD^YSDX0001("ENPLDX^YSDX3") ;Used for testing.  Inactivated in YSDX0001...
 S YSPLDX=1,N1=0 D @$S($D(YSDFN):"OLD",1:"ENTRY") I $G(YSQT)!YSTOUT!YSUOUT!(YSDFN'>0) D END^YSDX3U Q
 D AXIS4^YSDX3B I $D(YSQT) D END^YSDX3U Q
 D AXIS5^YSDX3B I $D(YSQT) D END^YSDX3U
 Q
 ;
ENPLIC ; Called by MENU option YSPLPDX
 ;  Called by routines YSPROB1, YSPROB3
 ;
 ;D RECORD^YSDX0001("ENPLIC^YSDX3") ;Used for testing.  Inactivated in YSDX0001...
 S YSPLIC=1,N1=0 S:'$D(YSDUZ) YSDUZ=$P(^VA(200,DUZ,0),U) D:$G(YSDFN)'>0 ^YSLRP I YSTOUT!YSUOUT!(YSDFN'>0) D END^YSDX3U Q
 D ^YSDX3A D END^YSDX3U Q
