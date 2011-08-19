PSSDOSRP ;BIR/RTR-Dosage review report ;03/24/00
 ;;1.0;PHARMACY DATA MANAGEMENT;**34,38,49,129**;9/30/97;Build 67
 ;Reference to ^PS(50.607 supported by DBIA 2221
EN ;
 N ZTRTN,ZTDESC,ZTSAVE,DUOUT,DTOUT,POP,ZTSK
 K PSSHOW,PSSBEG,PSSEND,PSSSRT
 K DIR S DIR(0)="S^A:ALL;S:SELECT A RANGE",DIR("B")="S",DIR("A")="Print Report for (A)ll or (S)elect a Range" D  D ^DIR K DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) W !!,"Nothing queued to print.",! G ENDX
 .S DIR("?")=" ",DIR("?",1)="Enter 'A' to run report for all dispense drugs. Enter 'S' to select a range",DIR("?",2)="(alphabetically) of dispense drugs to print."
 .S DIR("?",3)="This report displays Possible Dosage and Local Possible Dosage information for",DIR("?",4)="the dispense drugs in the range selected."
 S PSSHOW=Y I PSSHOW="A" S PSSBEG="A",PSSEND="Z" S PSSSRT="A" G DEV
 ;W !!,"To see drugs beginning with the letter 'A', enter 'A', or whichever letter you",!,"wish to see. To see drugs in a range, for example drugs starting with the",!,"letters 'G', 'H', 'I' and 'J', enter in the format 'G-J'.",!
