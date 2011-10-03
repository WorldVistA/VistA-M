PSSADRPT ;BIR/RTR-IV ADDITIVE REPORT ;07/15/09
 ;;1.0;PHARMACY DATA MANAGEMENT;**147**;9/30/97;Build 16
 ;
REP ;IV Additive report
 ;
 W !!,"This report displays entries in the IV ADDITIVES (#52.6) File. You can select",!,"to display only entries marked with '1 BAG/DAY' in the ADDITIVE FREQUENCY (#18)"
 W !,"Field, or only those entries with nothing entered in the ADDITIVE FREQUENCY",!,"(#18) Field, or all entries can be displayed.",!
 N DIR,PSSKFTP,Y,DIRUT,DIROUT,DUOUT,DTOUT,IOP,%ZIS,POP,X,ZTRTN,ZTDESC,ZTSAVE,ZTSK
 K DIR,Y S DIR(0)="SO^1:Print entries marked as '1 BAG/DAY' for ADDITIVE FREQUENCY;N:Print entries marked as Null for ADDITIVE FREQUENCY;A:Print all IV Additives"
 S DIR("B")="A",DIR("A")="Print which IV Additives"
 S DIR("?")=" ",DIR("?",1)="Enter '1' to see only those IV Additives that are marked as '1 BAG/DAY' in"
 S DIR("?",2)="the ADDITIVE FREQUENCY (#18) Field, enter 'N' to see only those IV Additives"
 S DIR("?",3)="with no data entered in the ADDITIVE FREQUENCY (#18) Field, enter 'A' to"
 S DIR("?",4)="see all IV Additives, regardless of ADDITIVE FREQUENCY designation."
 D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) D MESS Q
 I Y'="1",Y'="N",Y'="A" D MESS Q
 S PSSKFTP=Y
 W !!?3,"This report is designed for 80 column format!",!
 K IOP,%ZIS,POP S %ZIS="QM" D ^%ZIS I $G(POP)>0 W !!,"Nothing queued to print.",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR,IOP,%ZIS,POP Q
 I $D(IO("Q")) S ZTRTN="START^PSSADRPT",ZTDESC="IV Additives Report",ZTSAVE("PSSKFTP")="" D ^%ZTLOAD W !!,"Report queued to print.",! D  K IOP,%ZIS,POP Q
 .K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 ;
 U IO G STARTX
START ;
 U IO
 N DIR,Y,DIRUT,DIROUT,DUOUT,DTOUT,X
