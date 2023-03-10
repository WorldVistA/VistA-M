MAGDSTAS ;WOIFO/PMK - Q/R Retrieve of DICOM images from PACS to VistA ; Feb 15, 2022@10:52:34
 ;;3.0;IMAGING;**231,306,305**;Mar 19, 2002;Build 3
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ; Supported IA #2056 reference $$GET1^DIQ function call
 ; Supported IA #10103 reference $$FMTE^XLFDT function call
 ; Supported IA #10103 reference $$HTE^XLFDT function call
 ; Supported IA #10103 reference $$FMTH^XLFDT function call
 ; Supported IA #10075 reference to read the OPTION file (#19)
 ; Supported IA #2051 reference $$FIND1^DIC function call
 ;
CON ; entry point to output consult statistics
 N PATTERN S PATTERN="1"_"""MAGD CON"""_".E"
 N MYSERVICE S MYSERVICE="CONSULTS"
 N $ETRAP,$ESTACK S $ETRAP="D ERROR^MAGDSTA"
 D START(PATTERN)
 Q
 ; 
RAD ; entry point to output radiology statistics
 N PATTERN S PATTERN="1"_"""MAGD RAD"""_".E"
 N MYSERVICE S MYSERVICE="RADIOLOGY"
 N $ETRAP,$ESTACK S $ETRAP="D ERROR^MAGDSTA"
 D START(PATTERN)
 Q
 ; 
START(PATTERN) ; Entry point to output statistics
 N ACNUMB,BATCHSIZE,BEGDATE,CMOVEAET,DFN,ENDDATE,HOURS,IMAGINGSERVICE,OPTION,QRSCP
 N RUNTIME,SCANMODE,SORTORDER,STARTIEN,STARTTIME,STATUS,STUDYDATE,STUDYIEN
 N MENUOPTION,S2,X
 ;
 I $$YESNO^MAGDSTQ("Display statistics for individual "_MYSERVICE_" runs?","y",.X)<0 Q
 I X="YES" D  Q
 . D ONERUN(MYSERVICE)
 . Q
 ;
 I $$YESNO^MAGDSTQ("Display cumulative statistics for all "_MYSERVICE_" runs?","y",.X)<0 Q
 I X="NO" D  Q
 . D CONTINUE^MAGDSTQ
 . Q
 ;
 K ^TMP("MAG",$J,"BATCH Q/R","DATE"),^("NUMBER")
 S MENUOPTION=""
 F  S MENUOPTION=$O(^MAGDSTT(2006.543,"C",MENUOPTION)) Q:MENUOPTION=""  D
 . I MENUOPTION'?@PATTERN Q
 . S S2=""
 . F  S S2=$O(^MAGDSTT(2006.543,"C",MENUOPTION,S2)) Q:S2=""  D
 . . D OPTION(MENUOPTION,S2)
 . . Q
 . Q
 I $D(S2) D
 . W !,"The above statistics are only an estimate.  If the same scans are run"
 . W !,"multiple times, that scan's numbers will be counted more than once."
 . Q
 E  D
 . W !!,"There are no statistics for ",MYSERVICE,"."
 . Q
 D CONTINUE^MAGDSTQ
 K ^TMP("MAG",$J,"BATCH Q/R","DATE"),^("NUMBER")
 Q
 ;
