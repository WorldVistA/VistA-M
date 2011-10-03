PSIVWCR ;BIR/PR-BUILD WARD COST REPORT ;22 JUL 94 / 11:32 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
SUB ;Set sub routine variable
 S S=$S(I3&(I2):1,'I3&('I2):2,I3&('I2):3,1:4) S:I2["NON" S=$S(I3:5,1:6) S:I2["." S=$S('I3:7,1:8)
 ;
HV ;Preset sum header variables
 S (TD,TC,PC)=0,ZF="TOTAL FOR WARD: ",Y=I7 X ^DD("DD") S F=Y,Y=I8 X ^DD("DD") S L=Y,H=F_" THROUGH "_L,Y=DT X ^DD("DD") S NOW=Y K ^UTILITY($J),VA
 ;
RM1 ;Run report for one IV room
 I I4 S V=I4 I $D(^PS(50.8,V,2)) F ST=I7-1:0 S ST=$O(^PS(50.8,V,2,ST)) Q:'ST!(ST>I8)  S NA="" D @S
 ;
RMALL ;Run report for all IV rooms
 I 'I4 F V=0:0 S V=$O(^PS(50.8,V)) Q:'V  I $D(^PS(50.8,V,2)) F ST=I7-1:0 S ST=$O(^PS(50.8,V,2,ST)) Q:'ST!(ST>I8)  S NA="" D @S
 ;
QUEUE ;Queue
 G:'$D(I6) W S ZTIO=I6,ZTRTN="W^PSIVWCR",ZTDTH=$H,ZTDESC="IV WARD COST REPORT"
 F G="^UTILITY($J,","I7","I8","H","NOW","I3","I2","I6","PC","TD","TC","ZF","I11","I10","I4","I15" S ZTSAVE(G)=""
 S %ZIS="QN",IOP=I6 D ^%ZIS,^%ZTLOAD G K
 ;
W ;Enter here to print report
 U IO I '$D(^UTILITY($J)) D H W !,$C(7),"No data." W:$D(I6)&($Y) @IOF D ^%ZISC G K
 D H S AL="" F V=0:0 D F^PSIVWCR1 S V=$O(^UTILITY($J,V)) Q:'V  W !,"IV ROOM: "_$P(^PS(59.5,V,0),U),! D P^PSIVWCR1
 D T^PSIVWCR1 G K
 ;
5 ;N 1 w
 F J=0:0 S NA=$O(^PS(50.8,V,2,ST,2,"B",NA)) Q:NA=""  S DA=$O(^(+$O(^(NA,0)),0)) I DA D:^(DA)=1&($D(^PS(50.8,V,2,ST,2,DA,0)))&($D(^(3,I3,0))) B
 Q
6 ;N all w
 F J=0:0 S NA=$O(^PS(50.8,V,2,ST,2,"B",NA)) Q:NA=""  S DA=$O(^(+$O(^(NA,0)),0)) I DA,^(DA)=1,$D(^PS(50.8,V,2,ST,2,DA,0)) F I3=0:0 S I3=$O(^PS(50.8,V,2,ST,2,DA,3,I3)) Q:'I3  D B
 Q
1 ;1 d 1 w
 F J=0:0 S NA=$O(^PS(50.8,V,2,ST,2,"B",NA)) Q:NA=""  S DA=$O(^(NA,I2,0)) I DA,$D(^PS(50.8,V,2,ST,2,DA,0)),$D(^(3,I3,0)) D B
 Q
2 ;All w all d
 F DA=0:0 S DA=$O(^PS(50.8,V,2,ST,2,DA)) Q:'DA  I $D(^(DA,0)) F I3=0:0 S I3=$O(^PS(50.8,V,2,ST,2,DA,3,I3)) Q:'I3  I $D(^(I3,0)) D B
 Q
 ;
3 ;1 w all d
 F DA=0:0 S DA=$O(^PS(50.8,V,2,ST,2,DA)) Q:'DA  I $D(^(DA,0)),$D(^(3,I3,0)) D B
 Q
