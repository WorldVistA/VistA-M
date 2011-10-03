YSDXR1 ;SLC/DKG,SLC/RWF/LJA-(DSM-III) DIAGNOSIS REPORT CONTINUED ;12/14/93 12:59
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;D RECORD^YSDX0001("^YSDXR1") ;Used for testing.  Inactivated in YSDX0001...
 ;
 ; Called by routine YSDXR
 S (Y1,T1,T)=0 K W
PRT ;
 ;D RECORD^YSDX0001("PRT^YSDXR1") ;Used for testing.  Inactivated in YSDX0001...
 S T=$O(^MR(YSDFN,"DX","CH",T))
 G ^YSPDR1:'T ;->
 S Y1=0
PRT1 ;
 ;D RECORD^YSDX0001("PRT1^YSDXR1") ;Used for testing.  Inactivated in YSDX0001...
 S Y1=$O(^MR(YSDFN,"DX","CH",T,Y1))
 G PRT:'Y1 ;->
 S T1=0
PRT2 ;
 ;D RECORD^YSDX0001("PRT2^YSDXR1") ;Used for testing.  Inactivated in YSDX0001...
 S T1=$O(^MR(YSDFN,"DX","CH",T,Y1,T1))
 G PRT1:'T1 ;->
 S D2=^MR(YSDFN,"DX",Y1,0)
 G PRT:(D2<1) ;->
 S Y2=^YSD(627.7,+D2,0)
 I $D(A1),A1?1"Y".E G PRT1:$P(D2,U,2)="I" ;->
 I ($Y+YSSL+5)>IOSL D CK^YSDXR
 QUIT:YSLFT  ;->
 W !!,$P(Y2,U,2),?8
 S Y2=$P(Y2,U)
 F I=3:1:8 I $L($P(Y2," ",I))>70 QUIT
 W $P(Y2," ",1,I-1) W:$L($P(Y2," ",I,99)) !?9,$P(Y2," ",I,99)
 S C=$P(^MR(YSDFN,"DX",Y1,0),U,2)
 S C=$S(C="A":"A C T I V E",C="I":"** INACTIVE",1:"")
 W "  ",C
 S S2=^MR(YSDFN,"DX",Y1,1,T1,0)
 W !?8 S X=+S2,Z=$P(S2,U,2)
 D ENS^YSDXR
 S X=$P(S2,U,3)
 I X>0,$D(^VA(200,X,0)) D
 .  W "  ",$P(^VA(200,X,0),U)
 .  S X=$P(^VA(200,X,0),U,9)
 .  I X>0,$D(^DIC(3.1,X,0)) W ", ",^(0)
 S X=$P(S2,U,4)
 I $L(X) F I=4:1:10 I $L($P(X," ",I))>50 QUIT
 I $L(X) D
 .  W !?20,"COMMENT: ",$P(X," ",1,I)
 .  W:$L($P(X," ",I+1,99)) !?21,$P(X," ",I+1,99)
 G PRT2 ;->
EN ;
 ;D RECORD^YSDX0001("EN^YSDXR1") ;Used for testing.  Inactivated in YSDX0001...
 S DIC="^MR(YSDFN,""DX"",",DIC(0)="AEMNQZ"
 S DIC("W")="S CS=$P(^(0),U,2) W ?70,$S(CS=""A"":""ACTIVE"",CS=""I"":""INACTIVE"",1:""UNKNOWN"")"
 D ^DIC
 S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT)
 QUIT:YSTOUT!(YSUOUT)  ;->
 G EN:Y<1 ;->
 S DIE=DIC,DR="2",DA=+Y
 L +^MR(YSDFN)
 D ^DIE
 L -^MR(YSDFN)
 S YSTOUT=$D(DTOUT)
 QUIT:YSTOUT  ;->
 G EN ;->
 ;
EOR ;YSDXR1 - (DSM-III) DIAGNOSIS REPORT CONTINUED ; 10/6/88 15:13
