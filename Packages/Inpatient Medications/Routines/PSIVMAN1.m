PSIVMAN1 ;BIR/RGY,PR-COMPILE MAN LIST ;07 OCT 97 / 9:35 AM 
 ;;5.0; INPATIENT MEDICATIONS ;**81**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ; Reference to ^PS(52.6 is supported by DBIA# 1231.
 ; Reference to ^PS(52.7 is supported by DBIA# 2173.
PRNTO ;
 G:$S('$D(^PS(55,DFN,"IV",ON,"AD",0)):1,$P(^(0),"^",4)<1:1,1:0) SOL
 F PSIVA=0:0 S PSIVA=$O(^PS(55,DFN,"IV",ON,"AD",PSIVA)) Q:'PSIVA  S PSIVA=PSIVA_"^"_^(PSIVA,0) W !?16,$P(^PS(52.6,$P(PSIVA,"^",2),0),"^")," ",$P(PSIVA,"^",3) W:$P(PSIVA,"^",4)]"" " in bottle(s): ",$P(PSIVA,"^",4) W ?80,"Lot#: __________"
SOL W:$E(PSIVDN,1,3)="***" !?16,"in",!?16,PSIVDN
 G:$S('$D(^PS(55,DFN,"IV",ON,"SOL",0)):1,$P(^(0),"^",4)<1:1,1:0) PAT
 W !?16,"in" F PSIV=0:0 S PSIV=$O(^PS(55,DFN,"IV",ON,"SOL",PSIV)) Q:'PSIV  S PSIV=PSIV_"^"_^(PSIV,0) D
 .S PSIVSL=$S($D(^PS(52.7,$P(PSIV,"^",2),0)):$P(^(0),"^")_" "_$P(PSIV,"^",3)_" "_$P(^(0),"^",4),1:"*** Undefined Solution") W !?16,PSIVSL W:$E(PSIVSL,1,3)'="***" ?80,"Lot#: __________"
 ;
PAT W !?4,"[",ON,"] ",?10,VADM(1)," (",$E(VADM(2),6,9),") (",$S(+VAIN(4):$P(VAIN(4),U,2),1:"Outpatient IV"),")",?62,+^PS(55,PSIVGL1,PSIVSN,PSIVGL2,PSIVT,PSIV1,PSIV2,DFN,ON) S TOTAL=TOTAL+^(ON)
 I P(4)="S"!(P(23)="S") W ?75,"  Syringe size: ",$S($D(^PS(55,DFN,"IV",ON,2)):$S($P(^(2),U,4)'="":$P(^(2),U,4),1:"NF"),1:"NF")
 S PSIV=$S($D(^PS(55,DFN,"IV",ON,3)):$P(^(3),"^"),1:"") W:PSIV]"" !?10,"Other Info.: ",PSIV S PSIV=$S($D(^(1)):$P(^(1),"^"),1:"") W:PSIV]"" !?14,"Remarks: ",$P(^(1),"^")
 W ! K PSIVA,PSIV3,PSIV Q
ENT ; will print man. list
 S NOFLG=0
 I '$D(^PS(55,PSIVGL1,PSIVSN,PSIVGL2)) S NOFLG=1,PSIVT=$G(PSIVTTM) D HDR Q
 S PSIVT="",TOTAL=0
 F JJ=0:0 S PSIVT=$O(^PS(55,PSIVGL1,PSIVSN,PSIVGL2,PSIVT)) D:TOTAL>0 TOTAL Q:PSIVT=""  D HDR  S PSIV1="" F JJ1=0:0 S PSIV1=$O(^PS(55,PSIVGL1,PSIVSN,PSIVGL2,PSIVT,PSIV1)) Q:PSIV1=""  S PSIVDN=PSIV1 D:PSIVDN["^"!(PSIVDN["zz") LOOKUP D RGY1
 K PSIVT,PSIV1,PSIV2,PSIVTEST,PSIVDN,FILE Q
LOOKUP ; expand drug info
 I PSIVDN?1"zz"1N S PSIVDN="*** No "_$S(PSIVDN["6":"Additive",1:"Solution") Q
 S FILE=+("52."_+$P(PSIVDN,"^",3)),DA=$P(PSIVDN,";",2)
 I $D(^PS(FILE,DA,0)),$P(^(0),"^")]"" S PSIVDN=$P(^(0),"^")_" "_$P(PSIVDN,"^",2)_$S(FILE[7:" "_$P(^(0),"^",4),1:"")
 Q
 ;
RGY ;
 F DFN=0:0 S DFN=$O(^PS(55,PSIVGL1,PSIVSN,PSIVGL2,PSIVT,PSIV1,PSIV2,DFN)) Q:'DFN  D ENIV^PSJAC F ON=0:0 S ON=$O(^PS(55,PSIVGL1,PSIVSN,PSIVGL2,PSIVT,PSIV1,PSIV2,DFN,ON)) Q:'ON  D SETP,PRNTO
 Q
SETP S Y=^PS(55,DFN,"IV",ON,0) F X=1:1:23 S P(X)=$P(Y,"^",X)
 Q
WD X ^DD("DD") W $P(Y,"@")," ",$P(Y,"@",2) Q
HDR W:$Y @IOF W !,"MANUFACTURING LIST F" I '$D(PSIVOD) W "ROM SUSPENSE"
 E  W "OR IV ROOM: ",$P(^PS(59.5,PSIVSN,0),U)," AT " S Y=PSIVDT X ^DD("DD") W $P(Y,"@")
 W !,"Printed on",?30,": "
 D NOW^%DTC S Y=$E(%,1,12) K %I,%H,%
 D WD G:'$D(PSIVOD) HDRE
 S X=$$CODES^PSIVUTL(PSIVT,55.01,.04) W !,X," manufacturing time: " S Y=PSIVMT(PSIVT) D WD W !!,X,"S covering from " S Y=PSIVOD(PSIVT) D WD W " to " S Y=PSIVCD(PSIVT) D WD
 I NOFLG=1 W ! D DESC^PSIVLBL1(PSIVT)
 Q:NOFLG=1  W !!?20,"Order",?60,"Totals",?80,"Lot #'s"
HDRE W ! F X=1:1:IOM-1 W "-"
 W ! S X=$$CODES^PSIVUTL(PSIVT,55.01,.04) W:X]"" !,"*** ",X,"S ***",!
 Q
RGY1 W !,PSIVDN,?55,"Total: ",^PS(55,PSIVGL1,PSIVSN,PSIVGL2,PSIVT,PSIV1,0)  W:$E(PSIVDN,1,3)="***" !?16,PSIVDN
 S PSIV2="" F JJ=0:0 S PSIV2=$O(^PS(55,PSIVGL1,PSIVSN,PSIVGL2,PSIVT,PSIV1,PSIV2)) Q:PSIV2=""  S PSIVDN=PSIV2 D:PSIVDN["^"!(PSIVDN["zz") LOOKUP D RGY
 ;
 Q
TOTAL W !?60,"_______",!?47,"Overall Total: ",TOTAL S TOTAL=0 Q
