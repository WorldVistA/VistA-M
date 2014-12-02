LA7CHKF1 ;DALOI/LMT - Check SNOMED CT mappings against Lexicon for exceptions ;01/10/13  08:56
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**80**;Sep 27, 1994;Build 19
 ;
 ;
 ; This routine checks the SNOMED CT mappings against the Lexicon for exceptions.
 ; It checks the following files:
 ;   - Topography Field (#61)
 ;   - Etiology Field (#61.2)
 ;   - Collection Sample (#62)
 ;
 ; If any exceptions are found:
 ;    - the SCT CODE STATUS field for the entry will be updated to 'Error'
 ;    - an HDI exception alert will be sent to STS
 ;    - a MailMan message will be sent to the local staff with a list of all the exceptions found
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 ;
 ;
EN ; Entry point
 ;
 ;ZEXCEPT: ZTQUEUED
 ;
 N LACNT,LAFIEN,LAFILE,LALINE,LASCT,X
 ;
 D CLEAN ;kill TMP global
 ;
 S LACNT=0
 ;
 ;loop through "F" x-ref on files 61,61.2,62
 F LAFILE=61,61.2,62 D
 . S LASCT=""
 . F  S LASCT=$O(^LAB(LAFILE,"F",LASCT)) Q:LASCT=""  D
 . . ;
 . . S LAFIEN=0
 . . F  S LAFIEN=$O(^LAB(LAFILE,"F",LASCT,LAFIEN)) Q:'LAFIEN  D
 . . . ;
 . . . S LACNT=LACNT+1
 . . . I '(LACNT#100) H 1 ; take a "rest" - allow OS to swap out process
 . . . I '$D(ZTQUEUED) W:'(LACNT#50) "."
 . . . ;
 . . . D CHECK(LAFILE,LAFIEN,LASCT) ; Check entry against lexicon
 ;
 ; Send MailMan message to local staff if any exceptions were found.
 I $D(^TMP("LA7CHK",$J,"MSG"))!($D(^TMP("LA7CHK",$J,"ERR"))) S X=$$SENDMSG
 ;
 D CLEAN
 ;
 Q
 ;
CHECK(LAFILE,LAFIEN,LASCT) ; Check Entry against Lexicon
 ;
 N LAALRTST,LACODEINFO,LALEX,LALEXERR,LALEXSTAT,LANAME,LASCTSTAT
 ;
 S LANAME=$P($G(^LAB(LAFILE,LAFIEN,0)),U,1)
 ;
 S LACODEINFO=$$CODE^LRSCT(LASCT,"SCT",DT,"LALEX")
 S LALEXSTAT=$P(LACODEINFO,U,1)
 S LALEXERR=""
 I LALEXSTAT<0 S LALEXERR=$P(LACODEINFO,U,2)
 I $P($G(LALEX(0)),U,1)="" S $P(LALEX(0),U,1)=LASCT
 ;
 S LASCTSTAT=$$GET1^DIQ(LAFILE,LAFIEN_",",21,"I")
 I LASCTSTAT="E" Q  ; Alert was already sent - don't send duplicate alert
 ;
 I LASCTSTAT="LN",LALEXSTAT=-1 Q  ; Code still does not exist in Lexicon. Don't send duplicate alert.
 I LASCTSTAT="LN",LALEXSTAT=1 D  Q  ; Code now exists in the Lexicon. Update SCT CODE STATUS field and Quit.
 . N LASTATUS
 . ;
 . S LASTATUS="L" ; Default [L] = The spelling is not standard
 . I $$UP^XLFSTR(LANAME)=$$UP^XLFSTR($G(LALEX("P"))) S LASTATUS="P" ; preferred term
 . I $$UP^XLFSTR(LANAME)=$$UP^XLFSTR($G(LALEX("F"))) S LASTATUS="P" ; preferred term
 . I LASTATUS'="P",$O(LALEX("S",0)) D  ; Check to see if term is a synonym
 . . N I
 . . S I=0
 . . F  S I=$O(LALEX("S",I)) Q:I<1  I $$UP^XLFSTR(LANAME)=$$UP^XLFSTR(LALEX("S",I)) S LASTATUS="S" Q
 . . ;
 . D UPDSTAT(LAFILE,LAFIEN,LASTATUS,"")
 ;
 I LALEXSTAT<0 D
 . S LAALRTST=$$SNDALERT(LAFILE,LAFIEN,LANAME,LASCT,LACODEINFO) ; Send HDI alert to STS
 . D BLDMSG(LAFILE,LAFIEN,LANAME,.LALEX,LACODEINFO,LAALRTST) ; build mailman message
 . D UPDSTAT(LAFILE,LAFIEN,"E",LALEXERR,$P(LAALRTST,U,4)) ; update SCT CODE STATUS to 'Error'
 ;
 Q
 ;
SNDALERT(LAFILE,LAFIEN,LANAME,LASCT,LACODEINFO) ; Build alert that will be sent to STS. Return alert status.
 ;
 N EXCDATA,LAALRTST,LADATA,TNUM,X
 ;
 ; Lab mapping exception
 S EXCDATA("TXT")=$P(LACODEINFO,U,2)
 ;
 S LAALRTST=$$NOTIFY^LRSCTF1(LANAME,LAFILE,LAFIEN,LASCT,.EXCDATA,0)
 S TNUM=$G(EXCDATA("TNUM"))
 S $P(LAALRTST,U,4)=TNUM
 ;
 Q LAALRTST
 ;
BLDMSG(LAFILE,LAFIEN,LANAME,LALEX,LACODEINFO,LAALRTST) ; Build additional message text
 ;
 N I,LACODETXT,LAERROR,LAMSGSUB
 ;
 S LAMSGSUB="MSG"
 ;
 I $D(LAALRTST),'LAALRTST,$P(LAALRTST,U,2)=5 S LAERROR=1,LAMSGSUB="ERR"
 ;
 ; Format 'Code Text' to display nicely on multiple lines
 D FRMTTXT($G(LALEX("F")),1,60,.LACODETXT)
 ;
 S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))=""
 S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="  "_$$REPEAT^XLFSTR("-",76)
 S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))=""
 S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="            File #: "_LAFILE
 S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="             IEN #: "_LAFIEN
 S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="        Entry Name: "_LANAME
 S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="      SNOMED CT ID: "_$P(LALEX(0),U,1)
 I $G(LALEX("F"))'="" D
 . S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="    SNOMED CT Term: "_$G(LACODETXT(1,0))
 . S I=1
 . F  S I=$O(LACODETXT(I)) Q:'I  D
 . . I $G(LACODETXT(I,0))'="" D
 . . . S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="                    "_$G(LACODETXT(I,0))
 S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="             Error: "_$P(LACODEINFO,U,2)
 I $G(LAERROR) D
 . S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="  STS Alert Failed: "_$P(LAALRTST,"^",3)
 I '$G(LAERROR),$P($G(LAALRTST),U,4)'="" D
 . S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))=" STS Transaction #: "_$P(LAALRTST,U,4)
 ;
 Q
 ;
