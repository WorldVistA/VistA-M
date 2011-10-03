PSOCIDC3 ;BIR/LE - continuation of Copay Correction of erroneous billed copays ;11/08/05 1:56pm
 ;;7.0;OUTPATIENT PHARMACY;**226**;DEC 1997
 ;
RPT ;
 N JOBN,NAMSP,ZTDESC,ZTRTN
 S NAMSP=$$NAMSP^PSOCIDC1
 S JOBN="Copay Corrections"
 L +^XTMP(NAMSP):0 I '$T D  Q
 .W !,JOBN_" job for PSO*7*226 is still running.  Halting..."
 L -^XTMP(NAMSP)
 W !!,"This report shows the patient name and prescription information for"
 W !,"copay field corrections and copays billed erroneously that were cancelled"
 W !,"by the patch PSO*7*226."
 ;
 W !!,"You may queue the report to print, if you wish.",!
 ;
DVC K %ZIS,POP,IOP S %ZIS="QM" D ^%ZIS I $G(POP) W !!,"Nothing queued to print.",! G DONE
QUEUE I $D(IO("Q")) S ZTRTN="START^PSOCIDC3",ZTDESC=JOBN_" copay cancellation report" D ^%ZTLOAD K %ZSI W !,"Report queued to print.",! G DONE
START ;
 U IO
 N BLDT,RXO,NAMSP,PSOFILL,PSODFN,PSONAM,PSOOUT,PSODV,RXP,SSN,PSODIV,PSODV
 N CANCEL,JOBN,PSOPATID,PSOTOT,PSOTOTC
 S NAMSP=$$NAMSP^PSOCIDC1
 S JOBN="Copay Corrections"
 S PSOOUT=0,PSODV=$S($E(IOST)="C":"C",1:"P")
 S PSOPGCT=0,PSOPGLN=IOSL-7,PSOPGCT=1
 S BLDT=$P($G(^XTMP(NAMSP,0,"LAST")),"^",2)
 I '$D(DT) S DT=$$NOW^XLFDT
 D TITLE
 S (PSOTOT,PSOTOTC,PSONAM)=""
 F  S PSONAM=$O(^XTMP(NAMSP,"REL",PSONAM)) Q:PSONAM=""  D
 .S PSODFN=""
 .F  S PSODFN=$O(^XTMP(NAMSP,"REL",PSONAM,PSODFN)) Q:PSODFN=""  D
 ..S RXP=""
 ..F  S RXP=$O(^XTMP(NAMSP,"REL",PSONAM,PSODFN,RXP)) Q:RXP=""  D
 ...S PSOFILL=""
 ...F  S PSOFILL=$O(^XTMP(NAMSP,"REL",PSONAM,PSODFN,RXP,PSOFILL)) Q:PSOFILL=""  D
 ....N XX,RXO,Y,PSONAME
 ....S XX=$G(^XTMP(NAMSP,"REL",PSONAM,PSODFN,RXP,PSOFILL)) D   ;NOTE THIS IS THE RELEASE DATE
 .....D FULL Q:$G(PSOOUT)  S PSONAME=$P($G(^DPT(PSODFN,0)),"^")
 .....S CANCEL="" I $D(^XTMP(NAMSP,"CANCEL",PSODFN,RXP,PSOFILL)) D CHK S:CANCEL PSOTOTC=PSOTOTC+1
 .....W !,$S(CANCEL:"*",1:"") W:CANCEL $E(PSONAME,1,14) W:'CANCEL ?1,$E(PSONAME,1,14)
 .....D PRTSSN
 .....S RXO=$P($G(^PSRX(RXP,0)),"^")
 .....W ?41," ",RXO," (",PSOFILL,")"
 .....S Y=XX I Y>0 X ^DD("DD")
 .....W ?55," ",Y
 .....W ?69,$S($$PTCOV^IBCNSU3(PSODFN,XX,"PHARMACY"):"YES",1:" NO")
 .....W ?75,$S($$PTCOV^IBCNSU3(PSODFN,BLDT,"PHARMACY"):"YES",1:" NO")
 .....S PSOTOT=PSOTOT+1
 W !!,"Total number of released prescriptions modified: ",PSOTOT
 W !,"Total number of Cancelled Copay prescriptions: ",PSOTOTC
 ;
 ;UNRELEASED CORRECTED RX'S
 D TITLE2
 S (PSOTOT,PSONAM)=""
 F  S PSONAM=$O(^XTMP(NAMSP,"IBQ UPD",PSONAM)) Q:PSONAM=""  D
 .S PSODFN=""
 .F  S PSODFN=$O(^XTMP(NAMSP,"IBQ UPD",PSONAM,PSODFN)) Q:PSODFN=""  D
 ..S RXP=""
 ..F  S RXP=$O(^XTMP(NAMSP,"IBQ UPD",PSONAM,PSODFN,RXP)) Q:RXP=""  D
 ...S PSOFILL=""
 ...F  S PSOFILL=$O(^XTMP(NAMSP,"IBQ UPD",PSONAM,PSODFN,RXP,PSOFILL)) Q:PSOFILL=""  D
 ....N XX,RXO,Y,PSONAME
 ....S XX=$G(^XTMP(NAMSP,"IBQ UPD",PSONAM,PSODFN,RXP,PSOFILL)) D  ;NOTE THIS IS THE FILL DATE
 .....D FULL Q:$G(PSOOUT)  S PSONAME=$P($G(^DPT(PSODFN,0)),"^")
 .....W !,$E(PSONAME,1,14)
 .....D PRTSSN
 .....S RXO=$P($G(^PSRX(RXP,0)),"^")
 .....W ?41," ",RXO," (",PSOFILL,")"
 .....S Y=XX I Y>0 X ^DD("DD")
 .....W ?55," ",Y
 .....W ?69,$S($$PTCOV^IBCNSU3(PSODFN,XX,"PHARMACY"):"YES",1:" NO")
 .....W ?75,$S($$PTCOV^IBCNSU3(PSODFN,BLDT,"PHARMACY"):"YES",1:" NO")
 .....S PSOTOT=PSOTOT+1
 W !!,"Total number of un-released prescriptions modified: ",PSOTOT
 G END
 ;
