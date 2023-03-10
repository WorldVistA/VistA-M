PSDDSOR ;BHM/MHA/PWC - Digitally signed CS Orders Report ;02/02/2021
 ;;3.0;CONTROLLED SUBSTANCES;**40,42,45,67,73,89**;Feb 13,1997;Build 18
 ;Ref. to ^PSRX( supp. by IA 1977
 ;Ref. to ^PS(52.41, supp. by IA 3848
 ;Ref. to ^PS(59, supp. by IA 2621
 ;Ref. ^PSDRUG( supp. by IA 2621
 ;Ref. to GETDATA^ORWOR1 supp. by IA 3750
 ;Ref. to ^PSOERXU9 supported by ICR/IA 7222
 ;
 N AC,BDT,CT,DFN,DP,DRG,DRUG,DV,DVN,EDT,FI,NS,OP,ORD,ORS,PAT,PG,POS,PL,PL1,PRO,PROV
 N PSDBD,PSDDF,PSDDV,PSDED,PSDIO,PSDPO,PSDPR,PSDPT,PSDRG,PSDSC,PSDSD,PSDRXSRC
 N PSDXF,RX,RX0,RX2,S1,S2,S3,S4,S5,S6,SCH,SR,SRT,TDT,TY,I,J,O,X,Y,Z,G
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
 ;
 ; Prescription Source Filter Prompts - PSD-89
 K DIR S DIR(0)="S^C:CPRS (Internal);E:eRx (External - Inbound);B:Electronically Signed (CPRS+eRx);W:Written (Backdoor Pharmacy);A:ALL"
 S DIR("B")="A"
 S DIR("?")="Select the source of the CS prescription"
 S DIR("A")="Prescription Source"
 D ^DIR
 I $D(DIRUT)!$D(DTOUT) Q
 S PSDRXSRC=Y
 ;
 W ! D KV S DIR("A")="Include discontinued orders",DIR(0)="Y",DIR("B")="NO"
 D ^DIR K DIR G:$D(DIRUT) END S PSDDF=Y
 W ! S DIR("A")="Include expired orders",DIR(0)="Y",DIR("B")="NO" D ^DIR
 K DIR G:$D(DIRUT) END S PSDXF=Y
 I $G(PSDCSRX)!(PSDRXSRC="W") S PSDPO=0 G SL  ;PSD-89
 W ! S DIR("A")="Include pending orders",DIR(0)="Y",DIR("B")="NO" D ^DIR
 K DIR G:$D(DIRUT) END S PSDPO=Y
SL S (CT,PSDRG,PSDPR,PSDPT,PSDSC)=1,DP="Within ",DIR("B")="Drug" K SRT,SR
 S OP="D:Drug;PR:Provider;PA:Patient;S:Schedule"
 F  D KV S DIR(0)="SAO^"_OP D  Q:OP=""!($D(DUOUT))!($D(DTOUT))!($D(DIRUT))
 .S:CT=1 DIR("B")="Drug" K:CT>1 DIR("B")
 .S DIR("A")=$S(CT>1:DP,1:"")_"Sort By: " D ^DIR
 .Q:$D(DIRUT)
 .I Y="S" S PSDSC=0
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
 W !!,"Select controlled substance schedule(s)"
 K DIR
 S DIR(0)="S^1:"_$S($G(PSDCSRX):"SCHEDULE I - II",1:"SCHEDULE II")_";2:SCHEDULES III - V;3:SCHEDULES II - V",DIR("A")="Select Schedule(s)",DIR("B")=3
 D ^DIR I $D(DTOUT)!($D(DUOUT))!($D(DIRUT)) Q
 K SCH S I=$S($G(PSDCSRX)&(Y=1):1,Y=2:3,1:2),J=$S(Y=1:2,1:5) F K=I:1:J S SCH(K)=""
 W ! D KV
 Q
DEV K %ZIS,IOP,POP,ZTSK S PSDIO=ION,%ZIS="QM" D ^%ZIS K %ZIS
 I POP S IOP=PSDIO D ^%ZIS K IOP,PSDIO W !,"Please try later!" G END
 K PSDIO I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK D  G END
 .S ZTRTN="EN^PSDDSOR",ZTDESC="Digitally Signed CS Orders Report"
 .F G="PSOSITE","PSDDV","PSDSD","PSDBD","PSDED","PSDDF","PSDXF","PSDPO","PSDRG","PSDPR","PSDPT","PSDSC","PSDRXSRC" S:$D(@G) ZTSAVE(G)=""
 .S ZTSAVE("SRT(")="",ZTSAVE("SR(")="" S:$D(PRO) ZTSAVE("PRO(")="" S:$D(DRG) ZTSAVE("DRG(")="" S:$D(PAT) ZTSAVE("PAT(")="" S:$D(SCH) ZTSAVE("SCH(")=""
 .D ^%ZTLOAD W:$D(ZTSK) !,"Report is Queued to print !!" K ZTSK
EN ;
 K ^TMP("PSDDSOR",$J) S (I,NS)=0 F  S I=$O(SR(I)) Q:'I  S NS=I
 S PND=0,POS=PSDSD
 F  S PSDSD=$O(^PSRX("AC",PSDSD)) Q:'PSDSD!(PSDSD>PSDED)  D EN1
 D:PSDPO EN2 D PSTR G END
 Q
EN1 S RX=0 F  S RX=$O(^PSRX("AC",PSDSD,RX)) Q:'RX  D
 .Q:'$D(^PSRX(RX,0))  Q:$P(^(2),"^",9)'=PSDDV  Q:($G(PSDCSRX))&('+$P(^(2),"^",2))  S RX0=^(0),ORD=$P($G(^("OR1")),"^",2)
 .;Not a Controlled Substance Rx - PSD-89, next 4 lines
 .I '$$CSDS^PSOSIGDS(+$P(RX0,"^",6)) Q
 .I PSDRXSRC="E"!(PSDRXSRC="W"),$P($G(^PSRX(RX,"PKI")),"^",1) Q
 .I PSDRXSRC="C"!(PSDRXSRC="W"),$$ERXIEN^PSOERXU9(RX) Q
 .I PSDRXSRC'="W",PSDRXSRC'="A",'$P($G(^PSRX(RX,"PKI")),"^",1),'$$ERXIEN^PSOERXU9(RX) Q
 .Q:'$P(RX0,"^",2)!('$P(RX0,"^",4))!('$P(RX0,"^",6))!('ORD)
 .D GETD
 Q
EN2 S DV=0,PND=1
 N PSIR,PSINST
 S PSIR=0 F  S PSIR=$O(^PS(59,PSOSITE,"INI1",PSIR)) Q:'PSIR  I $P($G(^PS(59,PSOSITE,"INI1",PSIR,0)),"^") S PSINST($P($G(^(0)),"^"))=""
 F  S POS=$O(^PS(52.41,"AD",POS)) Q:'POS!(POS>(PSDED_".999999"))  S DV=0 F  S DV=$O(^PS(52.41,"AD",POS,DV)) Q:'DV  D
 .S RX=0 F  S RX=$O(^PS(52.41,"AD",POS,DV,RX)) Q:'RX  D
 ..Q:'$D(^PS(52.41,RX,0))  S RX0=^(0)
 ..;Not a Controlled Substance Rx - PSD-89
 ..I '$$CSDS^PSOSIGDS(+$P(RX0,"^",9)) Q
 ..I PSDRXSRC="E"!(PSDRXSRC="W"),$P(RX0,"^",24) Q
 ..I PSDRXSRC="C"!(PSDRXSRC="W"),$$ERXIEN^PSOERXU9(RX_"P") Q
 ..I PSDRXSRC'="W",PSDRXSRC'="A",'$P(RX0,"^",24),'$$ERXIEN^PSOERXU9(RX_"P") Q
 ..I $P(RX0,"^",3)["NW"!($P(RX0,"^",3)="DC") I $D(PSINST($P($G(^PS(52.41,RX,"INI")),"^"))) S ORD=$P(RX0,"^") D GETD  ;PSD-89 - remove check for sig stat
 Q
GETD ;
 I $G(PSDPT) G GETD1
 Q:'$D(PAT($P(RX0,"^",2)))
GETD1 ;
 D GETDATA^PSDDSOR1(.Y,ORD,$P(RX0,"^",2)) Q:Y<0  D:$G(PND)
 .S Y=Y_"^"_$P(RX0,"^",3)
 .I $P(RX0,"^",3)="DC",$G(^PS(52.41,RX,4))]"" D
 ..S Y=Y_"^"_$TR(^PS(52.41,RX,4),":",","),$P(Y,"^",4)="13;DISCONTINUED"
 D CONT
 Q
CONT ;
 S ORS=+$P(Y,"^",4) Q:ORS=""  S $P(Y,"^",12)=$S($G(PND):"P",1:"R")
 S $P(Y,"^",13)=$S($G(PND):$P(RX0,"^",13),1:$P(RX0,"^",5))
 I '$P(Y,"^",10) Q:'PSDXF&(ORS=7)  Q:'PSDDF&(",1,12,13,"[(","_ORS_","))  S S1=$S(ORS=5:4,ORS=7:3,",1,12,13,"[(","_ORS_","):2,1:1)
 I $P(Y,"^",10) Q:'PSDXF&(ORS=11)  Q:'PSDDF&(",12,13,14,15,"[(","_ORS_","))  S S1=$S(ORS=99:4,ORS=11:3,",12,13,14,15,"[(","_ORS_","):2,1:1)
 S PAT=$P($G(Y(1)),"^") Q:PAT=""
 S DRUG=$S($P($G(Y(2)),"^")]"":$P(Y(2),"^"),$P($G(Y(6)),"^")]"":$P(Y(6),"^"),1:"")
 N DRGN S DRGN=$S(+$P($G(Y(2)),"^",2):+$P(Y(2),"^",2),+$P($G(Y(6)),"^",2):+$P(Y(6),"^",2),1:"")
 G:$G(PSDRG) CT1
 Q:'$D(DRG(DRGN))
CT1 S PROV=$P($G(Y(4)),"^") Q:PROV=""
 G:$G(PSDPR) CT2
 Q:'$D(PRO($P(Y(4),"^",2)))
CT2 S SCH=$P($G(Y(2)),"^",5) Q:SCH=""  ; check is this the DEA code?
 G:$G(PSDSC) CT3
 Q:'$D(SCH(+$P(Y(2),"^",5)))  ;if schedule not selected then should include all schedules.
CT3 I NS=4 D  Q
 .S ^TMP("PSDDSOR",$J,S1,@(SR(1)),@(SR(2)),@(SR(3)),@(SR(4)),RX,0)=Y,I=0
 .F  S I=$O(Y(I)) Q:'I  M ^TMP("PSDDSOR",$J,S1,@(SR(1)),@(SR(2)),@(SR(3)),@(SR(4)),RX,I)=Y(I)
 I NS=3 D  Q
 .S ^TMP("PSDDSOR",$J,S1,@(SR(1)),@(SR(2)),@(SR(3)),RX,0)=Y,I=0
 .F  S I=$O(Y(I)) Q:'I  M ^TMP("PSDDSOR",$J,S1,@(SR(1)),@(SR(2)),@(SR(3)),RX,I)=Y(I)
 I NS=2 D  Q
 .S ^TMP("PSDDSOR",$J,S1,@(SR(1)),@(SR(2)),RX,0)=Y,I=0
 .F  S I=$O(Y(I)) Q:'I  M ^TMP("PSDDSOR",$J,S1,@(SR(1)),@(SR(2)),RX,I)=Y(I)
 S ^TMP("PSDDSOR",$J,S1,@(SR(1)),RX,0)=Y,I=0
 F  S I=$O(Y(I)) Q:'I  M ^TMP("PSDDSOR",$J,S1,@(SR(1)),RX,I)=Y(I)
 Q
 ;
PSTR ;
 N %
 D NOW^%DTC S TDT=$E(%,4,5)_"/"_$E(%,6,7)_"/"_$E(%,2,3)_"@"_$E(%,9,10)_":"_$E(%,11,12)
 N P1,P2 S $E(P1,42)="",$E(P2,12)="",PG=1,Y=PSDBD D D^DIQ S BDT=Y,Y=PSDED D D^DIQ S EDT=Y
 S DVN=$$GET1^DIQ(59,PSDDV,.01) S:DVN]"" DVN=$E(DVN,1,20) S:DVN="" DVN="N/A"
 U IO I '$D(^TMP("PSDDSOR",$J)) D HD W !!,"**********    NO DATA TO PRINT   **********",!! Q
 D @("N"_NS)
 Q
IN K Y0,Y1,Y2,Y3,Y4,Y5,Y6 S S6=""
 Q
WR S PG=1 D HD W $S(AC=1:"Processed",AC=2:"Discontinued",AC=3:"Expired",1:"Pending")_" Orders:",! Q
N4 S AC="" F  S AC=$O(^TMP("PSDDSOR",$J,AC)) Q:'AC  D WR D  Q:$D(DIRUT)  D HD1 Q:$D(DIRUT)
 .S S1="" F  S S1=$O(^TMP("PSDDSOR",$J,AC,S1)) Q:S1=""  S S2="" F  S S2=$O(^TMP("PSDDSOR",$J,AC,S1,S2)) Q:S2=""  D  Q:$D(DIRUT)
 ..S S3="" F  S S3=$O(^TMP("PSDDSOR",$J,AC,S1,S2,S3)) Q:S3=""  S S4="" F  S S4=$O(^TMP("PSDDSOR",$J,AC,S1,S2,S3,S4)) Q:S4=""  D  Q:$D(DIRUT)
 ...S S5="" F  S S5=$O(^TMP("PSDDSOR",$J,AC,S1,S2,S3,S4,S5)) Q:S5=""  D STR4 Q:$D(DIRUT)
 Q
STR4 ;
 D IN F  S S6=$O(^TMP("PSDDSOR",$J,AC,S1,S2,S3,S4,S5,S6)) Q:S6=""  S Z="Y"_S6,@Z=^TMP("PSDDSOR",$J,AC,S1,S2,S3,S4,S5,S6)
 D PRT Q
N3 S AC="" F  S AC=$O(^TMP("PSDDSOR",$J,AC)) Q:'AC  D WR D  Q:$D(DIRUT)  D HD1 Q:$D(DIRUT)
 .S S1="" F  S S1=$O(^TMP("PSDDSOR",$J,AC,S1)) Q:S1=""  S S2="" F  S S2=$O(^TMP("PSDDSOR",$J,AC,S1,S2)) Q:S2=""  D  Q:$D(DIRUT)
 ..S S3="" F  S S3=$O(^TMP("PSDDSOR",$J,AC,S1,S2,S3)) Q:S3=""  D  Q:$D(DIRUT)
 ...S S5="" F  S S5=$O(^TMP("PSDDSOR",$J,AC,S1,S2,S3,S5)) Q:S5=""  D STR3 Q:$D(DIRUT)
 Q
STR3 D IN F  S S6=$O(^TMP("PSDDSOR",$J,AC,S1,S2,S3,S5,S6)) Q:S6=""  S Z="Y"_S6 M @Z=^TMP("PSDDSOR",$J,AC,S1,S2,S3,S5,S6)
 D PRT Q
N2 S AC="" F  S AC=$O(^TMP("PSDDSOR",$J,AC)) Q:'AC  D WR D  Q:$D(DIRUT)  D HD1 Q:$D(DIRUT)
 .S S1="" F  S S1=$O(^TMP("PSDDSOR",$J,AC,S1)) Q:S1=""  S S2="" F  S S2=$O(^TMP("PSDDSOR",$J,AC,S1,S2)) Q:S2=""  D  Q:$D(DIRUT)
 ..S S5="" F  S S5=$O(^TMP("PSDDSOR",$J,AC,S1,S2,S5)) Q:S5=""  D STR2 Q:$D(DIRUT)
 Q
STR2 D IN F  S S6=$O(^TMP("PSDDSOR",$J,AC,S1,S2,S5,S6)) Q:S6=""  S Z="Y"_S6 M @Z=^TMP("PSDDSOR",$J,AC,S1,S2,S5,S6)
 D PRT Q
N1 S AC="" F  S AC=$O(^TMP("PSDDSOR",$J,AC)) Q:'AC  D WR D  Q:$D(DIRUT)  D HD1 Q:$D(DIRUT)
 .S S1="" F  S S1=$O(^TMP("PSDDSOR",$J,AC,S1)) Q:S1=""  D  Q:$D(DIRUT)
 ..S S5="" F  S S5=$O(^TMP("PSDDSOR",$J,AC,S1,S5)) Q:S5=""  D STR1 Q:$D(DIRUT)
 Q
STR1 D IN F  S S6=$O(^TMP("PSDDSOR",$J,AC,S1,S5,S6)) Q:S6=""  S Z="Y"_S6 M @Z=^TMP("PSDDSOR",$J,AC,S1,S5,S6)
 D PRT
 Q
PRT D:($Y+4)>IOSL HD Q:$D(DIRUT)  D PRT^PSDDSOR1
 Q
HD D HD1 Q:$D(DIRUT)
 W @IOF,!,"OP "_$S(PSDRXSRC'="W"&(PSDRXSRC'="A"):"Digitally Signed ",1:"")_"CS Orders Report for Division "_DVN,?71,"Page: ",$J(PG,3) ;PSD-89
 W !,"Date Range: "_$$FMTE^XLFDT(PSDBD,"2Y")_" - "_$$FMTE^XLFDT(PSDED,"2Y")
 W ?33,"Source: ",$S(PSDRXSRC="C":"CPRS",PSDRXSRC="E":"eRx",PSDRXSRC="B":"CPRS+eRx",PSDRXSRC="W":"WRITTEN",1:"ALL")
 W ?54,"Printed on: "_TDT,!
 S PG=PG+1
 Q
HD1 I PG>1,$E(IOST)="C" K DIR S DIR(0)="E",DIR("A")=" Press Return to Continue or ^ to Exit" D ^DIR K DIR
 Q
END W ! D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K ^TMP("PSDDSOR",$J),PSDDV,PSDSD,PSDED,PSDDF,PSDXF,DRG,PRO,PAT,PND,SCH,SRT,PSDRG,PSDPR,PSDPT,PSDSC,VA,Y0,Y1,Y2,Y3,Y4,Y5,Y6,I,J,K,PSDCSRX
KV K DIR,DIRUT,DTOUT,DUOUT
 Q
 ;
INST ;
 N PSIR
 S PSIR=0 F  S PSIR=$O(^PS(59,PSOSITE,"INI1",PSIR)) Q:'PSIR  I $P($G(^PS(59,PSOSITE,"INI1",PSIR,0)),"^") S PSINST($P($G(^(0)),"^"))=""
 Q
