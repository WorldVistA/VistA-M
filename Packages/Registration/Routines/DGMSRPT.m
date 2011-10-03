DGMSRPT ;ALB/LBD - Military Service Inconsistency Report; 01/05/04
 ;;5.3;Registration;**562,603**; Aug 13,1993
 ;
EN ; Called from DG MS INCONSISTENCIES RPT option
 ; Prompt user to select to run extract or print report
 N DGSEL
 S DGSEL=$$SEL Q:'DGSEL
 S DGSEL="SEL"_DGSEL
 G @DGSEL
 Q
 ;
SEL() ; Select action: Extract or Print
 ; INPUT: None
 ; OUTPUT: 1=Extract; 2=Print; 0=Quit
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 W !!,"Military Service Data Inconsistencies Report"
 W !,"============================================"
 S DIR(0)="S^1:Extract and Count Inconsistencies;2:Print Inconsistencies Detail Report"
 S DIR("A")="Enter 1 or 2"
 S DIR("?",1)="(1) Extract and Count Inconsistencies - selecting this option will queue a"
 S DIR("?",2)="    process to read through the Patient file and find records with"
 S DIR("?",3)="    inconsistent military service data.  The inconsistencies will be"
 S DIR("?",4)="    totaled by category in the Military Service Data Inconsistencies Volume"
 S DIR("?",5)="    Report that will be sent as a mail message to the DGEN ELIGIBILITY ALERT"
 S DIR("?",6)="    mail group.  This process must be run before the detail report can"
 S DIR("?",7)="    be printed, and can be rerun as necessary."
 S DIR("?",8)=""
 S DIR("?",9)="(2) Print Inconsistencies Detail Report - selecting this option will"
 S DIR("?",10)="    produce a detail report of the inconsistencies found for"
 S DIR("?",11)="    individual veterans.  The report can be sorted by veteran name"
 S DIR("?",12)="    or SSN (terminal digits)."
 S DIR("?")=" "
 D ^DIR I 'Y!($D(DTOUT))!($D(DUOUT)) Q 0
 Q Y
 ;
SEL1 ; Extract and count military service data inconsistencies from Patient
 ; file #2
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 I '$$CHK W ! S DIR(0)="E" D ^DIR Q
 W !!
 S DIR(0)="Y",DIR("A")="Queue Extract",DIR("B")="NO"
 D ^DIR K DIR Q:'Y!($D(DTOUT))!($D(DUOUT))
 K ^XTMP("DGMSRPT")
 D EXTQUE
 W ! S DIR(0)="E" D ^DIR
 Q
