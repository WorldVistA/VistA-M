YSPDR1 ;SLC/DKG,RWF-ICD9 DIAGNOSIS REPORT CONTINUED ;11/30/89  15:08 ; 9/25/09 11:22am
 ;;5.01;MENTAL HEALTH;**96**;Dec 30, 1994;Build 46
 ;Reference to ^ICD9( supported by DBIA #5388
 ;Reference to ICDCODE APIs supported by DBIA #3990
 ;Reference to ^DIC(3.1, supported by DBIA #1234
 ;Reference to ^VA(200, supported by DBIA #10060
 ; Called by routine YSDXR1
 I $D(^MR(YSDFN,"PHDX",1)) W !!,"ICD9 DIAGNOSES:",!
 S (Y1,T1,T)=0 K W
PRT ;
 S T=$O(^MR(YSDFN,"PHDX","CH",T)) G PRT^YSPDXR:'T S Y1=0
PRT1 ;
 S Y1=$O(^MR(YSDFN,"PHDX","CH",T,Y1)) G PRT:'Y1 S T1=0
PRT2 ;
 S T1=$O(^MR(YSDFN,"PHDX","CH",T,Y1,T1)) G PRT1:'T1
 S D2=^MR(YSDFN,"PHDX",Y1,0) G PRT:D2<1 S Y2=^ICD9(+D2,0)
 I $D(A1),A1?1"Y".E G PRT1:$P(D2,U,2)="I"
 IF $Y+7>IOSL D ENFT^YSFORM,WAIT Q:$D(W)  D ENHD^YSFORM
 W !!,$P(Y2,U),?8
 N YSDXZZ S YSXDZZ=$$ICDD^ICDCODE($P(Y2,U),"YSDXZZ") S Y2=YSXDZZ(1) ;asf 4/22/09
 F I=3:1:8 IF $L($P(Y2," ",I))>70 Q
 W $P(Y2," ",1,I-1) W:$L($P(Y2," ",I,99)) !?9,$P(Y2," ",I,99)
 S C=$P(^MR(YSDFN,"PHDX",Y1,0),U,2),C=$S(C="A":"A C T I V E",C="I":"** INACTIVE",1:"") W "  ",C
PT1 ;
 S S2=^MR(YSDFN,"PHDX",Y1,1,T1,0)
 W !?8 S X=+S2,Z=$P(S2,U,2) D ENS^YSDXR
 S X=$P(S2,U,3) IF X>0,$D(^VA(200,X,0)) W "  ",$P(^VA(200,X,0),U) S X=$P(^(0),U,9) IF X>0,$D(^DIC(3.1,X,0)) W ", ",^(0)
 S X=$P(S2,U,4) IF $L(X) F I=4:1:10 IF $L($P(X," ",I))>50 Q
 IF $L(X) W !?20,"COMMENT: ",$P(X," ",1,I) W:$L($P(X," ",I+1,99)) !?21,$P(X," ",I+1,99)
 G PRT2
WAIT ;
 I IOSL<30 K DIR S DIR(0)="E" D ^DIR K DIR S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT) S:YSUOUT W=1 Q
EN ;
 S DIC="^MR(YSDFN,""PHDX"",",DIC(0)="AEMNQZ"
 S DIC("W")="S C=$P(^(0),U,2) W ?70,$S(C=""A"":""ACTIVE"",C=""I"":""INACTIVE"",1:""UNKNOWN"")"
 D ^DIC Q:X=""!(X?1P)  G EN:Y'>0 S DIE=DIC,DR="2",DA=+Y L +^MR(YSDFN):30 D ^DIE L -^MR(YSDFN) S YSTOUT=$D(DTOUT) Q:YSTOUT  G EN ;asf 09/09
