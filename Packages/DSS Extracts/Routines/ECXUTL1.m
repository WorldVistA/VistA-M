ECXUTL1 ;ALB/GTS - Utilities for DSS Extracts ;July 16, 1998
 ;;3.0;DSS EXTRACTS;**9,49**;Dec 22, 1997
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