OPTION(MENUOPTION,S2) ; output statistics for all runs for one option/scan mode
 N HDATE1,HDATE2,I,MAXLENGTH,OPTIONIEN,OPTIONNAME,RUNNUMBER,STATS
 ;
 S SCANMODE=$S(S2="D":"DATE",S2="N":"NUMBER",S2="P":"PATIENT")
 ;
 I SCANMODE="DATE" D  ; build list of $H dates
 . S HDATE1=+$$FMTH^XLFDT(2900000) ; $H format of FM date Jan 1, 1990
 . S HDATE2=+$H ; today
 . F I=HDATE1:1:HDATE2 S ^TMP("MAG",$J,"BATCH Q/R","DATE",I)=""
 . Q
 E  I SCANMODE="NUMBER" D
 . ;
 . Q
 ;
 S OPTIONIEN=$$FIND1^DIC(19,"","B",MENUOPTION)
 S OPTIONNAME=$$GET1^DIQ(19,OPTIONIEN,1,"E")
 W @IOF,OPTIONNAME," -- ",SCANMODE," scan"
 ;
 ; collect statistics
 ;
 S (MAXLENGTH,RUNNUMBER,STATS)=0
 F  S RUNNUMBER=$O(^MAGDSTT(2006.543,"C",MENUOPTION,S2,RUNNUMBER)) Q:RUNNUMBER=""  D
 . D GETDATA(RUNNUMBER,.STATS)
 . Q
 ;
 ; display statistics
 ;
 D DISPLAY(.STATS)
 ;
 I SCANMODE="DATE" D
 . I '$D(^TMP("MAG",$J,"BATCH Q/R","DATE")) D
 . . W !,"The DATE scan has been run for the entire date interval from ",$$HTE^XLFDT(HDATE1)," to today."
 . . Q
 . E  D
 . . W !,"The process has not been run for the following date intervals:"
 . . S HDATE1="" F  D  Q:HDATE1=""
 . . . S HDATE1=$O(^TMP("MAG",$J,"BATCH Q/R","DATE",HDATE1))
 . . . I HDATE1="" Q  ; no more date intervals
 . . . F HDATE2=HDATE1:1 Q:'$D(^TMP("MAG",$J,"BATCH Q/R","DATE",HDATE2))
 . . . W ! I $Y>(IOSL-4) D CONTINUE^MAGDSTQ(1)
 . . . W ?15,$$HTE^XLFDT(HDATE1)," -- ",$$HTE^XLFDT(HDATE2)
 . . . S HDATE1=HDATE2
 . . . Q
 . . Q 
 . Q
 E  I SCANMODE="NUMBER" D
 . W !,"The NUMBER scan has not been run for the following IEN intervals:"
 . S (ZEROIEN1,ZEROIEN2)=0
 . S MOD100="" ; first node may be 0
 . F MOD100=0:1:10 D
 . . I '$D(^TMP("MAG",$J,"BATCH Q/R","NUMBER",MOD100)) D  Q
 . . . I ZEROIEN1=0 S ZEROIEN1=MOD100*100 I ZEROIEN1=0 S ZEROIEN1=1
 . . . S ZEROIEN2=(MOD100+1)*100
 . . . Q
 . . S X=^TMP("MAG",$J,"BATCH Q/R","NUMBER",MOD100)
 . . F I=1:1:100 D
 . . . I $E(X,I)="0" D  ; "0"
 . . . . I ZEROIEN1=0 S ZEROIEN1=(MOD100*100)+I-1
 . . . . S ZEROIEN2=(MOD100*100)+I-1
 . . . . Q
 . . . E  D  ; "1"
 . . . . I ZEROIEN1,ZEROIEN2=0 S ZEROIEN2=(MOD100*100)+I-2
 . . . . I ZEROIEN1=0 Q
 . . . . D ZEROES(ZEROIEN1,ZEROIEN2)
 . . . . S ZEROIEN1=0
 . . . . Q
 . . . Q
 . . Q
 . I ZEROIEN1 D ZEROES(ZEROIEN1,ZEROIEN2)
 . Q
 W ! D CONTINUE^MAGDSTQ(1)
 Q
ZEROES(ZEROIEN1,ZEROIEN2) ; output an IEN range
 W ! I $Y>(IOSL-4) D CONTINUE^MAGDSTQ(1)
 W ?15,ZEROIEN1," to ",ZEROIEN2
 Q 
 ;
