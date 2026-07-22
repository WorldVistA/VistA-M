EHMDISCH ;ALB/WTC - EHRM - AUTOMATED PATIENT DISCHARGE TOOL; Jun 06, 2025@13:23:13
 ;;1.0;ELECTRONIC HEALTH MODERNIZATION;**15**;Apr 19, 2021;Build 14
 ;
 ;
 Q  ;
 ;
LIST ;
 ;
 ;  List patients eligible for discharge.  To be used at time of conversion to Millennium.
 ;
 N WARD,DFN,VADM,FIRST,PTNAME,SORTBY,INSTFLTR,DIR,Y,X,INSTUTN,IEN,INSTNAME,QUEUED,LINES,QUIT,STATION,POP,TXDTTM,NEWWARD,INCLHIST,WARDFLTR ;
 ;
 S INSTFLTR=$$INSTFLTR() Q:INSTFLTR=""  ;
 S WARDFLTR="" I $P(INSTFLTR,U,1)="S" S WARDFLTR=$$WARDFLTR($P(INSTFLTR,U,2)) ;
 ;
 S DIR(0)="S^WARD:Ward;PATIENT:Patient",DIR("A")="Sort by" D ^DIR Q:$D(DIRUT)  S SORTBY=Y ;
 ;
 K DIR ;
 S DIR(0)="Y",DIR("A")="Include transfer history",DIR("B")="NO" D ^DIR Q:$D(DIRUT)  S INCLHIST=Y ; 
 ;
 W !!,"Report is 160 columns wide",! ;
 S %ZIS="Q" D ^%ZIS I POP Q  ;
 ;
 ;  If report is queued, add to Taskman
 ;
 S QUEUED=0 I $D(IO("Q")) S QUEUED=1 D  Q  ;
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK ;
 . S ZTRTN="LIST1^EHMDISCH",ZTDESC="Patient Discharge List" ;
 . S ZTSAVE("*")="" ;
 . D ^%ZTLOAD W $S($D(ZTSK):"...Task queued",1:"...Task cancelled"),! ;
 ;
