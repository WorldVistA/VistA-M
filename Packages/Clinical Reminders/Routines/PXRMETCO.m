PXRMETCO ; SLC/PJH - QUERI Extract Compliance Report ;06/09/2009
 ;;2.0;CLINICAL REMINDERS;**6,12**;Feb 04, 2005;Build 73
 ;
 ;
ADHOC(IEN,PXRMSTRT,PXRMSTOP) ;Ad Hoc Conformance Report
 D DUMMY1^PXRMRUTL
 Q
 ;
 D JOB
 Q
 ;
 ;BOOKMARK - cloned from PXRMETX, needs modifying to avoid patient list
 ;update. Build ^TMP("PXRMETX",$J) for report
 ;
REPORT ;Initialise
 K ^TMP("PXRMETX",$J)
 ;Workfile node for ^TMP
 S PXRMNODE="PXRMRULE"
 ;Get details from parameter file
 N DATA,DATES,LIST,NAME,PARTYPE,TEXT
 ;N PERIOD,TEXT,YEAR
 S DATA=$G(^PXRM(810.2,IEN,0))
 ;
 ;Determine Extract Name and period
 S NAME=$P(DATA,U),PARTYPE=$P(DATA,U,2)
 ;S YEAR=$P(NEXT,"/",2),PERIOD=$P(NEXT,"/")
 ;Calculate report period start and end dates
 ;D CALC^PXRMEUT(NEXT,.PXRMSTRT,.PXRMSTOP)
 ;Determine output name for patient list and extract summary
 S DATES=$$FMTE^XLFDT(PXRMSTRT)_" - "_$$FMTE^XLFDT(PXRMSTOP)
 ;
 ;Bookmark - Needs inventive patient list names
 S LIST=NAME_" REPORT "_DATES
 ;Process (single) Denominator rule into patient list
 N INDP,INTP,SEQ,SUB,SUFFIX
 S SEQ=""
 F  S SEQ=$O(^PXRM(810.2,IEN,10,"B",SEQ)) Q:'SEQ  D
 .S SUB=$O(^PXRM(810.2,IEN,10,"B",SEQ,"")) Q:'SUB
 .S DATA=$G(^PXRM(810.2,IEN,10,SUB,0)) Q:DATA=""
 .S PXRMRULE=$P(DATA,U,2) Q:'PXRMRULE
 .S SUFFIX=$P(DATA,U,3)
 .I SUFFIX="" S SUFFIX="DENOMINATOR "_SEQ
 .S INDP=+$P(DATA,U,4)
 .S INTP=+$P(DATA,U,5)
 .;Create new patient list
 .S PXRMLIST=$$CRLST^PXRMRUL1(LIST_" "_SUFFIX) Q:'PXRMLIST
 .D START^PXRMRULE(PXRMRULE,PXRMLIST,PXRMNODE,PXRMSTRT,PXRMSTOP,IEN,INDP,INTP)
 .;Clear ^TMP lists created for rule
 .D CLEAR^PXRMRULE(PXRMRULE,PXRMNODE)
 .;Process reminders
 .D REM^PXRMETXR(SUB,PXRMLIST)
 ;
 ;Bookmark - Report stuff goes here
 ;Update totals section
 N APPL,CNT,DUE,DATA,ETYP,EVAL
 N FAPPL,FCNT,FDATA,FDUE,FEVAL,FGNAM,FIND,FNAPPL,FNDUE,FSEQ
 N NAPPL,NDUE,PXRMLIST,RCNT,RIEN,RSEQ,SEQ
 S SEQ=0,CNT=1
 F  S SEQ=$O(^TMP("PXRMETX",$J,SEQ)) Q:'SEQ  D
 .S RCNT=0,RSEQ=0
 .F  S RCNT=$O(^TMP("PXRMETX",$J,SEQ,RCNT)) Q:'RCNT  D
 ..S DATA=$G(^TMP("PXRMETX",$J,SEQ,RCNT)) Q:'DATA
 ..S RIEN=$P(DATA,U),PXRMLIST=$P(DATA,U,5)
 ..S EVAL=$P(DATA,U,2),APPL=$P(DATA,U,3),DUE=$P(DATA,U,4)
 ..S NAPPL=EVAL-APPL,NDUE=APPL-DUE
 ..S CNT=CNT+1,RSEQ=RSEQ+1
 ..;bookmark - write patient line
 ..;For each count type
 ..S ETYP="",FCNT=CNT
 ..F  S ETYP=$O(^TMP("PXRMETX",$J,SEQ,RCNT,ETYP)) Q:ETYP=""  D
 ...;For each term
 ...S FIND=0,FSEQ=0
 ...F  S FIND=$O(^TMP("PXRMETX",$J,SEQ,RCNT,ETYP,FIND)) Q:FIND=""  D
 ....;Update finding totals
 ....S FDATA=$G(^TMP("PXRMETX",$J,SEQ,RCNT,ETYP,FIND)),FCNT=FCNT+1
 ....S FEVAL=$P(FDATA,U,2),FAPPL=$P(FDATA,U,3),FDUE=$P(FDATA,U,4)
 ....S FNAPPL=FEVAL-FAPPL,FNDUE=FAPPL-FDUE
 ....S FSEQ=FSEQ+1,FGNAM=$P(DATA,U,9)
 ....;Bookmark - write finding line
 ..;Update CNT
 ..S CNT=FCNT
 Q
 ;
 ;Determine whether the report should be queued.
