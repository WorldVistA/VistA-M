PSSPRMIX ;BIR/RTR-PREMIX REPORT ;07/14/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**129**;9/30/07;Build 67
 ;
REP ;IV Solutions report
 ;
 W !!,"This report displays only those solutions in the IV Solutions (#52.7) File",!,"that are marked as PreMix IV Solutions, or it displays all Solutions."
 N DIR,PSSPRTP,Y,DIRUT,DIROUT,DUOUT,DTOUT,IOP,%ZIS,POP,X,ZTRTN,ZTDESC,ZTSAVE,ZTSK
 K DIR,Y S DIR(0)="SO^P:Print only IV Solutions marked as PreMix;A:Print All IV Solutions",DIR("A")="Print report for PreMix (P), or All IV Solutions (A): (P/A): Premix",DIR("B")="P"
 S DIR("?")=" ",DIR("?",1)="Enter 'P' to see only those IV Solutions that are marked as PreMix,"
 S DIR("?",2)="Enter 'A' to see all IV Solutions, regardless of PreMix designation."
 D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) D MESS Q
 I Y'="P",Y'="A" D MESS Q
 S PSSPRTP=Y
 W !!?3,"This report is designed for 80 column format!",!
 K IOP,%ZIS,POP S %ZIS="QM" D ^%ZIS I $G(POP)>0 W !!,"Nothing queued to print.",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR,IOP,%ZIS,POP Q
 I $D(IO("Q")) S ZTRTN="START^PSSPRMIX",ZTDESC="IV Solutions PreMix Report",ZTSAVE("PSSPRTP")="" D ^%ZTLOAD W !!,"Report queued to print.",! D  K IOP,%ZIS,POP Q
 .K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 ;
 U IO G STARTX
START ;
 U IO
 N DIR,Y,DIRUT,DIROUT,DUOUT,DTOUT,X
