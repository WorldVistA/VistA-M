PSDDSOR ;BHM/MHA/PWC - Digitally signed CS Orders Report; 08/30/02
 ;;3.0; CONTROLLED SUBSTANCES ;**40,42,45,67**;13 Feb 97;Build 8
 ;Ref. to ^PSRX( supp. by IA 1977
 ;Ref. to ^PS(52.41, supp. by IA 3848
 ;Ref. to ^PS(59, supp. by IA 2621
 ;Ref. ^PSDRUG( supp. by IA 2621
 ;Ref. to GETDATA^ORWOR1 supp. by IA 3750
 ;
 N AC,BDT,CT,DFN,DP,DRG,DRUG,DV,DVN,EDT,FI,NS,OP,ORD,ORS,PAT,PG,POS,PL,PL1,PRO,PROV
 N PSDBD,PSDDF,PSDDV,PSDED,PSDIO,PSDPO,PSDPR,PSDPT,PSDRG,PSDSC,PSDSD
 N PSDXF,RX,RX0,RX2,S1,S2,S3,S4,S5,S6,SCH,SR,SRT,TDT,TY,I,J,O,X,Y,Z
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
SITE I '$D(PSOSITE) D  Q:$D(DUOUT)!($D(DTOUT))  G:'$D(PSOSITE) SITE
 .W ! S DIC("A")="Division: ",DIC=59,DIC(0)="AEMQ"
 .S DIC("S")="I $S('$D(^PS(59,+Y,""I"")):1,'^(""I""):1,DT'>^(""I""):1,1:0)"
 .D ^DIC K DIC Q:$D(DUOUT)!($D(DTOUT))  I +Y>0 S PSOSITE=+Y Q
 .W !!,"A 'DIVISION' must be selected!  or Enter '^' to exit."
 S PSDDV=PSOSITE
 W !!?10,"You are logged on under the ",$P(^PS(59,PSDDV,0),"^")," division.",!
DATE ;ask date range
 W ! K %DT S %DT(0)=-DT,%DT="AEP",%DT("A")="Start Date: " D ^%DT
 I Y<0!($D(DTOUT)) G END
 S (%DT(0),PSDBD)=Y,%DT("A")="End Date: "
 W ! D ^%DT I Y<0!($D(DTOUT)) G END
 S PSDED=Y,PSDSD=PSDBD-.000001
 W ! D KV S DIR("A")="Include discontinued orders",DIR(0)="Y",DIR("B")="NO"
 D ^DIR K DIR G:$D(DIRUT) END S PSDDF=Y
 W ! S DIR("A")="Include expired orders",DIR(0)="Y",DIR("B")="NO" D ^DIR
 K DIR G:$D(DIRUT) END S PSDXF=Y
 W ! S DIR("A")="Include pending orders",DIR(0)="Y",DIR("B")="NO" D ^DIR
 K DIR G:$D(DIRUT) END S PSDPO=Y
SL S (CT,PSDRG,PSDPR,PSDPT,PSDSC)=1,DP="Within ",DIR("B")="Drug" K SRT,SR
 S OP="D:Drug;PR:Provider;PA:Patient;S:Schedule"
 F  D KV S DIR(0)="SAO^"_OP D  Q:OP=""!($D(DUOUT))!($D(DTOUT))!($D(DIRUT))
 .S:CT=1 DIR("B")="Drug" K:CT>1 DIR("B")
 .S DIR("A")=$S(CT>1:DP,1:"")_"Sort By: " D ^DIR
 .Q:$D(DIRUT)
 .S O="" F I=1:1:$L(OP,";") S J=$P(OP,";",I) I J'[Y(0) S O=O_$S(O="":"",1:";")_J
 .S OP=O
 .S SRT(CT)=Y,SR(Y)=CT S CT=CT+1,DP=DP_$S(Y="D":"Drug, ",Y="PR":"Provider, ",Y="PA":"Patient, ",1:"Schedule, ")
 .D @Y
 G:$D(DUOUT)!($D(DTOUT)) END
 I $D(SRT) K SR S I="" D  G:$D(DIRUT) END G:'Y SL
 .W !!,"You have selected the following:",!
 .F  S I=$O(SRT(I)) Q:I=""  D
 ..S J=SRT(I),SR(I)=$S(J="D":"DRUG",J="PR":"PROV",J="PA":"PAT",1:"SCH")
 ..W !?5,$S(J="D":"Drug",J="PR":"Provider",J="PA":"Patient",1:"Schedule")
 .W ! D KV S DIR("A")="Continue to print:",DIR("B")="Y",DIR(0)="YN" D ^DIR
 G DEV Q
D ;ask drug(s)
 W !!,?5,"You may select a single drug, several drugs,",!,?5,"or enter ^ALL to select all drugs.",!!
 K DRG,DIC S PSDRG=0,DIC("A")="Select DRUG: ",DIC=50,DIC(0)="QEAM"
 S DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,DT'>+^(""I""):1,1:0),$P($G(^(2)),""^"",3)[""O"",$D(^PSDRUG(""ASP"",+$G(^(2)),+Y)),+$P(^PSDRUG(+Y,0),""^"",3)&(+$P(^PSDRUG(+Y,0),""^"",3)<6)"
 F  D ^DIC Q:Y<0  S DRG(+Y)=""
 S X=$$UP^XLFSTR(X)  ; PSD*3*67 pwc
 K DIC I X="^ALL" S PSDRG=1 K DUOUT Q
 Q:($D(DUOUT))!($D(DTOUT))
 I '$D(DRG)&(Y<0) G D
 Q
PR ;ask provider(s)
 W !!,?5,"You may select a single provider, several providers,",!,?5,"or enter ^ALL to select all providers.",!!
 K PRO,DIC S PSDPR=0,DIC="^VA(200,",DIC(0)="QEAM",DIC("A")="Select Provider: "
 F  D ^DIC Q:Y<0  S PRO(+Y)=""
 S X=$$UP^XLFSTR(X)  ; PSD*3*67 PWC
 K DIC I X="^ALL" S PSDPR=1 K DUOUT Q
 Q:$D(DUOUT)!($D(DTOUT))
 I '$D(PRO)&(Y<0) G PR
 Q
PA ;ask patient(s)
 W !!,?5,"You may select a single patient, several patients,",!,?5,"or enter ^ALL to select all patients.",!!
 K PAT,DIC S PSDPT=0,DIC=2,DIC(0)="QEAM",DIC("A")="Select Patient: "
 F  D ^DIC Q:Y<0  S PAT(+Y)=""
 S X=$$UP^XLFSTR(X)  ; PSD*3*67 pwc
 K DIC I X="^ALL" S PSDPT=1 K DUOUT Q
 Q:$D(DUOUT)!($D(DTOUT))
 I '$D(PAT)&(Y<0) G PA
 Q
S ;
 W !! K SCH,PSDSC D KV S DIR("A")="Include All CS Schedules: ",DIR("B")="Y",DIR(0)="YN" D ^DIR
 Q:$D(DIRUT)
 I Y S PSDSC=1 Q
 F I=1:1:7 W !,?5,$S(I=1:"1 - SCHEDULE I",I=2:"2 - SCHEDULE II",I=3:"3 - SCHEDULE II NON-NARCOTICS",I=4:"4 - SCHEDULE III",I=5:"5 - SCHEDULE III NON-NARCOTICS",I=6:"6 - SCHEDULE IV NARCOTICS",1:"7 - SCHEDULE V NARCOTICS")
 W ! D KV
 S DIR(0)="L^1:7" D ^DIR Q:$D(DIRUT)
 I Y,$L(Y,",")-1=1 S Y=+Y,SCH($S(Y<3:Y,Y=3:"2n",Y=4:3,Y=5:"3n",1:Y-2))="" Q
 F I=1:1:$L(Y,",")-1 S J=+$P(Y,",",I) S SCH($S(J<3:J,J=3:"2n",J=4:3,J=5:"3n",1:J-2))=""
 Q
DEV K %ZIS,IOP,POP,ZTSK S PSDIO=ION,%ZIS="QM" D ^%ZIS K %ZIS
 I POP S IOP=PSDIO D ^%ZIS K IOP,PSDIO W !,"Please try later!" G END
 K PSDIO I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK D  G END
 .S ZTRTN="EN^PSDDSOR",ZTDESC="Digitally Signed CS Orders Report"
 .F G="PSDDV","PSDSD","PSDBD","PSDED","PSDDF","PSDXF","PSDPO","PSDRG","PSDPR","PSDPT","PSDSC" S:$D(@G) ZTSAVE(G)=""
 .S ZTSAVE("SRT(")="",ZTSAVE("SR(")="" S:$D(PRO) ZTSAVE("PRO(")="" S:$D(DRG) ZTSAVE("DRG(")="" S:$D(PAT) ZTSAVE("PAT(")="" S:$D(SCH) ZTSAVE("SCH(")=""
 .D ^%ZTLOAD W:$D(ZTSK) !,"Report is Queued to print !!" K ZTSK
EN ;
 K ^TMP($J) S (I,NS)=0 F  S I=$O(SR(I)) Q:'I  S NS=I
 S PND=0,TY="APKI",POS=PSDSD F  S PSDSD=$O(^PSRX(TY,PSDSD)) Q:'PSDSD!(PSDSD>PSDED)  D EN1
 D:PSDPO EN2 D PSTR G END
 Q
EN1 S RX=0 F  S RX=$O(^PSRX(TY,PSDSD,RX)) Q:'RX  D
 .Q:'$D(^PSRX(RX,0))  Q:$P(^(2),"^",9)'=PSDDV  S RX0=^(0),ORD=$P($G(^("OR1")),"^",2)
 .Q:'$P(RX0,"^",2)!('$P(RX0,"^",4))!('$P(RX0,"^",6))!('ORD)
 .D GETD
 Q
EN2 S DV=0,FI=52.41,PND=1
 F  S POS=$O(^PS(FI,TY,POS)) Q:'POS!(POS>(PSDED_".999999"))  S DV=0 F  S DV=$O(^PS(FI,TY,POS,DV)) Q:'DV  D
 .S RX=0 F  S RX=$O(^PS(FI,TY,POS,DV,RX)) Q:'RX  D
 ..Q:'$D(^PS(FI,RX,0))  S RX0=^(0)
 ..I $P(RX0,"^",3)["NW"!($P(RX0,"^",3)="DC") I $P(RX0,"^",24) S ORD=$P(RX0,"^") D GETD
 Q
GETD ;
 I $G(PSDPT) G GETD1
 Q:'$D(PAT($P(RX0,"^",2)))
GETD1 ;
 D GETDATA^ORWOR1(.Y,ORD,$P(RX0,"^",2)) Q:Y<0  D:$G(PND)
 .S Y=Y_"^"_$P(RX0,"^",3)
 .I $P(RX0,"^",3)="DC",$G(^PS(52.41,RX,4))]"" D
 ..S Y=Y_"^"_$TR(^PS(52.41,RX,4),":",","),$P(Y,"^",4)="5;DISCONTINUED"
 D CONT
 Q
CONT ;
 S ORS=+$P(Y,"^",4) Q:'ORS!('PSDXF&(ORS=7))
 Q:'PSDDF&(",1,12,13,"[(","_ORS_","))
 S S1=$S(ORS=5:4,ORS=7:3,",1,12,13,"[(","_ORS_","):2,1:1)
 S PAT=$P($G(Y(1)),"^") Q:PAT=""
 S DRUG=$S($P($G(Y(2)),"^")]"":$P(Y(2),"^"),$P($G(Y(6)),"^")]"":$P(Y(6),"^"),1:"")
 G:$G(PSDRG) CT1
 Q:'$D(DRG($P(Y(2),"^",2)))
CT1 S PROV=$P($G(Y(4)),"^") Q:PROV=""
 G:$G(PSDPR) CT2
 Q:'$D(PRO($P(Y(4),"^",2)))
CT2 S SCH=$P($G(Y(2)),"^",5) Q:SCH=""
 G:$G(PSDSC) CT3
 Q:'$D(SCH($P(Y(2),"^",5)))
CT3 I NS=4 D  Q
 .S ^TMP($J,S1,@(SR(1)),@(SR(2)),@(SR(3)),@(SR(4)),RX,0)=Y,I=0
 .F  S I=$O(Y(I)) Q:'I  S ^TMP($J,S1,@(SR(1)),@(SR(2)),@(SR(3)),@(SR(4)),RX,I)=Y(I)
 I NS=3 D  Q
 .S ^TMP($J,S1,@(SR(1)),@(SR(2)),@(SR(3)),RX,0)=Y,I=0
 .F  S I=$O(Y(I)) Q:'I  S ^TMP($J,S1,@(SR(1)),@(SR(2)),@(SR(3)),RX,I)=Y(I)
 I NS=2 D  Q
 .S ^TMP($J,S1,@(SR(1)),@(SR(2)),RX,0)=Y,I=0
 .F  S I=$O(Y(I)) Q:'I  S ^TMP($J,S1,@(SR(1)),@(SR(2)),RX,I)=Y(I)
 S ^TMP($J,S1,@(SR(1)),RX,0)=Y,I=0
 F  S I=$O(Y(I)) Q:'I  S ^TMP($J,S1,@(SR(1)),RX,I)=Y(I)
 Q
 ;
PSTR D NOW^%DTC S TDT=$E(%,4,5)_"/"_$E(%,6,7)_"/"_$E(%,2,3)_"@"_$E(%,9,10)_":"_$E(%,11,12)
 N P1,P2 S $E(P1,42)="",$E(P2,12)="",PG=1,Y=PSDBD D D^DIQ S BDT=Y,Y=PSDED D D^DIQ S EDT=Y
 S DVN=$$GET1^DIQ(59,PSDDV,.01) S:DVN]"" DVN=$E(DVN,1,20) S:DVN="" DVN="N/A"
 U IO I '$D(^TMP($J)) D HD W !!,"**********    NO DATA TO PRINT   **********",!! Q
 D @("N"_NS)
 Q
