MAGQE7 ;WOIFO/LB - Imaging Utilities to support Monthly Report ; 18 Jan 2011 5:31 PM
 ;;3.0;IMAGING;**39**;Mar 19, 2002;Build 2010;Mar 08, 2011
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
ACXREF(IEN,LAST) ;
 ;This will set the "C" and "AC" cross reference on field #6, "ACCESS DATE/TIME",
 ;for all the entries in the file. I $D(^MAG(2006.95,"MAGP39")),$P(^MAG(2006.95,"MAGP39"),"^",2)]"" Q
 ; Don't re-index on further patch 39 rebuilds.
 K ^MAG(2006.95,"AC") D INDEX(IEN,LAST)
 Q
INDEX(IEN,LAST) ;
 N CNT,END,I,IMAGE,J,LAST,NODE,NOTSET,SITE,START,TCNT,USER,PLACE
 S START=$$FMTE^XLFDT($$NOW^XLFDT)
 D SETXTMP
 S:'$D(PLACE) PLACE=$O(^MAG(2006.1,"B",$$KSP^XUPARAM("INST"),"")),U="^"
 ; PLACE will be used as default
 S (CNT,TCNT,NOTSET)=0  ;Counter to count the number of entries set and not set.
 ;Will only re-index up to the last entry
 S LAST=$S('$G(LAST):$O(^MAG(2006.95," "),-1),1:LAST)
 S IEN=$S('$G(IEN):0,1:IEN)
 S I=IEN
 F  S I=$O(^MAG(2006.95,I)) Q:'I!(I>LAST)  D
 . S J=$P($G(^MAG(2006.95,I,0)),U,7) Q:J'?7N1".".N
 . S NODE=$G(^MAG(2006.95,I,0)),CNT=CNT+1
 . S IMAGE=$P(NODE,"^",4),USER=$P(NODE,"^",3),SITE=""
 . ;
 . S ^MAG(2006.95,"AC",$E(J,1,30),I)=""  ; Regular cross reference on date.
 . ;
 . I IMAGE D
 . . ;Get acquisition site
 . . I $D(^MAG(2005,IMAGE,0)),$D(^MAG(2005,IMAGE,100)) S SITE=$P(^(100),"^",3)
 . . E  I $D(^MAG(2005.1,IMAGE,0)),$D(^MAG(2005.1,IMAGE,100)) S SITE=$P(^(100),"^",3)
 . . Q 
 . I 'SITE D
 . . ; no acquisition site - use the user's division.
 . . S SITE=$$FINDSITE(USER)
 . I 'SITE D BUILD Q:'SITE
 . ;This is a new field for p39 - back filing
 . S $P(^MAG(2006.95,I,0),"^",11)=SITE
 . ;Now MagEnterprise needs the value from PLACE^MAGBAPI. 
 . S SITE=$S('$D(^MAG(2006.1,"B",SITE)):PLACE,1:$$PLACE^MAGBAPI(SITE))
 . S ^MAG(2006.95,"C",SITE,$E(J,1,30),I)="",TCNT=TCNT+1
 . S ^XTMP("MAGQE7","LASTXREF")=I_"^"_LAST  ; Store the last entry processed.
 . Q 
 S END=$$FMTE^XLFDT($$NOW^XLFDT)
 S $P(^MAG(2006.95,"MAGP39"),"^",2)=END ;To prevent re-indexing in future t builds.
 ;
 D DFNIQ^MAGQBPG1("","The starting time for patch 39 post-install XREF process: "_START,0,PLACE,"Consolidate Shares")
 D DFNIQ^MAGQBPG1("","# entries processed: "_CNT_" Cross reference set on "_TCNT_" Items unresolved: "_NOTSET,0,PLACE,"Consolidate Shares")
 D DFNIQ^MAGQBPG1("","The ending time for patch 39 post-install XREF process: "_END,0,PLACE,"Consolidate Shares")
 D DFNIQ^MAGQBPG1("","Installation: Patch 39 - xref post install completed",1,PLACE,"Consolidate Shares")
 ;
 Q
FINDSITE(USER) ;Get the user's site - covered by IA 10060
 ;File 2006.95 stores the user involved in the event - find out the actual division for this person.
 ;FSITE - first site found in the DIVISION multiple in file 200.
 N I,FSITE,MAGSITE,MAGARR,MSG,SITE
 S MAGSITE=""    ;FSITE=first entry in the Division field.
 Q:'USER
 D GETS^DIQ(200,USER_",","16*","I","MAGARR","MSG")
 Q:$D(MSG("DIERR"))
 S (FSITE,I)="" F  S I=$O(MAGARR(200.02,I)) Q:I=""!MAGSITE  D
 . S SITE=$G(MAGARR(200.02,I,.01,"I")) I 'FSITE S FSITE=SITE
 . ;Default division and a match in Imaging
 . I $G(MAGARR(200.02,I,1,"I")),$D(^MAG(2006.1,"B",SITE)) S MAGSITE=SITE
 . E  I $D(^MAG(2006.1,"B",SITE)) S MAGSITE=SITE
 . Q
 ; If not an image site then get the first entry in the Division field or default to site institution.
 I 'MAGSITE S MAGSITE=PLACE
 Q MAGSITE
 ;
BUILD ;if sent here there was no acquisition site or user's division is not set
 ;Purge date should be 30 days
 S ^XTMP("MAGQE7","NOTSET",I)=IMAGE_"^"_USER
 S NOTSET=NOTSET+1
 Q
PRINT ;Utility to print the exceptions in setting the AC cross reference in file 2006.95.
 ;
 N ZTSK
 I '$D(^XTMP("MAGQE7","NOTSET")) W !,"Sorry, the XTMP global has been cleared, nothing to display. Quitting" Q
 W !,"Exception list for entries in 2006.95 where an AC cross reference could not be set."
 N POP,ZTDESC,ZTRTN,ZTSK
 S %ZIS="QMP" D ^%ZIS K %ZIS I POP Q
 I '$D(IO("Q")) U IO D STARTPRT Q
 ; task job
 S ZTRTN="STARTPRT^MAGQE7",ZTDESC="Exceptions in setting AC cross reference for 2006.95"
 D ^%ZTLOAD
 W !!,$S($D(ZTSK):">>> Job has been queued. The task number is "_ZTSK_".",1:">>> Unable to queue this job.") K IO("Q")
 Q
STARTPRT ;
 N ANS,I,IMAGE,NODE,USER,HEADING,HEADING2,HEADING3,PAGE,STOP,ZTREQ
 S:'+$G(DTIME) DTIME=600
 S ZTREQ="@"  ;TaskMan utilities to delete the task.
 S PAGE=0,HEADING="Imaging Activity Log (#2006.95) entries without C cross reference."
 S HEADING2="Review the Image pointer, the entry should have an Acquisition Site (field #.05)."
 S HEADING3="Or possibly the user does not have a DIVISION defined in file #200."
 D HDR
 S (STOP,I)=0 F  S I=$O(^XTMP("MAGQE7","NOTSET",I)) Q:'I  S NODE=$G(^XTMP("MAGQE7","NOTSET",I)) D  Q:STOP
 . S IMAGE=$P(NODE,"^"),USER=$P(NODE,"^",2) D LINE
 . Q
 D ^%ZISC
 Q
HDR ;
 W @IOF S PAGE=PAGE+1
 W !?2,HEADING,"  Page: ",PAGE
 W !?(IOM-$L(HEADING2)\2),HEADING2 W !?(IOM-$L(HEADING3)\2),HEADING3
 W !,?10,"___________________________________",!
 Q
LINE ;Display output
 N TYPE
 D HDR:$Y+4>IOSL S TYPE="" I $D(^MAG(2006.95,I,0)) S TYPE=$P(^MAG(2006.95,I,0),"^",2)
 W !,"Entry: ",I,", has image pointer ,",$S('IMAGE:"NULL",1:IMAGE),"; the entry was set by user, ",USER," ",TYPE
 I $E(IOST,1,2)="C-",$Y+4>IOSL W !,"Press RETURN to continue or '^' to exit: "
 R ANS:DTIME S STOP=$S(ANS="^":1,1:0)
 Q
RESTART ;
 I '$P($G(^XTMP("MAGQE7","LASTXREF")),"^") W !,"Nothing to process." Q
 S IEN=$P(^XMTP("MAGQE7","LASTXREF"),"^"),LAST=$P(^XTMP("MAGQE7","LASTXREF"),"^",2)
 I IEN>LAST D  Q
 . W !,"Last entry processed was IEN: "_IEN_", and indexing did complete."
 . Q
 D INDEX(IEN,LAST)
 Q
SETXTMP ;
 ;XTMP global structure:
 ;XTMP("MAGQE7",0)=start date^purge date^AC x-ref for file 2006.95^duz 
 ;zero node to control the purging of this global.
 ;XTMP("MAGQE7","LASTXREF") =2006.95's IEN last indexed ^ last IEN in the file at time of indexing
 ;The above global can be used to restart the job incase an error occurs, RESTART^MAGQE7.
 ;XTMP("MAGQE7","NOTSET",I)=IMAGE_"^"_USER
 ;The above global is set when an entry can not be indexed.  Use PRINT^MAGQE7 to print the entries.
 N BEGIN,X,X2 S BEGIN=$$FMTE^XLFDT($$NOW^XLFDT)
 S X=$$NOW^XLFDT,X2=$$FMADD^XLFDT(X,30,"","","")
 S ^XTMP("MAGQE7",0)=X_"^"_X2_"^"_"AC x-ref for file 2006.95 "_"^"_$G(DUZ)   ;Create date^Purge date
 ;Now time stamp the dd to prevent future t build be executed on test accounts.
 S ^MAG(2006.95,"MAGP39")=BEGIN
 Q
REINDEX ;
 N START,END,DT
 S DT=$O(^MAG(2006.95,"AC",""),-1)
 I DT'="" S START=$O(^MAG(2006.95,"AC",DT,0))
 E  S START=1
 S END=$P(^MAG(2006.95,0),"^",3)
 N MAGDATE,MAGTIME,MAGHR,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSK
 S ZTRTN="INDEX^MAGQE7("_START_","_END_")",ZTDESC="Re-index file 2006.95",ZTIO=""
 S MAGDATE=$$NOW^XLFDT(),MAGTIME=$P(MAGDATE,".",2),MAGHR=$E(MAGTIME,1,2)
 I MAGHR>5,MAGHR<17 S MAGTIME=180000
 S MAGDATE=$P(MAGDATE,".")_"."_MAGTIME
 S ZTDTH=MAGDATE
 D ^%ZTLOAD I $D(IO(0)) U IO(0) W !,"Re-indexing scheduled TASK#: "_ZTSK
 Q
