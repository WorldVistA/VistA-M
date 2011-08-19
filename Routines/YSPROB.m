YSPROB ;SLC/DKG-ENTER/EDIT AND LIST PROBLEMS ;6/1/90  15:18 ;09/30/93 14:05
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
ENF ; Called from MENU option YSFPROB
 ;
 D ^YSLRP G:YSDFN<1 FIN
 S DIC="^YS(615,",DIC(0)="LX",X="`"_+YSDFN,DLAYGO=615 D ^DIC K DLAYGO,DIC
 D H I $D(^YS(615,YSDFN,P4)) W $C(7),!!?3,"There is already a 'Problem List' on this patient!",!!?3,"Select another option to modify the existing 'Problem List'." G FIN
F1 ; Called by routine YSCEN1
 W !!?28,"CRITICAL ITEM SCREEN",!!?12,"Answer (Y)es, (N)o, or (U)ncertain, i.e. (Y/N or U)",!
 W !?18,"(enter ""^"" to exit CRITICAL ITEM SCREEN)",! S YSA="N"
F11 ;
 I $D(^YS(615,YSDFN,P4,1)) W !!?3,"There is already a 'Suicidal/Self-Injury' problem",!?3,"on file.  Do you want to edit this problem? N// " R YSA:DTIME S YSTOUT='$T,YSUOUT=YSA["^" S:YSA="" YSA="N" S YSA=$E(YSA) G FIN:YSTOUT,A11:YSUOUT
 I $D(^YS(615,YSDFN,P4,1))&("YyNn"'[YSA) D HELP3^YSPROB2 G F11
 I $D(^YS(615,YSDFN,P4,1)) G:"Nn"[YSA VR S (Y,E2)=1,Y(0)="^A",X=$P(^DIC(620,Y,0),U) D AP^YSPROB2 G:YSTOUT FIN G VR
 R !?3,"Is patient a Suicidal/Self-Injury Risk? (Y/N/U) N// ",YSA:DTIME S YSTOUT='$T,YSUOUT=YSA["^" G FIN:YSTOUT,A2:YSUOUT S:YSA="" YSA="N" I "YyNnUu"'[YSA D HELP4^YSPROB2 G F11
 G:"Nn"[YSA VR S:"Yy"[YSA E2=1,X=$P(^DIC(620,1,0),U)
 I "Uu"[YSA S X="Incomplete data base",Z="Uncertain about suicidal/self-injury risk" D UN^YSPROB2 G:YSTOUT FIN G VR
 D EP^YSPROB2 G:YSTOUT FIN
VR ;
 G:YSA["^" FIN
 I $D(^YS(615,YSDFN,P4,2)) S YSA="N" D WMSG R YSA:DTIME S YSTOUT='$T,YSUOUT=YSA["^" G:'$T FIN S YSA=$E(YSA) G:YSUOUT A11 I "YyNn"'[YSA D HELP3^YSPROB2 G VR
 I $D(^YS(615,YSDFN,P4,2)) G:"Nn"[YSA PS S (Y,E2)=2,Y(0)="^B",X=$P(^DIC(620,Y,0),U) D AP^YSPROB2 G:YSTOUT FIN G PS
 R !!?3,"Is patient a violence risk? (Y/N/U) N// ",YSA:DTIME S YSTOUT='$T,YSUOUT=YSA["^" G FIN:YSTOUT,A2:YSUOUT S:YSA="" YSA="N" I "YyNnUu"'[YSA D HELP4^YSPROB2 G VR
 G:"Nn"[YSA PS S:"Yy"[YSA E2=1,X=$P(^DIC(620,2,0),U)
 I "Uu"[YSA S X="Incomplete data base",Z="Uncertain about violence risk" D UN^YSPROB2 G:YSTOUT FIN G PS
 D EP^YSPROB2 G:YSTOUT FIN
PS ;
 G:YSA["^" FIN
 I $D(^YS(615,YSDFN,P4,3)) S YSA="N" W !!?3,"There is already a 'Psychosis' problem",!?3,"on file.  Do you want to edit this problem: N// " R YSA:DTIME S YSTOUT='$T,YSUOUT=YSA["^" G FIN:YSTOUT,A11:YSUOUT S YSA=$E(YSA)
 I "YyNn"'[YSA D HELP3^YSPROB2 G PS
 I $D(^YS(615,YSDFN,P4,3)) G:"Nn"[YSA ^YSPROB1 S (Y,E2)=3,Y(0)="^C",X=$P(^DIC(620,Y,0),U) D AP^YSPROB2 G:YSTOUT FIN G ^YSPROB1
PS1 ;
 R !!?3,"Does patient have a psychosis? (Y/N/U) N// ",YSA:DTIME S YSTOUT='$T,YSUOUT=YSA["^" G FIN:YSTOUT,A2:YSUOUT S:YSA="" YSA="N" I "YyNnUu"'[YSA D HELP4^YSPROB2 G PS1
 G:"Nn"[YSA ^YSPROB1
 I "Uu"[YSA S X="Incomplete data base",Z="Uncertain about psychosis" D UN^YSPROB2 G:YSTOUT FIN G ^YSPROB1
PD ;
 W !!?3,"Do you want a (P)sychosis problem or (D)SM diagnosis? ",!
 W !?3,"(P)sychosis problem",!?3,"(D)SM diagnosis",!
 R !?3,"ANSWER (P or D): ",YSA:DTIME S YSTOUT='$T,YSUOUT=YSA["^" G:YSTOUT!YSUOUT FIN S:YSA="" YSA="Q" I "PpDd"'[YSA D HELP5^YSPROB2 G PD
 I "Dd"[YSA S PH1=YSDFN,PH2=P4 D ENPLDX^YSDX3 S YSDFN=PH1,P4=PH2 G:$D(YSQT) FIN G ^YSPROB1
 S E2=1,X=$P(^DIC(620,3,0),U) D EP^YSPROB2 G:YSTOUT FIN G ^YSPROB1
 ;
ENA ; Called from MENU option YSAPROB
 ;
 D ^YSLRP G:YSDFN<1 FIN D H I '$D(^YS(615,YSDFN,P4)) W $C(7),!!?3,"There is no 'Problem List' on this patient.",!!?3,"Some 'CRITICAL ITEMS' will be asked to formulate a new 'Problem List'.",!! G F1
ENA1 ; Called by routine YSCEN1
 S YSA="N" R !!?3,"DO YOU WANT THE CRITICAL ITEM SCREEN? N// ",YSA:DTIME S YSTOUT='$T,YSUOUT=YSA["^" G:YSTOUT!YSUOUT FIN S YSA=$E(YSA) G A11:"Nn"[YSA,F1:"Yy"[YSA D HELP1^YSPROB2 G ENA1
 ;
A1 ; Called from MENU option YSEPROB
 ;
 D ^YSLRP G:YSDFN<1 FIN D H
A11 ; Called by routine YSPROB1
 I $D(^YS(615,YSDFN,P4)) S YSA="N" R !!?3,"Do you want to see problems already on the list? N// ",YSA:DTIME S YSTOUT='$T,YSUOUT=YSA["^" G:YSTOUT!YSUOUT FIN G:"Nn"[YSA A2 I "Yy"'[YSA D HELP2^YSPROB2 G A11
 I $D(^YS(615,YSDFN,P4)) S N2=0 W ! D LS^YSPROB4
 I '$D(^YS(615,YSDFN,P4)) D
 .  W !!?3,"No 'Problem List' entries exist for this patient.",!!!
 .  S YSA=U
 G FIN:YSA["^"
A2 ;
 D:'$D(^YS(615,YSDFN,P4)) IN^YSPROB2 S DA(1)=YSDFN,DIC="^YS(615,YSDFN,P4,",DIC(0)="AELQMNZ",DLAYGO=615 W ! D ^DIC G:Y<0 FIN
 S E2=1 D AP^YSPROB2 G:YSTOUT FIN G A2
H ; Called by routine YSCEN1
 K Y D ENDTM^YSUTL S P4="PL",YSTOUT=0 S YSEND=$O(^YS(615,YSDFN,P4,0)) K:'YSEND ^YS(615,YSDFN,P4) Q
WMSG W !!?3,"There is already a 'Violence risk' problem",!?3,"on file.  Do you want to edit this problem? N// " Q
FIN ;
 G FIN^YSPROB1