GETDATA(RUNNUMBER,STATS) ; accumulate the data for one run
 D NODE0(RUNNUMBER)
 I SCANMODE="DATE" D  ; remove dates that have been processed
 . N HDATE1,HDATE2,I
 . S HDATE1=$$FMTH^XLFDT(BEGDATE)
 . S HDATE2=$$FMTH^XLFDT(ENDDATE)
 . F I=HDATE1:1:HDATE2 K ^TMP("MAG",$J,"BATCH Q/R","DATE",I)
 . Q
 E  I SCANMODE="NUMBER" D
  . D SETONES(+STARTIEN,+STUDYIEN)
 . Q
 D STATS(RUNNUMBER,.STATS)
 Q
 ;
SETONES(IEN1,IEN2) ; set 1's for scanned ien ranges
 N I,IEN,MOD100,REMAINDER,ZEROS
 S ZEROS=$TR($J("",100)," ","0")
 F IEN=IEN1:1:IEN2 D
 . S MOD100=(IEN\100)
 . I '$D(^TMP("MAG",$J,"BATCH Q/R","NUMBER",MOD100)) S ^(MOD100)=ZEROS
 . S REMAINDER=IEN-(MOD100*100)
 . S $E(^TMP("MAG",$J,"BATCH Q/R","NUMBER",MOD100),REMAINDER+1)="1"
 . ; set the first zero to one, for completeness
 . I MOD100=0 S $E(^TMP("MAG",$J,"BATCH Q/R","NUMBER",MOD100),1)="1"
 . Q
 Q 
 ;
STATS(I,STATS) ; collect statistics info
 N ISTATS,J,NAME,VALUE,X
 S J=0
 F  S J=$O(^MAGDSTT(2006.543,I,2,J)) Q:'J  D
 . S X=^MAGDSTT(2006.543,I,2,J,0)
 . S NAME=$P(X,"^",1),VALUE=$P(X,"^",2)
 . S ISTATS=$G(STATS("XREF",NAME))
 . I 'ISTATS D
 . . S (ISTATS,STATS)=STATS+1
 . . S STATS("XREF",NAME)=ISTATS
 . . Q
 . S STATS(ISTATS,"NAME")=NAME_"_____________________________"
 . S STATS(ISTATS,"VALUE")=$G(STATS(ISTATS,"VALUE"))+VALUE
  . Q
 Q
 ;
DISPLAY(STATS) ; output the statistics
 N I
 W !
 F I=1:1:STATS D
 . W !?10,$E(STATS(I,"NAME"),1,35),?45,$TR($J(STATS(I,"VALUE"),10)," ","_")
 . I $Y>(IOSL-4) D
 . . D CONTINUE^MAGDSTQ
 . . W @IOF
 . . Q
 . Q
 W !
 Q
 ;
 ;
 ;
ONERUN(MYSERVICE) ; display the statistics for individual runs
 N COUNT,LIST,MAXLENGTH,RUNNUMBER,SELECT,STATS
 ;
 ; get statistics for this imaging service
 D MAKELIST(MYSERVICE,.LIST,.COUNT)
 ;
 I COUNT=0 W !!,"No run statistics on file for ",MYSERVICE Q
 ;
 I COUNT=1 D
 . W !!,"Just a single run for ",MYSERVICE
 . S SELECT=1
 . D ONERUN1(.LIST,1)
 . Q
 E  D  ; select the run number from the list
 . N DONE1,FIRSTTIME
 . S DONE1=0,FIRSTTIME=1
 . F  D  Q:DONE1
 . . S SELECT=$$ONERUN2(.COUNT,.LIST)
 . . I SELECT'>0 D  Q
 . . . I FIRSTTIME W !!,"No run was selected"
 . . . S DONE1=1
 . . . Q
 . . S FIRSTTIME=0
 . . D ONERUN1(.LIST,SELECT)
 . . Q
 . Q
 Q
 ;
