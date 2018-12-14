PSOSUCAT ;EPIP/RTW -Print From Suspense By Category ;08/01/14  14:53
 ;;7.0;OUTPATIENT PHARMACY;**452**;DEC 1997;Build 56
 ;---------------------------------------------------------------------
 ; ICR#   TYPE    DESCRIPTION
 ;-----  -------  ------------------------------------
 ;10026  Support  ^DIK
 ;---------------------------------------------------------------------
START N DIR,X,Y,DTOUT,DUOUT,PSOSULST,PSORESP,PSOSTPF,PSOMOD,PSOTAG
 S CNT=0
 s DIR("B")="ALL"
 S DIR(0)="SBO^A:ALL;N:Non-Controlled Drugs;C:Controlled Substances;S:Supplies;R:Refrigerated Items;D:Drugs;V:VA Classifications;E:Exit"
 S DIR("A")="Select Print Category"
 S DIR("T")=DTIME
 S DIR("?",1)="Enter 'A' ALL Prescriptions on Suspense for the Division"
 S DIR("?",2)="      'N' Non-Controlled Rx or OTCs (Special Handling Code 6 or 9)"
 S DIR("?",3)="      'C' Controlled Substance Prescriptions (DEA 1, 2, 3, 4, 5)"
 S DIR("?",4)="      'S' Supply Prescriptions (Special Handling Code 'S')"
 S DIR("?",5)="      'R' Refrigerated Prescriptions (Special Handling Code 'Q')"
 S DIR("?",6)="      'D' Prescriptions by Selected Drugs"
 S DIR("?",7)="      'V' Prescriptions by Selected VA Classifications"
 S DIR("?",8)="   or 'E' or '^' to Exit"
 S DIR("?")=" "
 D ^DIR K DIR I $D(DIRUT)!(Y="E") D MESS^PSOSULB1 G EXIT^PSOSULBL
 I Y="A" G ASK^PSOSULB1
 I Y="N" S PSORESP="N^Non-Controlled Drugs^DEA"
 I Y="C" S PSORESP="C^Controlled Substances^DEA"
 I Y="D" S PSORESP="D^Specific Drugs^DRUG"
 I Y="V" S PSORESP="V^Specific VA Class^CLASS"
 I Y="S" S PSORESP="S^Supplies^SUPPLY"
 I Y="R" S PSORESP="R^Refrigerated Items^FRIDGE"
 S PSOSULST($P(PSORESP,U,3))=""
 D INVR I $D(PSOSTPF) D MESS^PSOSULB1 G EXIT^PSOSULBL
 D DISPENSE I $D(PSOSTPF) D MESS^PSOSULB1 G EXIT^PSOSULBL
 I "SR"'[$P(PSORESP,U) D @$P(PSORESP,U) I $D(PSOSTPF) D MESS^PSOSULB1 G EXIT^PSOSULBL
 S PSOTAG="" F  S PSOTAG=$O(PSOSULST(PSOTAG)) Q:PSOTAG']""  S PSOSULST(PSOTAG)=PSOMOD
 D CONT I $D(PSOSTPF) D MESS^PSOSULB1 G EXIT^PSOSULBL
 G ASK^PSOSULB1
