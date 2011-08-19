PXRMXSD ; SLC/PJH - Reminder Reports DIR Prompts; 06/05/2009
 ;;2.0;CLINICAL REMINDERS;**4,12**;Feb 04, 2005;Build 73
 ;
BED(YESNO) ;Option to sort by inpatient location and bed
 N DIR,X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA"
 S DIR("A")="Sort by Inpatient Location/Bed: "
 S DIR("B")="N"
 S DIR("?")="Enter Y or N. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMXHLP(11)"
 W !
 D ^DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S YESNO=$E(Y(0))
 I YESNO="Y" S YESNO="B"
 Q
 ;
COMB(YESNO,LIT,DEF) ;Option to combine report
 N DIR,X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA"
 S DIR("A")="Combined report for all "_LIT_" : "
 S DIR("B")=DEF
 S DIR("?")="Enter Y or N. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMXHLP(9)"
 W !
 D ^DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S YESNO=$E(Y(0))
 Q
 ;
DELIMSEL() ;Select DELIMITER CHARACTER
 N X,Y,DC,DIR
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="S"_U_"C:Comma;"
 S DIR(0)=DIR(0)_"M:Semicolon;"
 S DIR(0)=DIR(0)_"L:Tilde;"
 S DIR(0)=DIR(0)_"S:Space;"
 S DIR(0)=DIR(0)_"T:Tab;"
 S DIR(0)=DIR(0)_"U:Up arrow;"
 S DIR("A")="Specify REPORT DELIMITER CHARACTER"
 S DIR("B")="U"
 S DIR("?")="Select from the codes displayed. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMXHLP(14)"
 D ^DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q ""
 S DC=$S(Y="C":",",Y="M":";",Y="L":"~",Y="S":" ",Y="T":$C(9),Y="U":"^",1:"^")
 Q DC
 ;
FUTURE(YESNO,PROMPT,NUM) ;Option to display all future appointments on detail report
 N DIR,X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA"
 S DIR("A")=PROMPT
 S DIR("B")="N"
 S DIR("?")="Enter Y or N. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMXHLP("_NUM_")"
 W !
 D ^DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S YESNO=$E(Y(0))
 Q
 ;
PREV(TYPE) ;Future Appts/Prior Encounters selection
 N X,Y,DIR
 S NREM=0
 K DIROUT,DIRUT,DTOUT,DUOUT
 I 'PXRMINP D
 .S DIR(0)="S"_U_"P:Previous Encounters;"
 .S DIR(0)=DIR(0)_"F:Future Appointments;"
 .S DIR("A")="PREVIOUS ENCOUNTERS OR FUTURE APPOINTMENTS"
 .S DIR("B")="P"
 .S DIR("??")=U_"D HELP^PXRMXHLP(3)"
 I PXRMINP D
 .S DIR(0)="S"_U_"A:Admissions to Location in date range;"
 .S DIR(0)=DIR(0)_"C:Current Inpatients;"
 .S DIR("A")="CURRENT INPATIENTS OR ADMISSIONS"
 .S DIR("B")="C"
 .S DIR("??")=U_"D HELP^PXRMXHLP(7)"
 S DIR("?")="Select from the codes displayed. For detailed help type ??"
 D ^DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S TYPE=Y
 Q
 ;
PRIME(TYPE) ;Primary Provider patients only or All
 N X,Y,DIR
 S NREM=0
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="S"_U_"P:Primary care assigned patients only;"
 S DIR(0)=DIR(0)_"A:All patients on list;"
 S DIR("A")="PRIMARY CARE ONLY OR ALL"
 S DIR("B")="P"
 S DIR("?")="Select from the codes displayed. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMXHLP(4)"
 D ^DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S TYPE=Y
 Q
 ;
REP(TYPE) ;Report type selection
 N X,Y,DIR
 S NREM=0
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="S"_U_"D:Detailed;"
 S DIR(0)=DIR(0)_"S:Summary;"
 S DIR("A")="TYPE OF REPORT"
 S DIR("B")="S"
 I PXRMSEL="I" S DIR("B")="D"
 S DIR("?")="Select from the codes displayed. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMXHLP(2)"
 D ^DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S TYPE=Y
 Q
 ;
SELECT(TYPE) ;Patient Sample Selection
 N X,Y,DIR
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="S"_U_"I:Individual Patient;"
 S DIR(0)=DIR(0)_"R:Reminder Patient List;"
 S DIR(0)=DIR(0)_"L:Location;"
 S DIR(0)=DIR(0)_"O:OE/RR Team;"
 S DIR(0)=DIR(0)_"P:PCMM Provider;"
 S DIR(0)=DIR(0)_"T:PCMM Team;"
 S DIR("A")="PATIENT SAMPLE"
 S DIR("B")="L"
 S DIR("?")="Select from the codes displayed. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMXHLP(0)"
 D ^DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S TYPE=Y
 Q
 ;
SEPCS(PXRMCCS) ;Allow users to determine the output of the Clinic Stops report
 N DIR,TEXT,X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S PXRMCCS=""
 I PXRMREP="S",PXRMTOT="T" Q
 ;PXRMLCSC only defined if report is by Clinic Stops.
 I $P($G(PXRMLCSC),U)'="CS" Q
 S TEXT="C:Report by Clinic Stops Only;"
 I PXRMREP="S" S TEXT=TEXT_"B:Report by Clinic Stops and Individual Clinic(s);"
 S TEXT=TEXT_"I:Report by Individual Clinic(s)"
 S DIR(0)="S"_U_TEXT
 S DIR("A")="Clinic Stops output"
 S DIR("B")="C"
 D ^DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S PXRMCCS=Y
 Q
 ;
SRT(YESNO) ;Option to sort by next appointment date on detail report
 N DIR,X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA"
 S DIR("A")="Sort by Next Appointment date: "
 S DIR("B")="N"
 S DIR("?")="Enter Y or N. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMXHLP(6)"
 W !
 D ^DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S YESNO=$E(Y(0))
 Q
 ;
SSN(YESNO) ;Option to print full SSN.
 N DIR,X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA"
 S DIR("A")="Print full SSN: "
 I $P($G(^PXRM(800,1,"FULL SSN")),U)="Y" S DIR("B")="Y"
 E  S DIR("B")="N"
 S DIR("?")="Enter Y or N. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMXHLP(12)"
 W !
 D ^DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S YESNO=$E(Y(0))
 Q
 ;
TABS(YESNO) ;Option print compressed report
 N DIR,X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA"
 S DIR("A")="Print delimited output only: "
 S DIR("B")="N"
 S DIR("?")="Enter Y or N. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMXHLP(13)"
 W !
 D ^DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S YESNO=$E(Y(0))
 Q
 ;
TOTALS(TYPE,LIT1,LIT2,LIT3) ;Totals Selection
 N X,Y,DIR
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="S"_U_"I:"_LIT1_";"
 S DIR(0)=DIR(0)_"R:"_LIT2_";"
 S DIR(0)=DIR(0)_"T:"_LIT3_";"
 S DIR("A")="REPORT TOTALS"
 S DIR("B")="I"
 S DIR("?")="Select from the codes displayed. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMXHLP(10)"
 D ^DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S TYPE=Y
 Q