UPDSTAT(LAFILE,LAFIEN,LASTATUS,LALEXERR,LATNUM) ; Update SCT CODE STATUS field
 ;
 N LAERR,LAFDA,LRFMERTS
 ;
 I $G(LASTATUS)="" Q
 ; Lock file entry prior to updating
 F  L +^LAB(LAFILE,LAFIEN):DILOCKTM+15 Q:$T
 ;
 ; Stop AERT xref from triggering alert (from ^LRERT1)
 S LRFMERTS=1
 S LRFMERTS("STS","STAT")="OK"
 S LRFMERTS("STS","PROC")="CHECK"
 ;
 ; Update Status
 S LAFDA(1,LAFILE,LAFIEN_",",21)=LASTATUS
 D FILE^DIE("","LAFDA(1)","LAERR(1)")
 ;
 ; Update SCT STATUS DATE multiple
 D SCTUPD(LAFILE,LAFIEN,LASTATUS,$G(LALEXERR),$G(LATNUM))
 ;
 L -^LAB(LAFILE,LAFIEN)
 ;
 Q
 ;
SCTUPD(LAFILE,LAFIEN,LASTATUS,LALEXERR,LATNUM) ; Update SCT STATUS DATE multiple
 ;
 N LACNT,LAERR,LAFDA,LASUBFILE,LAWP
 ;
 S LASUBFILE=$S(LAFILE=61:61.023,LAFILE=61.2:61.223,LAFILE=62:62.023,1:"")
 I LASUBFILE="" Q
 ;
 ; Store date/time, user and new status
 S LAFDA(2,LASUBFILE,"+2,"_LAFIEN_",",.01)=$$NOW^XLFDT
 S LAFDA(2,LASUBFILE,"+2,"_LAFIEN_",",1)=LASTATUS
 S LAFDA(2,LASUBFILE,"+2,"_LAFIEN_",",3)=DUZ
 ; Store transaction number
 I $G(LATNUM)'="" S LAFDA(2,LASUBFILE,"+2,"_LAFIEN_",",2)=LATNUM
 ;
 D UPDATE^DIE("","LAFDA(2)","LAFIEN","LAERR(2)")
 ;
 I '$G(LAFIEN(2)) Q
 ;
 S LACNT=1
 S LAWP(LACNT)="SCT CODE STATUS updated by system due to current status in the Lexicon."
 S LACNT=LACNT+1
 ; Record any reported Lexicon API error
 I $G(LALEXERR)'="" D
 . S LAWP(LACNT)=" "
 . S LACNT=LACNT+1
 . S LAWP(LACNT)="Lexicon API: "_LALEXERR
 . S LACNT=LACNT+1
 ;
 I $D(LAWP) D WP^DIE(LASUBFILE,LAFIEN(2)_","_LAFIEN_",",4,"A","LAWP","LAERR(3)")
 ;
 Q
 ;
