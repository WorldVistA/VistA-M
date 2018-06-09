PXRMSXRM ; SLC/PKR - Main driver for building indexes. ;08/14/2017
 ;;2.0;CLINICAL REMINDERS;**6,17,26,47,42**;Feb 04, 2005;Build 80
 ;
 ;==========================================
ADDERROR(GLOBAL,IDEN,NERROR) ;Add to the error list.
 S NERROR=NERROR+1
 S ^TMP("PXRMERROR",$J,NERROR,0)="GLOBAL: "_GLOBAL_" ENTRY: "_IDEN
 Q
 ;
 ;==========================================
ASKTASK() ;See if this should be tasked.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YO"
 S DIR("A")="Do you want this to be tasked"
 S DIR("B")="Y"
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) Q ""
 I $D(DUOUT)!$D(DTOUT) Q ""
 Q Y
 ;
 ;==========================================
BLDINDEX(FNUMLIST,START,SEQP) ;API for building the Clinical Reminders
 ;Index. FNUMLIST contains the list of file numbers whose portion
 ;of the Index is to be built. START is the date/time to start the
 ;task. If SEQP is 1 then the indexes are built sequentially.
 N FNUM,NTB,ROUTINE,SEQ
 S SEQ=$S($G(SEQP)="":1,1:SEQP)
 S FNUM="",NTB=0
 F  S FNUM=$O(FNUMLIST(FNUM)) Q:FNUM=""  S NTB=NTB+1
 I NTB=0 Q
 I NTB=1 S SEQ=0
 D RTNLIST(.ROUTINE)
 K ZTSAVE
 S ZTSAVE("FNUMLIST(")=""
 S ZTSAVE("ROUTINE(")=""
 S ZTSAVE("SEQ")=SEQ
 S ZTSAVE("START")=START
 S ZTRTN="TASKRUN^PXRMSXRM"
 S ZTDESC="Clinical Reminders Index build"
 S ZTDTH=START
 S ZTIO=""
 D ^%ZTLOAD
 Q ZTSK
 ;
 ;==========================================
COMMSG(GLOBAL,START,END,NE,NERROR) ;Send a MailMan message providing
 ;notification that the indexing completed.
 N FROM,MGIEN,MGROUP,TO,XMSUB
 K ^TMP("PXRMXMZ",$J)
 S XMSUB="Index for global "_GLOBAL_" successfully built"
 S ^TMP("PXRMXMZ",$J,1,0)="Build of Clinical Reminders index for global "_GLOBAL_" completed."
 S ^TMP("PXRMXMZ",$J,2,0)="Build finished at "_$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 S ^TMP("PXRMXMZ",$J,3,0)=NE_" entries were created."
 S ^TMP("PXRMXMZ",$J,4,0)=$$ETIME(START,END)
 S ^TMP("PXRMXMZ",$J,5,0)="There were "_NERROR_" entries that could not be indexed."
 I NERROR>0 D
 . S ^TMP("PXRMXMZ",$J,6,0)="Another MailMan message  will contain detailed information about the entries"
 . S ^TMP("PXRMXMZ",$J,7,0)="that could not be indexed."
 S FROM=$$GET1^DIQ(200,DUZ,.01)
 S TO(DUZ)=""
 S MGIEN=$G(^PXRM(800,1,"MGFE"))
 I MGIEN'="" D
 . S MGROUP="G."_$$GET1^DIQ(3.8,MGIEN,.01)
 . S TO(MGROUP)=""
 D SEND^PXRMMSG("PXRMXMZ",XMSUB,.TO,FROM)
 Q
 ;
 ;==========================================
DETIME(START,END) ;Write out the elapsed time.
 ;START and END are $H times.
 N TEXT
 S TEXT=$$ETIME(START,END)
 D MES^XPDUTL(TEXT)
 Q
 ;
 ;==========================================