LIST1 ;  TaskMan start point
 ;
 I 'QUEUED,SORTBY="WARD" W !,"Sorting patients within ward..." ;
 I 'QUEUED,SORTBY="PATIENT" W !,"Sorting patients..." ;
 K ^TMP("EHMDISCH",$J) ;
 ;
 D BLDLIST(SORTBY,INSTFLTR,WARDFLTR,QUEUED) ;
 U IO ;
 ;
 I SORTBY="WARD" D  ;
 . S INSTUTN="",QUIT=0  F  S INSTUTN=$O(^TMP("EHMDISCH",$J,INSTUTN)) Q:INSTUTN=""  D  Q:QUIT  ;
 .. S INSTNAME=$P(INSTUTN,U,1),IEN=$P(INSTUTN,U,2),STATION=$$GET1^DIQ(4,IEN,99) D HEADER(INSTNAME,STATION,SORTBY) ;
 .. S WARD="",LINES=0 F  S WARD=$O(^TMP("EHMDISCH",$J,INSTUTN,WARD)) Q:WARD=""  D  Q:QUIT  ;
 ... S PTNAME="",FIRST=1 ;
 ... F  S PTNAME=$O(^TMP("EHMDISCH",$J,INSTUTN,WARD,PTNAME)) Q:PTNAME=""  Q:QUIT  S DFN=0 F  S DFN=$O(^TMP("EHMDISCH",$J,INSTUTN,WARD,PTNAME,DFN)) Q:'DFN  S X=^(DFN) D  S FIRST=0 Q:QUIT  ;
 .... ;
 .... I 'QUEUED D PAGINATE(.QUIT,INSTNAME,STATION,SORTBY,.LINES) Q:QUIT  ;
 .... ;
 .... W $S(FIRST:WARD,1:""),?32,PTNAME,?64,$$DATETIME($P(X,U,3)),?81,$P(X,U,2),?91,$P(X,U,4),?123,$P(X,U,5),! S LINES=LINES+1 ;
 .... Q:'INCLHIST  ;
 .... ;
 .... ; Transfers
 .... ;
 .... Q:$D(^TMP("EHMDISCH",$J,INSTUTN,WARD,PTNAME,DFN))<10  ;  No transfers
 .... ;
 .... S TXDTTM=0 F  S TXDTTM=$O(^TMP("EHMDISCH",$J,INSTUTN,WARD,PTNAME,DFN,TXDTTM)) Q:'TXDTTM  S X=^(TXDTTM) W ?10,$P(X,U,1),?25,$$DATETIME(TXDTTM),?42,$P(X,U,2),?74,$P(X,U,3),! S LINES=LINES+1 ;
 .... W ! S LINES=LINES+1 ;
 ... W ! ;
 .. ;
 .. I 'QUEUED,'QUIT S QUIT=$$CONTINUE()=0 ;
 ;
 I SORTBY="PATIENT" D  ;
 . S INSTUTN="",QUIT=0 F  S INSTUTN=$O(^TMP("EHMDISCH",$J,INSTUTN)) Q:INSTUTN=""  D  Q:QUIT  ;
 .. S INSTNAME=$P(INSTUTN,U,1),IEN=$P(INSTUTN,U,2),STATION=$$GET1^DIQ(4,IEN,99) D HEADER(INSTNAME,STATION,SORTBY) ;
 .. S PTNAME="",FIRST="",LINES=0 F  S PTNAME=$O(^TMP("EHMDISCH",$J,INSTUTN,PTNAME)) Q:PTNAME=""  D  Q:QUIT  ;
 ... I FIRST'=$E(PTNAME,1) W ! S LINES=LINES+1 ;
 ... S FIRST=$E(PTNAME,1) ;
 ... S DFN=0 F  S DFN=$O(^TMP("EHMDISCH",$J,INSTUTN,PTNAME,DFN)) Q:'DFN  S X=^(DFN) D  Q:QUIT  ;
 .... ;
 .... I 'QUEUED D PAGINATE(.QUIT,INSTNAME,STATION,SORTBY,.LINES) Q:QUIT  ;
 .... ;
 .... W PTNAME,?32,$P(X,U,2),?64,$$DATETIME($P(X,U,4)),?81,$P(X,U,3),?91,$P(X,U,5),?123,$P(X,U,6),! S LINES=LINES+1 ;
 .... Q:'INCLHIST  ;
 .... ;
 .... ; Transfers
 .... ;
 .... Q:$D(^TMP("EHMDISCH",$J,INSTUTN,PTNAME,DFN))<10  ;  No transfers
 .... ;
 .... S TXDTTM=0 F  S TXDTTM=$O(^TMP("EHMDISCH",$J,INSTUTN,PTNAME,DFN,TXDTTM)) Q:'TXDTTM  S X=^(TXDTTM) W ?10,$P(X,U,1),?25,$$DATETIME(TXDTTM),?42,$P(X,U,2),?74,$P(X,U,3),! S LINES=LINES+1 ;
 .... W ! S LINES=LINES+1 ;
 .. ;
 .. I 'QUEUED,'QUIT S QUIT=$$CONTINUE()=0 ;
 ;
 I QUIT W ! ;
 U 0 I 'QUEUED,IO=$I R !,"Press [RETURN] to continue",X:$G(DTIME,300) ;
 K ^TMP("EHMDISCH",$J) D ^%ZISC ;
 Q  ;
 ;
