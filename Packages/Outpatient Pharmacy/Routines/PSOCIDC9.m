PSOCIDC9 ;BIR/LE - continuation of activity log corrections ;2/28/05 12:50pm
 ;;7.0;OUTPATIENT PHARMACY;**239,250**;DEC 1997
 ;
RPT ;
 N JOBN,NAMSP,ZTDESC,ZTRTN,ZTQUEUED,ZTREQ
 S NAMSP=$$NAMSP^PSOCIDC7
 S JOBN="CIDC ACTIVITY LOG CORRECTION"
 L +^XTMP(NAMSP):0 I '$T D  Q
 .W !,JOBN_" job for PSO*7*239 is still running.  Halting..."
 L -^XTMP(NAMSP)
 W !!,"This report reflects all prescriptions where the activity and"
 W !,"copay activity logs were corrected.  For detailed information,"
 W !,"please view the activity and copay logs on the prescriptions."
 ;
 W !!,"You may queue the report to print, if you wish.",!
 ;
DVC ;
 K %ZIS,POP,IOP S %ZIS="QM" D ^%ZIS I $G(POP) W !!,"Nothing queued to print.",! G DONE
QUEUE ;
 I $D(IO("Q")) S ZTRTN="START^PSOCIDC9",ZTDESC=JOBN_" CIDC Activity Logs Corrections" D ^%ZTLOAD K %ZSI W !,"Report queued to print.",! G DONE
START ;
 U IO
 N BLDT,RXO,NAMSP,PSOFILL,PSODFN,PSONAM,PSOOUT,PSODV,RXP,SSN,PSODIV,PSODV
 N CANCEL,JOBN,PSOPATID,PSOTOT
 S NAMSP=$$NAMSP^PSOCIDC7
 ;****************************************************** for testing only - next line
 S JOBN="CIDC ACTIVITY LOGS CORRECTION"
 S PSOOUT=0,PSODV=$S($E(IOST)="C":"C",1:"P")
 S PSOPGCT=0,PSOPGLN=IOSL-7,PSOPGCT=1
 S BLDT=$P($G(^XTMP(NAMSP,0,"LAST")),"^",2)
 I '$D(DT) S DT=$$NOW^XLFDT
 D TITLE
 S (PSOTOT,PSONAM)=""
 F  S PSONAM=$O(^XTMP(NAMSP,"LOG",PSONAM)) Q:PSONAM=""  D
 .S PSODFN=""
 .F  S PSODFN=$O(^XTMP(NAMSP,"LOG",PSONAM,PSODFN)) Q:PSODFN=""  D
 ..S RXP=""
 ..F  S RXP=$O(^XTMP(NAMSP,"LOG",PSONAM,PSODFN,RXP)) Q:RXP=""  D
 ...D FULL Q:$G(PSOOUT)  S PSONAME=$P($G(^DPT(PSODFN,0)),"^"),PSOTOT=PSOTOT+1
 ...W !,$E(PSONAME,1,14)
 ...D PRTSSN
 ...S RXO=$P($G(^PSRX(RXP,0)),"^")
 ...W ?41," ",RXO  ;," (",PSOFILL,")"
 W:PSOTOT'="" !,"Total number of prescriptions modified: ",PSOTOT
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
 . W !,"Patch PSO*7*239 - Corrected Activity and Copay Activity logs",!!
 . W "Note that this report reflects all prescriptions where the activity and/or",!
 . W "copay activity logs were corrected. For detailed information, please view",!
 . W "the activity and copay activity log on the prescription.",!
 ;
 S Y=DT X ^DD("DD") W !,"Date printed: ",Y,?70,"Page: ",PSOPGCT,!
 F MJT=1:1:79 W "="
 ;W !?55,"Updated",?67,"Updated"
 ;W !,?55,"Activity",?67,"COPAY"
 W !,"PATIENT NAME     (SSN)       DIV",?42,"RX# " ;,?55,"Log",?67,"Activity Log"   ;,?55,"RELEASE DATE",?69,"REL   BILL"
 W !,"---------------  -------  --------------",?42,"------------"
 ;W ?55,"------------",?67,"-----------"
 S PSOPGCT=PSOPGCT+1
 Q
 ;
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
 ;------
LOCKED ;LIST OF LOCKED RX'S
 N JOBN,NAMSP,ZTDESC,ZTRTN,ZTQUEUED,ZTREQ,PSODV
 S NAMSP=$$NAMSP^PSOCIDC7
 S JOBN="CIDC ACTIVITY LOG CORRECTION - LOCKED PRESCRIPTIONS"
 L +^XTMP(NAMSP):0 I '$T D  Q
 .W !,JOBN_" job for PSO*7*239 is still running.  Halting..."
 L -^XTMP(NAMSP)
 W !!,"This report reflects all prescriptions where the activity and",!
 W "copay activity logs could not be corrected due to the Rx being locked."
 ;
 W !!,"You may queue the report to print, if you wish.",!
 ;
DVC2 ;
 K %ZIS,POP,IOP S %ZIS="QM" D ^%ZIS I $G(POP) W !!,"Nothing queued to print.",! G DONE
QUEUE2 ;
 I $D(IO("Q")) S ZTRTN="START2^PSOCIDC9",ZTDESC=JOBN_" CIDC Activity Logs Corrections - Locked Rx's" D ^%ZTLOAD K %ZSI W !,"Report queued to print.",! G DONE