STARTX ;
 N PSSPRM,PSSPRMDV,PSSPRMLN,PSSPROUT,PSSPRMCT,PSSPRMIN,PSSPRMAR,PSSPRML1,PSSPRML2,PSSPRML3,PSSPRMTP,PSSPRMSU,PSSPRMSY,PSSPRMSX,PSSPRMSC,PSSPRMDF,PSSPRMDZ,PSSPRMDQ,PSSPRMFD
 S (PSSPROUT,PSSPRMFD)=0,PSSPRMDV=$S($E(IOST,1,2)'="C-":"P",1:"C"),PSSPRMCT=1
 K PSSPRMLN S $P(PSSPRMLN,"-",79)=""
 D HD
 S PSSPRM="" F  S PSSPRM=$O(^PS(52.7,"B",PSSPRM)) Q:PSSPRM=""!(PSSPROUT)  D
 .F PSSPRMIN=0:0 S PSSPRMIN=$O(^PS(52.7,"B",PSSPRM,PSSPRMIN)) Q:'PSSPRMIN!(PSSPROUT)  D
 ..K PSSPRMAR,PSSPRML1,PSSPRML2,PSSPRML3,PSSPRMTP,PSSPRMSU,PSSPRMSY,PSSPRMSC
 ..S PSSPRMTP=PSSPRMIN_","
 ..D GETS^DIQ(52.7,PSSPRMTP,".01;.02;1;2;8;9;17;18","IE","PSSPRMAR")
 ..I PSSPRTP="P",'$G(PSSPRMAR(52.7,PSSPRMTP,18,"I")) Q
 ..S PSSPRMFD=1
 ..I ($Y+5)>IOSL D HD Q:PSSPROUT
 ..S PSSPRML1=$L($G(PSSPRMAR(52.7,PSSPRMTP,.01,"E"))),PSSPRML2=$L($G(PSSPRMAR(52.7,PSSPRMTP,2,"E"))),PSSPRML3=0
 ..S PSSPRML3=PSSPRML1+PSSPRML2
 ..W !!?18,"Print Name: "_$G(PSSPRMAR(52.7,PSSPRMTP,.01,"E"))
 ..I PSSPRML3<37 W "    Volume: "_$G(PSSPRMAR(52.7,PSSPRMTP,2,"E"))
 ..I PSSPRML3'<37 W !?30,"Volume: "_$G(PSSPRMAR(52.7,PSSPRMTP,2,"E"))
 ..I ($Y+5)>IOSL D HD Q:PSSPROUT
 ..W !?14,"Print Name {2}: "_$G(PSSPRMAR(52.7,PSSPRMTP,.02,"E"))
 ..I ($Y+5)>IOSL D HD Q:PSSPROUT
 ..W !?20,"Synonyms: "
 ..S PSSPRMSC=0 F PSSPRMSY=0:0 S PSSPRMSY=$O(^PS(52.7,PSSPRMIN,3,PSSPRMSY)) Q:'PSSPRMSY!(PSSPROUT)  D
 ...K PSSPRMSU,PSSPRMSX
 ...S PSSPRMSU=PSSPRMSY_","_PSSPRMIN_"," S PSSPRMSX=$$GET1^DIQ(52.703,PSSPRMSU,".01")
 ...W:PSSPRMSC !?30,$G(PSSPRMSX) W:'PSSPRMSC ?30,$G(PSSPRMSX)
 ...S PSSPRMSC=1
 ...I ($Y+5)>IOSL D HD Q:PSSPROUT
 ..Q:PSSPROUT
 ..I ($Y+5)>IOSL D HD Q:PSSPROUT
 ..W !?16,"Generic Drug: "_$G(PSSPRMAR(52.7,PSSPRMTP,1,"E"))
 ..I ($Y+5)>IOSL D HD Q:PSSPROUT
 ..K PSSPRML1,PSSPRML2,PSSPRML3,PSSPRMDF,PSSPRMDZ,PSSPRMDQ
 ..S PSSPRML1=$L($G(PSSPRMAR(52.7,PSSPRMTP,9,"E"))),PSSPRMDF=$G(PSSPRMAR(52.7,PSSPRMTP,9,"I"))
 ..S PSSPRML2=0 I PSSPRMDF S PSSPRMDZ=PSSPRMDF_"," S PSSPRMDQ=$$GET1^DIQ(50.7,PSSPRMDZ,".02") S PSSPRML2=$L(PSSPRMDQ)
 ..S PSSPRML3=PSSPRML1+PSSPRML2
 ..W !?5,"Pharmacy Orderable Item: "_$G(PSSPRMAR(52.7,PSSPRMTP,9,"E"))
 ..I PSSPRML3<47 W "  "_$G(PSSPRMDQ)
 ..I PSSPRML3'<47 W !?30,$G(PSSPRMDQ)
 ..I ($Y+5)>IOSL D HD Q:PSSPROUT
 ..W !?11,"Inactivation Date: "_$G(PSSPRMAR(52.7,PSSPRMTP,8,"E"))
 ..I ($Y+5)>IOSL D HD Q:PSSPROUT
 ..W !,"Used in IV Fluid Order Entry: "_$G(PSSPRMAR(52.7,PSSPRMTP,17,"E"))
 ..I ($Y+5)>IOSL D HD Q:PSSPROUT
 ..W !?22,"PreMix: "_$G(PSSPRMAR(52.7,PSSPRMTP,18,"E"))
 ..I ($Y+5)>IOSL D HD Q:PSSPROUT
 ;
END ;End of report
 I PSSPRTP="P",'$G(PSSPROUT),'$G(PSSPRMFD) W !!,"No IV Solutions marked as PreMixes found.",!
 I $G(PSSPRMDV)="P" W !!,"End of Report.",!
 K PSSPRTP
 I '$G(PSSPROUT),$G(PSSPRMDV)="C" W !!,"End of Report." K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $G(PSSPRMDV)="C" W !
 E  W @IOF
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
HD ;Report Header
 I $G(PSSPRMDV)="C",$G(PSSPRMCT)'=1 W ! K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSSPROUT=1 Q
 W @IOF W !,$S(PSSPRTP="P":"Solution PreMix report for IV Solutions marked as PreMix",1:"Solution PreMix report for all IV Solutions"),?69,"Page: "_$G(PSSPRMCT),!,PSSPRMLN,! S PSSPRMCT=PSSPRMCT+1
 Q
 ;
MESS ;
 W !!,"No Action taken.",!
 K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 Q