ONERUN1(LIST,SELECT) ; display statics for a single run
 N STATS
 S RUNNUMBER=LIST(SELECT)
 D NODE0(RUNNUMBER)
 W @IOF,"Entry #",SELECT
 W ?14,"Started: ",$$FMTE^XLFDT(STARTTIME)
 W ?50,"Ended: ",$$FMTE^XLFDT(RUNTIME)
 W !,MYSERVICE,?14,OPTION," by ",SCANMODE
 I STATUS'?1"ERROR: ".E W ?50,"Status: ",STATUS
 E  D  ; special processing for an error
 . W ?50,"*** ERROR ***"
 . W !?14,"<< ",STATUS," >>"
 . Q
 W !,"PACS: ",QRSCP
 I CMOVEAET'="" W "    Move Destination: ",CMOVEAET
 I SCANMODE="DATE" D
 . W !,"Beginning Date: ",$$FMTE^XLFDT(BEGDATE)
 . W "   Ending Date: ",$$FMTE^XLFDT(ENDDATE,"D")
 . Q
 E  I SCANMODE="PATIENT" D
 . W !,"DFN: ",DFN
 . W ?14,"Beginning Date: ",$$FMTE^XLFDT(BEGDATE)
 . W ?50,"Ending Date: ",$$FMTE^XLFDT(ENDDATE,"D")
 . Q
 E  I SCANMODE="NUMBER" D
 . W !,"Starting Report Number: ",STARTIEN,"    Batch Size: ",BATCHSIZE
 . Q
 W !,"Sort Order: ",SORTORDER,?43,"Hours: ",HOURS
 W !,"Last Accession #: ",ACNUMB,?50,"M12345678901N12345678901"
 W !,"Last Study Date: ",$$FMTE^XLFDT(STUDYDATE,"D")
 W ?35,"Last DFN: ",DFN,?55,"Last Report #: ",STUDYIEN
 I IMAGINGSERVICE="CONSULTS" D  ; display consult/procedure services
 . S I=0
 . W !,"Services: "
 . F  S I=$O(^MAGDSTT(2006.543,RUNNUMBER,1,I)) Q:'I  D
 . . S SERVICE=^MAGDSTT(2006.543,RUNNUMBER,1,I,0)
 . . S SERVICENAME=$$GET1^DIQ(123.5,SERVICE,.01,"E")
 . . I ($L(SERVICENAME)+2)+$X>IOM W ",",!?10 ; need new line
 . . E  W:I>1 ", "
 . . W SERVICENAME
 . . Q
 . Q
 S (MAXLENGTH,STATS)=0
 D STATS(RUNNUMBER,.STATS)
 D DISPLAY(.STATS)
 D CONTINUE^MAGDSTQ
 Q
 ;
ONERUN2(COUNT,LIST) ; present run selection screen(s)
 N DONE2,IBEGIN,IEND,INCREMENT,ISCREEN,NSCREENS,SELECT
 S INCREMENT=IOSL-7,DONE2=0
 S NSCREENS=((COUNT-1)\INCREMENT)+1
 F  D  Q:DONE2
 . F ISCREEN=1:1:NSCREENS D  Q:DONE2
 . . S IBEGIN=1+((ISCREEN-1)*INCREMENT)
 . . S IEND=INCREMENT*ISCREEN
 . . S IEND=$S(IEND>COUNT:COUNT,1:IEND)
 . . W !,ISCREEN
 . . S SELECT=$$ONERUN3(IBEGIN,IEND,.LIST,.DONE2)
 . . Q
 . Q
 Q SELECT
  ;