IN K Y0,Y1,Y2,Y3,Y4,Y5,Y6 S S6=""
 Q
WR S PG=1 D HD W !,$S(AC=1:"Processed",AC=2:"Discontinued",AC=3:"Expired",1:"Pending")_" Orders:",! Q
N4 S AC="" F  S AC=$O(^TMP($J,AC)) Q:'AC  D WR D  Q:$D(DIRUT)  D HD1 Q:$D(DIRUT)
 .S S1="" F  S S1=$O(^TMP($J,AC,S1)) Q:S1=""  S S2="" F  S S2=$O(^TMP($J,AC,S1,S2)) Q:S2=""  D  Q:$D(DIRUT)
 ..S S3="" F  S S3=$O(^TMP($J,AC,S1,S2,S3)) Q:S3=""  S S4="" F  S S4=$O(^TMP($J,AC,S1,S2,S3,S4)) Q:S4=""  D  Q:$D(DIRUT)
 ...S S5="" F  S S5=$O(^TMP($J,AC,S1,S2,S3,S4,S5)) Q:S5=""  D STR4 Q:$D(DIRUT)
 Q
STR4 ;
 D IN F  S S6=$O(^TMP($J,AC,S1,S2,S3,S4,S5,S6)) Q:S6=""  S Z="Y"_S6,@Z=^TMP($J,AC,S1,S2,S3,S4,S5,S6)
 D PRT Q
