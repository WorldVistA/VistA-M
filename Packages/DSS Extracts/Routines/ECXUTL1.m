ECXUTL1 ;ALB/GTS - Utilities for DSS Extracts ;2/11/14  13:09
 ;;3.0;DSS EXTRACTS;**9,49,136,144,149**;Dec 22, 1997;Build 27
 ;
CYFY(ECXFMDT) ;** Return the calandar and fiscal years for a FM date
 ;
 ; Input
 ;   ECXFMDT - Fileman formated date
 ;
 ; Output
 ;   X - CY begin date^ CY end date^ FY begin date^ FY end date
 ;
 N X,Y,Y2
 S X=""
 S ECXFMDT=$G(ECXFMDT)\1
 I ECXFMDT?7N DO
 .S (Y,Y2)=$E(ECXFMDT,1,3)
 .I $E(ECXFMDT,4,5)>9 S Y2=Y+1
 .S X=Y_"0101^"_Y_"1231^"_(Y2-1)_"1001^"_Y2_"0930"
 Q X
 ;
FISCAL(DATE)    ;Return fiscal year
 ; Input: DATE = Date (FileMan format) (defaults to today)
 ;Output: YYYY = Fiscal year that input date falls within
 ;
 N YEAR
 I '$G(DATE) S DATE=$$DT^XLFDT()
 S DATE=$$ECXYM^ECXUTL(DATE)
 S YEAR=$E(DATE,1,4)
 I $E(DATE,5,6)>9 S YEAR=YEAR+1
 Q YEAR
 ;
DTRNG() ;** Prompt the user for a date range
 ;
 N ECXBEG,ECXEND,ECXRNG,ENDRNG
 S ECXRNG=0
 ;
 ;* Prompt for beginning date
 W ! S DIR(0)="DA^:DT:EX",DIR("A")="Enter Start Date: "
 S DIR("?")="^W ""*** Future dates are not allowed ***"",! D HELP^%DTC"
 D ^DIR K DIR
 S:'$D(DIRUT) ECXBEG=+Y
 K %DT,Y,DTOUT,DUOUT,DIRUT
 ;
 ;* Prompt for ending date
 I $G(ECXBEG) DO
 .S ENDRNG=$$CYFY(ECXBEG)
 .S ENDRNG=$S($P(ENDRNG,"^",4)<DT:$P(ENDRNG,"^",4),1:DT)
 .W ! S DIR(0)="DA^"_ECXBEG_":"_ENDRNG_":EX"
 .S DIR("A")="Enter End date: "
 .S DIR("?")="^W ""Future dates and dates after the beginning date's FY end are not allowed."",! D HELP^%DTC"
 .D ^DIR
 .S ECXEND=+Y
 .S:'$D(DIRUT) ECXRNG=ECXBEG_"^"_ECXEND
 .K DIR,%DT,Y,DIRUT,DTOUT,DUOUT
 Q ECXRNG
 ;
