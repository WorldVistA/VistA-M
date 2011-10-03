YSPROB1 ;SLC/DKG-PROB LIST EXTENSION ;11/15/90  16:42 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 ; Called by routine YSPROB
AA ;
 G:YSA["^" FIN
 I $D(^YS(615,YSDFN,P4,8)) S YSA="N" W !!?3,"There is already an 'Alcohol abuse' problem",!?3,"on file.  Do you want to edit this problem? N// "
 I $D(^YS(615,YSDFN,P4,8)) R YSA:DTIME S YSTOUT='$T,YSUOUT=YSA["^" G FIN:YSTOUT,A11^YSPROB:YSUOUT S:YSA="" YSA="N" S YSA=$E(YSA) I "YyNn"'[YSA D HELP3^YSPROB2 G AA
 I $D(^YS(615,YSDFN,P4,8)) G:"Nn"[YSA DA S (Y,E2)=8,Y(0)="^H" D AP^YSPROB2 G:YSTOUT FIN G DA
 S YSA="N" R !!?3,"Does patient have an alcohol abuse problem? (Y/N/U) N// ",YSA:DTIME S YSTOUT='$T,YSUOUT=YSA["^" G FIN:YSTOUT,A2^YSPROB:YSUOUT S YSA=$E(YSA) I "YyNnUu"'[YSA D HELP4^YSPROB2 G AA
 G:"Nn"[YSA DA
 I "Uu"[YSA S X="Incomplete data base",Z="Uncertain about alcohol abuse" D UN^YSPROB2 G:YSTOUT FIN G DA
AD ;
 W !!?3,"Do you want an (A)lcohol misuse problem or a (D)SM diagnosis?",!
 R !?3,"ANSWER (A or D): ",YSA:DTIME S YSTOUT='$T,YSUOUT=YSA["^" G:YSTOUT!YSUOUT FIN S:YSA="" YSA="Q" I "AaDd"'[YSA D HELP5^YSPROB2 G AD
 I "Dd"[YSA S PH1=YSDFN,PH2=P4 D ENPLDX^YSDX3 S YSDFN=PH1,P4=PH2 S:$D(YSQT) YSA="^" G DA
 S E2=1,X=$P(^DIC(620,8,0),U) D EP^YSPROB2 G:YSTOUT FIN
DA ;
 G:YSA["^" FIN
 I $D(^YS(615,YSDFN,P4,9)) S YSA="N" W !!?3,"There is already a 'Substance (non-alcohol) abuse' problem",!?3,"on file.  Do you want to edit this problem? N// " R YSA:DTIME S YSTOUT='$T,YSUOUT=YSA["^" G FIN:YSTOUT,A11^YSPROB:YSUOUT S YSA=$E(YSA)
 I $D(^YS(615,YSDFN,P4,9)),"YyNn"'[YSA D HELP3^YSPROB2 G DA
 I $D(^YS(615,YSDFN,P4,9)) G:"Nn"[YSA PH S (Y,E2)=9,Y(0)="^I" D AP^YSPROB2 G:YSTOUT FIN G PH
 R !!?3,"Does patient abuse drugs/other non-alcohol substances? (Y/N/U) N// ",YSA:DTIME S YSTOUT='$T,YSUOUT=YSA["^" G FIN:YSTOUT,A2^YSPROB:YSUOUT S:YSA="" YSA="N" I "YyNnUu"'[YSA D HELP4^YSPROB2 G DA
 G:"Nn"[YSA PH
 I "Uu"[YSA S X="Incomplete data base",Z="Uncertain about drug/non-alcohol substance abuse" D UN^YSPROB2 G:YSTOUT FIN G PH
DD ;
 W !!?3,"Do you want (S)ubstance (non-alcohol) problem",!?3,"or (D)SM diagnosis?",!
 R !?3,"ANSWER (S or D): ",YSA:DTIME S YSTOUT='$T,YSUOUT=YSA["^" G:YSTOUT!YSUOUT FIN S:YSA="" YSA="Q" I "SsDd"'[YSA D HELP5^YSPROB2 G DD
 I "Dd"[YSA S PH1=YSDFN,PH2=P4 D ENPLDX^YSDX3 S YSDFN=PH1,P4=PH2 S:$D(YSQT) YSA="^" G PH
 S E2=1,X=$P(^DIC(620,9,0),U) D EP^YSPROB2 G:YSTOUT FIN
PH ;
 G:YSA["^" FIN
 I $D(^YS(615,YSDFN,P4,25)) S YSA="N" W !!?3,"There is already a 'General physical' problem",!?3,"on file.  Do you want to edit this problem: N// "
 I $D(^YS(615,YSDFN,P4,25)) R YSA:DTIME S YSTOUT='$T,YSUOUT=YSA["^" G FIN:YSTOUT,A11^YSPROB:YSUOUT S YSA=$E(YSA) I "YyNn"'[YSA D HELP3^YSPROB2 G PH
 I $D(^YS(615,YSDFN,P4,25)) G:"Nn"[YSA A11^YSPROB S (Y,E2)=25,Y(0)="^Y" D AP^YSPROB2 G:YSTOUT FIN G A11^YSPROB
 R !!?3,"Does patient have significant physical problems? (Y/N/U) N// ",YSA:DTIME S YSTOUT='$T,YSUOUT=YSA["^" G FIN:YSTOUT,A2^YSPROB:YSUOUT S:YSA="" YSA="N" I "YyNnUu"'[YSA D HELP4^YSPROB2 G PH
 G:"Nn"[YSA A11^YSPROB
 I "Uu"[YSA S X="Incomplete data base",Z="Uncertain about general physical problem" D UN^YSPROB2 G:YSTOUT FIN G A11^YSPROB
PHD ;
 W !!?3,"Do you want a (P)hysical problem or an ICD-9 (D)iagnosis?",!
 R !?3,"ANSWER (P or D): ",YSA:DTIME S YSTOUT='$T,YSUOUT=YSA["^" G:YSTOUT!YSUOUT FIN S:YSA="" YSA="Q" I "PpDd"'[YSA D HELP6^YSPROB2 G PHD
 I "Dd"[YSA S PH1=YSDFN,PH2=P4 D ENPLIC^YSDX3 S YSDFN=PH1,P4=PH2 Q:$D(YSQT)  G A11^YSPROB
 S E2=1,X=$P(^DIC(620,25,0),U) D EP^YSPROB2 G:YSTOUT FIN G A11^YSPROB
FIN ; Called by routine YSPROB, YSPROB4
 I $G(YSTOUT) W:IOF]"" @IOF
 K %,%DT,%ZIS,%Y,A,A2,B4,C,D,D0,D1,D2,D3,DA,DIC,DIE,DIU,DIV,DLAYGO,DO,DQ,DR,YSDT(0),YSDT(1),E2,E3,ER,H,I,I1,I2,I3,K,L1,L2,L3,M1,N1,N2,N3,N4,N5,N6,N7,P,P1,P2,P4,P5,R,R1,R2,S,S2,S3,S4,S5,S6,SCR,T,T2,T3,T4,V,X,X1,Y,Y1
 K YSA,YSAGE,YSBL,YSDFN,YSDOB,YSDTM,YSEND,YSFIN,YSLFT,YSMOR,YSNM,YSNO,YSOP,YSPF,YSPTD,YSSEX,YSSSN,YSTM,YSTOUT,YSZZ,Z,Z2,YSQT,PH1,PH2 Q
