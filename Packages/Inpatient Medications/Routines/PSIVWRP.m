PSIVWRP ;BIR/PR-WARD/DRUG USAGE REPORT ;20 JUN 94 / 2:35 PM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 S S=$S(I3&(I2):1,'I3&('I2):2,I3&('I2):3,1:4)
 I I2["NON" S S=$S(I3:5,1:6)
 I I2["." S S=$S('I3:7,1:8)
 S (TD,TC,PC)=0,ZF="TOTAL FOR WARD: ",Y=I7 X ^DD("DD") S F=Y,Y=I8 X ^DD("DD") S L=Y,H=F_" THROUGH "_L,Y=DT X ^DD("DD") S NOW=Y
 K ^UTILITY($J),VA F V=0:0 S V=$O(^PS(50.8,V)) Q:'V  I $D(^PS(50.8,V,2)) F ST=I7-1:0 S ST=$O(^PS(50.8,V,2,ST)) Q:'ST!(ST>I8)  S NA="" D @S
Q G:'$D(I6) W S ZTIO=I6,ZTDESC="WARD/DRUG USAGE REPORT (IV)",ZTRTN="W^PSIVWRP",ZTDTH=$H
 F G="^UTILITY($J,","I7","I8","H","NOW","I3","I2","PC","TD","TC","ZF","I11","I10" S ZTSAVE(G)=""
 S %ZIS="QN",IOP=I6 D ^%ZIS,^%ZTLOAD G K
W U IO I '$D(^UTILITY($J)) D H W !,$C(7),"No data." D ^%ZISC G K
 S AL="" F V=0:0 S V=$O(^UTILITY($J,V)) Q:'V  D H W !,"IV ROOM: "_$P(^PS(59.5,V,0),U),! D P
 D T
 Q
5 ;N 1 w
 F J=0:0 S NA=$O(^PS(50.8,V,2,ST,2,"B",NA)) Q:NA=""  S DA=$O(^(+$O(^(NA,0)),0)) I DA D:^(DA)=1&($D(^PS(50.8,V,2,ST,2,DA,0)))&($D(^(3,I3,0))) B
 Q
6 ;N all w
 F J=0:0 S NA=$O(^PS(50.8,V,2,ST,2,"B",NA)) Q:NA=""  S DA=$O(^(+$O(^(NA,0)),0)) I DA,^(DA)=1,$D(^PS(50.8,V,2,ST,2,DA,0)) F I3=0:0 S I3=$O(^PS(50.8,V,2,ST,2,DA,3,I3)) Q:'I3  D B
 Q
1 ;1 d 1 w
 F J=0:0 S NA=$O(^PS(50.8,V,2,ST,2,"B",NA)) Q:NA=""  S DA=$O(^(NA,I2,0)) I DA,$D(^PS(50.8,V,2,ST,2,DA,0)),$D(^(3,I3,0)) D B
 Q
2 ;
 F DA=0:0 S DA=$O(^PS(50.8,V,2,ST,2,DA)) Q:'DA  I $D(^(DA,0)) F I3=0:0 S I3=$O(^PS(50.8,V,2,ST,2,DA,3,I3)) Q:'I3  I $D(^(I3,0)) D B
 Q
 ;
3 ;
 F DA=0:0 S DA=$O(^PS(50.8,V,2,ST,2,DA)) Q:'DA  I $D(^(DA,0)),$D(^(3,I3,0)) D B
 Q
4 ;
 F J=0:0 S NA=$O(^PS(50.8,V,2,ST,2,"B",NA)) Q:NA=""  S DA=$O(^(NA,I2,0)) I DA F I3=0:0 S I3=$O(^PS(50.8,V,2,ST,2,DA,3,I3)) Q:'I3  D B
 Q
7 ;
 F J=0:0 S NA=$O(^PS(50.8,V,2,ST,2,"B",NA)) Q:NA=""  F D5=0:0 S D5=$O(^PS(50.8,V,2,ST,2,"B",NA,D5)) Q:'D5  S DA=$O(^(D5,0)) Q:'DA  D:I2["V." 71 I '$D(VA),$D(^PS(50.2,"AD",$P(I2,".",2),D5)) F I3=0:0 S I3=$O(^PS(50.8,V,2,ST,2,DA,3,I3)) Q:'I3  D B
 Q
71 ;
 S VA=1
 I I2["000" S MT=$E(I2,3,4) I $E($P(^PSDRUG(D5,0),U,2),1,2)=MT F I3=0:0 S I3=$O(^PS(50.8,V,2,ST,2,DA,3,I3)) Q:'I3  D B
 Q:I2["000"
 I $P(^PSDRUG(D5,0),U,2)=$P(I2,".",2) F I3=0:0 S I3=$O(^PS(50.8,V,2,ST,2,DA,3,I3)) Q:'I3  D B
 Q
8 ;
 F J=0:0 S NA=$O(^PS(50.8,V,2,ST,2,"B",NA)) Q:NA=""  F D5=0:0 S D5=$O(^PS(50.8,V,2,ST,2,"B",NA,D5)) Q:'D5  S DA=$O(^(D5,0)) Q:'DA  D:I2["V." 81 I '$D(VA),$D(^PS(50.2,"AD",$P(I2,".",2),D5)),$D(^PS(50.8,V,2,ST,2,DA,3,I3,0)) D B
 Q
81 ;
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
 W:$Y @IOF S PC=PC+1 W ?95,NOW,!!!,?56,"WARD/DRUG USAGE REPORT:",?99,"PG",?102,$J(PC,4),!,?56,H
 W !?56,I11,", ",I10
 W !!!?1," DRUG NAME",?38," DISPENSED",?57,"(DESTROYED)",?77,"RECYCLED",?95,"CANCELLED",?123,"DRUG COST" W !
 F LN=1:1:132 W "="
 W ! Q
P K K F W=0:0 W:$D(K) !,?121,"-----------",!,?18,ZF,Z,?105,$J(K,27,4),!! D:$Y+5>IOSL H S K=0,W=$O(^UTILITY($J,V,W)) Q:'W  D P1
 Q
P1 ;
 S Z=$S($D(^DIC(42,W,0)):$P(^(0),U),1:"OUTPATIENT") W !?1,Z D:$Y+5>IOSL H F Y=0:0 S AL=$O(^UTILITY($J,V,W,AL)) Q:AL=""  S K=K+$P(^(AL),U,4) D PD
 Q
PD S G3=^UTILITY($J,V,W,AL),C=$P(G3,U,2),X=$P(^DD(52.6,2,0),U,3),X=$P(X,";",C),X=$P(X,":",2),C=X
 S TD=TD+$P(G3,U,3),TC=TC+$P(G3,U,4) W !,?2,$E(AL,1,36),?38,$J($P(G3,U,3),10,2)_" "_C,?57,$J($P(G3,U,6),10,2) W ?78,$J($P(G3,U,5),7,2),?96,$J($P(G3,U,7),7,2),?115,$J($P(G3,U,4),17,4)
 D:$Y+4>IOSL H
 Q
T ;
 W !!,?120,"============"
 W !,?40,"GRAND TOTAL:",?112,$J(TC,20,4)
 W:$Y @IOF D ^%ZISC
K K VA,AL,%,^UTILITY($J),V,B,C,DA,NOW,DG,F,H,L,G,G2,S,J,K,LN,NA,PC,I2,I3,UR,ST,TC,TD,CO,UD,UM,W,Y,Z,G3,I7,I8,ZF,DEST,UC,I9,I10,I11 S:$D(ZTQUEUED) ZTREQ="@"
 Q
