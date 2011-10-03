DGPTODT2 ;ALB/BOK - PTF DRG TRIM POINT REPORT CONT ; 9/7/01 11:33am
 ;;5.3;Registration;**375**;Aug 13, 1993
MTRIM K DGBT1,DGWT1,DGBT1 S DGBT1=$S($D(^UTILITY($J,"DGPTFR","D",D2,"BT")):^("BT"),1:0),B1=+DGBT1+B1,B5=$P(DGBT1,U,5)+B5,B4=B4+$P(DGBT1,U,4),B2=B2+$P(DGBT1,U,2)
 S DGWT1=$S($D(^UTILITY($J,"DGPTFR","D",D2,"WT")):^("WT"),1:0_U_0),W1=+DGWT1+W1,W2=$P(DGWT1,U,2)+W2
 S DGAT1=$S($D(^UTILITY($J,"DGPTFR","D",D2,"AT")):^("AT"),1:0),A1=$P(DGAT1,U,3)+A1,A2=$P(DGAT1,U,2)+A2,A3=+DGAT1+A3
 S:'$D(^UTILITY($J,"DGTC",D2)) ^(D2,P)=""
 Q
TSET S $P(^UTILITY($J,"DGPTFR","T",D2),U,1)=$S($D(^UTILITY($J,"DGPTFR","T",D2)):+^(D2),1:0)+(+D3),$P(^UTILITY($J,"DGPTFR","T",D2),U,3)=$P(^UTILITY($J,"DGPTFR","T",D2),U,3)+$P(D3,U,2)
BSTRIM S ^UTILITY($J,"DGTC",P1,P)="" K DGBT1,DGWT1,DGAT1 S DGBT1=$S($D(^UTILITY($J,"DGPTFR","SB",G,D,D2,"BT")):^("BT"),1:0),B1=+DGBT1+B1,B5=B5+$P(DGBT1,U,5),B4=B4+$P(DGBT1,U,4),B2=B2+$P(DGBT1,U,2)
 S DGWT1=$S($D(^UTILITY($J,"DGPTFR","SB",G,D,D2,"WT")):^("WT"),1:0),W1=+DGWT1+W1,W2=$P(DGWT1,U,2)+W2
 S DGAT1=$S($D(^UTILITY($J,"DGPTFR","SB",G,D,D2,"AT")):^("AT"),1:0),A1=$P(DGAT1,U,3)+A1,A2=$P(DGAT1,U,2)+A2,A3=+DGAT1+A3 G:DGFLAG["Serv" STRIM
 Q
STRIM S Z=^UTILITY($J,"DGPTFR","T",D2),$P(^UTILITY($J,"DGPTFR","T",D2),U,6)=+DGBT1+$P(Z,U,6),$P(^UTILITY($J,"DGPTFR","T",D2),U,7)=$P(Z,U,7)+$P(DGBT1,U,2)
 S $P(^UTILITY($J,"DGPTFR","T",D2),U,8)=+DGWT1+$P(Z,U,8),$P(^UTILITY($J,"DGPTFR","T",D2),U,9)=$P(Z,U,9)+$P(DGWT1,U,2)
 S $P(^UTILITY($J,"DGPTFR","T",D2),U,10)=+DGAT1+$P(Z,U,10),$P(^UTILITY($J,"DGPTFR","T",D2),U,11)=$P(Z,U,11)+$P(DGAT1,U,2),$P(^UTILITY($J,"DGPTFR","T",D2),U,12)=$P(Z,U,12)+$P(DGAT1,U,3)
 S $P(^UTILITY($J,"DGPTFR","T",D2),U,2)=$P(Z,U,2)+$P(DGBT1,U,4) Q
HEAD I P S %=IOSL-14 F E=$Y:1:% W !
 I P D DIS^DGPTOD1 W !!
 W:P ?62,"-",P,"-" W @IOF,!,"DRG Trim Point Totals for ",$S(DGFLAG'["M":G2_" SERVICE",1:"MEDICAL CENTER"),$S(DGFLAG["Spec":" by Specialty",1:"") I 'DGD W " for Active Admissions"
 I DGD W !,"Discharge Dates from " S Y=DGSD+.1 X ^DD("DD") W $P(Y,"@",1)," to " S Y=DGED X ^DD("DD") W $P(Y,"@",1)
 W ?110,"Printed: " S Y=DT D DT^DIQ W !?15,$S('DGB:"not ",1:""),"including TRANSFER DRGs"
 W !!?38,"| BELOW |  WITHIN TRIM   |      ABOVE TRIM        |",!?16,"National",?30,"        ",?38,"|-------|----------------|------------------------|"
 W !,H,?36," | # of  | # of",?57,"Total | # of",?71,"Days Above ",?82,"Total |",?91,"Total    Total     Total",?123,"Average",!,H1
 W "| Disch | Disch     LOS  | Disch    Trim",?83,"LOS  |  Disch     LOS",?109,"Weight(*)",?124,"Weight",!
 K E S $P(E,"=",133)="" W E K E
 S P=P+1 Q
COV K ^UTILITY($J,"DGTC"),DGCPG,DGTCH S DGCPG(1)="TRIM POINT Report for "_DGFLAG_" by DRG",DGCPG(2)=$S(DGD:"for Discharge Dates Between ",1:"Active Admissions")
 I DGD S Y=DGSD+.1 X ^DD("DD") S %=Y,Y=$P(DGED,".") X ^DD("DD") S DGCPG(2)=DGCPG(2)_%_" to "_Y,DGCPG(3)=$S('DGB:"not ",1:"")_"including TRANSFER DRGs"
 S DGTCH="TRIM POINT by DRG^"_P3_"^PAGE #" D C^DGUTL Q