ERRMSG(NERROR,GLOBAL) ;If there were errors send an error message.
 N END,FROM,IND,MAXERR,MGIEN,MGROUP,NE,TO,XMSUB
 I NERROR=0 Q
 ;Return the last MAXERR errors
 S MAXERR=+$G(^PXRM(800,1,"MIERR"))
 I MAXERR=0 S MAXERR=200
 K ^TMP("PXRMXMZ",$J)
 S END=$S(NERROR'>MAXERR:NERROR,1:MAXERR)
 S NE=NERROR+1
 F IND=1:1:END S NE=NE-1,^TMP("PXRMXMZ",$J,IND,0)=^TMP("PXRMERROR",$J,NE,0)
 I END=MAXERR S ^TMP("PXRMXMZ",$J,MAXERR+1,0)="GLOBAL: "_GLOBAL_"- The maximum number of non-indexable entries to report has been reached, will not report any more."
 K ^TMP("PXRMERROR",$J)
 S XMSUB="CR INDEX: NON-INDEXABLE ENTRIES FOR GLOBAL "_GLOBAL
 S FROM=$$GET1^DIQ(200,DUZ,.01)
 S TO(DUZ)=""
 S MGIEN=$G(^PXRM(800,1,"MGFE"))
 I MGIEN'="" D
 . S MGROUP="G."_$$GET1^DIQ(3.8,MGIEN,.01)
 . S TO(MGROUP)=""
 D SEND^PXRMMSG("PXRMXMZ",XMSUB,.TO,FROM)
 Q
 ;
 ;==========================================
ETIME(START,END) ;Calculate and format the elapsed time.
 ;START and END are $H times.
 N ETIME,TEXT
 S ETIME=$$HDIFF^XLFDT(END,START,2)
 I ETIME>90 D
 . S ETIME=$$HDIFF^XLFDT(END,START,3)
 . S TEXT="Elapsed time: "_ETIME
 E  S TEXT="Elapsed time: "_ETIME_" secs"
 Q TEXT
 ;
 ;==========================================
INDEX ;Driver for building the various indexes.
 N ANS,GBL,LIST,ROUTINE,TASKIT
 D RTNLIST(.ROUTINE)
 W !,"Rebuilding an index will stop all evaluation, dialogs,"
 W !,"reminder order checks, and anything using reminder evaluation!"
 W !,"Are you sure you want to proceed?"
 S ANS=$$ASKYN^PXRMEUT("N","Rebuild index and disable reminder evaluation")
 I 'ANS Q
 ;Get the list
 W !,"Which indexes do you want to (re)build?"
 D SEL(.LIST,.GBL)
 I LIST="" Q
 ;See if this should be tasked.
 S TASKIT=$$ASKTASK
 I TASKIT="" Q
 I TASKIT D
 . W !,"Queue the Clinical Reminders index job."
 . D TASKIT(LIST,.GBL,.ROUTINE)
 E  D RUNNOW(LIST,.GBL,.ROUTINE)
 Q
 ;
 ;==========================================
NDONEMSG(FNUM,ZTSK) ;If the task to rebuild an index did not complete
 ;in the allowed time send a message.
 N FROM,MGIEN,MGROUP,TO,XMSUB
 S XMSUB="CR INDEX REBUILD FOR FILE #"_FNUM_" HAS NOT FINISHED"
 S FROM=$$GET1^DIQ(200,DUZ,.01)
 S TO(DUZ)=""
 S MGIEN=$G(^PXRM(800,1,"MGFE"))
 I MGIEN'="" D
 . S MGROUP="G."_$$GET1^DIQ(3.8,MGIEN,.01)
 . S TO(MGROUP)=""
 K ^TMP("PXRMXMZ",$J)
 S ^TMP("PXRMXMZ",$J,1,0)="As of "_$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 S ^TMP("PXRMXMZ",$J,2,0)="Task #"_ZTSK_" to rebuild the index for file #"_FNUM_" has not finished."
 S ^TMP("PXRMXMZ",$J,3,0)="You may want to investigate this."
 D SEND^PXRMMSG("PXRMXMZ",XMSUB,.TO,FROM)
 Q
 ;
 ;==========================================
RTNLIST(ROUTINE) ;Populate the routine list.
 S ROUTINE(45)="INDEX^DGPTDDCR" ;DBIA #4521
 S ROUTINE(52)="PSRX^PSOPXRMI"  ;DBIA #4522
 S ROUTINE(55)="PSPA^PSSSXRD"   ;DBIA #4172
 S ROUTINE(63)="LAB^LRPXSXRL"   ;DBIA #4247
 S ROUTINE(70)="RAD^RAPXRM"     ;DBIA #3731
 S ROUTINE(100)="INDEX^ORPXRM"  ;DBIA #4498
 S ROUTINE(120.5)="VITALS^GMVPXRM"  ;DBIA #3647
 S ROUTINE(601.2)="INDEX^YTPXRM" ;DBIA #4523
 S ROUTINE(601.84)="INDEX^YTQPXRM" ;DBIA #5055
 S ROUTINE(9000011)="INDEX^GMPLPXRM" ;DBIA #4516
 S ROUTINE(9000010.07)="VPOV^PXPXRMI2" ;DBIA #4520
 S ROUTINE(9000010.11)="VIMM^PXPXRMI1" ;DBIA #4519
 S ROUTINE(9000010.12)="VSK^PXPXRMI2"  ;DBIA #4520
 S ROUTINE(9000010.13)="VXAM^PXPXRMI2" ;DBIA #4520
 S ROUTINE(9000010.16)="VPED^PXPXRMI2" ;DBIA #4520
 S ROUTINE(9000010.18)="VCPT^PXPXRMI1" ;DBIA #4519
 S ROUTINE(9000010.23)="VHF^PXPXRMI1"  ;DBIA #4519
 S ROUTINE(9000010.71)="VSC^PXPXRMI2"  ;DBIA #
 Q
 ;
 ;==========================================
RUNNOW(LIST,GBL,ROUTINE) ;Run the index build routines now.
 N IND,INDEXL,LI,NUM,RTN
 S NUM=$L(LIST,",")-1
 I NUM>1 F IND=1:1:NUM D
 . S LI=$P(LIST,",",IND)
 . S INDEXL(GBL(LI))=""
 F IND=1:1:NUM D
 . S LI=$P(LIST,",",IND)
 . S RTN=ROUTINE(GBL(LI))
 . D INDEXD^PXRMDIEV(GBL(LI),.INDEXL)
 . D @RTN
 Q
 ;
 ;==========================================
SEL(LIST,GBL) ;Select global list
 N ALIST,DIR,DIROUT,DIRUT,DTOUT,DUOUT,INUM,X,Y
 S INUM=1,ALIST(INUM)="  "_INUM_" - LABORATORY TEST (CH, Anatomic Path, Micro)",GBL(INUM)=63
 S INUM=INUM+1,ALIST(INUM)="  "_INUM_" - MENTAL HEALTH",GBL(INUM)=601.2
 S INUM=INUM+1,ALIST(INUM)="  "_INUM_" - MENTAL HEALTH (MHA3)",GBL(INUM)=601.84
 S INUM=INUM+1,ALIST(INUM)="  "_INUM_" - ORDER",GBL(INUM)=100
 S INUM=INUM+1,ALIST(INUM)="  "_INUM_" - PTF",GBL(INUM)=45
 S INUM=INUM+1,ALIST(INUM)="  "_INUM_" - PHARMACY PATIENT",GBL(INUM)=55
 S INUM=INUM+1,ALIST(INUM)="  "_INUM_" - PRESCRIPTION",GBL(INUM)=52
 S INUM=INUM+1,ALIST(INUM)="  "_INUM_" - PROBLEM LIST",GBL(INUM)=9000011
 S INUM=INUM+1,ALIST(INUM)="  "_INUM_" - RADIOLOGY",GBL(INUM)=70
 S INUM=INUM+1,ALIST(INUM)=" "_INUM_" - V CPT",GBL(INUM)=9000010.18
 S INUM=INUM+1,ALIST(INUM)=" "_INUM_" - V EXAM",GBL(INUM)=9000010.13
 S INUM=INUM+1,ALIST(INUM)=" "_INUM_" - V HEALTH FACTORS",GBL(INUM)=9000010.23
 S INUM=INUM+1,ALIST(INUM)=" "_INUM_" - V IMMUNIZATION",GBL(INUM)=9000010.11
 S INUM=INUM+1,ALIST(INUM)=" "_INUM_" - V PATIENT ED",GBL(INUM)=9000010.16
 S INUM=INUM+1,ALIST(INUM)=" "_INUM_" - V POV",GBL(INUM)=9000010.07
 S INUM=INUM+1,ALIST(INUM)=" "_INUM_" - V SKIN TEST",GBL(INUM)=9000010.12
 S INUM=INUM+1,ALIST(INUM)=" "_INUM_" - V STANDARD CODES",GBL(INUM)=9000010.71
 S INUM=INUM+1,ALIST(INUM)=" "_INUM_" - VITAL MEASUREMENT",GBL(INUM)=120.5
 M DIR("A")=ALIST
 S DIR("A")="Enter your list"
 S DIR(0)="LO^1:"_INUM
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) S LIST="" Q
 I $D(DUOUT)!$D(DTOUT) S LIST="" Q
 S LIST=Y
 Q
 ;
 ;==========================================
