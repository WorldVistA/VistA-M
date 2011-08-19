TIUPRPN7 ;SLC/MJC - Progress Notes Outpt Batch Prt ;6/26/01
 ;;1.0;TEXT INTEGRATION UTILITIES;**45,100,121**;Jun 20, 1997
 ;
BATCH ;batch print outpatient progress notes sorted by terminal digit
 ;if you wish to exlude a particular hospital location from this
 ;print option that can be specified in the
 ;EXCLUDE FROM BATCH PRINTING field of file 8925.93
 ;[TIU PRINT PN BATCH INTERACTIVE]
 ;
 N Y,TIUQT,TIUSTART,TIUDIV,ANS,LAST,DIV
 D SETUP^TIUPRPN3("Batch Print Outpatient Progress Notes by Terminal Digit")
 W !!?5,"Notes will be printed in terminal digit order."
 W !!?5,"This option may also be scheduled to run non-interactively"
 W !?5,"in file #19.2 OPTION SCHEDULING FILE.",!!
 ;
 I $D(^TIU(8925.94,0))'=1 W $C(7),$C(7),!?5,"Before using this option "
 I  W "you must enter the divisions for your site in"
 I  W !?5,"file #8925.94 - TIU DIVISION PRINT PARAMETERS FILE." Q
 ;
 S DIC=8925.94,DIC(0)="AEQMNZ",DIC("A")="Select DIVISION: "
 S DIC("B")=$P($G(^DG(40.8,+$G(^DISV(DUZ,"^TIU(8925.94,")),0),""),U)
 D ^DIC K DIC Q:Y<0
 S TIUDIV=+Y(0)_U_+Y_U_Y(0,0)
 ;ien medical center div^ien tiu param^external division
 S LAST=$P($G(^TIU(8925.94,+$P(TIUDIV,U,2),1)),U)
 I LAST']"" S TIUSTART=$$DATE^TIUPRPN4() Q:TIUSTART']""
 I LAST]"" D  Q:$D(TIUQT)
 .W !!,"Notes were last printed for '"_$P(TIUDIV,U,3)_"' "
 .W $$FMTE^XLFDT(LAST,"1P"),!
 .S ANS=$$READ^TIUU("YA","Print from this DATE/TIME on? ","YES","D HELP^TIUPRPN5")
 .I $D(DIRUT) S TIUQT=1 Q
 .I +$G(ANS) S TIUSTART=LAST Q
 .D 3^TIUPRPN5 S TIUSTART=$$DATE^TIUPRPN4() I TIUSTART']"" S TIUQT=1 Q
DEV S %ZIS("B")=$P($G(^%ZIS(1,+$P($G(^TIU(8925.94,$P(TIUDIV,U,2),1)),U,2),0),""),U) ;brings up default prter from 8925.94 param file
 W ! S %ZIS="Q" D ^%ZIS I POP K POP G EXIT
 I $E(IOST)="C" W $C(7),$C(7),!?5,"You must select a printer for this "
 I  W "option!!" G DEV
 S TIUDIV=+$P(TIUDIV,U,2)
 I $D(IO("Q")) K IO("Q") D  G EXIT
 .S ZTRTN="PRINT^TIUPRPN7",ZTSAVE("TIUSTART")="",ZTSAVE("TIUDIV")=""
 .S ZTDESC="TIU BATCH PRT PNS OUTPT DIV"
 .D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued!",1:"Request Canceled!")
 .K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,STSAVE,%ZIS,TIUSTART,TIUDIV
 .D HOME^%ZIS
 U IO D PRINT,^%ZISC
 Q