FULL ;
 I ($Y+7)>IOSL&('$G(PSOOUT)) D TITLE
 Q
 ;
CHK ;VERIFY COPAY WAS CANCELLED
 N IBN,PSOREF,PSOIB,XX S PSOREF=PSOFILL
 I PSOREF=0 S XX=$G(^PSRX(RXP,"IB")),IBN=$P(XX,"^",2)
 I PSOREF>0 S XX=$G(^PSRX(RXP,1,PSOREF,"IB")),IBN=$P(XX,"^",1)
 S XX=$$STATUS^IBARX(IBN)
 S:$G(XX)=2 CANCEL=1
 Q
 ;
TITLE ;
 I $G(PSODV)="C",$G(PSOPGCT)'=1 W ! K DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSOOUT=1 Q
 ;
 W @IOF D
 . W !,"Patch PSO*7*226 -Corrected Released Prescriptions "
 . W !!,"Note that prescriptions where copay was cancelled are denoted with"
 . W !,"an asterisk (*) in front of the patient name.  Otherwise, only  the"
 . W !,"the IBQ node was updated.",!
 S Y=DT X ^DD("DD") W !,"Date printed: ",Y,?70,"Page: ",PSOPGCT,!
 F MJT=1:1:79 W "="
 W !,?69,"INS ON DTE"
 W !,"PATIENT NAME     (SSN)       DIV",?42,"RX# (FILL)",?55,"RELEASE DATE",?69,"REL   BILL"
 W !,"---------------  -------  --------------",?42,"------------"
 W ?55,"------------",?69,"---- -----"
 S PSOPGCT=PSOPGCT+1
 Q
TITLE2 ;
 I $G(PSODV)="C",$G(PSOPGCT)'=1 W ! K DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSOOUT=1 Q
 ;
 W @IOF D
 . W !,"Patch PSO*7*226 -Corrected Unreleased Prescriptions "
 S Y=DT X ^DD("DD") W !,"Date printed: ",Y,?70,"Page: ",PSOPGCT,!
 F MJT=1:1:79 W "="
 W !,?69,"INS ON DTE"
 W !,"PATIENT NAME     (SSN)       DIV",?43,"RX# (FILL)",?55,"FILL DATE",?69,"REL   BILL"
 W !,"--------------  -------  ----------------",?42,"------------"
 W ?55,"------------",?69,"---- -----"
 S PSOPGCT=PSOPGCT+1
 Q
END ;
 I '$G(PSOOUT),$G(PSODV)="C" W !!,"** End of Report **" K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $G(PSODV)="C" W !
 E  W @IOF
DONE ;
 K MJT,PSOPGCT,PSOPGLN,Y,DIR,X,IOP,POP,IO("Q"),DIRUT,DUOUT,DTOUT
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
PRTSSN ;
 S SSN=$P(^DPT(PSODFN,0),"^",9),SSN=$E(SSN,$L(SSN)-3,$L(SSN))
 S PSOPATID=$E(PSONAM,1)_SSN
 S PSODIV=$P($G(^PSRX(RXP,2)),"^",9)
 S:PSODIV'="" PSODIV=$P($G(^PS(59,PSODIV,0)),"^",1)
 W ?17,"("_PSOPATID_")"_"  "_$E(PSODIV,1,15)
 Q
 ;
ETIME(SECTIME) ;convert seconds to day:hr:min:sec
 N DAY,HR,MIN,SEC,ETIM
 S (DAY,HR,MIN,SEC)=""
 I SECTIME>86400 S DAY=SECTIME\86400,SECTIME=SECTIME#86400
 I SECTIME>3600 S HR=SECTIME\3600,SECTIME=SECTIME#3600
 I SECTIME>60 S MIN=SECTIME\60,SECTIME=SECTIME#60
 S SEC=SECTIME
 S ETIM=""
 S:$L(HR)=1 HR=0_HR S:$L(MIN)=1 MIN=0_MIN S:$L(SEC)=1 SEC=0_SEC
 S:DAY ETIM=DAY_" Day " S:HR ETIM=ETIM_HR_":" S:MIN ETIM=ETIM_MIN
 S ETIM=ETIM_":"_SEC
 Q ETIM
 ;
MAIL3(MSG) ;management mail message
 S PSOINST=$P($G(^DIC(4,+$P($G(^XMB(1,1,"XUS")),"^",17),99)),"^")
 D NOW^%DTC S Y=% D DD^%DT S PSOEND=Y
 K PSOTEXT
 S XMY(DUZ)=""
 S XMY("ELLZEY.LINDA@FORUM.VA.GOV")=""
 S:$$PROD^XUPROD(1) XMY("ELLZEY.LINDA@FORUM.VA.GOV")=""
 S XMDUZ="PSO*7*226 "_JOBN
 S XMSUB="STATION "_$G(PSOINST)
 S XMSUB=XMSUB_$S($$PROD^XUPROD(1):" (Prod)",1:" (Test)")
 S XMSUB=XMSUB_" CANCELLED COPAYS FOR ERRONEOUSLY BILLED PRESCRIPTION FILLS"
 S PSOTEXT(1)=""
 S PSOTEXT(2)="Started "_PSOSTART
 S PSOTEXT(3)=""
 S PSOTEXT(4)="   "_MSG
 S PSOTEXT(5)=""
 S PSOTEXT(6)="NO FURTHER ACTION REQUIRED."
 S XMTEXT="PSOTEXT(" N DIFROM D ^XMD K XMDUZ,XMTEXT,XMSUB
 Q
 ;
