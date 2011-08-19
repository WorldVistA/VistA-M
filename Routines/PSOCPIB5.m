PSOCPIB5 ;BIR/EJW-Report of back-billed fills with insurance information ;06/24/03
 ;;7.0;OUTPATIENT PHARMACY;**142**;DEC 1997
 ;External reference to $$STATUS^IBARX supported by DBIA 125
 ;External reference to $$PTCOV^IBCNSU3 supported by DBIA 4115
RPT ;
 W !!,"This report shows the patient name, prescription fill, and insurance"
 W !,"information for fills that were billed as part of patch PSO*7*123 clean-up."
 W !!,"You may queue the report to print, if you wish.",!
 ;
DVC K %ZIS,POP,IOP S %ZIS="QM" D ^%ZIS I $G(POP) W !!,"Nothing queued to print.",! G DONE
QUEUE I $D(IO("Q")) S ZTRTN="START^PSOCPIB5",ZTDESC="Billed copay insurance report" D ^%ZTLOAD K %ZSI W !,"Report queued to print.",! G DONE
START ;
 N PSOFIRST
 U IO
 S PSOOUT=0,PSODV=$S($E(IOST)="C":"C",1:"P")
 S PSOPGCT=0,PSOPGLN=IOSL-7,PSOPGCT=1
 D TITLE
 S PSOJ=0
 S BILLDT=$P($G(^XTMP("PSOCPIB3",0)),"^",2)
 F  S PSOJ=$O(^XTMP("PSOCPIB3",PSOJ)) Q:PSOJ=""  S PSONAM="" F  S PSONAM=$O(^XTMP("PSOCPIB3",PSOJ,"BILLED",PSONAM)) Q:PSONAM=""  S PSODFN="" F  S PSODFN=$O(^XTMP("PSOCPIB3",PSOJ,"BILLED",PSONAM,PSODFN)) Q:PSODFN=""  D
 .S PSOFIRST=1
 .W !
 .S RXP="" F  S RXP=$O(^XTMP("PSOCPIB3",PSOJ,"BILLED",PSONAM,PSODFN,RXP)) Q:RXP=""  S PSOFILL="" F  S PSOFILL=$O(^XTMP("PSOCPIB3",PSOJ,"BILLED",PSONAM,PSODFN,RXP,PSOFILL)) Q:PSOFILL=""  D
 ..N XX
 ..S XX=$G(^XTMP("PSOCPIB3",PSOJ,"BILLED",PSONAM,PSODFN,RXP,PSOFILL)) D
 ...I PSOFIRST D FULL Q:$G(PSOOUT)  W !,PSONAM D PRTSSN S PSOFIRST=0
 ...D FULL Q:$G(PSOOUT)  W !,?4,RXP," (",PSOFILL,")" D
 ....S Y=XX I Y>0 X ^DD("DD")
 ....W ?25," ",Y
 ....S PSORXP=$O(^PSRX("B",RXP,"")) I PSORXP="" Q
 ....S PSOBILL=$S('PSOFILL:$P($G(^PSRX(PSORXP,"IB")),"^",2),1:$P($G(^PSRX(PSORXP,1,PSOFILL,"IB")),"^"))
 ....I 'PSOBILL W ?43,"** NO BILL NUMBER FOR THIS FILL **" Q
 ....S PSOIBST=$$STATUS^IBARX(PSOBILL) I PSOIBST=2 W "** COPAY CHARGE CANCELLED **" Q
 ....W ?46,$S($$PTCOV^IBCNSU3(PSODFN,XX,"PHARMACY"):"YES",1:" NO"),?68,$S($$PTCOV^IBCNSU3(PSODFN,XX,"PHARMACY"):"YES",1:" NO")
 G END
 ;
FULL ;
 I ($Y+7)>IOSL&('$G(PSOOUT)) D TITLE
 Q
 ;
TITLE ;
 I $G(PSODV)="C",$G(PSOPGCT)'=1 W ! K DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSOOUT=1 Q
 ;
 W @IOF D
 . W !,"Patch PSO*7*142 -COPAYS BILLED BY PSO*7*123 WITH RX INSURANCE INFORMATION"
 S Y=DT X ^DD("DD") W !,"Date printed: ",Y,?70,"Page: ",PSOPGCT,!
 F MJT=1:1:79 W "="
 W !,"PATIENT NAME  (SSN)  DIV",?44,"RX INSURANCE",?66,"RX INSURANCE"
 W !,?4,"RX# (FILL)",?25,"RELEASE DATE",?43,"ON RELEASE DATE",?65,"ON BILLED DATE"
 W !,"------------------------",?25,"------------",?43,"---------------",?65,"--------------"
 S PSOPGCT=PSOPGCT+1
 Q
END ;
 I '$G(PSOOUT),$G(PSODV)="C" W !!,"** End of Report **" K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $G(PSODV)="C" W !
 E  W @IOF
DONE ;
 K MJT,PSOPGCT,PSOPGLN,Y,DIR,X,IOP,POP,IO("Q"),DIRUT,DUOUT,DTOUT,PSORXP,PSOIBST,PSOFILL,PSOOUT,PSOBILL,PSODIV,PSODFN,BILLDT,PSOJ,PSONAM,RXP,PSODV,VA
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
PRTSSN ;
 N DFN
 S DFN=PSODFN D PID^VADPT
 S PSORXP=$O(^PSRX("B",RXP,"")) I PSORXP="" Q
 S PSODIV=$P($G(^PSRX(PSORXP,2)),"^",9) S:PSODIV'="" PSODIV=$P($G(^PS(59,PSODIV,0)),"^",1)
 W "  ("_$G(VA("BID"))_")"_"  "_PSODIV
 Q
 ;
