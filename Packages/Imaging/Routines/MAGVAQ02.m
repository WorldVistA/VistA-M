MAGVAQ02 ;WOIFO/MAT - Archiver Options for Queues ; 29 Aug 2012 10:35 PM
 ;;3.0;IMAGING;**118**;Mar 19, 2002;Build 4525;May 01, 2013
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
 ; OPTIONS for the MAGV HDIG MENU.
 ; SORT template is MAGVA-ASYNC-STORAGE-ERRORS.
 ;
 ;+++++ OPTION: MAGVA ASYNC STORAGE ERR LIST
 ;
QERRLIST ;
 ;
 ;--- Quit if SEARCH template not found.
 N MAGTEMPL S MAGTEMPL=$$ZCONST01()
 N TMPLIEN S TMPLIEN=$$YNDIBT(MAGTEMPL) I TMPLIEN<0 D  Q
 . W !!,?2,"Search template ",MAGTEMPL," not found."
 . Q
 ;--- Quit if SEARCH template empty.
 I $D(^DIBT(TMPLIEN,1))'=10 W !!,?2,"Search template has no entries." Q
 ;
 ;--- Output.
 N TMPLDATA S TMPLDATA=$G(^DIBT(TMPLIEN,"QR"))
 N CTITEM,TMPLDTTM S (CTITEM,TMPLDTTM)=""
 S:$P(TMPLDATA,U)'="" TMPLDTTM=$$FMTE^XLFDT($P(TMPLDATA,U))
 S:$P(TMPLDATA,U,2)'="" CTITEM=$P(TMPLDATA,U,2)
 W !!,"Detail of ",CTITEM," item(s)" W:TMPLDTTM'="" " selected on "_TMPLDTTM
 W ":",!!
 ;
 N MAGIEN S MAGIEN=0
 F  S MAGIEN=$O(^DIBT(TMPLIEN,1,MAGIEN)) Q:MAGIEN=""  D
 . ;
 . W "Number ",$J(MAGIEN,8)," queued on: ",$$GET1^DIQ(2006.928,MAGIEN,3),!
 . D QERRLISU(MAGIEN)
 . W !
 . Q
 D YNEXIT
 Q
 ;+++++ Output for tag QERRLIST.
