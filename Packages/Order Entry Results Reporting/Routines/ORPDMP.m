ORPDMP ;SLC/AGP - PDMP Code ;Jul 13, 2021@20:28:13
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**519,405**;Dec 17, 1997;Build 211
 ;
 ; This routine uses the following ICRs:
 ;  #7143 - File 200, Field 205.5
 ;  #5541 - REQCOS^TIUSRVA
 ;
 Q
 ;
 ; Returns parameters
GETPAR(ORRESULTS,ORUSER) ;
 ;
 N ORNOTE,ORREQCOSIG
 ;
 S ORRESULTS("PDMP","turnedOn")=+$$GET^XPAR("ALL","OR PDMP TURN ON",1,"I")
 S ORRESULTS("PDMP","delegateFeatureEnabled")=+$$GET^XPAR("ALL","OR PDMP DELEGATION ENABLED",1,"I")
 S ORRESULTS("PDMP","useDefaultBrowser")=+$$GET^XPAR("ALL","OR PDMP USE DEFAULT BROWSER",1,"I")
 S ORRESULTS("PDMP","pollingInterval")=+$$GET^XPAR("ALL","OR PDMP POLLING INTERVAL",1,"I")
 S ORRESULTS("PDMP","showButton")=$$GET^XPAR("ALL","OR PDMP SHOW BUTTON",1,"I")
 S ORRESULTS("PDMP","daysBetweenReview")=+$$GET^XPAR("ALL","OR PDMP DAYS BETWEEN REVIEWS",1,"I")
 S ORRESULTS("PDMP","commentLimit")=+$$GET^XPAR("ALL","OR PDMP COMMENT LIMIT",1,"I")
 S ORRESULTS("PDMP","pasteEnabled")=+$$GET^XPAR("ALL","OR PDMP COPY/PASTE ENABLED",1,"I")
 S ORRESULTS("PDMP","isAuthorizedUser")=$$ISAUTH(ORUSER)
 S ORRESULTS("PDMP","backgroundRetrieval")=+$$GET^XPAR("ALL","OR PDMP BACKGROUND RETRIEVAL",1,"I")
 S ORNOTE=$$GETNOTE^ORPDMPNT()
 S ORRESULTS("PDMP","validNoteTitle")=$S(ORNOTE>0:1,1:0)
 S ORRESULTS("PDMP","noteTitle")=$S(ORNOTE>0:ORNOTE,1:"")
 D REQCOS^TIUSRVA(.ORREQCOSIG,ORNOTE,0,ORUSER,$$NOW^XLFDT)  ; ICR 5541
 S ORRESULTS("PDMP","requiresCosigner")=ORREQCOSIG
 ;
 Q
 ;
 ;
 ; Entry point to initiate PDMP Query
