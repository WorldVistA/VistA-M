YSPROB3 ;SLC/DKG-REFORMULATE PROBLEMS ;4/20/92  17:51 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 ; Called by routines YSPROB2, YSPROB4
 G DSM:R="DSM"!(R="ICD"),OTP:R="OT"
1 R !!?3,"Do you want to see problems already on the list? N// ",A3:DTIME S YSTOUT='$T,YSUOUT=A3["^" Q:YSTOUT!YSUOUT  S:A3="" A3="N" G:"Nn"[A3 ASK I "Yy"[A3 S N2=0 W ! D LS^YSPROB4 G ASK
 W:"?"'[A3 " ?",$C(7) G 1
ASK ;
 Q:$S(R="EP":0,R="NP":0,1:1)
 S DIC("A")=$S(R="EP":"Select EXISTING PROBLEM: ",1:"Select NEW PROBLEM: ")
 S N5=DA S DIC="^YS(615,YSDFN,P4,",DIC(0)="AELMQZ",DLAYGO=615 W ! D ^DIC K DIC("A") S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT)
 Q:YSTOUT!YSUOUT!(Y'>0)
 ; I Y<1 W $C(7)," ?" G ASK
 S D3=Y,N1=Y(0),N1(0)=$P(^DIC(620,+N1,0),U)
 I R="EP",$P(N1,U,4)']"" W !!?3,"This problem is not currently on the problem list.",!?3,"Additional information about the problem must be entered! ",! S R="NP" D R S (Y,E2)=N1,Y(0)=N1(0) K R D AP^YSPROB2 G FIN
ASK1 ;
 I R="EP" D R W !!?3,"Do you want to edit ",T3 R "? N// ",A:DTIME S YSTOUT='$T,YSUOUT=A["^" S:A="" A="N" Q:YSTOUT!("Nn^"[A)  I "Yy"[A S (Y,E2)=N1,Y(0)=N1(0) K R D AP^YSPROB2 G FIN
 I R="EP" W:A'["?" " ?",$C(7) G ASK1
 K A I R="NP",$P(N1,U,4)]"" W !!?3,"This problem is already on the problem list",! R !?3,"Do you want to edit it? N// ",A:DTIME S YSTOUT='$T,YSUOUT=A["^" Q:YSTOUT!YSUOUT  S:A="" A="N" S R="EP"
 D R S:'$D(A) A="Y" G:"Nn"[A FIN S (Y,E2)=N1,Y(0)=N1(0) K R D AP^YSPROB2 G FIN
OTP ;
 S N5=DA,DA(1)=YSDFN,X=27,DIC="^YS(615,YSDFN,P4,",DIC(0)="ELMNQZ",DLAYGO=615 D ^DIC Q:X="^"  I Y<1 W $C(7)," ?" G OTP
 S D3=Y,N1=Y(0),N1(0)=$P(^DIC(620,+N1,0),U)
 I $P(N1,U,4)']"" W !!?3,"'Other' is not currently on the problem list",!?3,"Additional information about the problem must be entered! ",! D R S (Y,E2)=N1,Y(0)=N1(0) K R D AP^YSPROB2 G FIN
 D R G FIN
DSM ;
 S:'$D(N5) N5=DA S T4=$S(R="DSM":"DX",R="ICD":"PHDX",1:""),DIC("A")=$S(R="DSM":"Select DSM DIAGNOSIS: ",R="ICD":"Select ICD9 DIAGNOSIS: ",1:"")
 I T4="DX" S PH1=YSDFN,PH2=P4 D ENPLDX^YSDX3 S YSDFN=PH1,P4=PH2 G FIN
 I T4="PHDX" S PH1=YSDFN,PH2=P4 D ENPLIC^YSDX3 S YSDFN=PH1,P4=PH2
 G FIN
R ;
 L +^YS(615,YSDFN) S ^YS(615,YSDFN,P4,DA,2,D1,0)=$P(^YS(615,YSDFN,P4,DA,2,D1,0),U,1,3)_U_+N1_U_$P(^(0),U,5) L -^YS(615,YSDFN)
 S T3=$P(N1(0),U)
 W !!?3,"Problem reformulated to:",!?3,T3,! Q
FIN ;
 K R,N2,DIC,N1,T3,PH1,PH2 Q
