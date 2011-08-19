PSIVLBDL ;BIR/PR,CML3-DELETE LBLS FROM SUSPENSE ;02 FEB 94 / 1:54 PM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
 D ^PSIVXU I $D(XQUIT) K XQUIT Q
 S PSIVAC="PRO" D ENGETP^PSIV G:DFN<0 DONE W !?3,"...one moment, please..." D EXPCHK
START ;
 D HDR I '$D(^PS(55,"PSIVSUS",PSIVSN,DFN)) W !!,"There are no labels on suspense for this patient." G PSIVLBDL
 D SUSLP1 G:X?1."?" START
DONE ;
 K %,A,B1,B2,BB,DFN,DIC,FL,HELP,J,K,KK,ON,P,PSGDT,PSIV,PSIVAC,PSIVCT,PSIVDT,PSIVRD,TN,VAERR,X,X1,X2,Y,Z D ENIVKV^PSGSETU Q
 ;
SUSLP1 ;
 S X="" F ON=0:0 S ON=$O(^PS(55,"PSIVSUS",PSIVSN,DFN,ON)) Q:'ON  D:$Y+7>IOSL DELINE Q:X="^"  Q:X?1."?"  D LP S X=""
 Q:$E(X)="^"  Q:X?1."?"
DELINE ;
 W !,"Select Order Number: " I ON W !,"or press return to view more "
 R X:DTIME W:'$T $C(7) S:'$T X="^" I "^"[X D:X=""&ON HDR Q
 I X?1."?" S HELP="LBSUSD" D ^PSIVHLP1 R !,"Press return to continue ",Y:DTIME W:'$T $C(7) S:Y="^"!'$T X="^" Q
 D:X'="ALL" ONC W:'$D(X) $C(7),"  ??" G:'$D(X) DELINE D KILL W !,"Deleted." Q
HDR ;
 W:$Y @IOF W !!,"Patient Name ",VADM(1)," (",$S(VAIN(4):$P(VAIN(4),U,2),1:"Outpatient IV"),")",!,"Order Number",?30,"Order",?IOM-11,"Suspended",! F X=1:1:IOM-1 W "-"
 Q
LP S Y=^PS(55,DFN,"IV",ON,0) F X=1:1:23 S P(X)=$P(Y,"^",X)
 F PSIVDT=0:0 S PSIVDT=$O(^PS(55,"PSIVSUS",PSIVSN,DFN,ON,PSIVDT)) Q:'PSIVDT  D PRNT
 Q
PRNT S Y=PSIVDT X ^DD("DD") S Y=+^PS(55,"PSIVSUS",PSIVSN,DFN,ON,PSIVDT)_"^"_$P(Y,"@")_" "_$P(Y,"@",2)
 W !,ON,$J(+Y_" label"_$S(+Y>1:"s",1:"")_"   "_$P(Y,"^",2),IOM-1-$X),!
 S PSIV=0,SSNF=1 D ENP3^PSIVRNL K SSNF Q
KILL ;
 I X'="ALL" F B1=1:1:Y F B2=1:1:$L(Y(B1),",")-1 S ON=$P(Y(B1),",",B2) K ^PS(55,"PSIVSUS",PSIVSN,DFN,ON)
 I X="ALL" F ON=0:0 S ON=$O(^PS(55,"PSIVSUS",PSIVSN,DFN,ON)) Q:'ON  K ^PS(55,"PSIVSUS",PSIVSN,DFN,ON)
 I '$D(^PS(55,"PSIVSUS",PSIVSN,DFN)) S PSIVD="" F KK=0:0 S PSIVD=$O(^PS(55,"PSIVSUS",PSIVSN,PSIVD)) Q:PSIVD=""  K ^PS(55,"PSIVSUS",PSIVSN,PSIVD,DFN)
 S X="^" Q
 ;
ONC ;
 K Y S Y=1,Y(1)=""
 F Q=1:1:$L(X,",") S X1=$P(X,",",Q) D SET Q:'$D(X)
 Q
 ;
SET ;
 I $S('X1:1,1:'$D(^PS(55,"PSIVSUS",PSIVSN,DFN,X1))) K X Q
 I $L(Y(Y))+$L(X1)>244 S Y=Y+1,Y(Y)=""
 S Y(Y)=Y(Y)_X1_"," Q
 ;
EXPCHK ;
 D NOW^%DTC
 F ON=0:0 S ON=$O(^PS(55,"PSIVSUS",PSIVSN,DFN,ON)) Q:'ON  S X=$S($D(^PS(55,DFN,"IV",ON,0)):^(0),1:"") I $P(X,U,2)'=$P(X,U,3),$P(X,U,3)'>%!("D"[$P(X,U,17)) K ^PS(55,"PSIVSUS",PSIVSN,DFN,ON)
 Q