N3 S AC="" F  S AC=$O(^TMP($J,AC)) Q:'AC  D WR D  Q:$D(DIRUT)  D HD1 Q:$D(DIRUT)
 .S S1="" F  S S1=$O(^TMP($J,AC,S1)) Q:S1=""  S S2="" F  S S2=$O(^TMP($J,AC,S1,S2)) Q:S2=""  D  Q:$D(DIRUT)
 ..S S3="" F  S S3=$O(^TMP($J,AC,S1,S2,S3)) Q:S3=""  D  Q:$D(DIRUT)
 ...S S5="" F  S S5=$O(^TMP($J,AC,S1,S2,S3,S5)) Q:S5=""  D STR3 Q:$D(DIRUT)
 Q
STR3 D IN F  S S6=$O(^TMP($J,AC,S1,S2,S3,S5,S6)) Q:S6=""  S Z="Y"_S6,@Z=^TMP($J,AC,S1,S2,S3,S5,S6)
 D PRT Q
N2 S AC="" F  S AC=$O(^TMP($J,AC)) Q:'AC  D WR D  Q:$D(DIRUT)  D HD1 Q:$D(DIRUT)
 .S S1="" F  S S1=$O(^TMP($J,AC,S1)) Q:S1=""  S S2="" F  S S2=$O(^TMP($J,AC,S1,S2)) Q:S2=""  D  Q:$D(DIRUT)
 ..S S5="" F  S S5=$O(^TMP($J,AC,S1,S2,S5)) Q:S5=""  D STR2 Q:$D(DIRUT)
 Q
