PSSPNSRP ;BIR/RTR-Instructions review report ;03/24/00
 ;;1.0;PHARMACY DATA MANAGEMENT;**38**;9/30/97
EN ;
 K PSSHOW,PSSBEG,PSSEND,PSSSRT,PSSIONLY
 K DIR S DIR(0)="S^A:ALL;S:SELECT A RANGE",DIR("B")="S",DIR("A")="Print Report for (A)ll or (S)elect a Range" D  D ^DIR K DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) W !!,"Nothing queued to print.",! G ENDX
 .S DIR("?")=" ",DIR("?",1)="Enter 'A' to run report for all Orderable Items. Enter 'S' to select a range",DIR("?",2)="(alphabetically) of Orderable Items to print."
 S PSSHOW=Y I PSSHOW="A" S PSSBEG="A",PSSEND="Z" S PSSSRT="A" G DEV
 ;W !!,"To see drugs beginning with the letter 'A', enter 'A', or whichever letter you",!,"wish to see. To see drugs in a range, for example drugs starting with the",!,"letters 'G', 'H', 'I' and 'J', enter in the format 'G-J'.",!
ASK ;
 K DIR,PSSBEG,PSSEND,PSSNUMBX
 S PSSNUMB=""
 F  S PSSNUMB=$O(^PS(50.7,"B",PSSNUMB)) Q:'PSSNUMB!($G(PSSNUMBX))  S PSSNUMBX=1
 I $G(PSSNUMBX) K DIR S DIR(0)="Y",DIR("A")="Print report for Orderable Items with leading numerics",DIR("B")="N" D  D ^DIR K DIR I Y["^"!($D(DUOUT))!($D(DTOUT)) W !!,"Nothing queued to print.",! G ENDX
 .W !!!,"There are entries in the Orderable Item file with leading numerics.",!
 .S DIR("?")=" ",DIR("?",1)="There are some entries in the Orderable Item file with leading numerics.",DIR("?",2)="Enter Yes to print the report for those drugs.",DIR("?",3)=" "
 I $G(PSSNUMBX),$G(Y)=1 S PSSSRT="N" G DEV
 K PSSNUMB,PSSNUMBX
ASKA K PSSBEG,PSSEND
 W !!,"To see items beginning with the letter 'A', enter 'A', or whichever letter you",!,"wish to see. To see items in a range, for example items starting with the",!,"letters 'G', 'H', 'I' and 'J', enter in the format 'G-J'.",!
 S DIR("?",1)=" ",DIR("?",2)="Enter either 1 letter, 'A', 'B', etc., to see items beginning with that letter,",DIR("?",3)="or to see a range of items enter in the format 'A-C', 'G-M', 'S-Z', etc.",DIR("?",4)=" ",DIR("?")=" "
 S DIR("A")="Select a Range",DIR(0)="F^1:3" D ^DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) W !!,"Nothing queued to print.",! G ENDX
 S X=Y I X'?1U&(X'?1U1"-"1U)&(X'?1L)&(X'?1L1"-"1L) W !!,"Invalid response, enter a letter, 'A', 'B', etc., or a range, 'C-F', 'M-R', etc.",! G ASKA
 I X["-" S PSSBEG=$P(X,"-"),PSSEND=$P(X,"-",2) I $A(PSSEND)<$A(PSSBEG) W !!,"Invalid response.",! G ASKA
 I X'["-" S PSSBEG=X,PSSEND=X
 S PSSSRT="X"
DEV I PSSSRT="X" W !!,"Report will be for items starting with the letter "_$G(PSSBEG)_",",!,"and ending with items starting with the letter "_$G(PSSEND)_".",!
 I PSSSRT="N" W !!,"This report will be for items with leading numerics.",!
 I PSSSRT="A" W !!,"This report will be for all items.",!
 K DIR S DIR(0)="Y",DIR("A")="Is this correct",DIR("B")="Y" D ^DIR K DIR I Y'=1 W ! G EN
 W ! K DIR S DIR(0)="Y",DIR("A")="Should report only include Orderable Items with Patient Instructions",DIR("B")="Y" S DIR("?")=" " D
 .S DIR("?",1)="Enter 'Yes' to print only those Orderble Items that already have Patient",DIR("?",2)="Instructions. Enter 'NO' to see all Orderable Items."
 D ^DIR K DIR I Y'=0,Y'=1 W !!,"Nothing queued to print.",! G ENDX
 S PSSIONLY=$S($G(Y):1,1:0)
 ;W $C(7),!!?3,"This report is designed for 132 column format!",!
 W ! K IOP,%ZIS,POP S %ZIS="QM" D ^%ZIS I $G(POP) W !!,"Nothing queued to print.",! G ENDX
 I $D(IO("Q")) S ZTRTN="START^PSSPNSRP",ZTDESC="Instructions Review Report",ZTSAVE("PSSHOW")="",ZTSAVE("PSSBEG")="",ZTSAVE("PSSEND")="",ZTSAVE("PSSSRT")="",ZTSAVE("PSSIONLY")="" D ^%ZTLOAD K %ZIS W !,"Report queued to print.",! G ENDX
START ;
 U IO
 I '$G(DT) S DT=$$DT^XLFDT
 S X1=DT,X2=-365 D C^%DTC S PSSYEAR=$G(X) K X,X1,X2
 S PSSOUT=0,PSSDV=$S($E(IOST)="C":"C",1:"P"),PSSCT=1
 K PSSLINE,PSSIEND S $P(PSSLINE,"-",78)=""
 D HD
 G:PSSSRT="N" PASS
 S PSSX=$A(PSSBEG)-1
 S PSSNAME=$C(PSSX)_"zzzz"
PASS ;
 I $G(PSSSRT)="N" S (PSSNAME,PSSEND)=""
 I $G(PSSSRT)="A" S (PSSNAME,PSSEND)=""
 F  S PSSNAME=$O(^PS(50.7,"ADF",PSSNAME)) Q:$S(PSSSRT="N"&('PSSNAME):1,PSSSRT="X"&(PSSNAME](PSSEND_"zzzz")):1,1:0)!(PSSNAME=""&(PSSSRT="X"))!(PSSSRT="A"&(PSSNAME=""))!($G(PSSOUT))  D
 .F PSSIEND=0:0 S PSSIEND=$O(^PS(50.7,"ADF",PSSNAME,PSSIEND)) Q:'PSSIEND!($G(PSSOUT))  F PSSIEN=0:0 S PSSIEN=$O(^PS(50.7,"ADF",PSSNAME,PSSIEND,PSSIEN)) Q:'PSSIEN!($G(PSSOUT))  D
 ..Q:'$D(^PS(50.7,PSSIEN,0))
 ..Q:$P($G(^PS(50.7,PSSIEN,0)),"^",3)
 ..I ($Y+5)>IOSL D HD Q:$G(PSSOUT)
 ..K PSSINA,PSSNF,PSSINAD,PSSUNIT,PSSAPU S PSSINA=$P($G(^PS(50.7,PSSIEN,0)),"^",4)
 ..I $G(PSSINA),$G(PSSYEAR),$G(PSSINA)<$G(PSSYEAR) Q
 ..I $P($G(^PS(50.7,PSSIEN,"INS")),"^")="",$G(PSSIONLY) Q
 ..I $G(PSSINA) S PSSINAD=$E(PSSINA,4,5)_"/"_$E(PSSINA,6,7)_"/"_$E(PSSINA,2,3)
 ..S PSSLEN=$P($G(^PS(50.7,PSSIEN,0)),"^")_"  "_$P($G(^PS(50.606,+$P($G(^PS(50.7,PSSIEN,0)),"^",2),0)),"^")
 ..W !!,$G(PSSLEN)
 ..I ($Y+5)>IOSL D HD Q:$G(PSSOUT)
 ..I $G(PSSINA) D
 ...I $L(PSSLEN)>62 W !,?64,$G(PSSINAD) Q
 ...W ?64,$G(PSSINAD)
 ..I ($Y+5)>IOSL D HD Q:$G(PSSOUT)
 ..Q:$P($G(^PS(50.7,PSSIEN,"INS")),"^")=""
 ..K PSSX D EN3^PSSUTLA2(PSSIEN,75)
 ..F PSSX=0:0 S PSSX=$O(PSSX("PI",PSSX)) Q:'PSSX!($G(PSSOUT))  D
 ...W !?2,$G(PSSX("PI",PSSX))
 ...I ($Y+5)>IOSL D HD
END ;
 I '$G(PSSOUT),$G(PSSDV)="C" W !!,"End of Report." K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $G(PSSDV)="C" W !
 E  W @IOF
ENDX K PSSNODE,PSSLEN,PSSIEND,PSSNUMB,PSSNUMBX,PSSSRT,PSSCALC,PSSSTR,PSSUNIT,PSSIEN,PSSINAD,PSSINA,PSSNF,PSSNAME,PSSDV,PSSX,PSSOUT,PSSHOW,PSSBEG,PSSLINE,PSSEND,PSSA,PSSB,PSSC,PSSD,PSSE,PSSAPU,PSSMSG,PSSYEAR D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K PSSIONLY Q
HD ;
 I $G(PSSDV)="C",$G(PSSCT)'=1 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSSOUT=1 Q
 W @IOF W !,$S(PSSSRT="N":"Instructions report for items with leading numerics",PSSSRT="A":"Instructions report for all items",1:"Instructions report for items from "_PSSBEG_" through "_PSSEND),?64,"PAGE: "_$G(PSSCT) S PSSCT=PSSCT+1
 W !,PSSLINE
 Q
SETD ;
 N PSSVA,PSSVA1,PSSVB,PSSVB1,PSSDASH,PSSNDFS,PSSDASH2,PSSDASH3,PSSDASH4,PSSDASH5 K PSSCALC
 S PSSDASH=0 S PSSNDFS=$$PSJST^PSNAPIS(+$P($G(^PSDRUG(PSSIEN,"ND")),"^"),+$P($G(^PSDRUG(PSSIEN,"ND")),"^",3)) S PSSNDFS=+$P($G(PSSNDFS),"^",2) I $G(PSSNDFS),$G(PSSSTR),+$G(PSSSTR)'=+$G(PSSNDFS) S PSSDASH=1
 S PSSVA=$P(PSSUNIT,"/"),PSSVB=$P(PSSUNIT,"/",2),PSSVA1=+$G(PSSVA),PSSVB1=+$G(PSSVB)
 I $G(PSSDASH) S PSSDASH2=PSSSTR/PSSNDFS,PSSDASH3=PSSDASH2*PSSC S PSSDASH4=PSSDASH3*$S($G(PSSVB1):PSSVB1,1:1) S PSSDASH5=$S('$G(PSSVB1):PSSDASH4_$G(PSSVB),1:PSSDASH4_$P(PSSVB,PSSVB1,2))
 S PSSCALC=$S('$G(PSSVA1):PSSD,1:($G(PSSVA1)*PSSD))_$S($G(PSSVA1):$P(PSSVA,PSSVA1,2),1:PSSVA)_"/"_$S($G(PSSDASH):$G(PSSDASH5),'$G(PSSVB1):+$G(PSSC)_$G(PSSVB),1:(+$G(PSSC)*+PSSVB1)_$P(PSSVB,PSSVB1,2))
 Q
OUT ;
 K PSSDFOI,PSSDFOIN,PSSDF,PSSDZZ
 Q:$G(PSSE)'["O"
 S PSSDFOI=$P($G(^PSDRUG(PSSIEN,2)),"^") Q:'PSSDFOI
 S PSSDF=$P($G(^PS(50.7,+PSSDFOI,0)),"^",2)
 S PSSDFOIN=$P($G(^PS(50.606,+$G(PSSDF),0)),"^")
 Q:'PSSDF
 K PSSDZ F PSSDZZ=0:0 S PSSDZZ=$O(^PS(50.606,PSSDF,"NOUN",PSSDZZ)) Q:'PSSDZZ!($G(PSSDZ)'="")  I $P($G(^(PSSDZZ,0)),"^")'="" S PSSDZ=$P($G(^(0)),"^")
 I $G(PSSDZ)="" S PSSDZ=$G(PSSDFOIN)
 I $G(PSSC) D PARN
 W ?94,$G(PSSC)_" "_$S($G(PSSDZN)'="":$G(PSSDZN),1:$G(PSSDZ))
 K PSSDFOI,PSSDF,PSSDZ,PSSDZZ,PSSDZN,PSSDZNX,PSSDFOIN
 Q
PARN ;
 K PSSDZN,PSSDZNX
 Q:$G(PSSDZ)=""
 Q:$L(PSSDZ)'>3
 S PSSDZNX=$E(PSSDZ,($L(PSSDZ)-2),$L(PSSDZ))
 I $G(PSSDZNX)="(S)"!($G(PSSDZNX)="(s)") D
 .I $G(PSSC)'>1 S PSSDZN=$E(PSSDZ,1,($L(PSSDZ)-3))
 .I $G(PSSC)>1 S PSSDZN=$E(PSSDZ,1,($L(PSSDZ)-3))_$E(PSSDZNX,2)
 Q
