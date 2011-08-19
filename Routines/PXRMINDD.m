PXRMINDD ; SLC/PKR - Index string date checking routines. ;11/02/2009
 ;;2.0;CLINICAL REMINDERS;**4,6,17**;Feb 04, 2005;Build 102
 ;
 ;========================================================
CNT5(FILENUM,NSD) ;Check for string dates for indexes where the date
 ;is at subscript 5. Works for file numbers:
 ;63, 70, 120.5, 601.2, 601.84
 ;9000010.11, 9000010.12, 9000010.13, 9000010.16, 9000010.23
 N DAS,DATE,DFN,IND,ITEM
 I '$D(ZTQUEUED) W !,"Checking file number "_FILENUM
 S IND=0
 S DFN=""
 F  S DFN=$O(^PXRMINDX(FILENUM,"PI",DFN)) Q:DFN=""  D
 . S IND=IND+1
 . I '$D(ZTQUEUED),(IND#10000=0) W "."
 . S ITEM=""
 . F  S ITEM=$O(^PXRMINDX(FILENUM,"PI",DFN,ITEM)) Q:ITEM=""  D
 .. S DATE=""
 .. F  S DATE=$O(^PXRMINDX(FILENUM,"PI",DFN,ITEM,DATE)) Q:DATE=""  D
 ... I +DATE=DATE Q
 ... S DAS=""
 ... F  S DAS=$O(^PXRMINDX(FILENUM,"PI",DFN,ITEM,DATE,DAS)) Q:DAS=""  D
 .... S NSD=NSD+1
 .... S ^TMP($J,"SDATE",NSD)="^PXRMINDX("_FILENUM_",""PI"","_DFN_","_ITEM_","""_DATE_""","_DAS_")"
 Q
 ;
 ;========================================================
CNT6(FILENUM,NSD) ;Check for string dates for indexes where the date
 ;is at subscript 6. Works for file numbers:
 ;9000010.07, 9000010.18
 N DAS,DATE,DFN,IND,ITEM,TYPE
 I '$D(ZTQUEUED) W !,"Checking file number "_FILENUM
 S IND=0
 S DFN=""
 F  S DFN=$O(^PXRMINDX(FILENUM,"PPI",DFN)) Q:DFN=""  D
 . S IND=IND+1
 . I '$D(ZTQUEUED),(IND#10000=0) W "."
 . S TYPE=""
 . F  S TYPE=$O(^PXRMINDX(FILENUM,"PPI",DFN,TYPE)) Q:TYPE=""  D
 .. S ITEM=""
 .. F  S ITEM=$O(^PXRMINDX(FILENUM,"PPI",DFN,TYPE,ITEM)) Q:ITEM=""  D
 ... S DATE=""
 ... F  S DATE=$O(^PXRMINDX(FILENUM,"PPI",DFN,TYPE,ITEM,DATE)) Q:DATE=""  D
 .... I +DATE=DATE Q
 .... S DAS=""
 .... F  S DAS=$O(^PXRMINDX(FILENUM,"PPI",DFN,TYPE,ITEM,DATE,DAS)) Q:DAS=""  D
 ..... S NSD=NSD+1
 ..... S ^TMP($J,"SDATE",NSD)="^PXRMINDX("_FILENUM_",""PPI"","_DFN_","_TYPE_","_ITEM_","""_DATE_""","_DAS_")"
 Q
 ;
 ;========================================================
CNTPL(FILENUM,NSD) ;Check for string date for Problem List indexes where the
 ;date is at subscript 7. Works for file numbers:
 ;9000011
 N DAS,DATE,DFN,IND,ITEM,PRIORITY,STATUS,TYPE
 I '$D(ZTQUEUED) W !,"Checking file number "_FILENUM
 S IND=0
 S DFN=""
 F  S DFN=$O(^PXRMINDX(FILENUM,"PSPI",DFN)) Q:DFN=""  D
 . S IND=IND+1
 . I '$D(ZTQUEUED),(IND#10000=0) W "."
 . S STATUS=""
 . F  S STATUS=$O(^PXRMINDX(FILENUM,"PSPI",DFN,STATUS)) Q:STATUS=""  D
 .. S PRIORITY=""
 .. F  S PRIORITY=$O(^PXRMINDX(FILENUM,"PSPI",DFN,STATUS,PRIORITY)) Q:PRIORITY=""  D
 ... S ITEM=""
 ... F  S ITEM=$O(^PXRMINDX(FILENUM,"PSPI",DFN,STATUS,PRIORITY,ITEM)) Q:ITEM=""  D
 .... S DATE=""
 .... F  S DATE=$O(^PXRMINDX(FILENUM,"PSPI",DFN,STATUS,PRIORITY,ITEM,DATE)) Q:DATE=""  D
 ..... I +DATE=DATE Q
 ..... S DAS=""
 ..... F  S DAS=$O(^PXRMINDX(FILENUM,"PSPI",DFN,STATUS,PRIORITY,ITEM,DATE,DAS)) Q:DAS=""  D
 ...... S NSD=NSD+1
 ...... S ^TMP($J,"SDATE",NSD)="^PXRMINDX("_FILENUM_",""PSPI"","_DFN_","_STATUS_","_PRIORITY_","_ITEM_","""_DATE_""","_DAS_")"
 Q
 ;
 ;========================================================
CNTPTF(FILENUM,NSD) ;Check for string dates for PTF indexes where the
 ;date is at subscript 7. Works for file numbers:
 ;45
 N DAS,DATE,DFN,IND,ITEM,NODE,TYPE
 I '$D(ZTQUEUED) W !,"Checking file number "_FILENUM
 S IND=0
 F TYPE="ICD0","ICD9" D
 . S DFN=""
 . F  S DFN=$O(^PXRMINDX(FILENUM,TYPE,"PNI",DFN)) Q:DFN=""  D
 .. S IND=IND+1
 .. I '$D(ZTQUEUED),(IND#10000=0) W "."
 .. S NODE=""
 .. F  S NODE=$O(^PXRMINDX(FILENUM,TYPE,"PNI",DFN,NODE)) Q:NODE=""  D
 ... S ITEM=""
 ... F  S ITEM=$O(^PXRMINDX(FILENUM,TYPE,"PNI",DFN,NODE,ITEM)) Q:ITEM=""  D
 .... S DATE=""
 .... F  S DATE=$O(^PXRMINDX(FILENUM,TYPE,"PNI",DFN,NODE,ITEM,DATE)) Q:DATE=""  D
 ..... I +DATE=DATE Q
 ..... S DAS=""
 ..... F  S DAS=$O(^PXRMINDX(FILENUM,TYPE,"PNI",DFN,NODE,ITEM,DATE,DAS)) Q:DAS=""  D
 ...... S NSD=NSD+1
 ...... S ^TMP($J,"SDATE",NSD)="^PXRMINDX("_FILENUM_","_TYPE_",""PNI"","_DFN_","_NODE_","_ITEM_","""_DATE_""","_DAS_")"
 Q
 ;
 ;========================================================
CNTSS(FILENUM,NSD) ;Check for string dates for indexes where the start date
 ;is at subscript 5 and the stop date is at subscript 6.
 ;Works for file numbers: 52, 55, 100
 N DAS,DFN,IND,ITEM,START,STOP
 I '$D(ZTQUEUED) W !,"Checking file number "_FILENUM
 S IND=0
 S DFN=""
 F  S DFN=$O(^PXRMINDX(FILENUM,"PI",DFN)) Q:DFN=""  D
 . S IND=IND+1
 . I '$D(ZTQUEUED),(IND#10000=0) W "."
 . S ITEM=""
 . F  S ITEM=$O(^PXRMINDX(FILENUM,"PI",DFN,ITEM)) Q:ITEM=""  D
 .. S START=""
 .. F  S START=$O(^PXRMINDX(FILENUM,"PI",DFN,ITEM,START)) Q:START=""  D
 ... I +START=START Q
 ... S STOP=""
 ... F  S STOP=$O(^PXRMINDX(FILENUM,"PI",DFN,ITEM,START,STOP)) Q:STOP=""  D
 .... S DAS=""
 .... F  S DAS=$O(^PXRMINDX(FILENUM,"PI",DFN,ITEM,START,STOP,DAS)) Q:DAS=""  D
 ..... S NSD=NSD+1
 ..... S ^TMP($J,"SDATE",NSD)="^PXRMINDX("_FILENUM_",""PI"","_DFN_","_ITEM_","""_START_""","_STOP_","_DAS_")"
 Q
 ;
 ;========================================================
CHECK ;Driver for making index date checks.
 N GBL,LIST,TASKIT
 W !,"Which indexes do you want to check?"
 D SEL^PXRMSXRM(.LIST,.GBL)
 I LIST="" Q
 ;See if this should be tasked.
 S TASKIT=$$ASKTASK^PXRMSXRM
 I TASKIT D
 . W !,"Queue the Clinical Reminders Index date check."
 . D TASKIT(LIST,.GBL,.ROUTINE)
 E  D RUNNOW(LIST,.GBL)
 Q
 ;
 ;========================================================
MESSAGE(FILENUM,NSD,START,END) ;Build the MailMan message giving the
 ;list of entries with string dates.
 N FROM,IND,NAME,NL,TEXT,TO,XMSUB
 K ^TMP("PXRMXMZ",$J)
 S XMSUB="CR Index string date check for file #"_FILENUM
 S NAME=$$GET1^DID(FILENUM,"","","NAME")_", file #"_FILENUM
 I NSD=0 S TEXT="No string dates were found for "_NAME_"."
 I NSD>0 S TEXT="A total of "_NSD_" string dates were found for "_NAME_"."
 S ^TMP("PXRMXMZ",$J,1,0)=TEXT
 S ^TMP("PXRMXMZ",$J,2,0)="Check finished at "_$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 S ^TMP("PXRMXMZ",$J,3,0)=$$ETIME^PXRMSXRM(START,END)
 S ^TMP("PXRMXMZ",$J,4,0)=" "
 I NSD=0,'$D(^PXRMINDX(FILENUM)) D
 . S ^TMP("PXRMXMZ",$J,5,0)="The index for file number "_FILENUM_" does not exist."
 . S ^TMP("PXRMXMZ",$J,6,0)=" "
 I NSD>0 D
 . S ^TMP("PXRMXMZ",$J,5,0)="The following entries with string dates were found:"
 . S NL=5
 . F IND=1:1:NSD D
 .. S NL=NL+1
 .. S ^TMP("PXRMXMZ",$J,NL,0)=" "_^TMP($J,"SDATE",IND)
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" "
 S FROM=$$GET1^DIQ(200,DUZ,.01)
 S TO(DUZ)=""
 D SEND^PXRMMSG("PXRMXMZ",XMSUB,.TO,FROM)
 K ^TMP($J,"SDATE"),^TMP("PXRMXMZ",$J)
 Q
 ;
 ;===============================================================
RUNNOW(LIST,GBL) ;Run the routines now.
 N END,FN,IND,LI,NSD,NUM,ROUTINE,RTN,START,TOTAL
 K ^TMP($J,"SDATE")
 S ROUTINE(45)="CNTPTF^PXRMINDD"
 S ROUTINE(52)="CNTSS^PXRMINDD"
 S ROUTINE(55)="CNTSS^PXRMINDD"
 S ROUTINE(63)="CNT5^PXRMINDD"
 S ROUTINE(70)="CNT5^PXRMINDD"
 S ROUTINE(100)="CNTSS^PXRMINDD"
 S ROUTINE(120.5)="CNT5^PXRMINDD"
 S ROUTINE(601.2)="CNT5^PXRMINDD"
 S ROUTINE(601.84)="CNT5^PXRMINDD"
 S ROUTINE(9000011)="CNTPL^PXRMINDD"
 S ROUTINE(9000010.07)="CNT6^PXRMINDD"
 S ROUTINE(9000010.11)="CNT5^PXRMINDD"
 S ROUTINE(9000010.12)="CNT5^PXRMINDD"
 S ROUTINE(9000010.13)="CNT5^PXRMINDD"
 S ROUTINE(9000010.16)="CNT5^PXRMINDD"
 S ROUTINE(9000010.18)="CNT6^PXRMINDD"
 S ROUTINE(9000010.23)="CNT5^PXRMINDD"
 S NUM=$L(LIST,",")-1
 F IND=1:1:NUM D
 . S LI=$P(LIST,",",IND)
 . S NSD=0
 . S FN=GBL(LI)
 . S RTN=ROUTINE(FN)
 . S RTN=RTN_"("_FN_",.NSD)"
 . S START=$H
 . I $D(^PXRMINDX(FN)) D @RTN
 . S END=$H
 . D MESSAGE(FN,NSD,START,END)
 Q
 ;
 ;===============================================================
TASKIT(LIST,GBL,ROUTINE) ;Check the indexes as a tasked job.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,MINDT,SDTIME,X,Y
 S MINDT=$$NOW^XLFDT
 S DIR("A",1)="Enter the date and time you want the job to start."
 S DIR("A",2)="It must be after "_$$FMTE^XLFDT(MINDT,"5Z")
 S DIR("A")="Start the task at: "
 S DIR(0)="DAU"_U_MINDT_"::RSX"
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) Q
 I $D(DTOUT)!$D(DUOUT) Q
 S SDTIME=Y
 K DIR
 ;Put the task into the queue.
 K ZTSAVE
 S ZTSAVE("LIST")=""
 S ZTSAVE("GBL(")=""
 S ZTRTN="TASKJOB^PXRMINDD"
 S ZTDESC="Clinical Reminders Index string date check"
 S ZTDTH=SDTIME
 S ZTIO=""
 D ^%ZTLOAD
 W !,"Task number ",ZTSK," queued."
 Q
 ;
 ;===============================================================
TASKJOB ;Execute as tasked job. LIST and GBL come through ZTSAVE.
 N IND,LI,NUM
 S ZTREQ="@"
 S ZTSTOP=0
 S NUM=$L(LIST,",")-1
 F IND=1:1:NUM D
 .;Check to see if the task has had a stop request
 . I $$S^%ZTLOAD S ZTSTOP=1,IND=NUM Q
 . S LI=$P(LIST,",",IND)_","
 . D RUNNOW^PXRMINDD(LI,.GBL)
 Q
 ;