HEADER(INSTNAME,STATION,SORTBY) ;
 ;
 W @IOF,$$CENTER("Patient Discharge List - "_INSTNAME_" ("_STATION_")",IOM),?IOM-8,$$FMTE^XLFDT(DT,2),!! ;
 I SORTBY="WARD" D  ;
 . W "WARD",?32,"PATIENT",?64,"ADMIT DATE/TIME",?81,"ROOM/BED",?91,"DIAGNOSIS",?123,"ATTENDING PROVIDER",! ;
 . W $$DASHES(30),?32,$$DASHES(30),?64,$$DASHES(15),?81,$$DASHES(8),?91,$$DASHES(30),?123,$$DASHES(30),! ;
 ;
 I SORTBY="PATIENT" D  ;
 . W "PATIENT",?32,"WARD",?64,"ADMIT DATE/TIME",?81,"ROOM/BED",?91,"DIAGNOSIS",?123,"ATTENDING PROVIDER",! ;
 . W $$DASHES(30),?32,$$DASHES(30),?64,$$DASHES(15),?81,$$DASHES(8),?91,$$DASHES(30),?123,$$DASHES(30),! ;
 Q  ;
 ;
SUMMARY ;
 ;
 ;  Summary of patients eligible for discharge.  To be used at time of conversion to Millennium.
 ;
 N WARD,DFN,VADM,FIRST,PTNAME,INSTUTN,IEN,INSTNAME,ADMDTTM,QUEUED,LINES,QUIT,STATION,POP,TOTAL1,TOTAL2 ;
 ;
 W !,"Report is 80 columns wide",! ;
 S %ZIS="Q" D ^%ZIS I POP Q  ;
 ;
 ;  If report is queued, add to Taskman
 ;
 S QUEUED=0 I $D(IO("Q")) S QUEUED=1 D  Q  ;
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK ;
 . S ZTRTN="SUMMARY1^EHMDISCH",ZTDESC="Summary of Patients to be Discharged" ;
 . S ZTSAVE("*")="" ;
 . D ^%ZTLOAD W $S($D(ZTSK):"...Task queued",1:"...Task cancelled"),! ;
 ;
SUMMARY1 ;  TaskMan start point
 ;
 I 'QUEUED W !,"Sorting patients within ward..." ;
 K ^TMP("EHMDISCH",$J),^TMP("EHMDISCH",$J+.1) ;
 ;
 D BLDLIST("WARD","A",,QUEUED) ;
 U IO ;
 S INSTUTN="" ;
 F  S INSTUTN=$O(^TMP("EHMDISCH",$J,INSTUTN)) Q:INSTUTN=""  D  ;
 . S INSTNAME=$P(INSTUTN,U,1),IEN=$P(INSTUTN,U,2),STATION=$$GET1^DIQ(4,IEN,99) ;
 . S WARD="" F  S WARD=$O(^TMP("EHMDISCH",$J,INSTUTN,WARD)) Q:WARD=""  D  ;
 .. S PTNAME="" ;
 .. F  S PTNAME=$O(^TMP("EHMDISCH",$J,INSTUTN,WARD,PTNAME)) Q:PTNAME=""  S DFN=0 F  S DFN=$O(^TMP("EHMDISCH",$J,INSTUTN,WARD,PTNAME,DFN)) Q:'DFN  S ^(WARD)=$G(^TMP("EHMDISCH",$J+.1,INSTUTN,WARD))+1 ;
 ;
 W @IOF,$$CENTER("Summary of Patients to be Discharged",IOM),?IOM-8,$$FMTE^XLFDT(DT,2),!! ;
 W "INSTITUTION",?42,"WARD",?74,"COUNT",!,$$DASHES(40),?42,$$DASHES(30),?74,$$DASHES(6),! ;
 S INSTUTN="",TOTAL2=0 ;
 F  S INSTUTN=$O(^TMP("EHMDISCH",$J+.1,INSTUTN)) Q:INSTUTN=""  D  ;
 . S INSTNAME=$P(INSTUTN,U,1),IEN=$P(INSTUTN,U,2),STATION=$$GET1^DIQ(4,IEN,99) ;
 . W INSTNAME," (",STATION,")" ;
 . S WARD="",TOTAL1=0 F  S WARD=$O(^TMP("EHMDISCH",$J+.1,INSTUTN,WARD)) Q:WARD=""  W ?42,WARD,?74,$J(^(WARD),6),! S TOTAL1=TOTAL1+^(WARD) ;
 . W ?42,$$DASHES(30),?74,$$DASHES(6),! ;
 . W ?42,"TOTAL",?74,$J(TOTAL1,6),!! S TOTAL2=TOTAL2+TOTAL1 ;
 W ?42,"GRAND TOTAL",?74,$J(TOTAL2,6),! ;
 ;
 U 0 I 'QUEUED,IO=$I R !,"Press [RETURN] to continue",X:$G(DTIME,300) ;
 K ^TMP("EHMDISCH",$J),^TMP("EHMDISCH",$J+.1) D ^%ZISC ;
 ;
 Q  ;
 ;