SEL2 ; Print detail report of military service data inconsistencies
 ; extracted and stored in ^XTMP("DGMSRPT",
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,DGTOT,DGBEG,DGEND,DGSRT
 I $P($G(^XTMP("DGMSRPT","DATE")),U,2)="" D  Q
 .W !!,*7,"*** The Extract of Military Service Data Inconsistencies must be run"
 .W !,"    before the report can be printed."
 .W ! S DIR(0)="E" D ^DIR
 I '$$CHK W ! S DIR(0)="E" D ^DIR Q
 I +$G(^XTMP("DGMSRPT","MSINC","CNT","VET"))=0 W !!,*7,"There are no records to print.",! S DIR(0)="E" D ^DIR Q
 W !!
 S DIR(0)="Y",DIR("A")="Print Report",DIR("B")="YES"
 D ^DIR K DIR Q:'Y!($D(DTOUT))!($D(DUOUT))
 S DGTOT=+$G(^XTMP("DGMSRPT","MSINC","CNT","VET"))
 W !!,"Total veteran records to print: ",DGTOT
 S DGBEG=$$BEG(DGTOT) Q:'DGBEG
 S DGEND=$$END(DGBEG,DGTOT) Q:'DGEND
 S DGSRT=$$SRT Q:DGSRT=""
 D RPTQUE
 Q
CHK() ; Check if extract can be tasked to run
 ; INPUT: None
 ; OUTPUT: 1=Run Extract; 0=Don't run Extract
 N CHK S CHK=1
 I $G(^XTMP("DGMSRPT","RUNNING")) D  Q CHK
 .N ZTSK
 .S ZTSK=^XTMP("DGMSRPT","RUNNING") D STAT^%ZTLOAD
 .I ZTSK(1)=1!(ZTSK(1)=2) W !!,*7,"*** Extract is currently running or queued as task ",^XTMP("DGMSRPT","RUNNING") S CHK=0
 I $P($G(^XTMP("DGMSRPT","DATE")),U,2)'="" W !!,"Extract was last run ",$P(^XTMP("DGMSRPT","DATE"),U,2)
 Q CHK
 ;
BEG(TOT) ; Get starting record number to print
 ; INPUT: TOT - Total number of veteran records to print
 ; OUTPUT: Y - Starting record number
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 I '$G(TOT) Q 0
 S DIR(0)="NA^1:"_TOT,DIR("A")="Print from record: ",DIR("B")=1
 D ^DIR I 'Y!($D(DTOUT))!($D(DUOUT)) Q 0
 Q Y
END(BEG,TOT) ; Get ending record number to print
 ; INPUT:  BEG - Starting record number to print
 ;         TOT - Total number of veteran records to print
 ; OUTPUT: Y - Ending record number
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 I '$G(BEG),'$G(TOT) Q 0
 S DIR(0)="NA^"_BEG_":"_TOT,DIR("A")="      to record: ",DIR("B")=DGTOT
 D ^DIR I 'Y!($D(DTOUT))!($D(DUOUT)) Q 0
 Q Y
SRT() ; Get sort order
 ; OUPUT: Y - Sort (N=Name; S=SSN)
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="SA^N:Name;S:SSN (Terminal digits)",DIR("A")="Sort report by Name or SSN (Terminal digits): ",DIR("B")="NAME"
 S DIR("?",1)="Indicate whether the report should be sorted by the"
 S DIR("?")="Veteran's Name or the terminal digits of the Veteran's SSN"
 D ^DIR I $D(DTOUT)!($D(DUOUT)) Q ""
 Q Y
 ;
EXTQUE ; Queue extract task
 N ZTRTN,ZTDESC,ZTSK,ZTIO,ZTDTH,DIR
 S ZTRTN="EN^DGMSRPT1",ZTIO="",ZTDTH=""
 S ZTDESC="Extract Military Service Inconsistencies"
 D ^%ZTLOAD
 I $G(ZTSK) D  Q
 .S ^XTMP("DGMSRPT","RUNNING")=ZTSK
 .W !,"Extract queued as task ",ZTSK
 .W !!,"When the process is completed a message containing the Military Service Data"
 .W !,"Inconsistencies Volume Report will be sent to mail group DGEN ELIGIBILITY ALERT.",!
 W !,*7,"Extract could not be queued!"
 Q
 ;
RPTQUE ; Get report device. Queue report if requested.
 N POP,ZTRTN,ZTDESC,ZTSAVE,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 K IOP,%ZIS
 S %ZIS="MQ"
 W !
 D ^%ZIS I POP W !!,*7,"Report Cancelled!",! S DIR(0)="E" D ^DIR Q
 I $D(IO("Q")) D  Q
 .S ZTRTN="EN^DGMSRPT2(DGBEG,DGEND,DGSRT)"
 .S ZTDESC="Print Military Service Inconsistencies Report"
 .S (ZTSAVE("DGBEG"),ZTSAVE("DGEND"),ZTSAVE("DGSRT"))=""
 .D ^%ZTLOAD
 .W !!,"Report "_$S($D(ZTSK):"Queued!",1:"Cancelled!")
 .W ! S DIR(0)="E" D ^DIR
 .D HOME^%ZIS
 D EN^DGMSRPT2(DGBEG,DGEND,DGSRT)
 D ^%ZISC
 Q
 ;
MSG(DGXTMP) ; Send message with counts of inconsistencies when extract completes.
 ;INPUT:  DGXTMP - ^XTMP global reference
 N DGMSG,XMDUZ,XMSUB,XMTEXT,XMY,LN,SUB,SITE
 S:$G(DGXTMP)="" DGXTMP="^XTMP(""DGMSRPT"",""MSINC"")"
 S SITE=$P($$SITE^VASITE,U,3) S:SITE="" SITE="UNKNOWN"
 S XMDUZ="STATION #"_SITE
 I $$GET1^DIQ(869.3,"1,",.03,"I")'="P" S XMDUZ=XMDUZ_" [TEST]"
 S XMSUB="MILITARY SERVICE DATA INCONSISTENCIES VOLUME REPORT"
 S (XMY(DUZ),XMY("G.DGEN ELIGIBILITY ALERT"),XMY("HECDQSUPPORT@MED.VA.GOV"))="",XMTEXT="DGMSG("
 S DGMSG(1)="The extract of Military Service data inconsistencies has completed"
 S DGMSG(2)="successfully."
 S DGMSG(3)=""
 S DGMSG(4)="Extract process started: "_$P($G(^XTMP("DGMSRPT","DATE")),U,1)
 S DGMSG(5)="Extract process ended:   "_$P($G(^XTMP("DGMSRPT","DATE")),U,2)
 S DGMSG(6)=""
 S DGMSG(7)="Total Veterans with MS Data Inconsistencies: "_+@DGXTMP@("CNT","VET")
 S DGMSG(8)=""
 S DGMSG(9)=$$LJ^XLFSTR("    INCONSISTENCY CATEGORY",55)_$$RJ^XLFSTR("TOTAL",20)
 S DGMSG(10)=$$LJ^XLFSTR("",79,"=")
 S LN=10,SUB=""
 F  S SUB=$O(@DGXTMP@("CNT",SUB)) Q:'SUB  S LN=LN+1,DGMSG(LN)=$$LJ^XLFSTR($P(^(SUB),U,2),55)_$$RJ^XLFSTR($P(^(SUB),U,1),20)
 D ^XMD
 Q
 ;
INIT ; Set variables and initialize array for counts
 S DGXTMP="^XTMP(""DGMSRPT"",""MSINC"")"
 S @DGXTMP@("CNT",2)="0^Branch of Service=B.E.C."
 S @DGXTMP@("CNT",3)="0^Branch of Service=Merchant Seaman, No WWII Service"
 S @DGXTMP@("CNT",4)="0^Military Service Episode Data Missing"
 S @DGXTMP@("CNT",5)="0^Military Service Episode Date Imprecise"
 S @DGXTMP@("CNT",6)="0^Military Service Episode End Date Before Start Date"
 S @DGXTMP@("CNT",7)="0^Military Service Episodes Overlap"
 S @DGXTMP@("CNT",8)="0^Combat Data Missing"
 S @DGXTMP@("CNT",9)="0^Combat Date Imprecise"
 S @DGXTMP@("CNT",10)="0^Combat Date Not Valid for Location"
 S @DGXTMP@("CNT",11)="0^Combat Date Not Within MSE"
 S @DGXTMP@("CNT",12)="0^Conflict Data Missing"
 S @DGXTMP@("CNT",13)="0^Conflict Date Imprecise"
 S @DGXTMP@("CNT",14)="0^Conflict Date Not Valid for Location"
 S @DGXTMP@("CNT",15)="0^Conflict Date Not Within MSE"
 S @DGXTMP@("CNT",16)="0^Prisoner of War Data Missing"
 S @DGXTMP@("CNT",17)="0^Prisoner of War Date Imprecise"
 S @DGXTMP@("CNT",18)="0^Prisoner of War Date Not Valid for Location"
 S @DGXTMP@("CNT",19)="0^Prisoner of War Date Not Within MSE"
 S @DGXTMP@("CNT","VET")="0^Number of Veterans with Inconsistent MS Data"
 Q