START2 ;
 U IO
 N BLDT,NAMSP,PSODFN,PSONAM,PSONAME,PSOOUT,PSODV,RXP,SSN,PSODIV,PSOPGCT,PSOOUT
 N CANCEL,JOBN,PSOPATID,PSOTOT,PSONCNT,PSORXN
 S NAMSP=$$NAMSP^PSOCIDC7
 S JOBN="CIDC ACTIVITY LOGS CORRECTION - Locked Rx report"
 S (PSOPGCT,PSONCNT,PSOOUT)=0,PSODV=$S($E(IOST)="C":"C",1:"P")
 S PSOPGLN=IOSL-7,PSOPGCT=1,RXP=""
 S BLDT=$P($G(^XTMP(NAMSP,0,"LAST")),"^",2)
 I '$D(DT) S DT=$$NOW^XLFDT
 D TITLE2
 F  S RXP=$O(^XTMP(NAMSP,0,"LOCKED RX",RXP)) Q:RXP=""  D
 . D FULL2 Q:$G(PSOOUT)
 . S PSONCNT=PSONCNT+1
 . S (DFN,PSODFN)=$P($G(^PSRX(RXP,0)),"^",2),PSORXN=$P($G(^PSRX(RXP,0)),"^")
 . S (PSONAME,PSONAM)=$P($G(^DPT(PSODFN,0)),"^") W !,$E(PSONAME,1,14)
 . D PRTSSN
 . W ?41," ",PSORXN
 . W:^XTMP(NAMSP,0,"LOCKED RX",RXP)'="" ?60,"CORRECTED"
 W !!,"Total number of prescriptions locked: ",PSONCNT,!
 G END
 Q
 ;
FULL2 ;
 I ($Y+7)>IOSL&('$G(PSOOUT)) D TITLE2
 Q
 ;
TITLE2 ;
 I $G(PSODV)="C",$G(PSOPGCT)'=1 W ! K DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSOOUT=1 Q
 ;
 W @IOF D
 . W !,"Patch PSO*7*239 - Locked Prescription Number Report",!!
 . W "Note that this report reflects all prescriptions where the activity and/or",!
 . W "copay activity logs could not be corrected. For detailed information,",!
 . W "please view the activity and copay activity log on the prescription.",!
 . W !!,"Note that FIXONE^PSOCIDC9 can be run from programmer's mode"
 . W !,"to correct individual prescriptions.",!!
 ;
 S Y=DT X ^DD("DD") W !,"Date printed: ",Y,?70,"Page: ",PSOPGCT,!
 F MJT=1:1:79 W "="
 ;
 W !,"PATIENT NAME     (SSN)       DIV",?42,"RX# "
 W !,"---------------  -------  --------------",?42,"------------"
 S PSOPGCT=PSOPGCT+1
 Q
 ;
FIXONE ;FIX LOCKED RX'S
 N RXP,SEQ,CSEQ,PSOMSG,PSONTIM,PSOCHECK,FIXONE,PSOFONE,NAMSP
 W @IOF D
 . W !,"This function is used to correct individual prescriptions that were locked"
 . W !,"during the CIDC Activity Log clean-up process.  It verifies whether the"
 . W !,"prescription needs to be corrected, and if so corrects it.  If the Rx still"
 . W !,"cannot be locked for correction, a message stating such will be displayed."
 . W !,"Otherwise, a message stating that no correction is needed will be displayed.",!
 . W !,"For detailed information please view the activity and copay activity log on"
 . W !,"the prescription.  For a listing of locked Rx's, type D LOCKED^PSOCIDC9 at"
 . W !,"the programmer's prompt.",!
 ;
FIX2 ;
 S (PSOMSG,PSONTIM,FIXONE,PSOFONE)=""
 K DIC
 W ! S DIC="^PSRX(",DIC(0)="QEA" D ^DIC Q:Y<0
 S RXP=+Y,(DFN,PSODFN)=$P($G(^PSRX(RXP,0)),"^",2),PSONAM=$P($G(^DPT(PSODFN,0)),"^")
 W !,"For Patient: ",PSONAM
 S (PSOCHECK,SEQ,CSEQ)=0,NAMSP=$$NAMSP^PSOCIDC7
 I $D(^PSRX(RXP,"A",0)) F  S SEQ=$O(^PSRX(RXP,"A",SEQ)) Q:SEQ=""  I $G(^PSRX(RXP,"A",SEQ,0))["BKGD CIDC" S PSOCHECK=1
 I $D(^PSRX(RXP,"COPAY",0)) F  S CSEQ=$O(^PSRX(RXP,"COPAY",CSEQ)) Q:CSEQ=""  I $G(^PSRX(RXP,"COPAY",CSEQ,0))["BKGD CIDC" S PSOCHECK=1
 I 'PSOCHECK W !!,"No changes are needed for this prescription.",! G FIX2
 S FIXONE=1 D CHECK^PSOCIDC8
 I '$G(PSOFONE) W !,"Activity logs corrected.",!! S ^XTMP("PSOCIDC7",0,"LOCKED RX",RXP)=DUZ_"^"_$H
 G FIX2
 Q