ASK ;
 K DIR,PSSBEG,PSSEND,PSSNUMBX
 S PSSNUMB=""
 F  S PSSNUMB=$O(^PSDRUG("B",PSSNUMB)) Q:'PSSNUMB!($G(PSSNUMBX))  S PSSNUMBX=1
 I $G(PSSNUMBX) K DIR S DIR(0)="Y",DIR("A")="Print report for drugs with leading numerics",DIR("B")="N" D  D ^DIR K DIR I Y["^"!($D(DUOUT))!($D(DTOUT)) W !!,"Nothing queued to print.",! G ENDX
 .W !!!,"There are drugs in the Drug file with leading numerics.",!
 .S DIR("?")=" ",DIR("?",1)="There are some entries in the drug file with leading numerics.",DIR("?",2)="Enter Yes to print the report for those drugs.",DIR("?",3)=" "
 I $G(PSSNUMBX),$G(Y)=1 S PSSSRT="N" G DEV
 K PSSNUMB,PSSNUMBX
ASKA K PSSBEG,PSSEND
 W !!,"To see drugs beginning with the letter 'A', enter 'A', or whichever letter you",!,"wish to see. To see drugs in a range, for example drugs starting with the",!,"letters 'G', 'H', 'I' and 'J', enter in the format 'G-J'.",!
 S DIR("?",1)=" ",DIR("?",2)="Enter either 1 letter, 'A', 'B', etc., to see drugs beginning with that letter,",DIR("?",3)="or to see a range of drugs enter in the format 'A-C', 'G-M', 'S-Z', etc.",DIR("?",4)=" ",DIR("?")=" "
 S DIR("A")="Select a Range",DIR(0)="F^1:3" D ^DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) W !!,"Nothing queued to print.",! G ENDX
 S X=Y I X'?1U&(X'?1U1"-"1U)&(X'?1L)&(X'?1L1"-"1L) W !!,"Invalid response, enter a letter, 'A', 'B', etc., or a range, 'C-F', 'M-R', etc.",! G ASKA
 I X["-" S PSSBEG=$P(X,"-"),PSSEND=$P(X,"-",2) I $A(PSSEND)<$A(PSSBEG) W !!,"Invalid response.",! G ASKA
 I X'["-" S PSSBEG=X,PSSEND=X
 S PSSSRT="X"
DEV I PSSSRT="X" W !!,"Report will be for drugs starting with the letter "_$G(PSSBEG)_",",!,"and ending with drugs starting with the letter "_$G(PSSEND)_".",!
 I PSSSRT="N" W !!,"This report will be for drugs with leading numerics.",!
 I PSSSRT="A" W !!,"This report will be for all drugs.",!
 K DIR S DIR(0)="Y",DIR("A")="Is this correct",DIR("B")="Y" D ^DIR K DIR I Y'=1 W ! G EN
 W $C(7),!!?3,"This report is designed for 132 column format!",!
 K IOP,%ZIS,POP S %ZIS="QM" D ^%ZIS I $G(POP) W !!,"Nothing queued to print.",! G ENDX
 I $D(IO("Q")) S ZTRTN="START^PSSDOSRP",ZTDESC="Dosage Review Report",ZTSAVE("PSSHOW")="",ZTSAVE("PSSBEG")="",ZTSAVE("PSSEND")="",ZTSAVE("PSSSRT")="" D ^%ZTLOAD K %ZIS W !,"Report queued to print.",! G ENDX
START ;
 U IO
 I '$G(DT) S DT=$$DT^XLFDT
 S X1=DT,X2=-365 D C^%DTC S PSSYEAR=$G(X) K X,X1,X2
 S PSSOUT=0,PSSDV=$S($E(IOST,1,2)'="C-":"P",1:"C"),PSSCT=1
 K PSSLINE S $P(PSSLINE,"-",130)=""
 D HD
 G:PSSSRT="N" PASS
 S PSSX=$A(PSSBEG)-1
 S PSSNAME=$C(PSSX)_"zzzz"
PASS ;
 I $G(PSSSRT)="N" S (PSSNAME,PSSEND)=""
 I $G(PSSSRT)="A" S (PSSNAME,PSSEND)=""
 F  S PSSNAME=$O(^PSDRUG("B",PSSNAME)) Q:$S(PSSSRT="N"&('PSSNAME):1,PSSSRT="X"&(PSSNAME](PSSEND_"zzzz")):1,1:0)!(PSSNAME=""&(PSSSRT="X"))!(PSSSRT="A"&(PSSNAME=""))!($G(PSSOUT))  D
 .F PSSIEN=0:0 S PSSIEN=$O(^PSDRUG("B",PSSNAME,PSSIEN)) Q:'PSSIEN!($G(PSSOUT))  D
 ..Q:'$D(^PSDRUG(PSSIEN,0))
 ..I ($Y+5)>IOSL D HD Q:$G(PSSOUT)
 ..K PSSINA,PSSNF,PSSINAD,PSSUNIT,PSSAPU S PSSNF=$S($P($G(^PSDRUG(PSSIEN,0)),"^",9):1,1:0),PSSINA=$P($G(^PSDRUG(PSSIEN,"I")),"^"),PSSNODE=$G(^("DOS"))
 ..I $G(PSSINA),$G(PSSYEAR),$G(PSSINA)<$G(PSSYEAR) Q
 ..S PSSMSG=$P($G(^PSDRUG(PSSIEN,0)),"^",10)
 ..S PSSAPU=$P($G(^PSDRUG(PSSIEN,2)),"^",3)
 ..I $G(PSSINA) S PSSINAD=$E(PSSINA,4,5)_"/"_$E(PSSINA,6,7)_"/"_$E(PSSINA,2,3)
 ..I $P(PSSNODE,"^",2) S PSSUNIT=$P($G(^PS(50.607,+$P(PSSNODE,"^",2),0)),"^")
 ..S PSSSTR=$P(PSSNODE,"^")
 ..W !!!,"("_$G(PSSIEN)_")",?19,$G(PSSNAME)_$S($G(PSSNF):"    *N/F*",1:"") W ?72,"Inactive Date: "_$G(PSSINAD)
 ..I ($Y+5)>IOSL D HD Q:$G(PSSOUT)
 ..I $G(PSSMSG)'="" W !?12,$G(PSSMSG)
 ..I '$O(^PSDRUG(PSSIEN,"DOS1",0)),'$O(^PSDRUG(PSSIEN,"DOS2",0)) D NEWX Q
 ..I ($Y+5)>IOSL D HD Q:$G(PSSOUT)
 ..W !?12,"Strength: "_$S($E($G(PSSSTR),1)=".":"0",1:"")_$G(PSSSTR) W ?43,"Units: " I $G(PSSUNIT)'="",$G(PSSUNIT)'["/" W $G(PSSUNIT)
 ..I $G(PSSUNIT)'="",$G(PSSUNIT)'["/",$L(PSSUNIT)>15 W !
 ..W ?66,"Application Package: "_$G(PSSAPU)
 ..I ($Y+5)>IOSL D HD Q:$G(PSSOUT)
 ..S PSSA=0 K PSSC,PSSD,PSSE W !?4,"Possible Dosages: " I $G(PSSSTR)'="",$G(PSSUNIT)'="" D
 ...F PSSB=0:0 S PSSB=$O(^PSDRUG(PSSIEN,"DOS1",PSSB)) Q:'PSSB!($G(PSSOUT))  S PSSC=$P($G(^(PSSB,0)),"^"),PSSD=$P($G(^(0)),"^",2),PSSE=$P($G(^(0)),"^",3) I $G(PSSC),$G(PSSD) S PSSA=1 D
 ....I ($Y+5)>IOSL D HD Q:$G(PSSOUT)
 ....W !?3,"Dispense Units Per Dose: "_$S($E($G(PSSC),1)=".":"0",1:"")_$G(PSSC),?44,"Dose: " D
 .....I $G(PSSUNIT)'["/" W $S($E($G(PSSD),1)=".":"0",1:"")_$G(PSSD)_$G(PSSUNIT) W ?78,"Package: "_$G(PSSE) D OUT Q
 .....D SETD D ZERO W $G(PSSCALC),?78,"Package: "_$G(PSSE) D OUT
 ..Q:$G(PSSOUT)
 ..I 'PSSA W "(None)"
 ..S PSSA=0 W !?4,"Local Possible Dosages: " F PSSB=0:0 S PSSB=$O(^PSDRUG(PSSIEN,"DOS2",PSSB)) Q:'PSSB!($G(PSSOUT))  D
 ...I $P($G(^PSDRUG(PSSIEN,"DOS2",PSSB,0)),"^")'="" S PSSA=1 D
 ....I ($Y+5)>IOSL D HD Q:$G(PSSOUT)
 ....W !?6,$P($G(^PSDRUG(PSSIEN,"DOS2",PSSB,0)),"^") D NEW
 ..Q:$G(PSSOUT)
 ..I 'PSSA W "(None)"
 ..D NEWX
END ;
 I '$G(PSSOUT),$G(PSSDV)="C" W !!,"End of Report." K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $G(PSSDV)="C" W !
 E  W @IOF
ENDX K PSSNODE,PSSNUMB,PSSNUMBX,PSSSRT,PSSCALC,PSSSTR,PSSUNIT,PSSIEN,PSSINAD,PSSINA,PSSNF,PSSNAME,PSSDV,PSSX,PSSOUT,PSSHOW,PSSBEG,PSSLINE,PSSEND,PSSA,PSSB,PSSC,PSSD,PSSE,PSSAPU,PSSMSG,PSSYEAR,PSSDFOI,PSSDFOIN,PSSDF,PSSDZZ,PSSDZ,X,Y,PSSCT
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HD ;
 I $G(PSSDV)="C",$G(PSSCT)'=1 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSSOUT=1 Q
 W @IOF W !,$S(PSSSRT="N":"Dosage report for drugs with leading numerics",PSSSRT="A":"Dosage report for all drugs",1:"Dosage report for drugs from "_PSSBEG_" through "_PSSEND)
 W ?94,"Outpatient Expansion",?119,"PAGE: "_$G(PSSCT),!,PSSLINE S PSSCT=PSSCT+1
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
 W ?94,$S($E($G(PSSC),1)=".":"0",1:"")_$G(PSSC)_" "_$S($G(PSSDZN)'="":$G(PSSDZN),1:$G(PSSDZ))
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
ZERO ;Leading zeros
 I $E($G(PSSCALC),1)="." S PSSCALC="0"_$G(PSSCALC)
 N PSSLEZ,PSSLEZ1,PSSLEZD
 I $G(PSSCALC)["/." S PSSLEZD=$G(PSSCALC) D
 .S PSSLEZ=$P(PSSLEZD,"/."),PSSLEZ1=$P(PSSLEZD,"/.",2)
 .S PSSCALC=$G(PSSLEZ)_"/0."_$G(PSSLEZ1)
 Q
 ;
NEW ;new fields added with patch PSS*1*129
 I ($Y+5)>IOSL D HD Q:$G(PSSOUT)
 N PSSYWD,PSSYWN,PSSYWNN
 S PSSYWD=$P($G(^PSDRUG(PSSIEN,"DOS2",PSSB,0)),"^",5),PSSYWN=$P($G(^PSDRUG(PSSIEN,"DOS2",PSSB,0)),"^",6)
 S PSSYWNN=$S($E($G(PSSYWN),1)=".":"0"_$G(PSSYWN),1:$G(PSSYWN))
 W !?6,"Numeric Dose: "_$G(PSSYWNN),?46,"Dose Unit: "_$S($G(PSSYWD):$P($G(^PS(51.24,+PSSYWD,0)),"^"),1:""),?92,"Package: ",$P($G(^PSDRUG(PSSIEN,"DOS2",PSSB,0)),"^",2)
 I ($Y+5)>IOSL D HD Q:$G(PSSOUT)
 Q
NEWX ;new fields added with patch PSS*1*129
 I ($Y+5)>IOSL D HD Q:$G(PSSOUT)
 N PSSYWND1,PSSYWND3,PSSYWNDN,PSSYWNDS,PSSYWFS,PSSYWFSS
 S PSSYWFS=$P($G(^PSDRUG(PSSIEN,"DOS")),"^")
 S PSSYWFSS=$S($E($G(PSSYWFS),1)=".":"0"_$G(PSSYWFS),1:$G(PSSYWFS))
 I PSSYWFSS="" Q
 S PSSYWND1=$P($G(^PSDRUG(PSSIEN,"ND")),"^"),PSSYWND3=$P($G(^PSDRUG(PSSIEN,"ND")),"^",3)
 I 'PSSYWND1!('PSSYWND3) Q
 S PSSYWNDN=$$PROD0^PSNAPIS(PSSYWND1,PSSYWND3)
 S PSSYWNDS=$S($E($P(PSSYWNDN,"^",3),1)=".":"0"_$P(PSSYWNDN,"^",3),1:$P(PSSYWNDN,"^",3))
 I PSSYWNDS="" Q
 I PSSYWFSS=PSSYWNDS Q
 W !,?3,"Note: Strength of "_PSSYWFSS_" does not match NDF strength of "_PSSYWNDS_"."
 I ($Y+5)>IOSL D HD Q:$G(PSSOUT)
 W !?3,"VA PRODUCT MATCH: "_$P(PSSYWNDN,"^")
 I ($Y+5)>IOSL D HD Q:$G(PSSOUT)
 Q