STRTPDMP(ORRESULTS,ORUSER,ORCOSIGNER,DFN,ORVSTR) ;
 ;
 ; Returns:
 ;   If there was an error initiating the query
 ;    @ORRESULTS@(0) = -1
 ;    @ORRESULTS@(1) = Error message
 ;
 ;   If query is tasked to run in the background
 ;     @ORRESULTS@(0) = 0^Handle - (Pass in Handle to CHKTASK to check status of tasked job)
 ;
 ;   If query ran in the foreground, will return the same format as RETPDMP
 ;
 N OREMAIL,ORAUTHUSER,ORLASTCHECKED,ORLOGIENS,ORRESULT,ORSUB
 ;
 S ORSUB="ORPDMP"
 K ^TMP(ORSUB,$J)
 S ORRESULTS=$NA(^TMP(ORSUB,$J))
 ;
 I '$G(ORUSER) S ORUSER=DUZ
 S ORCOSIGNER=$G(ORCOSIGNER)
 S ORAUTHUSER=$$ISAUTH(ORUSER)
 I ORUSER=ORCOSIGNER S ORCOSIGNER=""
 ;
 I '$G(DFN) D  Q
 . S ^TMP(ORSUB,$J,0)="-1"
 . S ^TMP(ORSUB,$J,1)="DFN is null."
 I $G(ORVSTR)="" D  Q
 . S ^TMP(ORSUB,$J,0)="-1"
 . S ^TMP(ORSUB,$J,1)="ORVSTR is null."
 ;
 ; Check if PDMP is enabled
 I '$$GET^XPAR("ALL","OR PDMP TURN ON",1,"I") D  Q
 . S ^TMP(ORSUB,$J,0)="-1"
 . S ^TMP(ORSUB,$J,1)="The PDMP functionality has been DISABLED."
 ;
 I 'ORAUTHUSER,'$$GET^XPAR("ALL","OR PDMP DELEGATION ENABLED",1,"I") D  Q
 . S ^TMP(ORSUB,$J,0)="-1"
 . S ^TMP(ORSUB,$J,1)="The PDMP delegate feature has been disabled. Only authorized healthcare providers can run a PDMP query."
 ;
 ; If delegate, check if they have an email defined
 I 'ORAUTHUSER,'$$HASEMAIL(ORUSER) D  Q
 . S ^TMP(ORSUB,$J,0)="-1"
 . S ^TMP(ORSUB,$J,1)="Your VistA account does not have your domain.ext email address defined. You need to have it defined to make a PDMP query as a delegate."
 . S ^TMP(ORSUB,$J,2)=" "
 . S ^TMP(ORSUB,$J,3)="You can log back into CPRS using your PIV card to link your VistA account with your PIV card, and that should populate your VistA account with your domain.ext email address."
 ;
 ; Check if authorized user, or if delegate, if user chosen ia an authorized user
 I 'ORAUTHUSER,'$$ISAUTH(+ORCOSIGNER) D  Q
 . S ^TMP(ORSUB,$J,0)="-1"
 . S ^TMP(ORSUB,$J,1)="You need to be an authorized healthcare provider to run a PDMP query, or if you are a delegate, you need to select an authorized healthcare provider."
 ;
 ; check if PDMP note title exists
 I '$$GETNOTE^ORPDMPNT D  Q
 . S ^TMP(ORSUB,$J,0)="-1"
 . S ^TMP(ORSUB,$J,1)="The national PDMP note title needs to be created in order run a PDMP query."
 ;
 S ORLOGIENS=$$LOGQUERY(DFN,$$NOW^XLFDT,ORUSER,ORCOSIGNER,ORAUTHUSER,0,"NO")
 ;
 ; if set to background retrieval start tasked job
 I +$$GET^XPAR("ALL","OR PDMP BACKGROUND RETRIEVAL",1,"I") D  Q
 . D STRTTASK(ORUSER,ORCOSIGNER,DFN,ORVSTR,ORLOGIENS)
 . S ^TMP(ORSUB,$J,0)="0^"_ORLOGIENS
 ;
 ; otherwise retrieve data directly
 D RETPDMP(ORSUB,ORUSER,ORCOSIGNER,DFN,ORVSTR,ORLOGIENS)
 ;
 Q
 ;
 ;
 ; Start PDMP query task (for background retrieval)
STRTTASK(ORUSER,ORCOSIGNER,DFN,ORVSTR,ORLOGIENS) ;
 ;
 N OROTHER,ORTASK,ORXSUB
 ;
 S ORXSUB="ORPDMP-"_ORLOGIENS
 S ^XTMP(ORXSUB,0)=$$FMADD^XLFDT(DT,1)_U_DT_U_"PDMP Results"
 S ^XTMP(ORXSUB,"DFN")=DFN
 S ^XTMP(ORXSUB,"STARTDT")=$H
 ;
 S OROTHER("ZTDTH")=$$NOW^XLFDT
 S ORTASK=$$NODEV^XUTMDEVQ("TASKEN^ORPDMP","PDMP Query From CPRS","ORUSER;ORCOSIGNER;DFN;ORVSTR;ORLOGIENS",.OROTHER)
 I ORTASK<0 Q
 ;
 S ^XTMP(ORXSUB,"TASKNUM")=ORTASK
 ;
 Q
 ;
 ;
 ; Call PDMP query in background task (for background retrieval)