ONERUN3(IBEGIN,IEND,LIST,DONE2) ; select the run number from a screen full  
 N DONE3,I,RETURN,RUNNUMBER,X
 S (DONE3,RETURN)=0
 F  D  Q:DONE2  Q:DONE3
 . W @IOF,"Select the number of the run"
 . W !,"----------------------------",!
 . F I=IBEGIN:1:IEND D
 . . S RUNNUMBER=LIST(I) D NODE0(RUNNUMBER)
 . . W !,$J(I,3),") ",$$FMTE^XLFDT(STARTTIME,"2MPZ")
 . . W ?24,OPTION," by ",SCANMODE
 . . W ?60,$S(STATUS?1"ERROR: ".E:"*** ERROR ***",1:STATUS)
 . . Q
 . ;
 . ; process user selection(s)
 . W !!,"Please enter 1-",IEND," to select the run, ""^"" to exit: "
 . R X:DTIME E  S X="^"
 . I $E(X)="^" S RETURN=-1,DONE2=1
 . E  I X?1N.N,X>0,X'>IEND D
 . . S RETURN=X
 . . S DONE2=1
 . . Q
 . E  I X="" S DONE3=1
 . E  D
 . . I $E(X)'="?" W " ???"
 . . W !,"Please enter the number of the run to display the statistics"
 . . D CONTINUE^MAGDSTQ
 . . Q
 . Q
 Q RETURN
 ;
MAKELIST(MYSERVICE,LIST,COUNT) ; make a list of the service's runs
 N ACNUMB,BATCHSIZE,BEGDATE,CMOVEAET,DFN,ENDDATE,HOURS,IMAGINGSERVICE
 N MENUOPTION,OPTION,RUNNUMBER,RUNTIME,QRSCP,SCANMODE,SORTORDER,STARTIEN
 N STARTTIME,STATUS,STUDYDATE,STUDYIEN
 ; get statistics for this imaging service
 S (COUNT,RUNNUMBER)=0
 F  S RUNNUMBER=$O(^MAGDSTT(2006.543,RUNNUMBER)) Q:'RUNNUMBER  D
 . D NODE0(RUNNUMBER) I MYSERVICE'=IMAGINGSERVICE Q
 . S COUNT=COUNT+1,LIST(COUNT)=RUNNUMBER
 . Q
 Q
 ;
 ;
 ;
LASTRUN(I) ; entry point from ^MAGDSTA1 to get last parameters of the last run
 D NODE0(I)
 D SERVICES(I)
 Q
 ;
NODE0(I) ; get parameters from the zero-node for one run
 N X
 S X=$G(^MAGDSTT(2006.543,I,0))
 S STARTTIME=$P(X,"^",1)
 S IMAGINGSERVICE=$$GET1^DIQ(2006.543,I,2,"E")
 S RUNTIME=$P(X,"^",3)
 S OPTION=$$GET1^DIQ(2006.543,I,4,"E")
 S STATUS=$P(X,"^",5)
 S SCANMODE=$$GET1^DIQ(2006.543,I,6,"E")
 S QRSCP=$P(X,"^",7)
 S CMOVEAET=$P(X,"^",8)
 S BEGDATE=$P(X,"^",9)
 S ENDDATE=$P(X,"^",10)
 S STARTIEN=$P(X,"^",11)
 S BATCHSIZE=$P(X,"^",12)
 S SORTORDER=$$GET1^DIQ(2006.543,I,13,"E")
 S HOURS=$P(X,"^",14)
 S DFN=$P(X,"^",15)
 S STUDYDATE=$P(X,"^",16)
 S STUDYIEN=$P(X,"^",17)
 S ACNUMB=$P(X,"^",18)
 S USERDUZ=$P(X,"^",19)
 S MENUOPTION=$P(X,"^",20)
 ;
 S ^TMP("MAG",$J,"BATCH Q/R","PATIENT DFN")=DFN
 Q
 ;
SERVICES(I) ; get the services for a consult run
 N IEN,J
 S J=0
 F  S J=$O(^MAGDSTT(2006.543,I,1,J)) Q:'J  D
 . S IEN=^MAGDSTT(2006.543,I,1,J,0)
 . S CONSULTSERVICES(IEN)=$$GET1^DIQ(123.5,IEN,.01,"E")
 . Q
 Q