DISCHARGE ;
 ;
 ;  Discharge eligible patients.  To be used at time of conversion to Millennium.
 ;
 N DSCWARD,DFN,VADM,FIRST,PTNAME,SORTBY,INSTFLTR,INSTUTN,IEN,INSTNAME,ADMDTTM,QUEUED,LINES,QUIT,STATION,POP,ROOMBED,WARDFLTR ;
 ;
 W !!,"*** This option automatically discharges eligible patients and processes all downstream discharge protocols. ***",! ;
 I $$CONTINUE("NO")'=1 Q  ;
 ;
 S INSTFLTR=$$INSTFLTR() Q:INSTFLTR=""  ;
 S WARDFLTR="" I $P(INSTFLTR,U,1)="S" S WARDFLTR=$$WARDFLTR($P(INSTFLTR,U,2)) ;
 ; 
 D BLDLIST("WARD",INSTFLTR,WARDFLTR,0) W ! ;
 ;
 S INSTUTN=""  F  S INSTUTN=$O(^TMP("EHMDISCH",$J,INSTUTN)) Q:INSTUTN=""  D  ;
 . S INSTNAME=$P(INSTUTN,U,1),IEN=$P(INSTUTN,U,2),STATION=$$GET1^DIQ(4,IEN,99) W !,"INSTITUTION (STA): ",INSTNAME," (",STATION,")",! ;
 . S DSCWARD="" F  S DSCWARD=$O(^TMP("EHMDISCH",$J,INSTUTN,DSCWARD)) Q:DSCWARD=""  D  ;
 .. S PTNAME="" W $$DASHES(80),!,DSCWARD ;
 .. F  S PTNAME=$O(^TMP("EHMDISCH",$J,INSTUTN,DSCWARD,PTNAME)) Q:PTNAME=""  S DFN=0 F  S DFN=$O(^TMP("EHMDISCH",$J,INSTUTN,DSCWARD,PTNAME,DFN)) Q:'DFN  S ROOMBED=$P(^(DFN),U,2),ADMDTTM=$P(^(DFN),U,3) D  ;
 ... ;
 ... W PTNAME,?32,$$DATETIME(ADMDTTM),?52,ROOMBED,! D ENTRY^EHMDGPMV(DFN) W !,$$DASHES(80),! ;
 ... ;
 ... ;  Mark incomplete record.
 ... ;
 ... D IRT(DFN,ADMDTTM) ;
 ;
 K ^TMP("EHMDISCH",$J) ;
 ;
 Q  ;
 ;