TASKEN ;
 ;
 ; ZEXCEPT: DFN,ORCOSIGNER,ORVSTR,ORLOGIENS,ORUSER,ZTSTOP
 N ORSUB,ORXSUB
 ;
 S ORSUB="ORPDMP"
 K ^TMP(ORSUB,$J)
 ;
 I $$S^%ZTLOAD() D  Q
 . D PROCSTOP(ORLOGIENS)
 ;
 S ORXSUB="ORPDMP-"_ORLOGIENS
 D RETPDMP(ORSUB,ORUSER,ORCOSIGNER,DFN,ORVSTR,ORLOGIENS)
 ;
 I $$S^%ZTLOAD() D  Q
 . D PROCSTOP(ORLOGIENS)
 ;
 I $D(^XTMP(ORXSUB)) D
 . M ^XTMP(ORXSUB,"DATA")=^TMP(ORSUB,$J)
 . S ^XTMP(ORXSUB,"DONE")=1
 ;
 Q
 ;
 ;
 ; Process stop task request
PROCSTOP(ORLOGIENS) ;
 ;
 ; ZEXCEPT: ZTSTOP
 ;
 K ^XTMP("ORPDMP-"_ORLOGIENS)
 ;
 S ZTSTOP=1
 ;
 Q
 ;
 ;
 ; When PDMP is being called in the background, check if the task completed
CHCKTASK(ORRESULTS,DFN,ORLOGIENS) ;
 ;
 ; Returns:
 ;   If query is still running
 ;     @ORRESULTS@(0) = 0^Handle - (query is still running in the background... keep checking back)
 ;
 ;   If there was an error checking on the background task
 ;    @ORRESULTS@(0) = -1
 ;    @ORRESULTS@(1) = Error message
 ;
 ;   If background task completed, will return the same format as RETPDMP
 ;
 N ORSUB,ORTASK,ORTASKSTARTDT,ORX,ORXSUB
 ;
 S ORSUB="ORPDMP"
 K ^TMP(ORSUB,$J)
 S ORRESULTS=$NA(^TMP(ORSUB,$J))
 ;
 I '$G(DFN) D  Q
 . S ^TMP(ORSUB,$J,0)="-1"
 . S ^TMP(ORSUB,$J,1)="DFN is null."
 I $G(ORLOGIENS)="" D  Q
 . S ^TMP(ORSUB,$J,0)="-1"
 . S ^TMP(ORSUB,$J,1)="ORLOGIENS is null."
 ;
 S ORXSUB="ORPDMP-"_ORLOGIENS
 I '$D(^XTMP(ORXSUB))!($G(^XTMP(ORXSUB,"DFN"))'=DFN) D  Q
 . S ^TMP(ORSUB,$J,0)=-1
 . S ^TMP(ORSUB,$J,1)="System Error"
 ;
 I $G(^XTMP(ORXSUB,"DONE"))=1 D  Q
 . M ^TMP(ORSUB,$J)=^XTMP(ORXSUB,"DATA")
 . ;K ^XTMP(ORXSUB)
 ;
 S ORTASKSTARTDT=$G(^XTMP(ORXSUB,"STARTDT"))
 I ORTASKSTARTDT,$$HDIFF^XLFDT($H,ORTASKSTARTDT,2)>$$GET^XPAR("ALL","OR PDMP TIMEOUT QUERY",1,"I") D  Q
 . S ^TMP(ORSUB,$J,0)=-1
 . S ^TMP(ORSUB,$J,1)="PDMP query timed out."
 ;
 S ^TMP(ORSUB,$J,0)="0"_U_ORLOGIENS
 ;
 Q
 ;
 ;
 ; Call PDMP Gateway (via web service)
