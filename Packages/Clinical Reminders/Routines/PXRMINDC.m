PXRMINDC ; SLC/PKR - Index counting routines. ;11/02/2009
 ;;2.0;CLINICAL REMINDERS;**4,6,17**;Feb 04, 2005;Build 102
 ;
 ;========================================================
CNT5(FILENUM,COUNT) ;Get date counts for indexes where the date
 ;is at subscript 5. Works for file numbers:
 ;63, 70, 120.5, 601.2, 601.84,
 ;9000010.11, 9000010.12, 9000010.13, 9000010.16, 9000010.23
 N DAS,DATE,DFN,IND,ITEM,YEAR
 I '$D(ZTQUEUED) W !,"Counting file number "_FILENUM
 S IND=0
 S DFN=""
 F  S DFN=$O(^PXRMINDX(FILENUM,"PI",DFN)) Q:DFN=""  D
 . S IND=IND+1
 . I '$D(ZTQUEUED),(IND#10000=0) W "."
 . S ITEM=""
 . F  S ITEM=$O(^PXRMINDX(FILENUM,"PI",DFN,ITEM)) Q:ITEM=""  D
 .. S DATE=""
 .. F  S DATE=$O(^PXRMINDX(FILENUM,"PI",DFN,ITEM,DATE)) Q:DATE=""  D
 ... S YEAR=$E(DATE,1,3)
 ... S DAS=""
 ... F  S DAS=$O(^PXRMINDX(FILENUM,"PI",DFN,ITEM,DATE,DAS)) Q:DAS=""  D
 .... S COUNT(YEAR)=$G(COUNT(YEAR))+1
 Q
 ;
 ;========================================================
CNT6(FILENUM,COUNT) ;Get date counts for indexes where the date
 ;is at subscript 6. Works for file numbers:
 ;9000010.07, 9000010.18
 N DAS,DATE,DFN,IND,ITEM,TYPE,YEAR
 I '$D(ZTQUEUED) W !,"Counting file number "_FILENUM
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
 .... S YEAR=$E(DATE,1,3)
 .... S DAS=""
 .... F  S DAS=$O(^PXRMINDX(FILENUM,"PPI",DFN,TYPE,ITEM,DATE,DAS)) Q:DAS=""  D
 ..... S COUNT(YEAR)=$G(COUNT(YEAR))+1
 Q
 ;
 ;========================================================
CNTPL(FILENUM,COUNT) ;Get date counts for Problem List indexes where the
 ;date is at subscript 7. Works for file numbers:
 ;9000011
 N DAS,DATE,DFN,IND,ITEM,PRIORITY,STATUS,TYPE,YEAR
 I '$D(ZTQUEUED) W !,"Counting file number "_FILENUM
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
 ..... S YEAR=$E(DATE,1,3)
 ..... S DAS=""
 ..... F  S DAS=$O(^PXRMINDX(FILENUM,"PSPI",DFN,STATUS,PRIORITY,ITEM,DATE,DAS)) Q:DAS=""  D
 ...... S COUNT(YEAR)=$G(COUNT(YEAR))+1
 Q
 ;
 ;========================================================
CNTPTF(FILENUM,COUNT) ;Get date counts for PTF indexes where the
 ;date is at subscript 7. Works for file numbers:
 ;45
 N DAS,DATE,DFN,IND,ITEM,NODE,TYPE,YEAR
 I '$D(ZTQUEUED) W !,"Counting file number "_FILENUM
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
 ..... S YEAR=$E(DATE,1,3)
 ..... S DAS=""
 ..... F  S DAS=$O(^PXRMINDX(FILENUM,TYPE,"PNI",DFN,NODE,ITEM,DATE,DAS)) Q:DAS=""  D
 ...... S COUNT(YEAR)=$G(COUNT(YEAR))+1
 Q
 ;
 ;========================================================
CNTSS(FILENUM,COUNT) ;Get date counts for indexes where the start date
 ;is at subscript 5 and the stop date is at subscript 6.
 ;Works for file numbers: 52, 55, 100
 N DAS,DFN,IND,ITEM,START,STOP,YEAR
 I '$D(ZTQUEUED) W !,"Counting file number "_FILENUM
 S IND=0
 S DFN=""
 F  S DFN=$O(^PXRMINDX(FILENUM,"PI",DFN)) Q:DFN=""  D
 . S IND=IND+1
 . I '$D(ZTQUEUED),(IND#10000=0) W "."
 . S ITEM=""
 . F  S ITEM=$O(^PXRMINDX(FILENUM,"PI",DFN,ITEM)) Q:ITEM=""  D
 .. S START=""
 .. F  S START=$O(^PXRMINDX(FILENUM,"PI",DFN,ITEM,START)) Q:START=""  D
 ... S YEAR=$E(START,1,3)
 ... S STOP=""
 ... F  S STOP=$O(^PXRMINDX(FILENUM,"PI",DFN,ITEM,START,STOP)) Q:STOP=""  D
 .... S DAS=""
 .... F  S DAS=$O(^PXRMINDX(FILENUM,"PI",DFN,ITEM,START,STOP,DAS)) Q:DAS=""  D
 ..... S COUNT(YEAR)=$G(COUNT(YEAR))+1
 Q
 ;
 ;========================================================