TASKIT(LIST,GBL,ROUTINE) ;Build the indexes as a tasked job.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,MINDT,SDTIME,X,Y
 S MINDT=$$NOW^XLFDT
 S DIR("A",1)="Enter the date and time you want the job to start."
 S DIR("A",2)="It must be after "_$$FMTE^XLFDT(MINDT,"5Z")
 S DIR("A")="Start the task at: "
 S DIR(0)="DAU"_U_MINDT_"::RSX"
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) Q
 I $D(DUOUT)!$D(DTOUT) Q
 S SDTIME=Y
 ;Put the task into the queue.
 K ZTSAVE
 S ZTSAVE("LIST")=""
 S ZTSAVE("GBL(")=""
 S ZTSAVE("ROUTINE(")=""
 S ZTRTN="TASKJOB^PXRMSXRM"
 S ZTDESC="Clinical Reminders index build"
 S ZTDTH=SDTIME
 S ZTIO=""
 D ^%ZTLOAD
 W !,"Task number ",ZTSK," queued."
 Q
 ;
 ;==========================================
TASKBLD ;Execute as tasked job. FNUM, FNUMLIST, and RTN come through ZTSAVE.
 S ZTREQ="@"
 D INDEXD^PXRMDIEV(FNUM,.FNUMLIST)
 D @RTN
 Q
 ;
 ;==========================================