STRIP(ECXFIELD,ECXLGTH,ECXPOS) ;* Strip blanks from a padded field
 ;
 ; Input
 ;  ECXFIELD - Data to remove blanks from
 ;  ECXLGTH  - Total length of padded field
 ;  ECXPOS   - Front or Back indicator ('F' or 'B')
 ;
 ; Output
 ;  ECXVAL   - Field with blanks removed
 ;
 N ECXPVAL,QVAL
 S:ECXPOS="B" ECXPVAL=ECXLGTH
 S:ECXPOS="F" ECXPVAL=1
 S QVAL=0
 F  Q:QVAL  DO
 .I ECXPOS="B" DO
 ..S:($E(ECXFIELD,ECXPVAL)'=" ") QVAL=1
 ..S:($E(ECXFIELD,ECXPVAL)=" ") ECXFIELD=$E(ECXFIELD,1,ECXPVAL-1)
 ..S ECXPVAL=ECXPVAL-1
 ..S:(ECXPVAL<1) QVAL=1
 .I ECXPOS="F" DO
 ..S:($E(ECXFIELD,1)'=" ") QVAL=1
 ..S:($E(ECXFIELD,1)=" ") ECXFIELD=$E(ECXFIELD,2,ECXLGTH-(ECXPVAL-1))
 ..S ECXPVAL=ECXPVAL+1
 ..S:(ECXPVAL>ECXLGTH) QVAL=1
 Q ECXFIELD
 ;
PAD(ECXVAL,ECXLGTH,ECXFB,ECXCHAR) ;* Pad the value passed in with ECXCHAR
 ;
 ;   ECXVAL   - The value to pad
 ;   ECXLGTH  - The maximum length
 ;   ECXFB    - 'F': Pad on front; 'B' Pad on back
 ;   ECXCHAR  - The character to pad ECXVAL with
 ;
 ; Output
 ;   ECXVAR   - The padded result
 ;
 N ECXLPCT,ECXVAR
 I $D(ECXVAL),($D(ECXLGTH)),($D(ECXFB)),($D(ECXCHAR)) DO
 .S (ECXVAL,ECXVAR)=$E(ECXVAL,1,ECXLGTH)
 .F ECXLPCT=1:1:ECXLGTH-$L($E(ECXVAR,1,ECXLGTH)) DO
 ..S:ECXFB="B" ECXVAL=ECXVAL_ECXCHAR
 ..S:ECXFB="F" ECXVAL=ECXCHAR_ECXVAL
 I '$D(ECXVAL) S ECXVAL=""
 Q ECXVAL
 ;
BLDXREF(START,END) ;Build temporary xref from EDIS LOG file #230 API added in patch 136
 N STDT,ENDT,TIME,SITE,IEN,PIEN
 S STDT=$$FMADD^XLFDT(START,-1) ;Start day before
 S ENDT=$$FMADD^XLFDT(END,1,23,59,59) ;Extend to next day, just before midnight.
 S SITE=0 F  S SITE=$O(^EDP(230,"ATO",SITE)) Q:'+SITE  S TIME=STDT F  S TIME=$O(^EDP(230,"ATO",SITE,TIME)) Q:'+TIME!(TIME>ENDT)  D
 .S IEN=0 F  S IEN=$O(^EDP(230,"ATO",SITE,TIME,IEN)) Q:'+IEN  S PIEN=$$GET1^DIQ(230,IEN,".06","I") I PIEN S ^TMP($J,"EDIS",PIEN,TIME)=IEN
 Q
 ;
EDIS(ECXDFN,ECD,ECETYPE,ECXVISIT,ECXSTOP) ;Find emergency room disposition, if it exists, and translate it to a value for DSS. API added with patch 136
 N DISP,STDT,DATE,IEN,ENDT
 I '+$$VERSION^XPDUTL("EDP") Q ""  ;If emergency department software not installed, return null
 I ECETYPE="N" Q:ECXSTOP=130 "N"  Q ""  ;If no-show and ER visit, set to N otherwise set to null
 I ECETYPE="A" D  Q:'$D(DISP) ""  ;If no dispositions found in time frame return null
 .S STDT=$$FMADD^XLFDT(ECD,,-24) ;find date/time 24 hours prior to admit date/time
 .S ENDT=$$FMADD^XLFDT(ECD,,24) ;add 24 hours to the admit date/time to allow for late entry of disposition following admission
 .S DATE=STDT F  S DATE=$O(^TMP($J,"EDIS",ECXDFN,DATE)) Q:'+DATE!(DATE>ENDT)  S DISP=$$GET1^DIQ(230,^TMP($J,"EDIS",ECXDFN,DATE),1.2,"I")
 I ECETYPE="C" Q:$G(ECXSTOP)'=130 ""  D
 .I +$G(ECXVISIT) S IEN=+$O(^EDP(230,"V",ECXVISIT,0)) ;Check visit file pointer
 .I '+$G(IEN) S IEN=+$O(^EDP(230,"B",ECD,0)) I IEN I ECXDFN'=$$GET1^DIQ(230,IEN_",",.06,"I") K IEN ;Check log date/time and patient IEN for match
 .I +$G(IEN) S DISP=$$GET1^DIQ(230,IEN,1.2,"I")
 I '$D(DISP) Q "N"  ;If no visits, return "N" for none
 I DISP="" Q "U"
 Q $$TRANS(DISP)
 ;
TRANS(DISP) ;Translate disposition to set of codes. API added in patch 136
 N CODE,DSP
 S CODE=$$GET1^DIQ(233.1,DISP_",",".01"),DSP=$$UP^XLFSTR($$GET1^DIQ(233.1,DISP_",",".02")) ;Get code name and display name for disposition
 I +CODE Q "U"  ;If code begins with a number, it's local
 I DSP["ADMIT" Q "A"
 I DSP["TRANSFER" Q "T"
 I DSP["HOME"!(DSP["AMA")!(DSP["LEFT")!(DSP["ELOPED") Q "L"
 I DSP["DECEASED" Q "D"
 I DSP["SENT" Q "R"
 I DSP["ERROR" Q "E"
 Q "U"
 ;
ERR ;Send email when scheduling system reports an error.  API added in patch 136
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,I,CNT,TEXT
 I '$D(^TMP($J,"SDAMA301")) Q  ;No error to report
 S XMY($G(DUZ,.5))="" ;Send to user or postmaster if no user identified
 S XMY("G.DSS-"_$G(ECGRP))="" ;Include extract group
 S XMDUZ="DSS SYSTEM"
 S XMSUB="Error in retrieving appointment data during extract"
 S CNT=1 S TEXT(CNT)="An error was encountered by the scheduling system during an extract.",CNT=CNT+1
 S TEXT(CNT)="The system returned the following error:",CNT=CNT+1,TEXT(CNT)="",CNT=CNT+1
 S I=0 F  S I=$O(^TMP($J,"SDAMA301",I)) Q:'+I  S TEXT(CNT)="Error code "_I_" - "_^TMP($J,"SDAMA301",I)_".",CNT=CNT+1
 S TEXT(CNT)="",CNT=CNT+1,TEXT(CNT)="Contact your local I.T. department for assistance."
 S XMTEXT="TEXT("
 D ^XMD
 Q
 ;
EXPORT() ;Function indicates if report output is going to a device or to the screen in exportable format - API added in patch 144
 N DIR,DIRUT,DTOUT,DUOUT,DIROUT,X,Y,VAL
 W !
 S DIR("?",1)="Enter yes if you want the data to be displayed in an '^' delimited format",DIR("?")="that can be captured for exporting."
 S DIR(0)="SA^Y:YES;N:NO",DIR("B")="NO",DIR("A")="Do you want the output in exportable format? "
 D ^DIR
 S VAL=$S($D(DIRUT):-1,Y="N":0,1:1)
 I VAL=1 W !!,"Gathering data for export..."
 Q VAL
 ;
EXPDISP ;Displays report in exportable format.  API added in patch 144
 N I,%ZIS,POP,DIR,DTOUT,DIRUT,X,Y,DUOUT
 I '+$O(^TMP($J,"ECXPORT",0)) W !,"No data found for this report." Q
 W !!,"To ensure all data is captured during the export:"
 W !!,"1. Select 'Logging...' from the File Menu. Select your file, and where to save."
 W !,"2. On the Setup menu, select 'Display...',then 'screen' tab and modify 'columns'",!,"   setting to at least 225 characters."
 W !,"3. The DEVICE input for the columns should also contain a large enough",!,"   parameter (e.g. 225).  The DEVICE prompt is defaulted to 0;225;99999 for you.",!,"   You may change it if need be."
 W !,"Example: DEVICE: 0;225;99999 *Where 0 is your screen, 225 is the margin width",!?17,"and 99999 is the screen length."
 W !!,"NOTE:  In order for all number fields, such as SSN and Feeder Key, to be",!,"displayed correctly in the spreadsheet, these fields must be formatted as Text",!,"when importing the data into the spreadsheet.",!
 S %ZIS="",%ZIS("B")="0;225;99999" D ^%ZIS Q:POP
 S I="" F  S I=$O(^TMP($J,"ECXPORT",I)) Q:I=""  W !,^TMP($J,"ECXPORT",I)
 W !!,"Turn off your logging..."
 W !,"...Then, pull your export text file into your spreadsheet.",!
 S DIR(0)="E",DIR("A")="Press any key to continue" D ^DIR
 D HOME^%ZIS ;set parameters back to normal
 Q
 ;
REPORTFY(NAME) ;Function added in patch 144, determines which version of the report to run
 ;For each report that has a previous fiscal year version, a line label
 ;will be added for the report.  Following the ;; on the line label is the
 ;name of the routine for the previous fiscal year.  This value will be
 ;returned if the user selects previous fiscal year.  The function will
 ;return null if current is selected or -1 if no selection is made
 N DIR,DIRUT,DTOUT,DUOUT,Y,X,DIROUT
 I $T(@NAME)="" Q ""  ;No previous FY version exists
 W !
 S DIR(0)="SA^C:Current Fiscal Year Report Logic;P:Previous Fiscal Year Report Logic",DIR("B")="C",DIR("A")="Use (C)urrent or (P)revious fiscal year logic for this report? "
 S DIR("?",1)="This report has been modified for the current fiscal year and may",DIR("?",2)="include additional information or functionality not previously"
 S DIR("?",3)="available.  If you desire the previous fiscal year logic",DIR("?",4)="to be used then select 'P'.  Otherwise, select 'C'"
 S DIR("?")="to run the current version of the report."
 D ^DIR
 I Y="C" Q ""
 I Y="P" Q $P($T(@NAME),";;",2)
 Q -1  ;User didn't make a selection
 ;
 ;Reports available for previous fiscal year are listed below as line labels
 ;The API^ROUTINE that's part of the line indicates the previous fiscal
 ;year entry point and routine to run when "previous" is selected
 ;149 updated list to remove previous year's entry
SAMPLE ;;API^ROUTINE
