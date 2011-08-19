PXRMXBSY ; SLC/PJH,PKR - Let the user know the computer is busy. ;02/11/2009
 ;;2.0;CLINICAL REMINDERS;**4,12**;Feb 04, 2005;Build 73
 ;
 ;=======================================================
ERROR ;Print Error message
 I $D(^XTMP(PXRMXTMP,"ERROR"))>0 D
 . W !!,"WARNING - REMINDER EVALUATION ERRORS; RESULTS MAY BE INCORRECT!"
 . N ERRNAME S ERRNAME=""
 . F  S ERRNAME=$O(^XTMP(PXRMXTMP,"ERROR",ERRNAME)) Q:ERRNAME=""  D
 .. W !,"Reminder: "_ERRNAME_" had a total of "_$G(^XTMP(PXRMXTMP,"ERROR",ERRNAME))_" evaluation errors."
 ;
 ;Print Could not be determine message
 I $D(^XTMP(PXRMXTMP,"CNBD"))>0 D
 . W !!,"WARNING - REMINDER STATUS COULD NOT BE DETERMINED; RESULTS MAY BE INCORRECT!"
 . N ERRNAME S ERRNAME=""
 . F  S ERRNAME=$O(^XTMP(PXRMXTMP,"CNBD",ERRNAME)) Q:ERRNAME=""  D
 .. W !,"Reminder: "_ERRNAME_" had a total of "_$G(^XTMP(PXRMXTMP,"CNBD",ERRNAME))_" CNBD errors."
 Q
 ;
 ;=======================================================
NOTIFY(TEXT,SPINCNT) ;
 I '$D(ZTQUEUED) D SPIN(TEXT,.SPINCNT)
 I $D(ZTQUEUED) D TASKMSG(TEXT,SPINCNT)
 Q
 ;
 ;=======================================================
SPIN(TEXT,SPINCNT) ;Move the spinner.
 N QUAD
 I SPINCNT=0 W !!,TEXT,"  "
 S SPINCNT=SPINCNT+1
 S QUAD=SPINCNT#8
 I QUAD=1 W @IOBS,"|"
 I QUAD=3 W @IOBS,"/"
 I QUAD=5 W @IOBS,"-"
 I QUAD=7 W @IOBS,"\"
 Q
 ;
 ;=======================================================
TASKMSG(TEXT,SPINCNT) ;
 I SPINCNT=0 S ZTSTOP=$$S^%ZTLOAD(TEXT)
 Q
 ;
