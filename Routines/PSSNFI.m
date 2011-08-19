PSSNFI ;BIR/WRT-Print report of drugs with no match to NDF (all or only OP) ;12/02/99
 ;;1.0;PHARMACY DATA MANAGEMENT;**29,38**;9/30/97
 ;
 ;
 W !!,"This report shows the dispense drugs and orderable items",!,"with the formulary information associated with them."
EN ;
 K PSSHOW,PSSBEG,PSSEND,PSSNUMBX,PSSSRT
 K DIR S DIR(0)="S^A:ALL;S:SELECT A RANGE",DIR("B")="S",DIR("A")="Print Report for (A)ll or (S)elect a Range" D  D ^DIR K DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) W !!,"Nothing queued to print.",! G DONE
 .S DIR("?")=" ",DIR("?",1)="Enter 'A' to run report for all dispense drugs. Enter 'S' to select a range",DIR("?",2)="(alphabetically) of dispense drugs to print."
 S PSSHOW=Y I PSSHOW="A" S PSSBEG="A",PSSEND="Z" S PSSSRT="A" G TASK
 ;
 S PSSNUMB="" F  S PSSNUMB=$O(^PSDRUG("B",PSSNUMB)) Q:'PSSNUMB!($G(PSSNUMBX))  S PSSNUMBX=1
 I $G(PSSNUMBX) K DIR S DIR(0)="Y",DIR("A")="Print report for drugs with leading numerics",DIR("B")="N" D  D ^DIR K DIR I Y["^"!($D(DUOUT))!($D(DTOUT)) W !!,"Nothing queued to print.",! G DONE
 .W !!!,"There are drugs in the Drug file with leading numerics.",!
 .S DIR("?")=" ",DIR("?",1)="There are some entries in the drug file with leading numerics.",DIR("?",2)="Enter Yes to print the report for those drugs.",DIR("?",3)=" "
 I $G(PSSNUMBX),$G(Y)=1 S PSSSRT="N" G TASK
 K PSSNUMB,PSSNUMBX
ASKA K PSSBEG,PSSEND
 W !!,"To see drugs beginning with the letter 'A', enter 'A', or whichever letter you",!,"wish to see. To see drugs in a range, for example drugs starting with the",!,"letters 'G', 'H', 'I' and 'J', enter in the format 'G-J'.",!
 S DIR("?",1)=" ",DIR("?",2)="Enter either 1 letter, 'A', 'B', etc., to see drugs beginning with that letter,",DIR("?",3)="or to see a range of drugs enter in the format 'A-C', 'G-M', 'S-Z', etc.",DIR("?",4)=" ",DIR("?")=" "
 S DIR("A")="Select a Range",DIR(0)="F^1:3" D ^DIR K DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) W !!,"Nothing queued to print.",! G DONE
 S X=Y I X'?1U&(X'?1U1"-"1U)&(X'?1L)&(X'?1L1"-"1L) W !!,"Invalid response, enter a letter, 'A', 'B', etc., or a range, 'C-F', 'M-R', etc.",! G ASKA
 I X["-" S PSSBEG=$P(X,"-"),PSSEND=$P(X,"-",2) I $A(PSSEND)<$A(PSSBEG) W !!,"Invalid response.",! G ASKA
 I X'["-" S PSSBEG=X,PSSEND=X
 S PSSSRT="X"
TASK W !!,"You have the choice to print the drug text information.",!,"If you answer ""yes"" to the question, you will print all the drug text",!,"information for both dispense drug and orderable items."
 W !,"If you answer ""no"", you will print only formulary designations."
 W $C(7),!!,"This report requires 132 columns.",!
 W !,"You may queue the report to print, if you wish.",!
ASK S PSSTX=0,PSSFLAG=0 K DIR S DIR("A")="Include drug text information ",DIR(0)="Y",DIR("B")="NO",DIR("?")="Enter 'Yes' to display the drug text information associated with the Pharmacy Orderable Item and Dispense Drug"
 D ^DIR K DIR D OUT I PSSFLAG=1 K PSSTX,PSSFLAG,X Q
 I "Yy"[X S PSSTX=1
 ;
DEV I PSSSRT="X" W !!,"Report will be for drugs starting with the letter "_$G(PSSBEG)_",",!,"and ending with drugs starting with the letter "_$G(PSSEND)_".",!
 I PSSSRT="N" W !!,"This report will be for drugs with leading numerics.",!
 I PSSSRT="A" W !!,"This report will be for all drugs.",!
 K DIR S DIR(0)="Y",DIR("A")="Is this correct",DIR("B")="Y" D ^DIR K DIR I Y'=1 W ! G EN
 ;
DVC K %ZIS,POP,IOP S %ZIS="QM" D ^%ZIS I $G(POP) W !!,"Nothing queued to print.",! G DONE
QUEUE I $D(IO("Q")) S ZTRTN="START^PSSNFI",ZTDESC="Formulary Information Report",ZTSAVE("PSSTX")="",ZTSAVE("PSSHOW")="",ZTSAVE("PSSBEG")="",ZTSAVE("PSSEND")="",ZTSAVE("PSSSRT")="" D ^%ZTLOAD K %ZSI W !,"Report queeud to print.",! G DONE
START ;
 U IO
 S PSSOUT=0,PSSDV=$S($E(IOST)="C":"C",1:"P")
 S PSSPGCT=0,PSSPGLNG=IOSL-5,PSSPRT=0,PSSPGCT=1
 D TITLE
 S:PSSSRT'="N" PSSX=$A(PSSBEG)-1,PSSLCL=$C(PSSX)_"zzzz"
 I $G(PSSSRT)="N"!($G(PSSSRT)="A") S (PSSLCL,PSSEND)=""
 ;
LOOP F  S PSSLCL=$O(^PSDRUG("B",PSSLCL)) Q:$S(PSSSRT="N"&('PSSLCL):1,PSSSRT="X"&(PSSLCL](PSSEND_"zzzz")):1,1:0)!(PSSLCL="")!($G(PSSOUT))  D
 .F PSSB=0:0 S PSSB=$O(^PSDRUG("B",PSSLCL,PSSB)) Q:'PSSB  D RSET,DATE
 G END
DATE I '$G(^PSDRUG(PSSB,"I"))!(+$G(^("I"))>DT) D NOTHG,POI,DTEXT,ITEXT
 Q
RSET S LOC="",VISN="",NAT="",OIFS="",DRTX="",DEA="",TXT="",APU="",OINM=""
 Q
DTEXT I $D(^PSDRUG(PSSB,9,0)) S PSF=1 F TD=0:0 S TD=$O(^PSDRUG(PSSB,9,TD)) Q:'TD  S POINT=$P(^PSDRUG(PSSB,9,TD,0),"^"),PSSDAY=$P($G(^PS(51.7,POINT,0)),"^",2) I 'PSSDAY!(PSSDAY'<DT),PSSTX=1 D
 .I PSF=1 D PDTEXT1 S PSF=0
 .D:$Y>PSSPGLNG TITLE Q:$G(PSSOUT)
 .D PDTEXT
 Q
DTX I $D(^PSDRUG(PSSB,9,0)),$O(^PSDRUG(PSSB,9,0)) S TXT="I"
 Q
PDTEXT1 W !,"Dispense Drug text:"
 I ($Y+5)>IOSL D TITLE Q:$G(PSSOUT)
 Q
PDTEXT S TXNFO=$P(^PS(51.7,POINT,2,1,0),"^") S:$L(TXNFO)>70 TXNFO=$E(TXNFO,1,70)_"..." W !?5,TXNFO
 I ($Y+5)>IOSL D TITLE Q:$G(PSSOUT)
 Q
NOTHG S ZERO=^PSDRUG(PSSB,0),LOC=$P(ZERO,"^",9),VISN=$P(ZERO,"^",11),DEA=$P(ZERO,"^",3) S:LOC=1 LOC="N" S:VISN=1 VISN="N" S:DEA["R" DEA="R" S:DEA'="R" DEA="" S APU=$P($G(^PSDRUG(PSSB,2)),"^",3) D MCLS,DTX,POITXT,REPRT
 Q
POI S PT1=$P($G(^PSDRUG(PSSB,2)),"^") I PT1 S DFPTR=$P(^PS(50.7,PT1,0),"^",2),DF=$P($G(^PS(50.606,DFPTR,0)),"^"),OINM=$P(^PS(50.7,PT1,0),"^")_" "_DF,OIFS=$P(^PS(50.7,PT1,0),"^",12) S:OIFS=1 OIFS="(N/F)" D OI
 Q
POITXT S OITM=$P($G(^PSDRUG(PSSB,2)),"^") I OITM I $O(^PS(50.7,OITM,1,0)) S TXT="I"
 Q
OI W !?3,"Orderable Item: "_OINM_"   "_OIFS
 I ($Y+5)>IOSL D TITLE Q:$G(PSSOUT)
 Q
POOI W !,"Orderable Item text:"
 I ($Y+5)>IOSL D TITLE Q:$G(PSSOUT)
 Q
PPOITXT S INFO=$P(^PS(51.7,POINTR,2,1,0),"^") S:$L(INFO)>70 INFO=$E(INFO,1,70)_"..." W !?5,INFO
 I ($Y+5)>IOSL D TITLE Q:$G(PSSOUT)
 Q
MCLS I $D(^PSDRUG(PSSB,"ND")) S PSSMC=^PSDRUG(PSSB,"ND") I $P(PSSMC,"^",2)']"" S NAT=$P(PSSMC,"^",11) S:NAT'=1 NAT="N"
 Q
REPRT D:$Y>PSSPGLNG TITLE Q:$G(PSSOUT)  W !!,PSSLCL,?43,LOC,?51,VISN,?58,NAT,?69,DEA,?83,APU,?93,TXT
 S PSSPRT=1
 Q
OUT I $D(DTOUT),DTOUT=1 S PSSFLAG=1
 I X="^" S PSSFLAG=1
 Q
ITEXT I PT1,$D(^PS(50.7,PT1,1,0)) S PSF=1 F TDD=0:0 S TDD=$O(^PS(50.7,PT1,1,TDD)) Q:'TDD  S POINTR=$P(^PS(50.7,PT1,1,TDD,0),"^"),TXT="I",PSSDAY1=$P($G(^PS(51.7,POINTR,0)),"^",2) I 'PSSDAY1!(PSSDAY1'<DT),PSSTX=1 D
 .I PSF=1 D POOI S PSF=0
 .D:$Y>PSSPGLNG TITLE Q:$G(PSSOUT)
 .D PPOITXT
 Q
TITLE ;
 I $G(PSSDV)="C",$G(PSSPGCT)'=1 W ! K DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSSOUT=1 Q
 ;
 W @IOF W !,?40,$S(PSSSRT="N":"Formulary Information Report for Drugs with Leading Numerics",PSSSRT="A":"Formulary Information Report for All Drugs",1:"Formulary Information Report for Drugs from "_PSSBEG_" through "_PSSEND),!
 S Y=DT X ^DD("DD") W !,"Date printed: ",Y,?116,"Page: ",PSSPGCT,!
 W !,"Generic Name",?43,"Local",?51,"Visn",?58,"National",?69,"Restriction",?83,"Appl",?93,"Drug",!
 W ?83,"Pkg",?93,"Text",!,?83,"Use",!
 F MJT=1:1:132 W "-"
 S PSSPGCT=PSSPGCT+1
 Q
END ;
 I '$G(PSSOUT),$G(PSSDV)="C" W !!,"End of Report." K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $G(PSSDV)="C" W !
 E  W @IOF
DONE ;
 K PSSB,APU,DF,DFPTR,DRTX,INFO,LOC,NAT,OIFS,OINM,PT1,TD,TDD,TXNFO,TXT,VISN,ZERO,PSSDAT,PSSDAY,PSSDAY1,PSSFLAG,PSSLCL,PSSMC,PSSTX,PSSUSE,PSSVCL,PSSPRT,PSF,MJT,PSSPGCT,PSSPGLNG,Y,DEA,POINTR,DIR,INDT,X,OITM,IOP,POP,IO("Q")
 K PSSSRT,PSSSTR,PSSDV,PSSX,PSSOUT,PSSHOW,PSSBEG,PSSEND D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
