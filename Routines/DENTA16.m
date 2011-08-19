DENTA16 ;ISC2/SAW-PRINT/DISPLAY TREATMENT DATA REPORTS - INDIVIDUAL SITTINGS BY CLINIC OR PROVIDER ;7/21/88  5:23 PM
 ;;1.2;DENTAL;**16,19**;JAN 26, 1989
 ;VERSION 1.2
 G NONE:'DENTC S DENTPRV=""
 F M=0:1 D:M COMP1 S DENTPRV=$O(^UTILITY($J,"DENTR",DENTPRV)) Q:DENTPRV=""  S H6="DENTAL PROVIDER NO.: "_DENTPRV Q:Z5=U  D:M HOLD Q:Z5=U  D HD S DENT="" F N=0:0 S DENT=$O(^UTILITY($J,"DENTR",DENTPRV,DENT)) Q:DENT=""  S X0=^(DENT) D B1 Q:Z5=U
 D:Z5'=U HOLD G EXIT
B1 S X=^DENT(221,DENT,0) D:IOSL-($Y#IOSL)<4 HOLD3 Q:Z5=U  D HD1
 K A F I=1:2 W:'$P(X0,U,I) ! Q:'$P(X0,U,I)  S:IOSL-($Y#IOSL)<4 A=1 S X1=$P(X0,U,I),X2=$P(X0,U,I+1) W ?40,$E($P(^DIC(220.3,X1,0),U,1),1,35),?77,$J(X2,3) W:$P(X0,U,I+2) ! I $D(A) K:'$P(X0,U,I+2) A D HOLD3 Q:Z5=U
 Q
HD S H3="DENTAL SERVICE TREATMENT REPORT - SITTINGS BY PROVIDER",H5=$S(H1=H2:"FOR "_H1,1:"FROM "_H1_" TO "_H2)_"   STATION NO.: "_DENTSTA_"   "_H6
 W @IOF,?(80-$L(H3)\2),H3,!,?(80-$L(H5)\2),H5
 W !!,?19,"PATIENT",?29,"PAT",?34,"BED",!,"TREATMENT DATE",?19,"SSN",?29,"CAT",?34,"SECT",?40,"TREATMENT (PROCEDURE)",?77,"NO.",! Q
HD1 S Y=$P(X,U,1) X ^DD("DD") S Y=$$DATE^DENTA14(Y) W !,Y,?19,$P(X,U,2),?30,$J($P(X,U,19),2),?35 W:$P(X,U,19)<9 $J($P(X,U,6),2) Q
HDR S H3="DENTAL SERVICE TREATMENT REPORT - INDIVIDUAL SITTINGS",H5=$S(H1=H2:"FOR "_H1,1:"FROM "_H1_" TO "_H2)_"   STATION NO.: "_DENTSTA_"   "
 W @IOF,?(80-$L(H3)\2),H3,!,?(80-$L(H5)\2),H5
 W !!,?19,"PROV",?25,"PATIENT",?35,"PAT",?40,"BED",!,"TREATMENT DATE",?19,"NO.",?27,"SSN",?35,"CAT",?40,"SECT",?46,"TREATMENT (PROCEDURE)",?77,"NO.",! Q
HOLD Q:$D(ZTSK)!(IO'=IO(0))  S Z5="" R !,"Press return to continue, uparrow (^) to exit: ",Z5:DTIME Q
HOLD3 D HOLD D:Z5'=U HD D:Z5'=U&($D(A)) HD1 K A Q
NONE S DENTF1=1 W !,"There is no treatment data for review/release for the time frame you specified",*7 G EXIT1
COMP W !,"There "_$S(DENTC=1:"is ",1:"are ")_DENTC_$S(DENTC=1:" sitting",1:" sittings")_" in the time frame you specified.  All data is complete" Q
COMP1 S DENTC(1)=^UTILITY($J,"DENTR",DENTPRV) W !,"There "_$S(DENTC(1)=1:"is ",1:"are ")_DENTC(1)_$S(DENTC(1)=1:" sitting",1:" sittings")_" for provider ",DENTPRV," in the time frame you specified." Q
ERR W !!,"The treatment data for this report is incomplete/incorrect.",!,"There are ",DENTC," sittings in the time frame you specified.",!,"The following errors were found:",*7,! Q
EXIT G EXIT1:Z5=U I $D(DENTF1) W @IOF,*7 D ERR S H="" F I=1:1 Q:Z5=U  S H=$O(^UTILITY($J,"DENTERR",H)) Q:H=""  F J=1:1:5 D:IOSL-($Y#IOSL)<4 HOLD Q:Z5=U  W:$D(^UTILITY($J,"DENTERR",H,J)) !,^(J)
 D:'$D(DENTF1) COMP W ! D:$D(DENTF1)&(Z5'=U) HOLD
EXIT1 S:Z5=U DENTF1=1 K DENT,DENTED,DENTPRV,DENTSD,H,H1,H2,H3,H4,H6,H7,I,J,K,M,N,X,X1,X2 Q