STARTX ;
 N PSSKFOUT,PSSKFMDV,PSSKFMFD,PSSKFMCT,PSSKFMLN,PSSKFMXX,PSSKFMIN,PSSKFMAR,PSSKFMSC,PSSKFMSY,PSSKFMSU,PSSKFMSX,PSSKFML1,PSSKFML2,PSSKFMDF,PSSKFMDZ,PSSKFMDQ,PSSKFML3,PSSKFMTP,PSSKFERR,PSSKFERZ,PSSKFERX
 S (PSSKFOUT,PSSKFMFD)=0,PSSKFMDV=$S($E(IOST,1,2)'="C-":"P",1:"C"),PSSKFMCT=1
 K PSSKFMLN S $P(PSSKFMLN,"-",79)=""
 D HD
 S PSSKFMXX="" F  S PSSKFMXX=$O(^PS(52.6,"B",PSSKFMXX)) Q:PSSKFMXX=""!(PSSKFOUT)  D
 .F PSSKFMIN=0:0 S PSSKFMIN=$O(^PS(52.6,"B",PSSKFMXX,PSSKFMIN)) Q:'PSSKFMIN!(PSSKFOUT)  D
 ..K PSSKFMTP,PSSKFMAR,PSSKFMSC,PSSKFMSY,PSSKFMSU,PSSKFMSX,PSSKFML1,PSSKFML2,PSSKFML3
 ..S PSSKFMTP=PSSKFMIN_","
 ..D GETS^DIQ(52.6,PSSKFMTP,".01;1;2;12;15;17;18","IE","PSSKFMAR","PSSKFERR")
 ..I PSSKFTP=1,$G(PSSKFMAR(52.6,PSSKFMTP,18,"I"))'=1 Q
 ..I PSSKFTP="N",$G(PSSKFMAR(52.6,PSSKFMTP,18,"I"))'="" Q
 ..S PSSKFMFD=1
 ..I ($Y+5)>IOSL D HD Q:PSSKFOUT
 ..W !!?18,"Print Name: "_$G(PSSKFMAR(52.6,PSSKFMTP,.01,"E"))
 ..I ($Y+5)>IOSL D HD Q:PSSKFOUT
 ..W !?19,"Drug Unit: "_$G(PSSKFMAR(52.6,PSSKFMTP,2,"E"))
 ..I ($Y+5)>IOSL D HD Q:PSSKFOUT
 ..W !?20,"Synonyms: "
 ..S PSSKFMSC=0 F PSSKFMSY=0:0 S PSSKFMSY=$O(^PS(52.6,PSSKFMIN,3,PSSKFMSY)) Q:'PSSKFMSY!(PSSKFOUT)  D
 ...K PSSKFMSU,PSSKFMSX
 ...S PSSKFMSU=PSSKFMSY_","_PSSKFMIN_"," S PSSKFMSX=$$GET1^DIQ(52.63,PSSKFMSU,".01",,,"PSSKFERX")
 ...W:PSSKFMSC !?30,$G(PSSKFMSX) W:'PSSKFMSC ?30,$G(PSSKFMSX)
 ...S PSSKFMSC=1
 ...I ($Y+5)>IOSL D HD Q:PSSKFOUT
 ..Q:PSSKFOUT
 ..I ($Y+5)>IOSL D HD Q:PSSKFOUT
 ..W !?16,"Generic Drug: "_$G(PSSKFMAR(52.6,PSSKFMTP,1,"E"))
 ..I ($Y+5)>IOSL D HD Q:PSSKFOUT
 ..K PSSKFML1,PSSKFML2,PSSKFMDF,PSSKFMDZ,PSSKFMDQ,PSSKFML3
 ..S PSSKFML1=$L($G(PSSKFMAR(52.6,PSSKFMTP,15,"E"))),PSSKFMDF=$G(PSSKFMAR(52.6,PSSKFMTP,15,"I"))
 ..S PSSKFML2=0 I PSSKFMDF S PSSKFMDZ=PSSKFMDF_"," S PSSKFMDQ=$$GET1^DIQ(50.7,PSSKFMDZ,".02",,,"PSSKFERZ") S PSSKFML2=$L(PSSKFMDQ)
 ..S PSSKFML3=PSSKFML1+PSSKFML2
 ..W !?5,"Pharmacy Orderable Item: "_$G(PSSKFMAR(52.6,PSSKFMTP,15,"E"))
 ..I PSSKFML3<47 W "  "_$G(PSSKFMDQ)
 ..I PSSKFML3'<47 W !?30,$G(PSSKFMDQ)
 ..I ($Y+5)>IOSL D HD Q:PSSKFOUT
 ..W !?11,"Inactivation Date: "_$G(PSSKFMAR(52.6,PSSKFMTP,12,"E"))
 ..I ($Y+5)>IOSL D HD Q:PSSKFOUT
 ..W !,"Used in IV Fluid Order Entry: "_$G(PSSKFMAR(52.6,PSSKFMTP,17,"E"))
 ..I ($Y+5)>IOSL D HD Q:PSSKFOUT
 ..W !?10,"Additive Frequency: "_$G(PSSKFMAR(52.6,PSSKFMTP,18,"E"))
 ..I ($Y+5)>IOSL D HD Q:PSSKFOUT
 ;
END ;End of report
 I '$G(PSSKFOUT),'$G(PSSKFMFD) W !!,$S($G(PSSKFTP)=1:"No IV Additives marked as '1 BAG/DAY'.",$G(PSSKFTP)="N":"No IV Additives marked as null.",1:"No IV Additives to print."),!
 I $G(PSSKFMDV)="P" W !!,"End of Report.",!
 K PSSKFTP
 I '$G(PSSKFOUT),$G(PSSKFMDV)="C" W !!,"End of Report." K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $G(PSSKFMDV)="C" W !
 E  W @IOF
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
HD ;Report Header
 I $G(PSSKFMDV)="C",$G(PSSKFMCT)'=1 W ! K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSSKFOUT=1 Q
 W @IOF W !,$S(PSSKFTP=1:"IV Additives marked as '1 BAG/DAY' for ADDITIVE FREQUENCY",PSSKFTP="N":"IV Additives marked as null for ADDITIVE FREQUENCY",1:"All IV Additives"),?68,"Page: "_$G(PSSKFMCT),!,PSSKFMLN,! S PSSKFMCT=PSSKFMCT+1
 Q
 ;
MESS ;
 W !!,"No Action taken.",!
 K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 Q