4 ;All w 1 d
 F J=0:0 S NA=$O(^PS(50.8,V,2,ST,2,"B",NA)) Q:NA=""  S DA=$O(^(NA,I2,0)) I DA F I3=0:0 S I3=$O(^PS(50.8,V,2,ST,2,DA,3,I3)) Q:'I3  D B
 Q
7 ;C all WD
 F J=0:0 S NA=$O(^PS(50.8,V,2,ST,2,"B",NA)) Q:NA=""  F D5=0:0 S D5=$O(^PS(50.8,V,2,ST,2,"B",NA,D5)) Q:'D5  S DA=$O(^(D5,0)) Q:'DA  D:I2["V." 71 I '$D(VA),$D(^PS(50.2,"AD",$P(I2,".",2),D5)) F I3=0:0 S I3=$O(^PS(50.8,V,2,ST,2,DA,3,I3)) Q:'I3  D B
 Q
71 ;V C all w
 S VA=1
 I I2["000" S MT=$E(I2,3,4) I $E($P(^PSDRUG(D5,0),U,2),1,2)=MT F I3=0:0 S I3=$O(^PS(50.8,V,2,ST,2,DA,3,I3)) Q:'I3  D B
 Q:I2["000"
 I $P(^PSDRUG(D5,0),U,2)=$P(I2,".",2) F I3=0:0 S I3=$O(^PS(50.8,V,2,ST,2,DA,3,I3)) Q:'I3  D B
 Q
8 ;C 1 w
 F J=0:0 S NA=$O(^PS(50.8,V,2,ST,2,"B",NA)) Q:NA=""  F D5=0:0 S D5=$O(^PS(50.8,V,2,ST,2,"B",NA,D5)) Q:'D5  S DA=$O(^(D5,0)) Q:'DA  D:I2["V." 81 I '$D(VA),$D(^PS(50.2,"AD",$P(I2,".",2),D5)),$D(^PS(50.8,V,2,ST,2,DA,3,I3,0)) D B
 Q
81 ;V C 1 w
 S VA=1
 I I2["000" S MT=$E(I2,3,4) I $E($P(^PSDRUG(D5,0),U,2),1,2)=MT,$D(^PS(50.8,V,2,ST,2,DA,3,I3,0)) D B
 Q:I2["000"
 I $P(^PSDRUG(D5,0),U,2)=$P(I2,".",2),$D(^PS(50.8,V,2,ST,2,DA,3,I3,0)) D B
 Q
B ;
 S G=^PS(50.8,V,2,ST,2,DA,0),G2=^PS(50.8,V,2,ST,2,DA,3,I3,0),DG=$P(G,U),CO=$P(G,U,5),UM=$P(G,U,6),UD=$P(G2,U,2),UR=$P(G2,U,3),DEST=$P(G2,U,4),UC=$P(G2,U,5)
 S J=$S($D(^UTILITY($J,V,I3,DG)):^(DG),1:CO_U_UM),^(DG)=$P(J,U,1,2)_U_($P(J,U,3)+UD)_U_(UD-UR-UC*CO+$P(J,U,4))_U_($P(J,U,5)+UR)_U_($P(J,U,6)+DEST)_U_($P(J,U,7)+UC)
 Q
H ;
 W:$Y @IOF S PC=PC+1 W !!,?56,"WARD/DRUG USAGE REPORT:",?120,"PAGE:",?102,$J(PC,4),!,?56,H
 W !?56,I11,!?56,I10,!?56,I15
 W !!!?1," DRUG NAME",?38," DISPENSED",?57,"(DESTROYED)",?77,"RECYCLED",?95,"CANCELLED",?123,"DRUG COST" W !
 F LN=1:1:132 W "=" W:LN=132 !
 Q
K K VA,AL,%,^UTILITY($J),V,B,C,DA,NOW,DG,F,H,L,G,G2,S,J,K,LN,NA,PC,I2,I3,UR,ST,TC,TD,CO,UD,UM,W,Y,Z,G3,I7,I8,ZF,DEST,UC,I9,I10,I11 S:$D(ZTQUEUED) ZTREQ="@" Q
