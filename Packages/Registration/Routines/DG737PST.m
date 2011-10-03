DG737PST ;BAY/JAT ;file #45 cleanup
 ;;5.3;Registration;**737**;Aug 13, 1993;Build 8
 Q
 ; loosely based on PXRMINDD routine released in PX*2*4
CHECK ;Driver for making index date checks & stripping trailing zeros
 N GBL,LIST,ROUTINE
 W !,"Queue the Clinical Reminders Index date check and update."
 S GBL(4)=45
 S LIST="4,"
 S ROUTINE(45)="CNTPTF^DG737PST"
 D TASKIT(LIST,.GBL,.ROUTINE)
 Q
 ;
CNTPTF(FILENUM,NSD) ;Check for string dates for PTF indexes where the
 ;date is at subscript 7. Works for file numbers:
 ;45
 K ^TMP($J,"SDATE"),^TMP("PXRMXMZ",$J)
 N DAS,DATE,DFN,IND,ITEM,NODE,TYPE
 I '$D(ZTQUEUED) W !,"Checking file number "_FILENUM
 S IND=0
 ; only procedure codes affected (file 80.1) therefore only
 ; sub-file 45.01 or 45.05 are involved
 F TYPE="ICD0" D
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
 ...... D UPDATE
 Q
 ;
UPDATE ; strip trailing zeros from date,e.g., 3031005.1340 or 3010816.134050
 N DGNEWDT,DGFILE,DGDA,DGIENS,FDA
 S DGNEWDT=+DATE
 S DGFILE=$P(DAS,";",2)
 I DGFILE'="P"&(DGFILE'="S") Q
 I DGFILE="P" S DGFILE=45.05
 I DGFILE="S" S DGFILE=45.01
 ; below patterned after UPD^DGENDBS
 S DGDA=$P(DAS,";",3)
 S DGDA(1)=+DAS
 S DGIENS=$$IENS^DILF(.DGDA)
 S FDA(DGFILE,DGIENS,.01)=DGNEWDT
 D FILE^DIE("K","FDA")
 Q
 ; 
 ;========================================================
MESSAGE(FILENUM,NSD,START,END) ;Build the MailMan message giving the
 ;list of entries with string dates.
 N IND,NAME,NL,TEXT,XMSUB
 K ^TMP("PXRMXMZ",$J)
 S XMSUB="CR Index string date check for file #"_FILENUM
 S NAME=$$GET1^DID(FILENUM,"","","NAME")_", file #"_FILENUM
 I NSD=0 S TEXT="No string dates were found for "_NAME_"."
 I NSD>0 S TEXT="A total of "_NSD_" string dates were found for "_NAME_"."
 S ^TMP("PXRMXMZ",$J,1,0)=TEXT
 S ^TMP("PXRMXMZ",$J,2,0)="Check finished at "_$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 S ^TMP("PXRMXMZ",$J,3,0)=$$ETIME^DG737PST(START,END)
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
 D SEND^DG737PST(XMSUB,DUZ)
 ;K ^TMP($J,"SDATE"),^TMP("PXRMXMZ",$J)
 Q
 ;
 ;===============================================================
RUNNOW(LIST,GBL) ;Run the routine now.
 N END,FN,IND,LI,NSD,NUM,ROUTINE,RTN,START,TOTAL
 K ^TMP($J,"SDATE")
 S ROUTINE(45)="CNTPTF^DG737PST"
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
 S ZTRTN="TASKJOB^DG737PST"
 S ZTDESC="Clinical Reminders Index string date check and update"
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
 . D RUNNOW^DG737PST(LI,.GBL)
 Q
 ;
ETIME(START,END) ;Calculate and format the elapsed time.
 ;START and END are $H times.
 N ETIME,TEXT
 S ETIME=$$HDIFF^XLFDT(END,START,2)
 I ETIME>90 D
 . S ETIME=$$HDIFF^XLFDT(END,START,3)
 . S TEXT="Elapsed time: "_ETIME
 E  S TEXT="Elapsed time: "_ETIME_" secs"
 Q TEXT
SEND(XMSUB,USER) ;Send a MailMan message to the user. The text of the message is in
 ;^TMP("PXRMXMZ",$J,N,0), where there are N lines of text. The subject
 ;is the string XMSUB.
 N MGIEN,MGROUP,NL,REF,XMDUZ,XMY,XMZ
 ;If this is a test run write out the message.
 ;I $G(PXRMDEBG) D
 ;. S REF="^TMP(""PXRMXMZ"",$J)"
 ;. D AWRITE^PXRMUTIL(REF)
 ;Make sure the subject does not exceed 64 characters.
 S XMSUB=$E(XMSUB,1,64)
 ;Make the sender the Postmaster.
 S XMDUZ=0.5
RETRY    ;Get the message number.
 D XMZ^XMA2
 I XMZ<1 G RETRY
 ;Load the message
 M ^XMB(3.9,XMZ,2)=^TMP("PXRMXMZ",$J)
 K ^TMP("PXRMXMZ",$J)
 S NL=$O(^XMB(3.9,XMZ,2,""),-1)
 S ^XMB(3.9,XMZ,2,0)="^3.92^"_+NL_U_+NL_U_DT
 ;Send message to requestor if USER is defined
 I $G(USER)'="" S XMY(DUZ)="" D ENT1^XMD Q
 ;Send the message to the site defined mail group or the user if
 ;there is no mail group.
 ;S MGIEN=$G(^PXRM(800,1,"MGFE"))
 ;I MGIEN'="" D
 ;. S MGROUP="G."_$$GET1^DIQ(3.8,MGIEN,.01)
 ;. S XMY(MGROUP)=""
 ;E  S XMY(DUZ)=""
 ;D ENT1^XMD
 Q
