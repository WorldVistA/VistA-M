PSSTRENG ;BIR/RTR-Mismatch Strength Report ;06/28/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**129**;9/30/97;Build 67
 ;Reference to ^PS(50.607 supported by DBIA 2221
EN ;
DEV ;
 N IOP,%ZIS,POP,ZTRTN,ZTDESC,ZTSK,DUOUT,DTOUT,DIRUT,DIROUT,X,Y,DIR
 W !!,"This report will print Dosage information for all entries in the DRUG (#50)",!,"File that have a different Strength than what is in the VA PRODUCT (#50.68)"
 W !,"File match. If these drugs have Local Possible Dosages, you need to be careful",!,"when populating the new Dose Unit and Numeric Dose fields to be used for Dosage"
 W !,"checks, because the Dosage check will be based on the VA Product. This report",!,"can only identify Strength mismatches if the Drug qualifies for Possible"
 W !,"Dosages, and a Strength has been defined in the DRUG (#50) File.",!
 W !?3,"This report is designed for 132 column format!",!
 K IOP,%ZIS,POP S %ZIS="QM" D ^%ZIS I $G(POP)>0 K IOP,%ZIS,POP W !!,"Nothing queued to print.",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR Q
 I $D(IO("Q")) S ZTRTN="START^PSSTRENG",ZTDESC="Mismatch Strength Report" D ^%ZTLOAD K %ZIS W !!,"Report queued to print.",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR Q
START ;
 U IO
 N PSSLINE,PSSYEAR,X,X1,X2,PSSOUT,PSSNAME,PSSCT,PSSIEN,PSSA,PSSB,PSSC,PSSD,PSSDV,PSSE,PSSINA,PSSINAD,PSSSTND1,PSSSTND3,PSSSTNDS,PSSSTNDZ
 N PSSNF,PSSUNIT,PSSAPU,PSSNODE,PSSMSG,PSSSTR,PSSNWD,PSSNWDN,PSSFOUND,Y,PSSMSXXX,PSSNWDS,PSSNWDSS
 S X1=DT,X2=-365 D C^%DTC S PSSYEAR=$G(X) K X,X1,X2
 S (PSSOUT,PSSFOUND)=0,PSSDV=$S($E(IOST,1,2)'="C-":"P",1:"C"),PSSCT=1
 K PSSLINE S $P(PSSLINE,"-",130)=""
 D HD
PASS ;
 S PSSNAME="" F  S PSSNAME=$O(^PSDRUG("B",PSSNAME)) Q:PSSNAME=""!($G(PSSOUT))  D
 .F PSSIEN=0:0 S PSSIEN=$O(^PSDRUG("B",PSSNAME,PSSIEN)) Q:'PSSIEN!($G(PSSOUT))  D
 ..Q:'$D(^PSDRUG(PSSIEN,0))
 ..K PSSINA,PSSNF,PSSINAD,PSSUNIT,PSSAPU,PSSNODE,PSSMSG,PSSMSXXX,PSSSTNDS,PSSSTNDZ,PSSSTND1,PSSSTND3,PSSSTR S PSSNF=$S($P($G(^PSDRUG(PSSIEN,0)),"^",9):1,1:0),PSSINA=$P($G(^PSDRUG(PSSIEN,"I")),"^"),PSSNODE=$G(^PSDRUG(PSSIEN,"DOS"))
 ..;Quit if no Strength in File 50
 ..S (PSSMSXXX,PSSSTR)=$P(PSSNODE,"^") S PSSMSXXX=$S($E(PSSMSXXX,1)=".":"0"_PSSMSXXX,1:PSSMSXXX)
 ..I PSSMSXXX="" Q
 ..S PSSSTND1=$P($G(^PSDRUG(PSSIEN,"ND")),"^"),PSSSTND3=$P($G(^("ND")),"^",3)
 ..I 'PSSSTND3!('PSSSTND1) Q
 ..S PSSSTNDZ=$$PROD0^PSNAPIS(+PSSSTND1,+PSSSTND3) S PSSSTNDS=$P(PSSSTNDZ,"^",3) S PSSSTNDS=$S($E(PSSSTNDS,1)=".":"0"_PSSSTNDS,1:PSSSTNDS)
 ..I $G(PSSSTNDS)="" Q
 ..I PSSSTNDS=PSSMSXXX Q
 ..;PSS*1*78 Aadding the Space for Dosages, - Depending on work group decision, you may need to chane this!
 ..S PSSFOUND=1
 ..S PSSMSG=$P($G(^PSDRUG(PSSIEN,0)),"^",10)
 ..S PSSAPU=$P($G(^PSDRUG(PSSIEN,2)),"^",3)
 ..I $G(PSSINA) S PSSINAD=$E(PSSINA,4,5)_"/"_$E(PSSINA,6,7)_"/"_$E(PSSINA,2,3)
 ..I $P(PSSNODE,"^",2) S PSSUNIT=$P($G(^PS(50.607,+$P(PSSNODE,"^",2),0)),"^")
 ..;S PSSSTR=PSSMSXXX
 ..W !!!,"("_$G(PSSIEN)_")",?19,$G(PSSNAME)_$S($G(PSSNF):"    *N/F*",1:"") W ?72,"Inactive Date: "_$G(PSSINAD)
 ..I ($Y+5)>IOSL D HD Q:$G(PSSOUT)
 ..I $G(PSSMSG)'="" W !?12,$G(PSSMSG)
 ..;I '$O(^PSDRUG(PSSIEN,"DOS1",0)),'$O(^PSDRUG(PSSIEN,"DOS2",0)) Q
 ..I ($Y+5)>IOSL D HD Q:$G(PSSOUT)
 ..W !?12,"Strength: "_$G(PSSMSXXX) W ?43,"Units: " I $G(PSSUNIT)'="" W $G(PSSUNIT)
 ..I $G(PSSUNIT)'="",$L(PSSUNIT)>15 W !
 ..W ?66,"Application Package: "_$G(PSSAPU)
 ..I ($Y+5)>IOSL D HD Q:$G(PSSOUT)
 ..S PSSA=0 K PSSC,PSSD,PSSE W !?4,"Possible Dosages: " D
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
 ....K PSSNWD,PSSNWDN,PSSNWDS,PSSNWDSS
 ....S PSSNWD=$P($G(^PSDRUG(PSSIEN,"DOS2",PSSB,0)),"^",5) I PSSNWD S PSSNWDN=$P($G(^PS(51.24,+$G(PSSNWD),0)),"^")
 ....W !?6,$P($G(^PSDRUG(PSSIEN,"DOS2",PSSB,0)),"^")
 ....I ($Y+5)>IOSL D HD Q:$G(PSSOUT)
 ....S PSSNWDS=$P($G(^PSDRUG(PSSIEN,"DOS2",PSSB,0)),"^",6) S PSSNWDSS=$S($E(PSSNWDS,1)=".":"0"_$G(PSSNWDS),1:$G(PSSNWDS))
 ....W !?6,"Numeric Dose: "_$G(PSSNWDSS),?46,"Dose Unit: "_$G(PSSNWDN),?92,"Package: ",$P($G(^PSDRUG(PSSIEN,"DOS2",PSSB,0)),"^",2)
 ....I ($Y+5)>IOSL D HD Q:$G(PSSOUT)
 ..Q:$G(PSSOUT)  I 'PSSA W "(None)"
 ..I ($Y+5)>IOSL D HD Q:$G(PSSOUT)
 ..W !?3,"Note: Strength of "_PSSMSXXX_" does not match NDF strength of "_PSSSTNDS_"."
 ..I ($Y+5)>IOSL D HD Q:$G(PSSOUT)
 ..W !?3,"VA PRODUCT MATCH: "_$P(PSSSTNDZ,"^")
 ..I ($Y+5)>IOSL D HD Q:$G(PSSOUT)
END ;
 I '$G(PSSOUT),'PSSFOUND W !,"No mismatches found."
 I $G(PSSDV)="P" W !!,"End of Report.",!
 I '$G(PSSOUT),$G(PSSDV)="C" W !!,"End of Report." K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $G(PSSDV)="C" W !
 E  W @IOF
ENDX K PSSCALC,PSSDFOI,PSSDFOIN,PSSDF,PSSDZZ D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HD ;
 I $G(PSSDV)="C",$G(PSSCT)'=1 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSSOUT=1 Q
 W @IOF
 W !,"Mismatched Strength Report",?119,"PAGE: "_$G(PSSCT),!,PSSLINE S PSSCT=PSSCT+1
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
