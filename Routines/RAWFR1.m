RAWFR1 ;HISC/GJC-'Wasted Film Report' (1 of 4) ;4/15/96  07:22
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
 ;                     *** Variable List ***
 ; ------------------ Validate Rad/Nuc Med User -------------------------
 I '($D(RACCESS)\10) D SETVARS^RAPSET1(0) S RAPSTX=""
 I '($D(RACCESS)\10) D ACCVIO^RAUTL19,KILL^RAWFR3 Q
 ; ----------------------------------------------------------------------
 K ^TMP($J,"RA WFR") S RATDAY=$$FMTE^XLFDT($$NOW^XLFDT,1)
 S RADATE=$$FMTE^XLFDT($$NOW^XLFDT\1,1),RAXIT=0
 K X,Y,Z S X="Radiology/Nuclear Med" W @IOF
 S Y="*** Wasted Film Report ***",$P(Z,"-",($L(Y)+1))=""
 W !?(IOM-$L(X)\2),X,!?(IOM-$L(Y)\2),Y,!?(IOM-$L(Z)\2),Z,!
 K DIR,X,Y,Z
 S DIR("A")="Do you wish to generate a summary report only"
 S DIR("?",1)="Enter 'Y' to generate a general summary report by division."
 S DIR("?")="Enter <CR> or 'No' to generate a detailed divisional report."
 S DIR("B")="No",DIR(0)="Y" D ^DIR K DIR
 I $D(DIRUT) D  D KILL^RAWFR3 Q
 . W !?5,$C(7),"The 'Summary Report' question must be answered to"
 . W !?5,"continue on with the 'Wasted Film Report'."
 . Q
 S RASYN=+Y W !
DIVITY ; Select division/imaging type
 S X=$$DIVLOC^RAUTL7()
 I X D KILL^RAWFR3 Q
 I $D(RACCESS(DUZ,"DIV-IMG")) D
 . D ZEROUT^RAWFR4
 . Q
 E  D KILL^RAWFR3 Q
 ;                  *** Start of Exam Status display ***
 D DISPXAM^RAWFR4(6)
 I RAXIT!('($D(RAWFR)\10)) D KILL^RAWFR3 Q
 ;                  *** End of Exam Status display ***
STRTDT ;                  *** Prompt for Starting Date ***
 W ! K DIR S DIR(0)="DA^:"_DT_":PEA"
 S DIR("A")="Enter the start date for the search: "
 S DIR("?",1)="This is the date from which our search will begin."
 S DIR("?",2)="Think of it in terms of 'FROM' and 'TO'.  This date is our 'FROM'."
 S DIR("?",3)="The starting date must not exceed: "_RADATE_"."
 S DIR("?")="Dates associated with a time will not be accepted."
 S DIR("B")=RADATE D ^DIR K DIR
 I $D(DIRUT) D KILL^RAWFR3 Q
 S RABGDTI=Y,RABGDTX=Y(0),RAMBGDT=RABGDTI-.0001
 ;
ENDDT ;                  *** Prompt for Ending Date ***
 W ! K DIR S DIR(0)="DA^"_RABGDTI_":"_DT_":PEA"
 S DIR("A")="Enter the ending date for the search: "
 S DIR("?",1)="This is the date in which our search will end."
 S DIR("?",2)="Think of it in terms of 'FROM' and 'TO'.  This date is our 'TO'."
 S DIR("?",3)="The ending date must not exceed: "_RADATE_"."
 S DIR("?",4)="The ending date must not precede: "_RABGDTX_"."
 S DIR("?")="Dates associated with a time will not be accepted."
 S DIR("B")=RABGDTX D ^DIR K DIR
 I $D(DIRUT) D KILL^RAWFR3 Q
 S RAENDTI=Y,RAENDTX=Y(0),RAMENDT=RAENDTI+.9999
 S ZTSAVE("RA*")="",ZTSAVE("^TMP($J,""RA D-TYPE"",")=""
 S ZTSAVE("^TMP($J,""RA I-TYPE"",")="",ZTSAVE("^TMP($J,""RA WFR"",")=""
 S ZTRTN="START^RAWFR1"
 S ZTDESC="Rad/Nuc Med Wasted Film report"
 W ! D ZIS^RAUTL
 I POP D KILL^RAWFR3 Q
 I +$G(RAPOP) D KILL^RAWFR3 Q  ;'RAPOP' set to '1' if task is created
START ; Start the sort/print process
 U IO S $P(RALINE,"-",$S(IOM=132:133,1:81))=""
 S:$D(ZTQUEUED) ZTREQ="@"
 S RAHEAD=">>>>> Wasted Film Report <<<<<"
 F RADT=RAMBGDT:0:RAMENDT S RADT=$O(^RADPT("AR",RADT)) Q:RADT'>0!(RADT>RAMENDT)!(RAXIT)  D
 . S RADFN=0 F  S RADFN=$O(^RADPT("AR",RADT,RADFN)) Q:RADFN'>0!(RAXIT)  D
 .. S RADTI=0 F  S RADTI=$O(^RADPT("AR",RADT,RADFN,RADTI)) Q:RADTI'>0!(RAXIT)  D
 ... I $G(^RADPT(RADFN,"DT",RADTI,0))]"" D
 .... S RARP0=$G(^RADPT(RADFN,"DT",RADTI,0)) D RAEXAM
 .... Q
 ... Q
 .. Q
 . Q
 ; If 'RASYN'=1 do summary
 I 'RAXIT D:RASYN COMPSUM^RAWFR2 D:'RASYN COMP^RAWFR3
 K RACCESS(DUZ,"DIV-IMG") W ! D ^%ZISC
 D KILL^RAWFR3
 Q
RAEXAM ; Journey through the 'Examination' multiple.
 S RAEX=0
 F  S RAEX=$O(^RADPT(RADFN,"DT",RADTI,"P",RAEX)) Q:RAEX'>0!(RAXIT)  D
 . I $G(^RADPT(RADFN,"DT",RADTI,"P",RAEX,0))]"" D
 .. S RAEX0=$G(^RADPT(RADFN,"DT",RADTI,"P",RAEX,0))
 .. S RAEXS=+$P(RAEX0,U,3)
 .. I $D(RAWFR(RAEXS)) D SETUP^RAWFR2
 .. Q
 . Q
 Q