TASKJOB ;Execute as tasked job, used by list build option.
 ;LIST, GBL, and ROUTINE come through ZTSAVE.
 N IND,INDEXL,LI,NUM,RTN
 S ZTREQ="@"
 S ZTSTOP=0
 S NUM=$L(LIST,",")-1
 I NUM>1 F IND=1:1:NUM D
 . S LI=$P(LIST,",",IND)
 . S INDEXL(GBL(LI))=""
 F IND=1:1:NUM D
 .;Check to see if the task has had a stop request.
 . I $$S^%ZTLOAD S ZTSTOP=1,IND=NUM Q
 . S LI=$P(LIST,",",IND)
 . S RTN=ROUTINE(GBL(LI))
 . D INDEXD^PXRMDIEV(GBL(LI),.INDEXL)
 . D @RTN
 Q
 ;
 ;==========================================
TASKDONE(TASKNUM) ;Return a 1 when task number TASKNUM has completed.
 N DONE,NT,ZTSK
 S ZTREQ="@"
 S ZTSK=TASKNUM
 S (DONE,NT)=0
 F  Q:DONE  D
 . S NT=NT+1
 . D STAT^%ZTLOAD
 . I ZTSK(0)=0 S DONE=1 Q
 . I ZTSK(1)=3 S DONE=1 Q
 . I ZTSK(1)=5 S DONE=1 Q
 .;Timeout after 6 hours.
 . I NT>359 S DONE=1 Q
 . I 'DONE H 60
 I NT>359 S DONE=0
 Q DONE
 ;
 ;==========================================
TASKRUN ;Task to queue index builds for BLDINDEX API.
 ;FNUMLIST, ROUTINE, and START come through ZTSAVE.
 N BUILT,DESC,FNUM,RTN
 S ZTREQ="@"
 S FNUM=""
 F  S FNUM=$O(FNUMLIST(FNUM)) Q:FNUM=""  D
 . S RTN=$G(ROUTINE(FNUM))
 . I RTN="" Q
 . K ZTSAVE,ZTSK
 . S ZTSAVE("FNUM")=FNUM
 . S ZTSAVE("FNUMLIST(")=""
 . S ZTSAVE("RTN")=RTN
 . S ZTRTN="TASKBLD^PXRMSXRM"
 . S ZTDESC="Clinical Reminders Index build for file #"_FNUM
 . S DESC=ZTDESC
 . S ZTDTH=START
 . S ZTIO=""
 . D ^%ZTLOAD
 . I '$D(ZTSK) Q
 .;If SEQ is true then wait for the current index build to finish
 .;before starting the next one.
 . I SEQ D
 .. S BUILT=$$TASKDONE^PXRMSXRM(ZTSK)
 .. I 'BUILT D NDONEMSG(FNUM,ZTSK)
 .;If concurrent allow some time for the first job to establish ^XTMP.
 . I 'SEQ H 2
 Q
 ;
