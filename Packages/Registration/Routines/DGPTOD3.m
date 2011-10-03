DGPTOD3 ;ALB/AS - PTF DRG REPORTS CONTINUATION FROM DGSUDO ; 9/5/01 9:43am
 ;;5.3;Registration;**375**;Aug 13, 1993
EN K DG1,DG2,DG3,DG4 S (Z,DGPTFR)="" F I=1:1:4 S (Z,Z1)=Z_U_I_"   "_$P($T(@I),";;",2)
BATCH W ! F I=1:1:4 W !,I,". ",$P($T(@I),";;",2)
B1 F I=1:1 R !!,"  CHOOSE REPORTS TO BE BATCHED (BY NUMBER) : ",X:DTIME Q:X=""  G NO:X["^"!'($T),HELP:X'?1N,HELP:"1234"'[X D IN^DGHELP,A S Z=Z1
 Q:'$D(DGPTFR)  Q:DGPTFR']""  W !!,"You have selected the following outputs:",! F I=2:1 Q:$P(DGPTFR,"*",I)=""  W !,$P($T(@$P(DGPTFR,"*",I)),";;",2)
OK W !,"IS THIS CORRECT" S %=1 D YN^DICN I '% W !!?6,"Enter <RET> if this information is correct",!?10,"Enter 'N' for NO to exit",!! G OK
 G NO:%'=1,^DGPTOD0 Q
1 ;;Trim Point DRG Report
2 ;;DRG Frequency Report
3 ;;ALOS Report for DRGs
4 ;;DRG Case Mix Summary
A I $D(@("DG"_X)) W !,"YOU ALREADY CHOSE TO PRINT ",$P($T(@X),";;",2) S Z=Z1 Q
 S @("DG"_X)=X,DGPTFR=DGPTFR_"*"_@("DG"_X) Q
HELP W !!,"ENTER THE OPTION NUMBER OF THE REPORT TO BE PRINTED" G BATCH
NO K %,DGPTFR,DG1,DG2,DG3,DG4,I,X,Z,Z1 Q