JOB ;
 N DBDUZ,PXRMQUE
 N %ZIS,ZTDESC,ZTSAVE,ZTRTN,ZTSK
 S DBDUZ=DUZ
 D SAVE^PXRMXQUE
 S %ZIS="Q"
 S ZTDESC="QUERI Compliance Report - print"
 S ZTRTN="REPORT^PXRMETCO"
 S ZTSK=1
 S PXRMQUE=0
 S PXRMQUE=$$DEVICE^PXRMXQUE(ZTRTN,ZTDESC,.ZTSAVE,.%ZIS,.ZTSK)
 I PXRMQUE=1 G EXIT
 I PXRMQUE>0 S ^XTMP(PXRMXTMP,"PRZTSK")=PXRMQUE
 Q
 ;
EXIT ;Clean things up.
 D ^%ZISC
 D HOME^%ZIS
 K IO("Q")
 K DIRUT,DTOUT,DUOUT,POP,ZTREQ
 I $D(ZTSK) D KILL^%ZTLOAD
 K ZTSK,ZTQUEUED
 K ^TMP("PXRMXTR",$J)
 Q
 ;
SAVE ;Save the variables for queing.
 S ZTSAVE("IEN")=""
 S ZTSAVE("PXRMSTRT")=""
 S ZTSAVE("PXRMSTOP")=""
 Q
 ;
 ;
QUE ;BOOKMARK - NOT USED
 ;Queue the MST synchronization job.
 N DIR,DTOUT,DUOUT,MINDT,SDTIME,STIME,X,Y
 S MINDT=$$NOW^XLFDT
 W !,"Queue the Clinical Reminders MST synchronization."
 S DIR("A",1)="Enter the date and time you want the job to start."
 S DIR("A",2)="It must be after "_$$FMTE^XLFDT(MINDT,"5Z")
 S DIR("A")="Start the task at: "
 S DIR(0)="DAU"_U_MINDT_"::RSX"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q
 S SDTIME=Y
 K DIR
 S DIR(0)="YA"
 S DIR("A")="Do you want to run the MST synchronization at the same time every day? "
 S DIR("B")="Y"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q
 I Y S STIME="1."_$P(SDTIME,".",2)
 E  S STIME=-1
 ;
 ;Put the task into the queue.
 K ZTSAVE
 ;S ZTSAVE("START")=SDTIME
 S ZTSAVE("STIME")=STIME
 S ZTRTN="SYNCH^PXRMMST"
 S ZTDESC="Clinical Reminders MST synchronization job"
 S ZTDTH=SDTIME
 S ZTIO=""
 D ^%ZTLOAD
 W !,"Task number ",ZTSK," queued."
 Q