COUNT ;Driver for making index counts.
 N GBL,LIST,TASKIT
 W !,"Which indexes do you want to count?"
 D SEL^PXRMSXRM(.LIST,.GBL)
 I LIST="" Q
 ;See if this should be tasked.
 S TASKIT=$$ASKTASK^PXRMSXRM
 I TASKIT D
 . W !,"Queue the Clinical Reminders Index count."
 . D TASKIT(LIST,.GBL,.ROUTINE)
 E  D RUNNOW(LIST,.GBL)
 Q
 ;
 ;========================================================
MESSAGE(FILENUM,COUNT,TOTAL,START,END) ;Build the MailMan message giving the
 ;count breakdown.
 N COFF,FROM,ML,NAME,NL,PERC,TEXT,TO,YEAR,XMSUB
 K ^TMP("PXRMXMZ",$J)
 S ML=$$MAX^XLFMTH($L(TOTAL)+2,8)
 S COFF=ML-5
 S NAME=$$GET1^DID(FILENUM,"","","NAME")
 S XMSUB="Yearly data distribution for global "_NAME
 S ^TMP("PXRMXMZ",$J,1,0)="File name: "_NAME
 S ^TMP("PXRMXMZ",$J,2,0)="Count finished at "_$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 S ^TMP("PXRMXMZ",$J,3,0)=$$ETIME^PXRMSXRM(START,END)
 S ^TMP("PXRMXMZ",$J,4,0)=" "
 S ^TMP("PXRMXMZ",$J,5,0)="Year"_$$INSCHR^PXRMEXLC(COFF," ")_"Count"_$J("%",8)
 S ^TMP("PXRMXMZ",$J,6,0)="----"_$$INSCHR^PXRMEXLC(COFF," ")_"-----"_$J("-----",10)
 S NL=6,YEAR=0
 F  S YEAR=$O(COUNT(YEAR)) Q:YEAR=""  D
 . S PERC=100*COUNT(YEAR)/TOTAL
 . S TEXT=YEAR_$J(COUNT(YEAR),ML,0)_$J(PERC,10,2)
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=TEXT
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" "
 S TEXT="Total entries: "_TOTAL
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=TEXT
 I TOTAL=0 D
 . I '$D(^PXRMINDX(FILENUM)) S TEXT="The index for file "_NAME_" does not exist!"
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=TEXT
 I TOTAL>0,'$D(^PXRMINDX(FILENUM,"DATE BUILT")) D
 . S TEXT="Warning, the index for file "_NAME_" may be incomplete or corrupted!"
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=TEXT
 S FROM=$$GET1^DIQ(200,DUZ,.01)
 S TO(DUZ)=""
 D SEND^PXRMMSG("PXRMXMZ",XMSUB,.TO,FROM)
 K ^TMP("PXRMXMZ",$J)
 Q
 ;
 ;===============================================================
RUNNOW(LIST,GBL) ;Run the routines now.
 N COUNT,END,FN,IND,LI,NUM,ROUTINE,RTN,START,TOTAL
 S ROUTINE(45)="CNTPTF^PXRMINDC"
 S ROUTINE(52)="CNTSS^PXRMINDC"
 S ROUTINE(55)="CNTSS^PXRMINDC"
 S ROUTINE(63)="CNT5^PXRMINDC"
 S ROUTINE(70)="CNT5^PXRMINDC"
 S ROUTINE(100)="CNTSS^PXRMINDC"
 S ROUTINE(120.5)="CNT5^PXRMINDC"
 S ROUTINE(601.2)="CNT5^PXRMINDC"
 S ROUTINE(601.84)="CNT5^PXRMINDC"
 S ROUTINE(9000011)="CNTPL^PXRMINDC"
 S ROUTINE(9000010.07)="CNT6^PXRMINDC"
 S ROUTINE(9000010.11)="CNT5^PXRMINDC"
 S ROUTINE(9000010.12)="CNT5^PXRMINDC"
 S ROUTINE(9000010.13)="CNT5^PXRMINDC"
 S ROUTINE(9000010.16)="CNT5^PXRMINDC"
 S ROUTINE(9000010.18)="CNT6^PXRMINDC"
 S ROUTINE(9000010.23)="CNT5^PXRMINDC"
 S NUM=$L(LIST,",")-1
 F IND=1:1:NUM D
 . S LI=$P(LIST,",",IND)
 . S FN=GBL(LI)
 . S RTN=ROUTINE(FN)
 . S RTN=RTN_"("_FN_",.COUNT)"
 . S START=$H
 . K COUNT
 . I $D(^PXRMINDX(FN)) D @RTN
 . S END=$H
 . D TOTAL(.COUNT,.TOTAL)
 . D MESSAGE(FN,.COUNT,TOTAL,START,END)
 Q
 ;
 ;===============================================================
TASKIT(LIST,GBL,ROUTINE) ;Count the indexes as a tasked job.
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
 S ZTRTN="TASKJOB^PXRMINDC"
 S ZTDESC="Clinical Reminders Index count"
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
 . D RUNNOW^PXRMINDC(LI,.GBL)
 Q
 ;
 ;========================================================
TOTAL(COUNT,TOTAL) ;Convert the FileMan years in COUNT to regular
 ;years get the total number of entries in count.
 N TC,YEAR
 S (TOTAL,YEAR)=0
 F  S YEAR=$O(COUNT(YEAR)) Q:YEAR=""  D
 . S TOTAL=TOTAL+COUNT(YEAR)
 . S TC(YEAR+1700)=COUNT(YEAR)
 K COUNT
 M COUNT=TC
 Q
 ;