INVR N DIR
 S DIR(0)="SBAO^Include:Include "_$P(PSORESP,U,2)_";Exclude:Exclude "_$P(PSORESP,U,2)
 S DIR("A")=$P(PSORESP,U,2)_": ",DIR("B")="Include"
 S DIR("T")=DTIME
 D ^DIR S:$D(DIRUT) PSOSTPF=1 Q:$D(PSOSTPF)
 S PSOMOD=""
 I Y["Exclude" S PSOMOD="1"
 Q
DISPENSE N DIR
 S DIR(0)="SBAO^M:Mail;W:Window;B:Both Mail and Window"
 S DIR("A")=$S($P(PSOMOD,U):"Exclude:",1:"Include:")_" Mail (M), Window (W), Both (B): ",DIR("B")="Both"
 S DIR("T")=DTIME
 D ^DIR S:$D(DIRUT) PSOSTPF=1 Q:$D(PSOSTPF)
 S PSOMOD=PSOMOD_"^"_$S((Y="B"):"",1:Y)
 Q
INCLD N DIR,PSOPMT
 S DIR(0)="YO",DIR("B")="YES"
 S DIR("T")=DTIME
 S PSOPMT=$S(1:$P(PSOMOD,U),1:"")
 I $P(PSORESP,U)="N",$G(PSOPMT) D 
 . S DIR("?")=" ",DIR("?",1)="Enter 'YES' to EXCLUDE refrigerated "_$P(PSORESP,U,2)_" from printing."
 . S DIR("?",2)="Enter 'NO' to print refrigerated "_$P(PSORESP,U,2)_" in addition to the"
 . S DIR("?",3)="other categories."
 I $P(PSORESP,U)="N",'$G(PSOPMT) D
 . S DIR("?")=" ",DIR("?",1)="Enter 'NO' to EXCLUDE refrigerated "_$P(PSORESP,U,2)_" from printing."
 . S DIR("?",2)="Enter 'YES' to print refrigerated "_$P(PSORESP,U,2)_"."
 I $P(PSORESP,U)="C",$G(PSOPMT) D
 . S DIR("?")=" "
 . S DIR("?",1)="Enter 'YES' to EXCLUDE refrigerated "_$P(PSORESP,U,2)_" of the selected range"
 . S DIR("?",2)="from printing."
 . S DIR("?",3)="Enter 'NO' to print refrigerated "_$P(PSORESP,U,2)_" of the selected range"
 . S DIR("?",4)="in addition to the other categories."
 I $P(PSORESP,U)="C",'$G(PSOPMT) D
 . S DIR("?")=" ",DIR("?",1)="Enter 'NO' to EXCLUDE refrigerated "_$P(PSORESP,U,2)_" of the selected range"
 . S DIR("?",2)="from printing."
 . S DIR("?",3)="Enter 'YES' to print refrigerated "_$P(PSORESP,U,2)_" of the selected range."
 S DIR("A")=$S($P(PSOMOD,U):"Exclude",1:"Include")_" Refrigerated Items" D ^DIR S:$D(DIRUT) PSOSTPF=1 Q:$D(PSOSTPF)  S:Y>0 PSOMOD=PSOMOD_"^" S:Y=0 PSOMOD=PSOMOD_"^Q"
 I $P(PSORESP,U)="N",$G(PSOPMT) D
 . S DIR("?")=" "
 . S DIR("?",1)="Enter 'YES' to EXCLUDE Non-Controlled supplies from printing."
 . S DIR("?",2)="Enter 'NO' to print Non-Controlled supplies in addition to the"
 . S DIR("?",3)="other categories."
 I $P(PSORESP,U)="N",'$G(PSOPMT) D
 . S DIR("?")=" "
 . S DIR("?",1)="Enter 'NO' to EXCLUDE Non-Controlled supplies from printing."
 . S DIR("?",2)="Enter 'YES' to print Non-Controlled supplies."
 I $P(PSORESP,U)="N" S DIR("A")=$S($P(PSOMOD,U):"Exclude",1:"Include")_" Supplies" D ^DIR S:$D(DIRUT) PSOSTPF=1 Q:$D(PSOSTPF)  S:Y>0 PSOMOD=PSOMOD_"^" S:Y=0 PSOMOD=PSOMOD_"^S"
 Q
CONT N DIR
 S DIR(0)="YO"
 S DIR("A")="Print Suspended '"_$P(PSORESP,U,2)_"' selections" ;rtw
 I $P(PSOMOD,U) S DIR("A")="Print everything Suspended EXCEPT '"_$P(PSORESP,U,2)_"' selections" ;rtw
 S DIR("B")="NO"
 S DIR("T")=DTIME
 W ! D ^DIR S:Y'>0 PSOSTPF=1
 Q
N N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="SBO^Rx:Rx;OTC:OTC;Both:Both Rx and OTC"
 S DIR("A")="Include the following"
 I $P(PSOMOD,U) S DIR("A")="Exclude the following"
 S DIR("?",1)="Enter 'Rx'   Prescriptions for Legend Drugs (Special Handling Code 6)"
 S DIR("?",2)="      'OTC'  Prescriptions for OTC Drugs (Special Handling Code 9)"
 S DIR("?",3)="      'Both' Prescriptions for BOTH Legend and OTC Drugs"
 S DIR("?")=" "
 S DIR("B")="Both"
 S DIR("T")=DTIME
 D ^DIR K DIR S:$D(DIRUT)!(Y="E") PSOSTPF=1 Q:$D(PSOSTPF)
 I Y="Rx" S PSOSULST($P(PSORESP,U,3),6)=""
 I Y="OTC" S PSOSULST($P(PSORESP,U,3),9)=""
 I Y="Both" S PSOSULST($P(PSORESP,U,3),6)="",PSOSULST($P(PSORESP,U,3),9)=""
 D INCLD Q:$D(PSOSTPF)
 Q
C N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="LAO^1:5:0"
 S DIR("A")="Enter a list or range of CS Federal Schedules to INCLUDE (1-5): "
 I $P(PSOMOD,U) S DIR("A")="Enter list or range of CS Federal Schedules to EXCLUDE (1-5): "
 S DIR("B")="1-5"
 S DIR("?")="This response must be a list or range, e.g. 2,4 or 3-5."
 S DIR("T")=DTIME
 D ^DIR K DIR S:$D(DIRUT) PSOSTPF=1 Q:$D(PSOSTPF)
 N XX F XX=1:1:($L(Y,",")-1) S PSOSULST($P(PSORESP,U,3),+$P(Y,",",XX))=""
 D INCLD Q:$D(PSOSTPF)
 Q
D N PSODRG,PSOSORT,PSOSRT,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 D DSLCT S:'$O(PSOSULST($P(PSORESP,U,3),"")) PSOSTPF=1 Q:$D(PSOSTPF)  D
 . W !!,"Drugs Selected:"
 . S PSODRG=0 F  S PSODRG=$O(PSOSULST($P(PSORESP,U,3),PSODRG)) Q:'PSODRG  D
 .. S PSOSORT($P(^PSDRUG(PSODRG,0),U))=""
 . S PSOSRT="" F  S PSOSRT=$O(PSOSORT(PSOSRT)) Q:PSOSRT=""  D
 .. W !,PSOSRT
 Q
DSLCT N DIC,X,Y,DTOUT,DUOUT
 S DIC=50,DIC(0)="AEQM"
DSLCT2 D ^DIC Q:Y'>0  S PSOSULST($P(PSORESP,U,3),+Y)=""
 S DIC("A")="Select Another DRUG GENERIC NAME: "
 G DSLCT2
 Q
V N PSOCLSS,PSOSORT,PSOSRT,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 D VSLCT S:'$O(PSOSULST($P(PSORESP,U,3),"")) PSOSTPF=1 Q:$D(PSOSTPF)  D
 . W !!,"VA Classification Selected:"
 . S PSOCLSS=0 F  S PSOCLSS=$O(PSOSULST($P(PSORESP,U,3),PSOCLSS)) Q:'PSOCLSS  D
 .. S PSOSORT($P(^PS(50.605,PSOCLSS,0),U))=""
 . S PSOSRT="" F  S PSOSRT=$O(PSOSORT(PSOSRT)) Q:PSOSRT=""  D
 .. W !,PSOSRT
 Q
VSLCT N DIC,X,Y,DTOUT,DUOUT
 S DIC=50.605,DIC(0)="AEQM"
VSLCT2 N PSOCLSIN,PSOVACLS,CHLDCLSS
 D ^DIC Q:Y'>0  S PSOCLSIN=+Y S PSOSULST($P(PSORESP,U,3),+Y)=""
 S PSOVACLS=$P(^PS(50.605,PSOCLSIN,0),U)
 D VDISP,VSPLIT
 W !
 S DIC("A")="Select Another VA DRUG CLASS CODE: "
 G VSLCT2
 Q
VDISP N OI,PSODRG
 N CNT S CNT=0
 S OI=0 F  S OI=$O(^PSDRUG("AOC",OI)) Q:'OI  S PSODRG=0 F  S PSODRG=$O(^PSDRUG("AOC",OI,PSOVACLS,PSODRG)) Q:'PSODRG  D
 . S CNT=CNT+1 I CNT=1 W !!,"Dispense Drugs for VA Class ",PSOVACLS," are:"
 . W !,$P(^PSDRUG(PSODRG,0),U)
 Q
VSPLIT I $D(^PS(50.605,"AC",PSOCLSIN)) D
 . S CHLDCLSS=0 F  S CHLDCLSS=$O(^PS(50.605,"AC",PSOCLSIN,CHLDCLSS)) D:$D(^PS(50.605,"AC",+CHLDCLSS)) VSPLIT2 Q:'+CHLDCLSS  D
 .. S PSOSULST($P(PSORESP,U,3),+CHLDCLSS)="",PSOVACLS=$P(^PS(50.605,CHLDCLSS,0),"^") D VDISP
 Q
VSPLIT2 N CHLDCLSS2
 S CHLDCLSS2=0 F  S CHLDCLSS2=$O(^PS(50.605,"AC",CHLDCLSS,CHLDCLSS2)) Q:'+CHLDCLSS2  S PSOSULST($P(PSORESP,U,3),+CHLDCLSS2)="",PSOVACLS=$P(^PS(50.605,CHLDCLSS2,0),"^") D VDISP
 Q
EN N PSODRUG,PSODEA,PSOIEN,PSOMW,PSOPP,PSONODE,PSOVACLS
 S PSOIEN=+$G(^PS(52.5,SFN,0)) Q:'PSOIEN  S PSODRUG=$P($G(^PSRX(PSOIEN,0)),U,6)
 S PSODEA=$P($G(^PSDRUG(PSODRUG,0)),U,3),PSOVACLS=$P($G(^PSDRUG(PSODRUG,0)),U,2),PSOOK=+PSOSULST($O(PSOSULST("")))
 S PSONODE=$G(^PS(52.5,SFN,0)) D
 . I $P(PSONODE,"^",5) S PSOMW=$P($G(^PSRX(+$G(PSONODE),"Q",$P(PSONODE,"^",5),0)),"^",2) Q
 . I $P(PSONODE,"^",13)!($O(^PSRX(+$G(PSONODE),1,0))) D  Q
 .. I $P(PSONODE,"^",13) S PSOMW=$P($G(^PSRX(+$G(PSONODE),1,$P(PSONODE,"^",13),0)),"^",2) Q
 .. F PSOPP=0:0 S PSOPP=$O(^PSRX(+$G(PSONODE),1,PSOPP)) Q:'PSOPP  S PSOMW=$P($G(^PSRX(+$G(PSONODE),1,PSOPP,0)),"^",2)
 . S PSOMW=$P($G(^PSRX(+$G(PSONODE),0)),"^",11)
 D @$O(PSOSULST(""))
 Q
DEA N XX
 S XX="" F  S XX=$O(PSOSULST("DEA",XX)) Q:'XX  I (PSODEA[XX)&(PSOMW[$P(PSOSULST("DEA"),U,2)) S PSOOK='PSOOK D
 . I (($P(PSOSULST("DEA"),U,3)="Q")&(PSODEA["Q"))!(($P(PSOSULST("DEA"),U,4)="S")&(PSODEA["S")) S PSOOK='PSOOK
 . I PSOOK'=+PSOSULST("DEA") Q
 Q
DRUG N PSODRG
 S PSODRG="" F  S PSODRG=$O(PSOSULST("DRUG",PSODRG)) Q:'PSODRG  D
 . I (PSODRUG=PSODRG)&(PSOMW[$P(PSOSULST("DRUG"),U,2)) S PSOOK='PSOOK Q
 Q
CLASS N PSOCLSS
 S PSOCLSS="" F  S PSOCLSS=$O(PSOSULST("CLASS",PSOCLSS)) Q:'PSOCLSS  D
 . I (PSOVACLS=$P(^PS(50.605,PSOCLSS,0),U))&(PSOMW[$P(PSOSULST("CLASS"),U,2)) S PSOOK='PSOOK Q
 Q
SUPPLY I (PSODEA["S")&(PSOMW[$P(PSOSULST("SUPPLY"),U,2)) S PSOOK='PSOOK
 Q
FRIDGE I (PSODEA["Q")&(PSOMW[$P(PSOSULST("FRIDGE"),U,2)) S PSOOK='PSOOK
 Q
