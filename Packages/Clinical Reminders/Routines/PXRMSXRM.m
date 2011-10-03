PXRMSXRM ; SLC/PKR - Main driver for building indexes. ;11/02/2009
 ;;2.0;CLINICAL REMINDERS;**6,17**;Feb 04, 2005;Build 102
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
COMMSG(GLOBAL,START,END,NE,NERROR) ;Send a MailMan message providing
 ;notification that the indexing completed.
 N FROM,MGIEN,MGROUP,TO,XMSUB
 K ^TMP("PXRMXMZ",$J)
 S XMSUB="Index for global "_GLOBAL_" sucessfully built"
 S ^TMP("PXRMXMZ",$J,1,0)="Build of Clinical Reminders index for global "_GLOBAL_" completed."
 S ^TMP("PXRMXMZ",$J,2,0)="Build finished at "_$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 S ^TMP("PXRMXMZ",$J,3,0)=NE_" entries were created."
 S ^TMP("PXRMXMZ",$J,4,0)=$$ETIME(START,END)
 S ^TMP("PXRMXMZ",$J,5,0)=NERROR_" errors were encountered."
 I NERROR>0 S ^TMP("PXRMXMZ",$J,6,0)="Another MailMan message will contain the error information."
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
 I END=MAXERR S ^TMP("PXRMXMZ",$J,MAXERR+1,0)="GLOBAL: "_GLOBAL_"- Maximum number of errors reached, will not report any more."
 K ^TMP("PXRMERROR",$J)
 S XMSUB="CLINICAL REMINDER INDEX BUILD ERROR(S) FOR GLOBAL "_GLOBAL
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
 N GBL,LIST,ROUTINE,TASKIT
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
RUNNOW(LIST,GBL,ROUTINE) ;Run the routines now.
 N IND,LI,NUM,RTN
 S NUM=$L(LIST,",")-1
 F IND=1:1:NUM D
 . S LI=$P(LIST,",",IND)
 . S RTN=ROUTINE(GBL(LI))
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
TASKJOB ;Execute as tasked job. LIST, GBL, and ROUTINE come through
 ;ZTSAVE.
 N IND,LI,NUM,RTN
 S ZTREQ="@"
 S ZTSTOP=0
 S NUM=$L(LIST,",")-1
 F IND=1:1:NUM D
 .;Check to see if the task has had a stop request
 . I $$S^%ZTLOAD S ZTSTOP=1,IND=NUM Q
 . S LI=$P(LIST,",",IND)
 . S RTN=ROUTINE(GBL(LI))
 . D @RTN
 Q
 ;