SENDMSG() ; Send MailMan message. Return message ID.
 ;
 N I,LABODY,LAMSGSUB,LASUB,XMERR,XMINSTR,XMSUBJ,XMTO,XMZ
 ;
 S LAMSGSUB="MSGFINAL"
 ;
 S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="Due to a recent Lexicon patch that updated the SNOMED CT (SCT) code set at"
 S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="your facility, some of the Lab entries in the TOPOGRAPHY FIELD file (#61),"
 S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="COLLECTION SAMPLE file (#62), and ETIOLOGY FIELD file (#61.2) are mapped to"
 S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="SCT codes that have been deprecated or have other exceptions."
 S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))=""
 ;
 ; if failed to send alert to STS, use this verbiage:
 I $D(^TMP("LA7CHK",$J,"ERR")) D
 . S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="An STS alert failed to be generated for some of these exceptions."
 . S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="Please contact Standards & Terminology Services (STS) to have those SNOMED"
 . S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="CT mappings updated."
 ;
 ; if alert was sent to STS, use this verbiage:
 I '$D(^TMP("LA7CHK",$J,"ERR")) D
 . S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="Standards & Terminology Services (STS) has received notification of these"
 . S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="SNOMED CT exceptions and will provide your site with a new SCT mapping file"
 . S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="within several weeks or less."
 . S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))=""
 . S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="-----------------------------------------------------------------------------"
 . S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))=" NOTE: YOU DO NOT NEED TO DO ANYTHING UNTIL YOU GET THE UPDATED MAPPING FILE"
 . S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="       FROM STS"
 . S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="-----------------------------------------------------------------------------"
 ;
 S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))=""
 S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))="The following SNOMED CT exceptions have been found at:"
 S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))=$$NAME^XUAF4($$KSP^XUPARAM("INST"))_" ("_$$KSP^XUPARAM("WHERE")_")."
 ;
 F LASUB="ERR","MSG" D
 . S I=0
 . F  S I=$O(^TMP("LA7CHK",$J,LASUB,I)) Q:'I  D
 . . S ^TMP("LA7CHK",$J,LAMSGSUB,$$LN(LAMSGSUB))=$G(^TMP("LA7CHK",$J,LASUB,I))
 ;
 S XMSUBJ="SNOMED CT MAPPING ERRORS"
 S LABODY="^TMP(""LA7CHK"",$J,"""_LAMSGSUB_""")"
 S XMINSTR("ADDR FLAGS")="R"
 S XMINSTR("FROM")="LAB PACKAGE"
 ;
 I $$GOTLOCAL^XMXAPIG("LAB MESSAGING") S XMTO("G.LAB MESSAGING")=""
 I $$GOTLOCAL^XMXAPIG("LMI") S XMTO("G.LMI")=""
 I '$D(XMTO) M XMTO=^XUSEC("LRLIASON") ; File ^XUSEC/10076
 ;
 D SENDMSG^XMXAPI(DUZ,XMSUBJ,LABODY,.XMTO,.XMINSTR,.XMZ)
 ;
 K ^TMP("XMERR",$J)
 ;
 Q $G(XMZ)
 ;
FRMTTXT(TEXT,LMARGIN,RMARGIN,LARSLT) ;Format Text
 ;
 ; Format text
 ;
 ; Input:
 ;   TEXT = The text to format
 ;   LMARGIN (optional) = The left margin for the text
 ;                        Defaults to 1
 ;   RMARGIN (optional) = The right margin for the text
 ;                        Defaults to 80
 ;   LARSLT = The resulting array
 ;
 N DIWF,DIWL,DIWR,X
 ;
 K ^UTILITY($J,"W")
 S DIWL=$G(LMARGIN)
 S DIWR=$G(RMARGIN)
 I DIWL="" S DIWL=1
 I DIWR="" S DIWR=80
 S DIWF=""
 S X=TEXT
 D ^DIWP
 M LARSLT=^UTILITY($J,"W",DIWL)
 K ^UTILITY($J,"W")
 ;
 Q
 ;
LN(SUB) ; Increment the line counter.
 ;
 ;ZEXCEPT: LALINE
 ;
 S LALINE(SUB)=$G(LALINE(SUB))+1
 Q LALINE(SUB)
 ;
CLEAN ; Clean up tmp global(s)
 ;
 K ^TMP("LA7CHK",$J)
 Q
