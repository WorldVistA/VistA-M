YSD4E010 ;DALISC/MJD - DSM CONVERSION ERROR UTILITY ;3/22/94  [ 04/08/94  11:09 AM ]
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 QUIT
 ;
KILL ;KILL all error data stored
 ;
 W !!,"Killing global error data ......",!!
 K ^YSD(627.99,"AS","TE")
 QUIT
 ;
DE ;If data exists in ^YSD(627.99,"AS","TE",0), the value "1" will be
 ;passed back in the variable YSD4EDE, a "0" if no data exists
 I '$D(^YSD(627.99,"AS","TE",0)) D  QUIT  ;->
 .  S YSD4EDE=0
 S YSD4EDE=1
 QUIT
 ;
PED(YSD4EDT,YSD4ETXT,YSD4EFN,YSD4END,YSD4EIEN,YSD4EMIN,YSD4EQID) ;
 ;Patient Error Demographics is passed when a DSM conversion error
 ;is encountered;;;^YSD(627.99,"AS","TE",0) is set the first time entered
 ;
 ;  Called by YSD40030,31,32,40,41,42,50,51,52
 ;
 I '$D(^YSD(627.99,"AS","TE",0)) D
 .  D HDRN
 .  S (YSD4ECTR,YSD4EMR,YSD4EPN,YSD4EDR)=0
 S YSD4ECTR=$G(YSD4ECTR)+1
 S ^YSD(627.99,"AS","TE",YSD4ECTR)=$G(YSD4EDT)_U_$G(YSD4ETXT)_U_$G(YSD4EFN)_U_$G(YSD4END)_U_$G(YSD4EIEN)_U_$G(YSD4EMIN)_U_$G(YSD4EQID)
 ;
 I $G(YSD4EFN)>0 D
 .  S ^YSD(627.99,"AS","TE")=YSD4ECTR
 .  S:+YSD4EFN=90 YSD4EMR=$G(YSD4EMR)+1,$P(^YSD(627.99,"AS","TE","MR"),U)=YSD4EMR
 .  S:+YSD4EFN=627.8 YSD4EDR=$G(YSD4EDR)+1,$P(^YSD(627.99,"AS","TE","DR"),U)=YSD4EDR
 .  S:+YSD4EFN=121 YSD4EPN=$G(YSD4EPN)+1,$P(^YSD(627.99,"AS","TE","PN"),U)=YSD4EPN
 QUIT
 ;
INITSITE() ; Set YSD4SITE to Name of Institution
 K DIC S DIC=4,DR=".01;.02",DA=+$G(DUZ(2)),DIQ="YSD4E",DIQ(0)="E" D EN^DIQ1
 S YSD4ESTE=$P(YSD4E(4,+$G(DUZ(2)),.01,"E"),",")
 S YSD4SITE=""
 F YSD4I=1:1:$L(YSD4ESTE," ") D
 .  S YSD4S1=$E($P(YSD4ESTE," ",YSD4I),1)
 .  S YSD4S2=$$LOW^XLFSTR($E($P(YSD4ESTE," ",YSD4I),2,$L($P(YSD4ESTE," ",YSD4I))))
 .  S YSD4STE(YSD4I)=YSD4S1_YSD4S2
 .  S YSD4SITE=YSD4SITE_YSD4STE(YSD4I)_" "
 I $E(YSD4SITE,$L(YSD4SITE))=" " D
 .  S YSD4SITE=$E(YSD4SITE,1,$L(YSD4SITE)-1)
 QUIT YSD4SITE
 ;
HDRN ;Set ^YSD(627.99,"AS","TE",0)=create date^purge date^description^duz
 N YSD4E0,YSD4E,YSD4E1
 S YSD4E0=$H,YSD4E1=$$HADD^XLFDT(YSD4E0,7),^YSD(627.99,"AS","TE",0)=$$HTFM^XLFDT(YSD4E0,1)_U_$$HTFM^XLFDT(YSD4E1,1)_U_"MENTAL HEALTH V. 5.01 DSM CONVERSION ERROR LOG"_U_$P($G(^VA(200,DUZ,0)),U)
 S ^YSD(627.99,"AS","TE")=0
 S ^YSD(627.99,"AS","TE","MR")=0_U_90_U_"MEDICAL RECORD"
 S ^YSD(627.99,"AS","TE","PN")=0_U_121_U_"GENERIC PROGRESS NOTES"
 S ^YSD(627.99,"AS","TE","DR")=0_U_627.8_U_"DIAGNOSTIC RESULTS"
 QUIT
 ;
REP ;If DSM conversion errors exist the Total number of errors by file will
 ;be displayed to the screen, user will be prompted to print to a device
 ;
 ;  Called by YSD4DSM
 ;
 S YSD4EABT=0
 I '$D(^YSD(627.99,"AS","TE",0)) D  QUIT  ;->
 .   W !!,"No DSM conversion errors to report....",!!
 D SHDR
 D SD
 K DIR S DIR(0)="Y",DIR("A")="Print Errors",DIR("B")="Y"
 D ^DIR
 QUIT:+Y'>0  ;->
 S %ZIS="QM" D ^%ZIS G EXIT:POP
 I $D(IO("Q")) D  QUIT
 .  S ZTRTN="DQ^YSD4E010"
 .  F YSD4E1="YSD4EABT","YSD4ECNT","YSD4ECON","YSD4EL","YSD4EP","YSD4ERD","YSD4ESMD","YSD4ESME","YSD4ESTE"  D
 ..  S ZTSAVE(YSD4E1)=""
 .  S ZTDESC="Mental Health V. 5.01 DSM Conversion Error Report"
 .  S ZTIO=ION
 .  D ^%ZTLOAD
 .  D HOME^%ZIS K IO("Q")
 .  W !!,"Your Job has been Queued to "_ION_", job# ",ZTSK,"...",!!
 ;
DQ ;
 U IO
 D PROC^YSD4E020
 D ^%ZISC
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@" K ZTSK
 QUIT
 ;
SHDR ;Screen header for DSM Conversion Error reporting
 W @IOF,!,"DSM Conversion Error Totals",?35,$J($$INITSITE,45),!,$$REPEAT^XLFSTR("=",IOM),!!
 QUIT
 ;
SD ;Write error totals to the screen
 W "Error Summary:",?25,"Medical Record (#90) file errors:",?(IOM-12),$J($P($G(^YSD(627.99,"AS","TE","MR")),U),10)
 W !,?25,"Generic Progress Notes (#121) file errors:",?(IOM-12),$J($P($G(^YSD(627.99,"AS","TE","PN")),U),10)
 W !,?25,"Diagnostic Results (#627.8) file errors:",?(IOM-12),$J($P($G(^YSD(627.99,"AS","TE","DR")),U),10),!
 W ?25,$$REPEAT^XLFSTR("-",55),!
 W ?25,"Total number of errors:",?(IOM-12),$J($G(^YSD(627.99,"AS","TE")),10),!!!
 QUIT
 ;
EOR ;YSD4E010 - DSM CONVERSION ERROR UTILITY ;3/22/94