RETPDMP(ORSUB,ORUSER,ORCOSIGNER,DFN,ORVSTR,ORLOGIENS) ;
 ;
 ; Returns:
 ;   ^TMP(ORSUB,$J,0) = Status ^  ^  ^  ^ Handle ^ Note Cosigner
 ;                 Note: Status can be one of the following values:
 ;                    -1 - PDMP down, or other reason that didn't even attempt to connect
 ;                    -2 - error connecting
 ;                    -3 - connected - but error returned by PDMP
 ;                     1 - success
 ;
 ;  For errors (Status < 1):
 ;   ^TMP(ORSUB,$J,1) = Error Message.
 ;
 ;  For success (Status = 1):
 ;   ^TMP(ORSUB,$J,1) = Report URL
 ;   ^TMP(ORSUB,$J,2...n) = Data needed to create the review form.
 ;
 N ORARR,ORAUTHUSER,ORDELEGATEOF,ORFINISH,ORQSTATS,ORRETURN,ORSESSION,ORSHARED,ORSTART,ORSTATUS,ORTRACK,ORVDT,ORVLOC
 ;
 S ORVLOC=$P(ORVSTR,";",1)
 S ORVDT=$P(ORVSTR,";",2)
 ;
 S ORAUTHUSER=$$ISAUTH(ORUSER)
 S ORDELEGATEOF=ORCOSIGNER
 I ORAUTHUSER S ORDELEGATEOF=""
 S ORSTART=$ZH
 D EN^ORPDMPWS(.ORRETURN,DFN,ORUSER,ORDELEGATEOF,$G(DUZ(2)))
 S ORFINISH=$ZH
 ;
 S ORQSTATS=ORFINISH-ORSTART
 S ORQSTATS=+$FN(ORQSTATS,"",2)
 S ORSTATUS=$P($G(^TMP(ORSUB,$J,0)),U,1)
 S ORSHARED=+$P($G(^TMP(ORSUB,$J,0)),U,2)
 S ORSESSION=$P($G(^TMP(ORSUB,$J,0)),U,3)
 D UPDATELOG(ORLOGIENS,ORSTATUS,ORSHARED,ORQSTATS,"",$NA(^TMP(ORSUB,$J,"ERR")),ORSESSION)
 ;
 S ^TMP(ORSUB,$J,0)=ORSTATUS
 K ^TMP(ORSUB,$J,"ERR")
 ;
 I ORSTATUS=1 D
 . S $P(^TMP(ORSUB,$J,0),U,5,6)=ORLOGIENS_U_ORCOSIGNER
 . ; return nodes 2...n with data for UI to create review form
 . I ORAUTHUSER D
 . . D RVWFORM(ORSUB,"P",DFN)
 . I 'ORAUTHUSER D
 . . D RVWFORM(ORSUB,"D",DFN)
 ;
 I ORSTATUS<0 D
 . S ORTRACK="VistA "_$E(ORLOGIENS,1,$L(ORLOGIENS)-1)
 . I ORSESSION'="" S ORTRACK=ORTRACK_". VDIF "_ORSESSION
 . S ^TMP(ORSUB,$J,1)=$G(^TMP(ORSUB,$J,1))_" ["_ORTRACK_"]"
 ;
 Q
 ;
 ; Return Review Form text
