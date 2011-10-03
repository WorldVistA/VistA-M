PSIVPCR ;BIR/PR,MV-BUILD PROVIDER COST REPORT ;20 JUN 94 / 2:33 PM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
SUB ;Set sub routine variable
 S S=$S(I1&(I2):1,'I1&('I2):2,I1&('I2):3,1:4) S:I2["NON" S=$S(I1:5,1:6) S:I2["." S=$S(I1:8,1:7) K ^UTILITY($J),VA
 ;
RM1 ;Run report for one IV room
 I I4 S V=I4 I $D(^PS(50.8,V,2)) F DAT=I7-1:0 S DAT=$O(^PS(50.8,V,2,DAT)) Q:'DAT!(DAT>I8)  I $D(^(DAT,2)) S NA="" D @S
 ;
RMALL ;Run report for all IV rooms
 I 'I4 F V=0:0 S V=$O(^PS(50.8,V)) Q:'V  I $D(^(V,2)) F DAT=I7-1:0 S DAT=$O(^PS(50.8,V,2,DAT)) Q:'DAT!(DAT>I8)  I $D(^(DAT,2)) S NA="" D @S
 ;
QUEUE ;Queue
 I $D(I6) S ZTIO=I6,ZTDESC="IV PROVIDER DRUG COST REPORT (PRINT)",ZTRTN="W^PSIVPCR",ZTDTH=$H F G="^UTILITY($J,","I7","I8","I1","I2","I6","I9","I10","I4","I15","BRIEF" S ZTSAVE(G)=""
 I  S %ZIS="QN",IOP=I6 D ^%ZIS,^%ZTLOAD G K^PSIVPCR1
 ;
W ;Enter to print report
 U IO S PG=0,Y=I7 X ^DD("DD") S H=Y,Y=I8 X ^DD("DD") S H=H_" THROUGH "_Y D H I '$D(^UTILITY($J)) W !,"NO DATA." W:$D(I6)&($Y) @IOF D ^%ZISC G K^PSIVPCR1
 D P^PSIVPCR1 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
1 ;1 p 1 d
 F J=0:0 S NA=$O(^PS(50.8,V,2,DAT,2,"B",NA)) Q:NA=""  S DA=$O(^(NA,I2,0)) I DA,$D(^PS(50.8,V,2,DAT,2,DA,0)),$D(^(2,I1,0)) S P=I1 D B
 Q
2 ;Al p al d
 F DA=0:0 S DA=$O(^PS(50.8,V,2,DAT,2,DA)) Q:'DA  I $D(^(DA,0)) F P=0:0 S P=$O(^PS(50.8,V,2,DAT,2,DA,2,P)) Q:'P  I $D(^(P,0)) D B
 Q
3 ;1 p al d
 F DA=0:0 S DA=$O(^PS(50.8,V,2,DAT,2,DA)) Q:'DA  I $D(^(DA,0)),$D(^(2,I1,0)) S P=I1 D B
 Q
4 ;Al p 1 d
 F J=0:0 S NA=$O(^PS(50.8,V,2,DAT,2,"B",NA)) Q:NA=""  S DA=$O(^(NA,I2,0)) I DA F P=0:0 S P=$O(^PS(50.8,V,2,DAT,2,DA,2,P)) Q:'P  D B
 Q
5 ;1 p n d
 F J=0:0 S NA=$O(^PS(50.8,V,2,DAT,2,"B",NA)) Q:NA=""  S DA=$O(^(+$O(^(NA,0)),0)) I DA,^(DA)=1,$D(^PS(50.8,V,2,DAT,2,DA,2,I1,0)) S P=I1 D B
 Q
6 ;Al p n d
 F J=0:0 S NA=$O(^PS(50.8,V,2,DAT,2,"B",NA)) Q:NA=""  S DA=$O(^(+$O(^(NA,0)),0)) I DA,^(DA)=1,$D(^PS(50.8,V,2,DAT,2,DA,0)) F P=0:0 S P=$O(^PS(50.8,V,2,DAT,2,DA,2,P)) Q:'P  D B
 Q
7 ;C al p
 F J=0:0 S NA=$O(^PS(50.8,V,2,DAT,2,"B",NA)) Q:NA=""  F D5=0:0 S D5=$O(^PS(50.8,V,2,DAT,2,"B",NA,D5)) Q:'D5  S DA=$O(^(D5,0)) Q:'DA  D:I2["V." 71 I '$D(VA),$D(^PS(50.2,"AD",$P(I2,".",2),D5)) F P=0:0 S P=$O(^PS(50.8,V,2,DAT,2,DA,2,P)) Q:'P  D B
 Q
71 ;VA C al p
 S VA=1
 I I2["000" S MT=$E(I2,3,4) I $E($P(^PSDRUG(D5,0),U,2),1,2)=MT F P=0:0 S P=$O(^PS(50.8,V,2,DAT,2,DA,2,P)) Q:'P  D B
 Q:I2["000"
 I $P(^PSDRUG(D5,0),U,2)=$P(I2,".",2) F P=0:0 S P=$O(^PS(50.8,V,2,DAT,2,DA,2,P)) Q:'P  D B
 Q
8 ;C 1 p
 F J=0:0 S NA=$O(^PS(50.8,V,2,DAT,2,"B",NA)) Q:NA=""  F D5=0:0 S D5=$O(^PS(50.8,V,2,DAT,2,"B",NA,D5)) Q:'D5  S DA=$O(^(D5,0)) Q:'DA  D:I2["V." 81 I '$D(VA),$D(^PS(50.2,"AD",$P(I2,".",2),D5)),$D(^PS(50.8,V,2,DAT,2,DA,2,I1,0)) S P=I1 D B
 Q
81 ;VA C 1 p
 S VA=1
 I I2["000" S MT=$E(I2,3,4) I $E($P(^PSDRUG(D5,0),U,2),1,2)=MT,$D(^PS(50.8,V,2,DAT,2,DA,2,I1,0)) S P=I1 D B
 Q:I2["000"
 I $P(^PSDRUG(D5,0),U,2)=$P(I2,".",2),$D(^PS(50.8,V,2,DAT,2,DA,2,I1,0)) S P=I1 D B
 Q
B ;
 S P1=$S('$D(^VA(200,+P,0)):"?",$P(^(0),"^")]"":$P(^(0),"^"),1:"?")
 S G=^PS(50.8,V,2,DAT,2,DA,0),G2=^PS(50.8,V,2,DAT,2,DA,2,P,0),DG=$P(G,U),CO=$P(G,U,5),UM=$P(G,U,6),UD=$P(G2,U,2),UR=$P(G2,U,3),DES=$P(G2,U,4),UC=$P(G2,U,5)
 S J=$S($D(^UTILITY($J,V,P1,DG)):^(DG),1:CO_U_UM),^(DG)=$P(J,U,1,2)_U_($P(J,U,3)+UD)_U_(UD-UR-UC*CO+$P(J,U,4))_U_($P(J,U,5)+UR)_U_($P(J,U,6)+DES)_U_($P(J,U,7)+UC)
 Q
H ;
 S PG=PG+1 W:$Y @IOF
 I $D(BRIEF) D HBRIEF Q
 W !?56,"PROVIDER DRUG COST REPORT (REGULAR):",?120,"PAGE:",PG,!?56,H
 W !?56,I9,!?56,I10,!?56,I15
 W !!!?1,"PROVIDER",?36,"DISPENSED",?56,"DESTROYED",?73,"RECYCLED",?97,"CANCELLED",?128,"COST",! F I=1:1:132 W "=" I I=132 W !
 Q
HBRIEF ;
 W !?20,"PROVIDER DRUG COST REPORT (CONDENSED):",?70,"PAGE:",PG,!?20,H
 W !?20,I9,!?20,I10,!?20,I15
 W !!!?1,"PROVIDER",?53,"TOTAL COST",! F I=1:1:80 W "="
 Q