STR2 D IN F  S S6=$O(^TMP($J,AC,S1,S2,S5,S6)) Q:S6=""  S Z="Y"_S6,@Z=^TMP($J,AC,S1,S2,S5,S6)
 D PRT Q
N1 S AC="" F  S AC=$O(^TMP($J,AC)) Q:'AC  D WR D  Q:$D(DIRUT)  D HD1 Q:$D(DIRUT)
 .S S1="" F  S S1=$O(^TMP($J,AC,S1)) Q:S1=""  D  Q:$D(DIRUT)
 ..S S5="" F  S S5=$O(^TMP($J,AC,S1,S5)) Q:S5=""  D STR1 Q:$D(DIRUT)
 Q
STR1 D IN F  S S6=$O(^TMP($J,AC,S1,S5,S6)) Q:S6=""  S Z="Y"_S6,@Z=^TMP($J,AC,S1,S5,S6)
 D PRT
 Q
PRT D:($Y+4)>IOSL HD Q:$D(DIRUT)  D PRT^PSDDSOR1
 Q
HD D HD1 Q:$D(DIRUT)
 W @IOF,!?2,"Digitally Signed CS Orders Report for Division "_DVN,?70,"Page: ",PG
 W !,?8,"Date Range: "_BDT_" - "_EDT,?53,"Printed on: "_TDT,!
 S PG=PG+1
 Q
HD1 I PG>1,$E(IOST)="C" K DIR S DIR(0)="E",DIR("A")=" Press Return to Continue or ^ to Exit" D ^DIR K DIR
 Q
END W ! D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K ^TMP($J),PSDDV,PSDSD,PSDED,PSDDF,PSDXF,DRG,PRO,PAT,PND,SCH,SRT,PSDRG,PSDPR,PSDPT,PSDSC,VA,Y0,Y1,Y2,Y3,Y4,Y5,Y6
KV K DIR,DIRUT,DTOUT,DUOUT
 Q
