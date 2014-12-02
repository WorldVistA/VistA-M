YSDX3A ;SLC/DJP - Entry of Axis 3 Diagnosis for the Mental Health Med Rec ;11 Sep 2013  11:32 AM
 ;;5.01;MENTAL HEALTH;**33,107**;Dec 30, 1994;Build 23
 ;D RECORD^YSDX0001("YSDX3A^YSDX3A") ;Used for testing.  Inactivated in YSDX0001...
 ;
 ;  Called from routines YSCEN1, YSDX3
AXIS3 ;
 ;D RECORD^YSDX0001("AXIS3^YSDX3A") ;Used for testing.  Inactivated in YSDX0001...
 K YSDXDA,YSDA,YSDTY,YSNO,P1 W @IOF,!!?10,"ENTRY OF DIAGNOSIS - Continued - ",$E(YSNM,1,25) S YSAX=3,YSDTY="A",P1=0 K P2 W !!,"ACTIVE ICD DIAGNOSES (Axis 3): ",! D LIST^YSDX3U G:$D(YSNO) QUES2
 I '$D(YSDXN) W !!?3,"No active ICD diagnosis on file for ",YSNM,".",!
 D INQ^YSDX3U Q:$D(YSQT)
QUES2 ;Subroutine presents questions for Axis 3
 ;D RECORD^YSDX0001("QUES2^YSDX3A") ;Used for testing.  Inactivated in YSDX0001...
 I $G(YSDXDAT)="" S YSDXDAT=DT
 N YSACSREC,YSACS S YSACSREC=$$ACTDT^YSDXUTL(YSDXDAT),YSACS=$P(YSACSREC,U,3)
 I YSACS["-" S YSACS=$P(YSACS,"-",1,2)
 I '$D(^XUSEC("YSD",DUZ)) W !!,"You must hold correct security key to enter ",YSACS," diagnosis." Q
 I $P(YSACSREC,U,1)'="ICD" D  G:$G(X2)?1N.N QUES2B G:YSRETV'<0 DUPLCK
 . K X2 S YSDT=YSDXDAT D EN^YSLXDG Q:YSRETV<0  I $P(YSRETV,U,1)?.N S X2=$P(YSRETV,U,1)
 . S (YSDXDA,Y)=$P($$ICDDATA^ICDXCODE("DIAG",$P($P(YSRETV,U,1),";",2),YSDXDAT,"E"),U,1)
 I $G(YSRETV)<0 K YSRETV Q
 W !!,"Enter ",YSACS," DIAGNOSIS:  " R X2:DTIME S YSTOUT='$T,YSUOUT=X2["^" I YSTOUT!YSUOUT S YSQT=1 Q
QUES2B Q:X2="" 
 I X2="???" S X2="??"
 I X2?.N I X2<(P1+1) D ICDP^YSDX3UA G:'$D(YSY) QUES2 S:$D(S1) YSDXDA=$P(S1,";")
 I '$D(YSY) S X2=$$UP^XLFSTR(X2) D ICDLK^YSDX3UA G:Y<0 QUES2
DUPLCK ;Checks for and displays possible duplicate entries
 ;D RECORD^YSDX0001("DUPLCK^YSDX3A") ;Used for testing.  Inactivated in YSDX0001...
 S:'$D(YSDXDA) YSDXDA=+Y S:'$D(S2) S2=+Y S W2="",W1=S2_";"_"ICD9(" F I=1:1 S W2=$O(^YSD(627.8,"AG","I",YSDFN,W1,W2)) Q:W2=""  S YSDUPDA=W2 D DUPL^YSDX3UA
CORR ;
 ;D RECORD^YSDX0001("CORR^YSDX3A") ;Used for testing.  Inactivated in YSDX0001...
 N YSDXDATA S YSDXDATA=$$ICDDATA^ICDXCODE("DIAG",YSDXDA,YSDXDAT,"I")
 I $P(YSDXDATA,U,1)=-1 W !!,"Invalid Diagnosis for DATE/TIME OF DIAGNOSIS that was entered." G QUES2
 ;S YSW=$P(^ICD9(YSDXDA,0),U),YSWN=$P(^(0),U,3)
 S YSW=$P(YSDXDATA,U,2),YSWN=$P(YSDXDATA,U,4)
 S %=0 F  Q:$G(%)  W !!?10,YSW_" "_YSWN,!!,"Is this the ICD diagnosis you wish to select" S %=2 D
 .D YN^DICN S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT) I YSTOUT!YSUOUT Q
 .I '% W !!,"""YES"" indicates the diagnosis entered applies to ",YSNM,"."
 I %=2 K YSDXDA,YSY,X2,S2 G QUES2
 Q:%=-1
FILE ;
 ;D RECORD^YSDX0001("FILE^YSDX3A") ;Used for testing.  Inactivated in YSDX0001...
 ;S DIC="^YSD(627.8,",DIC(0)="L",X="""N""",DLAYGO=627 D ^DIC Q:Y'>0  S YSDA=+Y,YSDXDA=YSDXDA_";ICD9("
 K DD,DO,DA,DINUM
 S X="NOW",%DT="TR" D ^%DT S X=Y
 S DIC="^YSD(627.8,",DIC(0)="L",DLAYGO=627.8 D FILE^DICN Q:Y'>0  S YSDA=+Y,YSDXDA=YSDXDA_";ICD9("
 D FILE^YSDX3UA
 K YSDXDA,YSDA,YSDTY,YSDXDA1,YSDXDT,YSDXN,YSDXNN,YSDXST,YSMOD,YSW,YSWN,YSALZ,YSY,F1,F2,F3,K1,K2,K3,K4,K5,K6,L2,L3,L4,L5,L7,P2,P3,P4,P5,S2,W1,W2,W3,W4,W5,W6,X,X2 G:'$D(YSPLIC) QUES2