PRINT ;entry point for non-interactive tasked job
 ;requires TIUDIV set to the division you want notes for
 ;if queued non-interactively, file 8925.94- field #1.02 will need 
 ;to contain the start time of the batch
 ;[TIU PRINT PN BATCH SCHEDULED]- entry point if called from file #19.2
 ;
 I '$D(TIUDIV) D TROUBLE G EXIT
 N DATE,LOC,IFN,SSN,DFN,STOP,DIV
 K ^TMP("TIUREPLACE",$J),^TMP("TIUPR",$J),^TMP("TIULQ",$J)
 S STOP=$$NOW^XLFDT
 I '$D(TIUSTART) S TIUSTART=$P($G(^TIU(8925.94,TIUDIV,1)),U)
 Q:TIUSTART']""  ;date not passed/no date in field 1.01 file #8925.94
 S DIV=+$P($G(^TIU(8925.94,TIUDIV,0)),U)
 S LOC=0
 F  S LOC=$O(^TIU(8925,"ALOCP",LOC)) Q:'LOC  D
 .Q:+$$LOC(LOC,DIV)  S DATE=TIUSTART
 .F  S DATE=$O(^TIU(8925,"ALOCP",LOC,DATE)) Q:'DATE!(DATE>STOP)  D
 ..S IFN=0 F  S IFN=$O(^TIU(8925,"ALOCP",LOC,DATE,IFN)) Q:'IFN  D
 ...D REPLACE^TIUPRPN3(IFN,DATE,1501)
 S IFN=0 F  S IFN=$O(^TMP("TIUREPLACE",$J,IFN)) Q:'IFN  D
 .S DFN=$P(^TIU(8925,IFN,0),U,2),SSN=$P(^DPT(DFN,0),U,9)
 .S SSN=$E(SSN,8,9)_$E(SSN,6,7)_$E(SSN,4,5)_$E(SSN,1,3)
 .S DATE=^TMP("TIUREPLACE",$J,IFN,"DT")
 .S ^TMP("TIUPR",$J,SSN_";"_DFN,DATE,IFN)="Vice SF 509"
 I '$D(^TMP("TIUPR",$J)) D TROUBLE G EXIT
 D PRINT^TIUPRPN1(1,1)
 S $P(^TIU(8925.94,TIUDIV,1),U)=STOP
EXIT K ^TIU("TIUPR",$J),^TMP("TIULQ",$J),^TMP("TIUREPLACE",$J)
 Q
LOC(LOC,DIV) ;checks if this location should be batch prted
 N IEN
 S IEN=$O(^TIU(8925.93,"B",LOC,0))
 Q $S($P($G(^SC(LOC,0)),U,3)="W":1,$P($G(^SC(LOC,0)),U,15)'=DIV:1,'$D(^TIU(8925.93,+IEN,0)):"",+$G(^TIU(8925.93,IEN,3)):1,1:"")
 ;
TROUBLE ;message to print if no output
 W !!,"The option [TIU PRINT PN BATCH OUTPT] ran to completion at "
 W !,$$FMTE^XLFDT($$NOW^XLFDT,"1P")," but did not find any notes."
 W !!,"If you were expecting notes to print review the following:"
 ;
 W !!,"INTERACTIVE"
 W !,"-----------"
 W !,"1.  Very little can go wrong- the required criteria is screened"
 W !,"while the user is manually queueing the job."
 W !!,"2.  This option prints all the outpatient progress notes, in"
 W !,"terminal digit order, for the selected date range for ALL CLINICS"
 W !,"for the selected DIVISION.  Verify that you have signed progress"
 W !,"notes satisfying this criteria.",!
 ;
 W !!,"NON-INTERACTIVE (job set to run in OPTION SCHEDULING FILE (#19.2)"
 W !,"-----------------------------------------------------------------"
 W !,"1.  DIVISION must be defined in file #8925.94 (TIU DIVISION PRINT"
 W !,"PRINT PARAMETERS FILE)."
 W !!,"2.  The variable TIUDIV must be defined in the VARIABLE NAME "
 W !,"multiple of the OPTION SCHEDULING FILE (#19.2).  TIUDIV should"
 W !,"be set to the IEN of an entry in the TIU DIVISION PRINT PARAMETERS"
 W !,"FILE (#8925.94)."
 W !!,"3.  This option must find a valid date in field #1.01 of"
 W !,"file #8925.94 to start looping on.  If a valid date is not "
 W !,"found, the option will terminate with this message."
 W !!,"4.  To assist in troubleshooting, if no notes are found, the"
 W !,"DATE/TIME field (#1.01) of file #8925.94 will not be re-set"
 W !,"to the new value (which is NOW) when the option begins "
 W "calculating."
 Q
