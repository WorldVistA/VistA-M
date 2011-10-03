PSXSRST ;BIR/WPB-Reset Suspense and Print Again ;30 JAN 1998  12:57 PM
 ;;2.0;CMOP;**3,23,41**;11 Apr 97
 ;Reference to ^PS(52.5, supported by DBIA #1978
 ;Reference to ^PS(59,   supported by DBIA #1976
 ;Reference to ^PSRX(    supported by DBIA #1977
 ;Reference to ^PSOLSET  supported by DBIA #1973
 ;Reference to EN^PSOHLSN1 supported by DBIA #2385
 ;
 Q:'$G(PSXVER)
 D:'$D(PSOPAR) ^PSOLSET I '$D(PSOPAR) G END
START W !!,"Select a date range to see all CMOP batches that have printed from suspense",!,"within that date range."
BEG K ^TMP($J,"PSXRESP"),^TMP($J,"PSXRESPR"),^UTILITY($J,"PSXREPT"),PSXOUT,DTOUT
 W ! K %DT S %DT="AEX",%DT("A")="START DATE: " D ^%DT K %DT G:Y<0!($D(DTOUT)) END S (%DT(0),BDT)=Y W ! S %DT="AEX",%DT("A")="END DATE: " D ^%DT K %DT G:Y<0!($D(DTOUT)) END S ENDDATE=Y
 S BDT=BDT-.0001,ENDDATE=ENDDATE+.9999,RECNT=1 W !!,"Gathering batches, please wait...",! H 1
 F ZZZ=BDT:0 S ZZZ=$O(^PS(52.5,"APR",ZZZ)) Q:'ZZZ!(ZZZ>ENDDATE)  F XXX=0:0 S XXX=$O(^PS(52.5,"APR",ZZZ,XXX)) Q:'XXX  F MMM=0:0 S MMM=$O(^PS(52.5,"APR",ZZZ,XXX,MMM)) Q:'MMM  D
 .I MMM=$G(PSOSITE) S ^TMP($J,"PSXRESP",RECNT,ZZZ,XXX,MMM)="",RECNT=RECNT+1,^TMP($J,"PSXZRST",ZZZ)=""
 I '$D(^TMP($J,"PSXRESP")) W $C(7),!!,"There are no CMOP printed batches found for that date range!",! G BEG
 H 1 W @IOF W !?1,"BATCH",?10,"PRINTED ON:",?40,"PRINTED BY:",?56,$E($P($G(^PS(59,PSOSITE,0)),"^"),1,23),! F AA=1:1:78 W "-"
 W ! F AAA=0:0 S AAA=$O(^TMP($J,"PSXRESP",AAA)) Q:'AAA!($G(PSXOUT))  S PSIDATE=$O(^TMP($J,"PSXRESP",AAA,0)),XDUZ=$O(^TMP($J,"PSXRESP",AAA,PSIDATE,0)) D
 .S Y=PSIDATE X ^DD("DD") S PSXDT=Y,PSXU=$S($D(^VA(200,XDUZ,0)):$P($G(^(0)),"^"),1:"UNKNOWN") D:($Y+5)>IOSL  Q:$G(PSXOUT)  W !?2,AAA,?10,PSXDT,?40,PSXU
 ..W ! K DIR S DIR(0)="E" D ^DIR K DIR S:'Y PSXOUT=1 I Y W @IOF W !?1,"BATCH",?10,"PRINTED ON:",?40,"PRINTED BY:",?56,$E($P($G(^PS(59,PSOSITE,0)),"^"),1,23),! F AA=1:1:78 W "-"
 I $G(PSXOUT),Y="" G END
 S RECNT=RECNT-1,PSXOUT=0 W ! K DIR S DIR("A")="Select Batch(s) to "_$S($G(PSXFLAG)=1:"reset",$G(PSXFLAG)=2:"reprint",1:""),DIR(0)="L^1:"_RECNT D ^DIR K DIR
 I Y["^"!($D(DTOUT))!($D(DUOUT)) W !!?3,$S($G(PSXFLAG)=1:"Nothing to Reset!",1:"Nothing queued to print!"),! G START
 ;currently only checking Y, not Y(0),Y(1), etc. if list>245
 S COUNT=1 F ZZ=1:1:$L(Y) S ZZZ=$E(Y,ZZ) I ZZZ="," S COUNT=COUNT+1
 S COUNT=COUNT-1 F JJ=1:1:COUNT S RR=$P(Y,",",JJ),^TMP($J,"PSXRESPR",RR)=""
 W !!,"Batches selected for "_$S($G(PSXFLAG)=1:"Reset",1:"Reprint")_" are:",! F ZZZ=0:0 S ZZZ=$O(^TMP($J,"PSXRESPR",ZZZ)) Q:'ZZZ  D
 .S PSIDATE=$O(^TMP($J,"PSXRESP",ZZZ,0)),XDUZ=$O(^TMP($J,"PSXRESP",ZZZ,PSIDATE,0)) S Y=PSIDATE X ^DD("DD") S PSXDT=Y,PSXU=$S($D(^VA(200,XDUZ,0)):$P($G(^(0)),"^"),1:"UNKNOWN")
 .W !,"Batch ",ZZZ," Printed on ",PSXDT," by ",PSXU
 W ! K DIR S DIR(0)="Y",DIR("B")="N",DIR("A")="Before "_$S($G(PSXFLAG)=1:"Resetting",1:"Queuing")_" would you like a list of these prescriptions" D ^DIR K DIR
 I Y["^"!($D(DTOUT)) W !!?3,$S($G(PSXFLAG)=1:"Nothing to Reset!",1:"Nothing queued to print!"),! G START
 I Y D LIST I $G(PSXOUT) G BEG
 G:$G(PSXFLAG)=1 TRANS
 G:$G(PSXFLAG)=2 QUE^PSXSRP
 Q
TRANS K DIR,Y,X S DIR(0)="Y",DIR("B")="NO",DIR("A")="Reset for Transmission" D ^DIR K DIR I Y="^"!($D(DTOUT))!($G(Y)<1) W !!,"Nothing Reset for Transmission!",! G START
 K TSK D OPTSTAT^XUTMOPT("PSXR SCHEDULED NON-CS TRANS",.TSK)
 S ATM=$P($G(TSK(1)),U,2),ATM=$$FMTE^XLFDT(ATM)
 K BCT,PDT,USR,DIV,SEQ,REC,RXN,CNT,DTTM,COM,JJ,RFCNT,RF,Y
 S BCT=0 D NOW^%DTC S RSDT=$$FMTE^XLFDT(%,"1") K %
 F  S BCT=$O(^TMP($J,"PSXRESPR",BCT)) Q:BCT'>0  S PDT="" F  S PDT=$O(^TMP($J,"PSXRESP",BCT,PDT)) Q:'PDT  S USR=0 F  S USR=$O(^TMP($J,"PSXRESP",BCT,PDT,USR)) Q:USR'>0  S DIV=0 F  S DIV=$O(^TMP($J,"PSXRESP",BCT,PDT,USR,DIV)) Q:DIV'>0  D TRANS1
 K BCT,PDT,USR,DIV,RSDT
 I $G(ATM)'="" W !,"Next auto transmission scheduled for "_$G(ATM)
 W !,"To transmit now use the Print from Suspense option, Initiate a CMOP Transmission"
 K AUTOREC,ATM
 ;the next two lines are commented out to, if specs change back to the
 ;way version 1 works just uncomment these two lines and the user will
 ;be prompted to do a transmission now
 ;K DIR,Y,X S DIR(0)="Y",DIR("B")="NO",DIR("A")="DO YOU WANT TO TRANSMIT TO CMOP NOW" D ^DIR K DIR I Y["^"!($D(DTOUT))!($D(DIROUT))!($D(DIRUT))!($G(Y)=0) G END
 ;I $G(Y)>0 G BEGIN^PSXRSUS
 Q
TRANS1 Q:'$D(^PS(52.5,"APR",PDT,USR,DIV))
 K DIE,DR
 S SEQ=0,DIE="^PS(52.5,",DR="3////Q" F  S SEQ=$O(^PS(52.5,"APR",PDT,USR,DIV,SEQ)) Q:SEQ'>0  S REC=0 F  S REC=$O(^PS(52.5,"APR",PDT,USR,DIV,SEQ,REC)) Q:REC'>0  D
 .S RXN=$P($G(^PS(52.5,REC,0)),"^"),$P(^PSRX(RXN,"STA"),"^",1)=5 D EN^PSOHLSN1(RXN,"SC","ZS","CMOP Rx Reset to Transmit")
 .D NOW^%DTC S DTTM=%,COM="CMOP Rx Reset to Transmit"
 .S CNT=0 F JJ=0:0 S JJ=$O(^PSRX(RXN,"A",JJ)) Q:'JJ  S CNT=JJ
 .S RFCNT=0 F RF=0:0 S RF=$O(^PSRX(RXN,1,RF)) Q:'RF  S RFCNT=RF S:RF>5 RFCNT=RF+1
 .S CNT=CNT+1,^PSRX(RXN,"A",0)="^52.3DA^"_CNT_"^"_CNT
LOCK52 .L +^PSRX(RXN):DTIME G:'$T LOCK52 S ^PSRX(RXN,"A",CNT,0)=DTTM_"^S^"_USR_"^"_RFCNT_"^"_COM L -^PSRX(RXN)
LOCK525 .S DA=REC L +^PS(52.5,REC):DTIME G:'$T LOCK525 S DR="3////Q" D ^DIE
 .K ^PS(52.5,"ADL",$E($P(^PS(52.5,REC,0),"^",8),1,7),REC)
 .S ^PS(52.5,REC,"P")=0,$P(^PS(52.5,REC,0),"^",8)="",$P(^(0),"^",9)="",$P(^(0),"^",11)=""
 .K ^PS(52.5,"APR",PDT,USR,DIV,SEQ,REC)
 .L -^PS(52.5,REC)
 .K RXN,DA,CNT,DTTM,COM,JJ,RFCNT,RF,%
 W !,"Batch ",$G(BCT)," Reset by ",$P(^VA(200,DUZ,0),"^")," on ",$G(RSDT)
 K SEQ,REC
 Q
END K ^TMP($J,"PSXRESPR"),^UTILITY($J,"PSXREPT"),%DT,%ZIS,AA,AAA,BDT,COUNT,DUOUT,DTOUT,ENDDATE,GG,INRX,JJ,LLL,MMM,NNN,POP,PSIDATE,PSXDT,XDUZ,PSXDEV,TIME,PSXREP,PSXU
 K PSRDATE,PSRDIV,PSRDUZ,RECNT,REDT,REDUZ,RR,SS,XXX,ZZ,ZZZ,ZZZ,ZZZZ,PSXFLAG D ^%ZISC Q
LIST F LLL=0:0 S LLL=$O(^TMP($J,"PSXRESPR",LLL)) Q:'LLL!($G(PSXOUT))  D
 .W ! S DIR(0)="E" D ^DIR K DIR S:'Y PSXOUT=1 Q:$G(PSXOUT)  D HEAD S REDT=$O(^TMP($J,"PSXRESP",LLL,0)),REDUZ=$O(^TMP($J,"PSXRESP",LLL,REDT,0)) F SS=0:0 S SS=$O(^PS(52.5,"APR",REDT,REDUZ,PSOSITE,SS)) Q:'SS!($G(PSXOUT))  D
 ..F GG=0:0 S GG=$O(^PS(52.5,"APR",REDT,REDUZ,PSOSITE,SS,GG)) Q:'GG!($G(PSXOUT))  D:($Y+5)>IOSL HEADONE Q:$G(PSXOUT)  I $D(^PS(52.5,GG,0)),$P($G(^(0)),"^",6)=PSOSITE S INRX=$P(^(0),"^") I $D(^PSRX(INRX,0)) D
 ...W !,$P(^PSRX(INRX,0),"^"),?20,$P($G(^DPT(+$P(^PSRX(INRX,0),"^",2),0)),"^"),?60,$S($P($G(^PS(52.5,GG,0)),"^",5):"(PARTIAL)",$P($G(^(0)),"^",12):"(REPRINT)",1:"")
 I $G(PSXOUT),(Y="") Q
 S PSXOUT=0 I Y'=0 W !,"END OF LIST"
 Q
HEAD W @IOF W !,"RX #",?20,"PATIENT NAME",?60,"BATCH ",LLL,! F ZZZZ=1:1:78 W "-"
 Q
HEADONE S DIR(0)="E" D ^DIR K DIR I 'Y S PSXOUT=1 Q
 W @IOF W !,"RX #",?20,"PATIENT NAME",?60,"BATCH ",LLL,! F ZZZZ=1:1:78 W "-"
 Q