RVWFORM(ORSUB,ORTYPE,DFN) ;
 ;
 N ORARR,ORI,ORJ,ORTEXT,ORLINE,ORERR,ORLASTNOTE,ORREPLACE
 ;
 S ORREPLACE("|DAYS|")=+$$GET^XPAR("ALL","OR PDMP DAYS BETWEEN REVIEWS",1,"I")
 D RECNTNOTE^ORPDMPNT(.ORLASTNOTE,DFN)
 I ORLASTNOTE S ORREPLACE("|LASTDATE|")=$$FMTE^XLFDT(ORLASTNOTE,"5D")
 I 'ORLASTNOTE S ORREPLACE("|LASTDATE|")="none"
 ;
 D GETWP^XPAR(.ORARR,"ALL","OR PDMP REVIEW FORM",ORTYPE,.ORERR)
 S ORI=0
 S ORJ=1
 S ORTEXT=""
 F  S ORI=$O(ORARR(ORI)) Q:'ORI  D
 . S ORLINE=$$TRIM^XLFSTR($G(ORARR(ORI,0)))
 . I ORLINE="" D  Q
 . . I ORTEXT["|" S ORTEXT=$$REPLACE^XLFSTR(ORTEXT,.ORREPLACE)
 . . S ORJ=ORJ+1
 . . S ^TMP(ORSUB,$J,ORJ)=ORTEXT
 . . S ORTEXT=""
 . S ORTEXT=ORTEXT_$S(ORTEXT="":"",1:" ")_ORLINE
 ;
 I ORTEXT'="" D
 . I ORTEXT["|" S ORTEXT=$$REPLACE^XLFSTR(ORTEXT,.ORREPLACE)
 . S ORJ=ORJ+1
 . S ^TMP(ORSUB,$J,ORJ)=ORTEXT
 ;
 Q
 ;
 ;
 ; Request that PDMP task be stopped
STOPTASK(ORRESULTS,ORLOGIENS) ;
 ;
 N ORSUB,ORTASK
 ;
 S ORSUB="ORPDMP"
 K ^TMP(ORSUB,$J)
 S ORRESULTS=$NA(^TMP(ORSUB,$J))
 ;
 I $G(ORLOGIENS)="" D  Q
 . S ^TMP(ORSUB,$J,0)="-1"
 . S ^TMP(ORSUB,$J,1)="ORLOGIENS is null."
 ;
 D UPDATELOG(ORLOGIENS,"","","","QCANCEL")
 ;
 S ORTASK=$G(^XTMP("ORPDMP-"_ORLOGIENS,"TASKNUM"))
 I 'ORTASK D  Q
 . S ORRESULTS=-1
 ;
 S ORRESULTS=$$ASKSTOP^%ZTLOAD(ORTASK)
 ;
 Q
 ;
 ; Check if there are cached PDMP results for a given patient and user
GETCACHE(ORRESULTS,DFN,ORUSER) ;
 ;
 ; Returns:
 ;   If there are no cached results
 ;     @ORRESULTS@(0) = 0
 ;
 ;   If there are cached results, will return the same format as RETPDMP (although status should always be 1).
 ;
 N ORHOURSBACK,ORIEN,ORIENQ,ORLOGIENS,ORSTARTDT,ORSTATUS,ORSUB,ORVIEWED,ORQDT,ORXSUB
 ;
 S ORSUB="ORPDMP"
 K ^TMP(ORSUB,$J)
 S ORRESULTS=$NA(^TMP(ORSUB,$J))
 S ^TMP(ORSUB,$J,0)=0
 I '$$GET^XPAR("ALL","OR PDMP BACKGROUND RETRIEVAL",1,"I") Q
 I '$G(DFN) Q
 I '$G(ORUSER) S ORUSER=DUZ
 ;
 S ORHOURSBACK=+$$GET^XPAR("ALL","OR PDMP TIME TO CACHE URL",1,"I")
 S ORSTARTDT=$$FMADD^XLFDT($$NOW^XLFDT,0,-ORHOURSBACK)
 S ORSTATUS=1  ;Report URL is available
 S ORVIEWED="NO"  ;User never viewed report
 S ORQDT=$O(^ORD(101.62,"AC",DFN,ORUSER,ORSTATUS,ORVIEWED,ORSTARTDT))
 I 'ORQDT Q
 S ORIEN=$O(^ORD(101.62,"AC",DFN,ORUSER,ORSTATUS,ORVIEWED,ORQDT,0))
 I 'ORIEN Q
 S ORIENQ=$O(^ORD(101.62,"AC",DFN,ORUSER,ORSTATUS,ORVIEWED,ORQDT,ORIEN,0))
 I 'ORIENQ Q
 ;
 S ORLOGIENS=ORIENQ_","_ORIEN_","
 S ORXSUB="ORPDMP-"_ORLOGIENS
 I '$G(^XTMP(ORXSUB,"DATA",0)) Q
 I '$G(^XTMP(ORXSUB,"DONE")) Q
 I $G(^XTMP(ORXSUB,"DFN"))'=DFN Q
 M ^TMP(ORSUB,$J)=^XTMP(ORXSUB,"DATA")
 ;
 Q
 ;
 ; Log Query to the PDMP Query Log file
LOGQUERY(DFN,ORDATE,ORUSER,ORCOSIGNER,ORAUTHUSER,ORSTATUS,ORVIEWED) ;
 ;
 N ORIENOUT,ORIENS,ORERR,ORFDA
 ;
 ; Root entry - Add new entry if one doesn't already exist for this patient
 S ORIENS="?+1,"
 S ORFDA(101.62,ORIENS,.01)=DFN
 ; Query Multiple - Always add new multiple entry
 S ORIENS="+2,"_ORIENS
 I '$G(ORDATE) S ORDATE=$$NOW^XLFDT
 S ORFDA(101.621,ORIENS,.01)=ORDATE
 I '$G(ORUSER) S ORUSER=DUZ
 S ORFDA(101.621,ORIENS,.02)=ORUSER
 I $G(ORCOSIGNER)'="" S ORFDA(101.621,ORIENS,.03)=ORCOSIGNER
 I $G(ORAUTHUSER)'="" S ORFDA(101.621,ORIENS,.08)=ORAUTHUSER
 I $G(ORSTATUS)'="" S ORFDA(101.621,ORIENS,.04)=ORSTATUS
 I $G(ORVIEWED)'="" S ORFDA(101.621,ORIENS,.07)=ORVIEWED
 ;
 L +^ORD(101.62,0):DILOCKTM
 D UPDATE^DIE("U","ORFDA","ORIENOUT","ORERR")
 L -^ORD(101.62,0)
 ;
 ; Return the ORIENS to this query multiple
 S ORIENS=ORIENOUT(2)_","_ORIENOUT(1)_","
 ;
 Q ORIENS
 ;
 ; Update the entry in the PDMP Query Log file
UPDATELOG(ORIENS,ORSTATUS,ORSHARED,ORQSTATS,ORVIEWED,ORERRINFO,ORSESSION,ORNOTE,ORNOTESTAT,ORFROMREM) ;
 ;
 N ORFDA
 ;
 I $G(ORSTATUS)'="" S ORFDA(101.621,ORIENS,.04)=ORSTATUS
 I $G(ORSHARED)'="" S ORFDA(101.621,ORIENS,.05)=ORSHARED
 I $G(ORQSTATS)'="" S ORFDA(101.621,ORIENS,.06)=ORQSTATS
 I $G(ORVIEWED)'="" S ORFDA(101.621,ORIENS,.07)=ORVIEWED
 I $G(ORNOTE)'="" S ORFDA(101.621,ORIENS,.09)=ORNOTE
 I $G(ORNOTESTAT)'="" S ORFDA(101.621,ORIENS,.1)=ORNOTESTAT
 I $G(ORSESSION)'="" S ORFDA(101.621,ORIENS,.11)=ORSESSION
 I $G(ORFROMREM)'="" S ORFDA(101.621,ORIENS,.12)=ORFROMREM
 I $G(ORERRINFO)'="",$D(@ORERRINFO) S ORFDA(101.621,ORIENS,1)=ORERRINFO
 L +^ORD(101.62,ORIENS):DILOCKTM
 D FILE^DIE("","ORFDA")
 L -^ORD(101.62,ORIENS)
 ;
 Q
 ;
 ;
 ; Update PDMP Query Log to reflect if user viewed the PDMP report
VIEWEDREPORT(ORRESULT,ORLOGIENS,ORSTATUS,ORNOTE,ORERRINFO) ;
 ;
 N ORD0,ORD1,ORI,ORLINE,ORLOGERR,ORFROMREM
 ;
 I $G(ORLOGIENS)="" D  Q
 . S ORRESULT="-1^ORLOGIENS is null."
 ;
 I $G(ORSTATUS)="" D  Q
 . S ORRESULT="-1^ORSTATUS is null."
 ;
 I $O(ORERRINFO(""))'="" D
 . S ORD0=$P(ORLOGIENS,",",2)
 . S ORD1=$P(ORLOGIENS,",",1)
 . S ORLINE=0
 . S ORI=0
 . F  S ORI=$O(^ORD(101.62,ORD0,1,ORD1,1,ORI)) Q:'ORI  D
 . . S ORLINE=ORLINE+1
 . . S ORLOGERR(ORLINE)=$G(^ORD(101.62,ORD0,1,ORD1,1,ORI,0))
 . S ORLINE=ORLINE+1
 . S ORLOGERR(ORLINE)="Error viewing PDMP report. Error received:"
 . S ORI=""
 . F  S ORI=$O(ORERRINFO(ORI)) Q:ORI=""  D
 . . S ORLINE=ORLINE+1
 . . S ORLOGERR(ORLINE)=$G(ORERRINFO(ORI))
 ;
 I $G(ORNOTE) S ORFROMREM=1
 D UPDATELOG(ORLOGIENS,"","","",ORSTATUS,"ORLOGERR","",$G(ORNOTE),"",$G(ORFROMREM))
 S ORRESULT=1
 ;
 Q
 ;
 ; Does ORUSER have thier domain.ext email define?
HASEMAIL(ORUSER) ;
 N OREMAIL
 D GETEMAIL(.OREMAIL,ORUSER)
 Q $S(OREMAIL'="":1,1:0)
 ;
 ;
 ; Return a user's domain.ext email address (only look at #200,#205.5 as it's standardized by IAM)
GETEMAIL(ORRESULT,ORUSER) ;
 ;
 N OREMAIL
 ;
 S ORRESULT=""
 ;
 S OREMAIL=$$GET1^DIQ(200,ORUSER_",",205.5)  ; ICR 7143
 I $$LOW^XLFSTR(OREMAIL)["@domain.ext" D  Q
 . S ORRESULT=OREMAIL
 ;
 Q
 ;
 ; Is user a PDMP authorized user?
ISAUTH(ORUSER) ;
 ;
 N ORNPI,ORPERSCLASS,ORVACODE,ORI,ORRETURN,ORLIST
 ;
 ; If user has an active DEA #, they are an authorized user.
 I $$USERDEA(ORUSER)'="" Q 1
 ;
 ; Also, if user has an NPI # and a person class from the OR PDMP PERSON CLASS param
 ; list they are an authorized user.
 ;
 S ORNPI=$$USERNPI(ORUSER)
 I ORNPI="" Q 0  ; Does not have active NPI #
 ;
 ; User has NPI #. Now check if they have correct Person Class.
 S ORPERSCLASS=$$GET^XUA4A72(ORUSER)
 I ORPERSCLASS<1 Q 0  ; Does not have active Person Class
 S ORVACODE=$P(ORPERSCLASS,U,7)
 I ORVACODE="" Q 0
 D GETLST^XPAR(.ORLIST,"ALL","OR PDMP PERSON CLASS","I")
 S ORRETURN=0
 S ORI=0
 F  S ORI=$O(ORLIST(ORI)) Q:'ORI  D  Q:ORRETURN
 . I ORVACODE=$G(ORLIST(ORI)) S ORRETURN=1
 ;
 Q ORRETURN
 ;
 ;
 ; Return user's DEA #
USERDEA(ORUSER) ;
 ;
 N ORDEA
 ;
 S ORDEA=$$DEA^XUSER(0,ORUSER)
 I ORDEA["-" S ORDEA=""
 Q ORDEA
 ;
 ;
 ; Return user's NPI #
USERNPI(ORUSER) ;
 ;
 N ORNPI
 ;
 S ORNPI=$$NPI^XUSNPI("Individual_ID",ORUSER)
 I ORNPI<1!($P(ORNPI,U,3)'="Active") Q ""
 Q $P(ORNPI,U,1)
 ;
 ;
 ; Return Institution's DEA #
INSTDEA(ORINST) ;
 ;
 N ORDEA,ORARR
 ;
 S ORDEA=$$GET1^DIQ(4,ORINST_",",52)  ; ICR 10090 (supported)
 ;
 Q ORDEA
 ;
 ;
