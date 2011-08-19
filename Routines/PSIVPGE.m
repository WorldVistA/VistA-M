PSIVPGE ;BIR/PR-PURGE IV ORDERS ;05 DEC 97 / 8:44 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
EN ;
 N XQUIT D ^PSIVXU Q:$D(PSIVXU)  D VW
Q W:'$D(PSIVPR)&($Y) @IOF S:$D(ZTQUEUED) ZTREQ="@" K DFN,N,ON,P,P17,PS,PSIVDT,PSIVLAB,PSIVLOG,PSIVPN,PSIVRD,PSIVREA,PSIVPDT,PSIVVO,PSJACNWP,Z,ZTSK D ENIVKV^PSGSETU
 Q
VW ;Ask user to view order.
 S (PSIVLOG,PSIVLAB)=0 W !!,"View orders before purged" S %=1 D YN^DICN G:%=-1 Q I %=0 S HELP="PRTVW" D ^PSIVHLP1 G VW
 S PSIVVO=%[1 I PSIVVO,PSIVPR=ION W $C(7),!!,"WARNING -- YOU HAVE NOT SELECTED A PRINTER PROFILE DEVICE !!"
 ;
VW1 ;Ask user to view activity log.
 I PSIVVO W !,"View activity logs before purged" S %=1 D YN^DICN G:%=-1 Q S PSIVLOG=%[1 I %=0 S HELP="PRTAVW" D ^PSIVHLP1 G VW1
 ;
VW2 ;Ask to view label log
 I PSIVVO W !,"View label logs before purged" S %=1 D YN^DICN G:%=-1 Q S PSIVLAB=%[1 I %=0 S HELP="LABLOG" D ^PSIVHLP2 G VW2
BEG ;Start purge
 S HELP="PURGE" D ^PSIVHLP W ! S %DT="ETA",%DT("A")="Purge orders older than what date: " D ^%DT G:Y<0 Q
 S PSIVPDT=Y D NOW^%DTC S Y=% S X1=Y,X2=PSIVPDT D ^%DTC I X<30 W $C(7),!,"Enter a date greater than 30 days ago.",! G BEG
 ;
YN ;Make sure it is ok to start purge.
 W !!,"Will purge expired IV orders from " S Y=PSIVPDT X ^DD("DD") W $P(Y,"@")," ",$P(Y,"@",2),"back.",!,"Ok to start purge" S %=2 D YN^DICN I %=0 S HELP="YNPRG" D ^PSIVHLP1 G YN
 G:%=-1!(%=2) Q
 I PSIVPR'=ION S ZTDESC="PURGE IV ORDERS",ZTRTN="DEQ^PSIVPGE",(ZTSAVE("PSIVLOG"),ZTSAVE("PSIVLAB"),ZTSAVE("PSIVSITE"),ZTSAVE("PSIVPDT"),ZTSAVE("PSIVVO"),ZTSAVE("PSIVSN"),ZTSAVE("PSJSYSW0"),ZTSAVE("PSJSYSU"))="",ZTIO=PSIVPR D ^%ZTLOAD G Q
 ;
DEQ W:$Y @IOF S PSIVPN=0,Y=PSIVPDT,PSIVSLV=IO'=IO(0)!(IOST'["C-") X ^DD("DD") W:PSIVSLV !,"Purge expired IV orders from ",$P(Y,"@")," ",$P(Y,"@",2)," back.",!,"Time started: "
 D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") W:PSIVSLV $P(Y,"@")," ",$P(Y,"@",2),!!
 S PSIVPDT=PSIVPDT+1,PSIVRD=1
 F PSIVDT=0:0 S PSIVDT=$O(^PS(55,"AIV",PSIVDT)) Q:PSIVDT>PSIVPDT!('PSIVDT)!$D(DIRUT)  D
 .F DFN=0:0 S DFN=$O(^PS(55,"AIV",PSIVDT,DFN)) Q:'DFN!$D(DIRUT)  D:PSIVVO&(PSIVDT>1) ENNA^PSIVACT S PSJACNWP=1 D ENIV^PSJAC F ON=0:0 S ON=$O(^PS(55,"AIV",PSIVDT,DFN,ON)) Q:'ON!$D(DIRUT)  D PRGE
 I '$D(DIRUT) W !!,"Time finished: " D NOW^%DTC S Y=% X ^DD("DD") W $P(Y,"@")," ",$P(Y,"@",2) W !,"Number of IV ORDERS purged is: ",PSIVPN,!!
 D Q
 Q
PRGE ;
 I $D(^PS(55,DFN,"IV",ON,2)) I $P(^(2),"^",2)'=PSIVSN&$P(^(2),"^",2)!(^(2)>PSIVPDT&($P(^PS(55,DFN,"IV",ON,0),"^",3)'=1)) Q
 I $G(^PS(55,DFN,"IV",ON,"ADC")) S TDC=+^("ADC") K ^PS(55,"ADC",TDC,DFN,ON),TDC
 I PSIVVO,$D(^PS(55,DFN,"IV",ON,0)),PSIVDT>1 S (P("PON"),ON55)=ON_"V" D GT55^PSIVORFB,ENNONUM^PSIVORV2(DFN,ON) S PSIVPN=PSIVPN+1 D PAUSE Q:$D(DIRUT)
 I 'PSIVVO,$D(^PS(55,DFN,"IV",ON,0)),PSIVDT>1 S PSIVPN=PSIVPN+1 W:'(PSIVPN#100) "."
 I PSIVLOG,$D(^PS(55,DFN,"IV",ON,0)),PSIVDT>1 S PSJORD=ON55 D ENLOG^PSIVVW1,PAUSE Q:$D(DIRUT)
 S ON=+ON ;* ^PSIVVW1 set ON=PSJORD and PSJORD is concatenated to "V"
 I PSIVLAB,$D(^PS(55,DFN,"IV",ON,0)),PSIVDT>1 D DATA^PSIVLTR1(DFN,ON),PAUSE Q:$D(DIRUT)
 D DCNV^PSIVOE S X=$G(^PS(55,DFN,"IV",ON,0)) Q:'X
 K ^PS(55,"PSIVSUS",PSIVSN,DFN,ON),^PS(55,"AIV",PSIVDT,DFN,ON),^PS(55,DFN,"IV",ON),^PS(55,DFN,"IV","B",ON)
 K:$D(^PS(55,DFN,"IV","AIT",$P(X,U,4),$P(X,U,3),ON)) ^PS(55,DFN,"IV","AIT",$P(X,U,4),$P(X,U,3),ON)
 K:$D(^PS(55,DFN,"IV","AIS",$P(X,U,3),ON)) ^PS(55,DFN,"IV","AIS",$P(X,U,3),ON)
 I $D(^PS(55,DFN,"IV",0)),$P(^(0),"^",4) S $P(^(0),"^",4)=$P(^(0),"^",4)-1
 Q
 ;
PAUSE ;
 I 'PSIVSLV K DIR S DIR(0)="E" D ^DIR
 Q
 ;
ENT ;Will let user delete an IV order if no doses printed.
 D FULL^VALM1
 S PSJORD=ON D ENNH^PSIVORV2(ON)
 D A,PAUSE^PSJLMUTL
 Q
A W !,"Delete this order" S %=2 D YN^DICN I %=0 S HELP="OPUR" D ^PSIVHLP1 G A
 I %=-1!(%=2) W $C(7),"  Order not deleted." Q
 S ON=+ON55 I $D(^PS(55,DFN,"IV",ON,9)) S Y=^(9) I $P(Y,"^",2) W !,"Order # ",ON," ... Not deleted ",$P(Y,"^",2)," dose(s) given " S Y=+Y X ^DD("DD") W $P(Y,"@")," ",$P(Y,"@",2) Q
 D ENDEL W "  Order deleted." Q
ENDEL ;D DCNV^PSIVOE S X=^PS(55,DFN,"IV",ON,0) S $P(X,U,17)="P" K:$P(X,U,3)]"" ^PS(55,"AIV",$P(X,U,3),DFN,ON) S $P(X,U,3)=1,^PS(55,DFN,"IV",ON,0)=X,^PS(55,"AIV",1,DFN,ON)="" I $D(^PS(55,DFN,"IV",ON,"ADC")) S TC=^("ADC") K ^PS(55,"ADC",TC,DFN,ON)
 D DCNV^PSIVOE S X=$G(^PS(55,DFN,"IV",ON,0)) Q:'X  S $P(X,U,17)="P"
 K:$P(X,U,3)]"" ^PS(55,"AIV",$P(X,U,3),DFN,ON)
 K:$D(^PS(55,DFN,"IV","AIT",$P(X,U,4),$P(X,U,3),ON)) ^PS(55,DFN,"IV","AIT",$P(X,U,4),$P(X,U,3),ON)
 K:$D(^PS(55,DFN,"IV","AIS",$P(X,U,3),ON)) ^PS(55,DFN,"IV","AIS",$P(X,U,3),ON)
 S $P(X,U,3)=1,^PS(55,DFN,"IV",ON,0)=X,^PS(55,"AIV",1,DFN,ON)="",^PS(55,DFN,"IV","AIT",$P(X,U,4),1,ON)="",^PS(55,DFN,"IV","AIS",1,ON)=""
 I $D(^PS(55,DFN,"IV",ON,"ADC")) S TC=^("ADC") K ^PS(55,"ADC",TC,DFN,ON)
