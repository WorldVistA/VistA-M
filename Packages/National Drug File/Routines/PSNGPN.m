PSNGPN ;BIR/SJA-Local Drug/VA Print Name Report ; 01/11/01 10:00
 ;;4.0; NATIONAL DRUG FILE;**48**; 30 Oct 98
 ;
 ; Reference to ^PSDRUG supported by IA# 221
 ;
 W !!," This report shows a list of the active drugs in local DRUG file where the",!," GENERIC NAME does not match the VA PRINT NAME."
EN K PSNHOW,PSNBEG,PSNEND,PSNUMBX,PSNSRT
 K DIR S DIR(0)="S^A:ALL;S:SELECT A RANGE",DIR("B")="S",DIR("A")="Print Report for (A)ll Drugs or (S)elect a Range of Drugs" D  D ^DIR K DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) W !!,"Nothing queued to print.",! G DONE
 .S DIR("?")=" ",DIR("?",1)="Enter 'A' to run report for all local drugs. Enter 'S' to select a range",DIR("?",2)="(alphabetically) of local drugs to print."
 S PSNHOW=Y I PSNHOW="A" S PSNBEG="A",PSNEND="Z" S PSNSRT="A" G DEV
 ;
 S PSNUMB="" F  S PSNUMB=$O(^PSDRUG("B",PSNUMB)) Q:'PSNUMB!($G(PSNUMBX))  S PSNUMBX=1
 I $G(PSNUMBX) K DIR S DIR(0)="Y",DIR("A")="Print report for drugs with leading numerics",DIR("B")="N" D  D ^DIR K DIR I Y["^"!($D(DUOUT))!($D(DTOUT)) W !!,"Nothing queued to print.",! G DONE
 .W !!!,"There are drugs in the Drug file with leading numerics.",!
 .S DIR("?")=" ",DIR("?",1)="There are some entries in the drug file with leading numerics.",DIR("?",2)="Enter Yes to print the report for those drugs.",DIR("?",3)=" "
 I $G(PSNUMBX),$G(Y)=1 S PSNSRT="N" G DEV
 K PSNUMB,PSNUMBX
ASKA K PSNBEG,PSNEND
 W !!,"To see drugs beginning with the letter 'A', enter 'A', or whichever letter you",!,"wish to see. To see drugs in a range, for example drugs starting with the",!,"letters 'G', 'H', 'I' and 'J', enter in the format 'G-J'.",!
 S DIR("?",1)=" ",DIR("?",2)="Enter either 1 letter, 'A', 'B', etc., to see drugs beginning with that letter,",DIR("?",3)="or to see a range of drugs enter in the format 'A-C', 'G-M', 'S-Z', etc.",DIR("?",4)=" ",DIR("?")=" "
 S DIR("A")="Select a Range",DIR(0)="F^1:3" D ^DIR K DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) W !!,"Nothing queued to print.",! G DONE
 S X=Y I X'?1U&(X'?1U1"-"1U)&(X'?1L)&(X'?1L1"-"1L) W !!,"Invalid response , enter a letter, 'A', 'B', etc., or a range, 'C-F', 'M-R', etc.",! G ASKA
 I X["-" S PSNBEG=$P(X,"-"),PSNEND=$P(X,"-",2) I $A(PSNEND)<$A(PSNBEG) W !!,"Invalid response.",! G ASKA
 I X'["-" S PSNBEG=X,PSNEND=X
 S PSNSRT="X"
DEV I PSNSRT="X" W !!,"This report will include drugs starting with the letter "_$G(PSNBEG)_",",!,"and ending with drugs starting with the letter "_$G(PSNEND)_".",!
 I PSNSRT="N" W !!,"This report will be for drugs with leading numerics.",!
 I PSNSRT="A" W !!,"This report will be for all drugs.",!
 K DIR S DIR(0)="Y",DIR("A")="Is this correct",DIR("B")="Y" D ^DIR K DIR I Y'=1 W ! G EN
 ;
DVC K %ZIS,POP,IOP S %ZIS="QM" D ^%ZIS I $G(POP) W !!,"Nothing queued to print.",! G DONE
QUEUE I $D(IO("Q")) S ZTRTN="START^PSNGPN",ZTDESC="Local Drug/VA Print Name Report",ZTSAVE("PSNHOW")="",ZTSAVE("PSNBEG")="",ZTSAVE("PSNEND")="",ZTSAVE("PSNSRT")="" D ^%ZTLOAD K %ZSI W !,"Report queued to print.",! G DONE
START ;
 U IO
 S PSNOUT=0,PSNDV=$S($E(IOST)="C":"C",1:"P")
 S PSNPGCT=0,PSNPGLNG=IOSL-5,PSNPGCT=1 D TITLE
 S:PSNSRT'="N" PSNX=$A(PSNBEG)-1,PSNLCL=$C(PSNX)_"zzzz"
 I $G(PSNSRT)="N"!($G(PSNSRT)="A") S (PSNLCL,PSNEND)=""
 ;
LOOP F  S PSNLCL=$O(^PSDRUG("B",PSNLCL)) Q:$S(PSNSRT="N"&('PSNLCL):1,PSNSRT="X"&(PSNLCL](PSNEND_"zzzz")):1,1:0)!(PSNLCL="")!($G(PSNOUT))  D
 .F PSNB=0:0 S PSNB=$O(^PSDRUG("B",PSNLCL,PSNB)) Q:'PSNB  D CHECK
 G END
CHECK I '$G(^PSDRUG(PSNB,"I"))!(+$G(^("I"))>DT),$D(^PSDRUG(PSNB,"ND")) S PSNMC=$G(^PSDRUG(PSNB,"ND")) D
 .I $P(PSNMC,"^",2)]"" S PSND3=$P(PSNMC,"^",3) I PSND3 S PSNVA=$P($G(^PSNDF(50.68,PSND3,1)),"^") I $P(^PSDRUG(PSNB,0),"^")'=PSNVA D:$Y>PSNPGLNG TITLE Q:$G(PSNOUT)  W !!,$P(^PSDRUG(PSNB,0),"^"),?43,PSNVA
 Q
TITLE I $G(PSNDV)="C",$G(PSNPGCT)'=1 W ! K DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSNOUT=1 Q
 S PSNAM="Local Drug/VA Print Name Report"
 S PSNAM1=$S(PSNSRT="N":"for Drugs with Leading Numerics",PSNSRT="A":"for All Drugs",1:"for Drug Names Beginning with the letter "_PSNBEG_" through "_PSNEND)
 W @IOF W !,?25,PSNAM,!,?(80-$L(PSNAM1)\2),PSNAM1,!
 S Y=DT X ^DD("DD") W !,"Date printed: ",Y,?69,"Page: ",PSNPGCT,!
 W !,"Generic Name",?43,"VA Print Name",!
 F MJT=1:1:79 W "-"
 S PSNPGCT=PSNPGCT+1 Q
 ;
END I '$G(PSNOUT),$G(PSNDV)="C" W !!,"End of Report.",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $G(PSNDV)="C" W !
 E  W @IOF
 ;
DONE W @IOF S:$D(ZTQUEUED) ZTREQ="@" K PSNB,PSND3,PSNVA,PSNDV,PSNLCL,PSNOUT,PSNPGCT,PSNPGLNG,PSNPRT,PSNX,PSNAM1,PSNAM,PSNFLAG,PSNMC,PSNOP,PSNUSE,PSNVCL,MJT,Y,DEA,DIR,INDT,X,IOP,POP,IO("Q") D ^%ZISC
 Q
