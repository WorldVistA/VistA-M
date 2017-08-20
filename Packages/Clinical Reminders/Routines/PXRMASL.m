PXRMASL ;SLC/PKR - Computed findings for age and sex. ;10/30/2014
 ;;2.0;CLINICAL REMINDERS;**47**;Feb 04, 2005;Build 289
 ;
 ;=========================
BDAYSL(MINBDAY,MAXBDAY,SEX,TODAY,PLIST) ;Build a list of patients based on an
 ;inclusive range of birthdates defined by a minimum and maximum
 ;birthday. Sex is an optional filter
 N BDAY,DFN
 K ^TMP($J,PLIST)
 S TODAY=$$TODAY^PXRMDATE
 S BDAY=$$FMADD^XLFDT(MINBDAY,-1,0,0,0)
 ;DBIA #10035
 F  S BDAY=$O(^DPT("ADOB",BDAY)) Q:(BDAY>MAXBDAY)!(BDAY="")  D
 . S DFN=""
 . F  S DFN=$O(^DPT("ADOB",BDAY,DFN)) Q:DFN=""  D
 .. I SEX="" S ^TMP($J,PLIST,DFN,1)=DFN_U_TODAY_U_"2"_U_BDAY Q
 .. I SEX=$P(^DPT(DFN,0),U,2) S ^TMP($J,PLIST,DFN,1)=DFN_U_TODAY_U_"2"_U_BDAY
 Q
 ;
 ;=========================
CFAGESL(NGET,BDT,EDT,PLIST,PARAM) ;Computed finding that returns a list of
 ;patients in an inclusive age range defined by minimum age and 
 ;maximum age and optionally filter on sex. AGE can be specified in
 ;units of D=days, W=weeks, M=months, or Y=years. If no unit is
 ;specified it defaults to years.
 N MAXAGE,MAXBDAY,MINAGE,MINBDAY,MAXUNIT,MINUNIT,SEX,TODAY
 S MINAGE=$P(PARAM,U,1),MAXAGE=$P(PARAM,U,2),SEX=$P(PARAM,U,3)
 I MINAGE="" Q
 I MAXAGE="" Q
 S TODAY=$$TODAY^PXRMDATE
 S MAXUNIT=$E(MAXAGE,$L(MAXAGE))
 I "DWMY"'[MAXUNIT S MAXAGE=MAXAGE_"Y"
 S MINBDAY=$$NEWDATE^PXRMDATE(TODAY,"-",MAXAGE)
 S MINUNIT=$E(MINAGE,$L(MINAGE))
 I "DWMY"'[MINUNIT S MINUNIT="Y",MINAGE=MINAGE_"Y"
 I MINUNIT="Y" S MINBDAY=$E(MINBDAY,1,3)_"0101"
 S MAXBDAY=$$NEWDATE^PXRMDATE(TODAY,"-",MINAGE)
 I MINBDAY>MAXBDAY Q
 D BDAYSL(MINBDAY,MAXBDAY,SEX,TODAY,PLIST)
 Q
 ;
 ;=========================
CFBDAYSL(NGET,BDT,EDT,PLIST,PARAM) ;Computed finding that returns a list of
 ;patients in an inclusive birth date range defined by minimum birthday
 ;and maximum birthday and optionally filter on sex.
 N MAXBDAY,MINBDAY,SEX,TODAY
 S MINBDAY=$P(PARAM,U,1),MAXBDAY=$P(PARAM,U,2),SEX=$P(PARAM,U,3)
 I MINBDAY="" Q
 I MAXBDAY="" Q
 S MINBDAY=$$CTFMD^PXRMDATE(MINBDAY)
 S MAXBDAY=$$CTFMD^PXRMDATE(MAXBDAY)
 I MINBDAY>MAXBDAY Q
 S TODAY=$$TODAY^PXRMDATE
 D BDAYSL(MINBDAY,MAXBDAY,SEX,TODAY,PLIST)
 Q
 ;