QERRLISU(MAGQIEN) ;
 ;
 ;--- Validate parameter or quit.
 I $G(MAGQIEN)="" W !,"Undefined QUEUE MESSAGE file entry." Q
 N MAGARY S MAGARY=$NA(^TMP("MAGVAQ02",$J))
 K @MAGARY
 ;
 ;--- Load WP field data to temp global array; quit if empty.
 N MAGWP S MAGWP=$$GET1^DIQ(2006.928,MAGQIEN,6,,MAGARY)
 I MAGWP="" W !,?18,"MESSAGE field is empty." Q
 ;
 ;--- Initialize the MXMLDOM or quit. (All calls: Supported IA #3561)
 N MAGNDX S MAGNDX=$$EN^MXMLDOM(MAGARY)
 I MAGNDX=0 W !,?18,"Error processing MESSAGE field data." Q
 ;
 ;--- Traverse child(ren) node(s) for element(s).
 N CT S CT=1 F  S CT=$$CHILD^MXMLDOM(MAGNDX,1,CT) Q:CT=0  D
 . ;
 . N MAGNAME S MAGNAME=$$NAME^MXMLDOM(MAGNDX,CT)
 . ;--- Process element lastError.
 . D:MAGNAME="lastError"
 . . N OUT S OUT=""
 . . N TXT S:$$TEXT^MXMLDOM(MAGNDX,CT,"TXT") OUT=TXT(1)
 . . W !,?36,MAGNAME_": "_OUT
 . . Q
 . ;--- Process element artifactToken.
 . D:MAGNAME="artifactToken"
 . . ;
 . . ;--- Quit if no artifactToken value.
 . . N ARTTKN S ARTTKN=$$QERRXML2(MAGNDX,CT) I +ARTTKN<0 W !,?18,$P(ARTTKN,"`",2) Q
 . . W !,?32,MAGNAME,": ",ARTTKN
 . . ;
 . . ;--- Quit if no IEN in ARTIFACT file (#2006.919).
 . . N ARTIEN,MAGERR S ARTIEN=$$FIND1^DIC(2006.916,,"X",ARTTKN,,,"MAGERR")
 . . I $D(MAGERR) W !,?18,$G(MAGERR("DIERR",1,"TEXT",1)) Q
 . . W !,?26,"ARTIFACT File entry: ",$S(ARTIEN=0:"Record not found.",1:ARTIEN)
 . . ;
 . . ;--- Get [SUCCESS=0] STORAGE TRANSACTION entries for ARTIFACT IEN.
 . . W !,?18,"STORAGE TRANSACTION MESSAGE: "
 . . K MAGERR
 . . N MAGMSG
 . . N MAGX S MAGX=$$GET1^DIQ(2006.926,ARTIEN,7,,"MAGMSG","MAGERR")
 . . I $D(MAGERR) W "FileMan error: ",MAGERR("DIERR",1,"TEXT",1) Q
 . . ;
 . . ;--- Output entry's MESSAGE field.
 . . W $S(MAGMSG(1)="":"[null]",1:MAGMSG(1))
 . . Q
 . Q
 W !
 ;--- Cleanup.
 D DELETE^MXMLDOM(MAGNDX)
 K @MAGARY
 Q
 ;
QERRXML2(MAGNDX,CT) ;
 N OUT,TXT S OUT=-1_"`Element value not found."
 S:$$TEXT^MXMLDOM(MAGNDX,CT,"TXT") OUT=TXT(1)
 Q OUT
 ;+++++ OPTION: MAGVA ASYNC STORAGE ERR REQU
 ;
 ;--- Re-queue QUEUE MESSAGE (#2006.928) async storage request error queue
 ;      entries as async storage request queue entries.
 ;
 ;    Changes: #.01 QUEUE value to 'Async Storage Request Queue'.
 ;             #3 ENQUEUED DATE/TIME
 ;             #4 EARLIEST DELIVERY DATE/TIME
 ;
 ;    Remaining fields are unchanaged.
 ;
QERRREQ ;
 ;
 ;--- Initialize.
 N NOW S NOW=$$NOW^XLFDT
 N FILE S FILE=2006.927
 N MAGQUEUE S MAGQUEUE=$$ZCONST02()
 ;--- Quit if target QUEUE not found.
 N MAGQIEN S MAGQIEN=$$YNQUEUE(FILE,MAGQUEUE)
 I MAGQIEN<0 W !,"QUEUE: '"_MAGQUEUE_"' not found." Q
 ;--- Get target QUEUE's TRIGGER DELAY IN SECONDS.
 N MAGDELAY S MAGDELAY=$$GET1^DIQ(FILE,MAGQIEN,"TRIGGER DELAY IN SECONDS","I")
 ;--- Set EARLIEST DELIVERY DATE/TIME. IA #10103 (Supported).
 N MAGDLVRY S MAGDLVRY=$$FMADD^XLFDT(NOW,0,0,0,MAGDELAY)
 ;
 ;--- Quit if SEARCH template not found.
 N MAGTEMPL S MAGTEMPL=$$ZCONST01()
 N TMPLIEN S TMPLIEN=$$YNDIBT(MAGTEMPL)
 I TMPLIEN<0 W !,?2,"Search template ",MAGTEMPL," not found." Q
 ;--- Quit if SEARCH template empty.
 I $D(^DIBT(TMPLIEN,1))'=10 W !!,?2,"Search template has no entries." Q
 ;
 ;--- Initialize.
 N FILE1 S FILE1=2006.928
 N DIE S DIE="^MAGV("_FILE1_","
 N DA,DR S DR=".01////^S X=MAGQIEN;3////^S X=NOW;4////^S X=MAGDLVRY;"
 ;
 ;--- Requeue each IEN in the sort template.
 W !,?3,"Requeuing entry ... Result",!
 N CTREQUE,QMSGIEN S (CTREQUE,QMSGIEN)=0
 F  S QMSGIEN=$O(^DIBT(TMPLIEN,1,QMSGIEN)) Q:QMSGIEN=""  D
 . ;
 . ;--- Quit if not found.
 . W !,?10,$J(QMSGIEN,8) I '$D(^MAGV(FILE1,QMSGIEN)) W " ... not found." Q
 . ;
 . ;--- Quit if already requeued.
 . I MAGQIEN=$$GET1^DIQ(FILE1,QMSGIEN,"QUEUE","I") W " ... already requeued." Q
 . ;
 . ;--- Requeue.
 . N DA S DA=QMSGIEN D ^DIE W " ... requeued." S CTREQUE=CTREQUE+1
 . Q
 ;--- Output total requeue count.
 W !!,$J(CTREQUE,8)," Async Storage Request Errors requeued."
 ;--- Prompt to exit.
 D YNEXIT
 Q
 ;+++++ OPTION: MAGVA ASYNC STORAGE ERR QURY
 ;
 ;--- Find QUEUE MESSAGE (#2006.928) async error request queue entries and
 ;      store in template.
 ;
QERRQURY ;
 ;--- Quit if SEARCH template not found.
 N MAGTEMPL S MAGTEMPL=$$ZCONST01()
 N MAGQUEUE S MAGQUEUE=$$ZCONST03()
 N TMPLIEN S TMPLIEN=$$YNDIBT(MAGTEMPL)
 I TMPLIEN<0 W !,?3,"Search template not found." Q
 ;--- Quit if target QUEUE not found.
 N MAGQIEN S MAGQIEN=$$YNQUEUE(2006.927,MAGQUEUE)
 I MAGQIEN<0 W !,"QUEUE: '"_MAGQUEUE_"' not found." Q
 ;--- Lock template and re-initialize matching entries matching QUEUE.
 L +^DIBT(TMPLIEN):3 I $T D
 . K ^DIBT(TMPLIEN,1)
 . M ^DIBT(TMPLIEN,1)=^MAGV(2006.928,"B",MAGQIEN)
 . N CT,ND S (CT,ND)=0 F  S ND=$O(^DIBT(TMPLIEN,1,ND)) Q:ND=""  S CT=CT+1
 . S $P(^DIBT(TMPLIEN,"QR"),U)=$$NOW^XLFDT,$P(^DIBT(TMPLIEN,"QR"),U,2)=CT
 . W !!,?3,$J(CT,5)," entries selected."
 . L -^DIBT(TMPLIEN)
 . Q
 E  D
 . W !!,"Template is locked."
 . Q
 D YNEXIT
 Q
 ;--- Internal Utility: Return IEN of input SORT template X.
YNDIBT(X) ;
 N DIC,Y S DIC="^DIBT(",DIC(0)="BX" D ^DIC
 Q +Y
 ;--- Internal Utility: Call ^DIR for exit prompt.
YNEXIT ;
 W !
 N DIR S DIR("A")="Enter or '^' to exit"
 S DIR(0)="E"
 D ^DIR
 Q
 ;--- Internal Utility: Return IEN of input FILE entry X.
YNQUEUE(FILE,X) ;
 N DIC,Y S DIC="^MAGV("_FILE_",",DIC(0)="BX" D ^DIC
 Q +Y
 ;--- Template Name
ZCONST01() ;
 Q "MAGVA-ASYNC-STORAGE-ERRORS"
 ;--- QUEUE file (#2006.927) entry name for requests.
ZCONST02() ;
 Q "Async Storage Request Queue"
 ;--- QUEUE file entry name for errors.
ZCONST03() ;
 Q "Async Storage Request Error Queue"
 ;
 ; MAGVAQ02