BLDLIST(SORTBY,INSTFLTR,WARDFLTR,QUEUED) ;
 ;
 ;  Build sorted list of patients to be discharged in ^TMP("EHMDISCH",$J).
 ;
 ;  INSTFLTR = "A" if all institutions are included or "S^ien" if a single institution included.  "ien" points to file #4.
 ;  SORTBY   = "WARD" or "PATIENT"
 ;  QUEUED   = 1 if report is queued, 0 otherwise.
 ;
 N WARD,IEN,INSTUTN,INSTNAME,DFN,ADMPTR,VADM,VAIN,VAIP,IDX,TRANSFER,WARDTO ;
 ;
 K ^TMP("EHMDISCH",$J) S WARD="" F  S WARD=$O(^DPT("CN",WARD)) Q:WARD=""  D  ;
 . I $G(WARDFLTR)'="" Q:$P(^SC(WARDFLTR,0),U,1)'=WARD  ;
 . S IEN=$O(^SC("B",WARD,0)) Q:'IEN  S INSTUTN=$P($G(^SC(IEN,0)),U,4) Q:'INSTUTN  I $P(INSTFLTR,U,1)="S" Q:$P(INSTFLTR,U,2)'=INSTUTN  ;
 . S INSTNAME=$P(^DIC(4,INSTUTN,0),U,1) ;
 . W:'QUEUED "." S DFN=0 F  S DFN=$O(^DPT("CN",WARD,DFN)) Q:'DFN  S ADMPTR=^(DFN) D  ;
 .. ;
 .. K VADM D DEM^VADPT ;
 .. K VAIN D INP^VADPT ;
 .. K VAIP D IN5^VADPT ;
 .. ;
 .. ; Patient movement pointer (#405) ^ Room/Bed ^ Admission Date/Time ^ Admitting Diagnosis ^ Attending Provider's Name
 .. ;
 .. I SORTBY="WARD" S ^TMP("EHMDISCH",$J,INSTNAME_U_INSTUTN,WARD,VADM(1),DFN)=ADMPTR_U_VAIN(5)_U_$P(VAIN(7),U,1)_U_VAIN(9)_U_$P(VAIN(11),U,2) D  Q  ;
 ... ;
 ... ;  Transfers
 ... ;
 ... F IDX=13:1:17 Q:VAIP(IDX,1)=""  S ^TMP("EHMDISCH",$J,INSTNAME_U_INSTUTN,WARD,VADM(1),DFN,$P(VAIP(IDX,1),U,1))=$P(VAIP(IDX,2),U,2)_U_$P(VAIP(IDX,4),U,2)_U_VAIP(9) ;
 .. ;
 .. ; Patient movement pointer (#405) ^ Ward ^ Room/Bed ^ Admission Date/Time ^ Admitting Diagnosis ^ Attending Provider's Name
 .. ;
 .. I SORTBY="PATIENT" S ^TMP("EHMDISCH",$J,INSTNAME_U_INSTUTN,VADM(1),DFN)=ADMPTR_U_WARD_U_VAIN(5)_U_$P(VAIN(7),U,1)_U_VAIN(9)_U_$P(VAIN(11),U,2) D  Q  ;
 ... ;
 ... ;  Transfers
 ... ;
 ... F IDX=13:1:17 Q:VAIP(IDX,1)=""  S ^TMP("EHMDISCH",$J,INSTNAME_U_INSTUTN,VADM(1),DFN,$P(VAIP(IDX,1),U,1))=$P(VAIP(IDX,2),U,2)_U_$P(VAIP(IDX,4),U,2)_U_VAIP(9) ;
 Q  ;
 ;
POSTLIST ;
 ;
 ;  List patients discharged at conversion.  To be used at time of or after conversion to Millennium.
 ;
 N DFN,VADM,PTNAME,DSCDTTM,QUEUED,POP,X,LINES,QUIT ;
 ;
 ;
 W !,"Report is 80 columns wide",! ;
 S %ZIS="Q" D ^%ZIS I POP Q  ;
 ;
 ;  If report is queued, add to Taskman
 ;
 S QUEUED=0 I $D(IO("Q")) S QUEUED=1 D  Q  ;
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK ;
 . S ZTRTN="POSTLIST1^EHMDISCH",ZTDESC="Patients Discharged at Conversion List" ;
 . S ZTSAVE("*")="" ;
 . D ^%ZTLOAD W $S($D(ZTSK):"...Task queued",1:"...Task cancelled"),! ;
 ;
POSTLIST1 ;  TaskMan start point
 ;
 K ^TMP("EHMDISCH",$J) S DSCDTTM="" F  S DSCDTTM=$O(^DPT("ACERNER",DSCDTTM)) Q:'DSCDTTM  S DFN=0 F  S DFN=$O(^DPT("ACERNER",DSCDTTM,DFN)) Q:'DFN  D  ;
 . W:'QUEUED "." ;
 . ;
 . K VADM D DEM^VADPT ;
 . S ^TMP("EHMDISCH",$J,VADM(1),DFN)=DSCDTTM ;
 ;
 U IO ;
 ;
 D POSTHDR ;
 S PTNAME="",QUIT=0,LINES=0 F  S PTNAME=$O(^TMP("EHMDISCH",$J,PTNAME)) Q:PTNAME=""  D  Q:QUIT  ;
 . S DFN=0 F  S DFN=$O(^TMP("EHMDISCH",$J,PTNAME,DFN)) Q:'DFN  S DSCDTTM=^(DFN) D  Q:QUIT  ;
 .. ;
 .. ;  If report displayed on screen, stop when screen full and prompt user to continue or stop.
 .. ;
 .. U 0 ;
 .. I IO=$I,LINES'<(IOSL-7) S QUIT=$$CONTINUE()=0 Q:QUIT  U IO D POSTHDR S LINES=1 ;
 .. ;
 .. ;  New page header for printed report
 .. ;
 .. I LINES'<IOSL U IO D POSTHDR S LINES=1 ;
 .. ;
 .. U IO W PTNAME,?32,$$DATETIME(DSCDTTM),! S LINES=LINES+1 ;
 ;
 I QUIT W ! ;
 U 0 I 'QUEUED,IO=$I R !,"Press [RETURN] to continue",X:$G(DTIME,300) ;
 K ^TMP("EHMDISCH",$J) D ^%ZISC ;
 Q  ;
 ;
POSTHDR ;
 ;
 W @IOF,$$CENTER("Patients Discharged at Conversion",IOM),?IOM-8,$$FMTE^XLFDT(DT,2),! ;
 W !,"Patient Name",?32,"Date/Time Discharged",!,$$DASHES(30),?32,$$DASHES(20),! ;
 Q  ;
 ;
PAGINATE(QUIT,INSTNAME,STATION,SORTBY,LINES) ;
 ;
 ;  If report displayed on screen, stop when screen full and prompt user to continue or stop.
 ;
 U 0 ;
 I IO=$I Q:LINES<(IOSL-7)  S QUIT=$$CONTINUE()=0 Q:QUIT  U IO D HEADER(INSTNAME,STATION,SORTBY) S LINES=1 Q  ;
 ;
 ;  New page header for printed report
 ;
 I LINES'<IOSL U IO D HEADER(INSTNAME,STATION,SORTBY) S LINES=1 ;
 Q  ;
 ;
CENTER(TEXT,WIDTH) ;
 ;
 ;  Return centered text.
 ;
 N CENTERED ;
 S CENTERED=$J("",WIDTH-$L(TEXT)/2)_TEXT ;
 Q CENTERED ;
 ;
DASHES(COUNT) ;
 ;
 N I,DASHES S DASHES="" F I=1:1:COUNT S DASHES=DASHES_"-" ;
 Q DASHES ;
 ;
CONTINUE(DEFAULT) ;
 ;
 ;  Prompt user to continue or quit.
 ;
 ;  DEFAULT - Default answer (YES or NO) - optional.  YES assumed.
 ;
 N DIR,Y,DIRUT,X,Y ;
 S DIR(0)="Y",DIR("A")="Continue",DIR("B")=$S($G(DEFAULT)'="":DEFAULT,1:"YES") D ^DIR ; 
 I $D(DIRUT) Q 0 ;
 Q Y ;
 ;
DATETIME(X) ;
 ;
 ;  Returns date and time in HH/MM/YY HH:MM format (zero-filled if required)
 ;
 N DATE,TIME,I,PC,HH,MM ;
 S DATE=$P(X,".",1),TIME=$P(X,".",2)_"0000" ;
 S DATE=$$FMTE^XLFDT(DATE,2) F I=1:1:3 S PC=$P(DATE,"/",I) S:PC<10 PC="0"_(+PC) S $P(DATE,"/",I)=PC ;
 S HH=$E(TIME,1,2),MM=$E(TIME,3,4),TIME=HH_":"_MM ;
 Q DATE_" "_TIME ;
 ;
INSTFLTR() ;
 ;
 ;  Enter institution filter.
 ;
 N DIR,DIC,X,Y,INSTFLTR ;
 ;
 S DIR(0)="SO^A:All;S:Selected",DIR("A")="Institutions",DIR("B")="All" D ^DIR Q:$D(DIRUT) "" S INSTFLTR=Y ;
 ;
 I INSTFLTR="S" D  ;
 . ;
 . ;  Select institution to include.
 . ;
 . K DIC S DIC=4,DIC(0)="AEQM",DIC("A")="Institution: ",DIC("S")="I $$INSTSCRN^EHMDISCH(Y)" D ^DIC ;
 . ;K DIC S DIC=4,DIC(0)="AEQM",DIC("A")="Institution: ",DIC("S")="I 1" D ^DIC ;
 . I $D(DIRUT) S INSTFLTR="" Q  ;
 . I Y=-1 S INSTFLTR="" Q  ;
 . S INSTFLTR="S^"_Y ;
 ;
 Q INSTFLTR ;
 ;
INSTSCRN(IEN4) ;
 ;
 ;  Screen institutions for the VistA instance only.
 ;
 I $$GET1^DIQ(4,IEN4,99)=$P($$SITE^VASITE(),U,3) Q 1 ;
 ;
 N IEN1,OK,IEN S OK=0,IEN1=0 ;
 F  S IEN1=$O(^DIC(4,IEN4,7,IEN1)) Q:'IEN1  I $P($G(^(IEN1,0)),U,1)=2 S IEN=$P(^(0),U,2) I IEN,$$GET1^DIQ(4,IEN,99)=$P($$SITE^VASITE(),U,3) S OK=1 Q  ;
 ;
 Q OK ;
 ;
WARDFLTR(INSTUTN) ;
 ;
 ;  Enter ward filter
 ;
 N DIC,X,Y,WARDFLTR ;
 ;
 S DIC=44,DIC(0)="AEQM",DIC("S")="I $P(^(0),U,4)=INSTUTN,$P(^(0),U,3)=""W""" D ^DIC S WARDFLTR=+Y ;
 I WARDFLTR<0 S WARDFLTR="" ;
 Q WARDFLTR ;
 ;
IRT(DFN,ADMDTTM) ;
 ;
 ;  Mark INCOMPLETE RECORDS (file #393) entries COMPLETED for a patient being discharged.
 ;
 ;  Note:  Should be only one discharge summary entry in #393 per admission.
 ;
 N IEN,PTMVMT,TYPE,DIE,DR,DA ;
 ;
 S IEN=0 F I=1:1 S IEN=$O(^VAS(393,"B",DFN,IEN)) Q:'IEN  S PTMVMT=$P($G(^VAS(393,IEN,0)),U,4),TYPE=$P($G(^VAS(393,IEN,0)),U,2) D  ;
 . Q:'PTMVMT  Q:$$GET1^DIQ(405,PTMVMT,.01,"I")'=ADMDTTM  ;
 . Q:'TYPE  Q:$$GET1^DIQ(393,IEN,.02)'="DISCHARGE SUMMARY"  ;
 . ;
 . ;  Mark COMPLETED
 . ;
 . K DIE,DR S DA=IEN,DR=".11////COMPLETED",DIE=^DIC(393,0,"GL") D ^DIE ;
 ;
 Q  ;
 ;
