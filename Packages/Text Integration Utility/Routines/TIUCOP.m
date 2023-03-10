TIUCOP ;SLC/TDP - Copy/Paste API(s) and RPC(s) ;Jul 29, 2020@10:13:01
 ;;1.0;TEXT INTEGRATION UTILITIES;**290,336**;Jun 20, 1997;Build 4
 ;
 ; External Reference
 ;   DBIA  2051  $$FIND1^DIC
 ;   DBIA  1544  $$ISA^USRLM
 ;
 Q
WORDS(INST) ;Return the number of words required to begin tracking
 ; copied text as part of the Copy/Paste functionality.
 ;
 ;   Call using $$WORDS^TIUCOP(INSTITUTION IEN)
 ;
 ;   Input
 ;     INST - institution ien
 ;
 ;   Ouput
 ;     - Number of Words required (example "5")^Max text length
 ;                Or
 ;       Error condition "-1^Error Msg"
 ;
 N IEN,WRDS,MAXLNG
 I $G(INST)="" S INST=$G(DUZ(2))
 I +INST<1 Q "-1^Invalid institution"
 S INST=$$FIND1^DIC(4,"","","`"_INST,"","","ERR")
 I +INST<1 Q "-1^Invalid institution"
 S IEN=$O(^TIU(8925.99,"B",INST,0))
 I +IEN=0 Q "-1^Institution not defined in TIU PARAMETERS file"
 S WRDS=+$P($G(^TIU(8925.99,IEN,4)),U,1)
 I WRDS=0 S WRDS=5 D ERMSG^TIUCOPUT("WORD") ;Send error message if required words not set in parameter
 Q WRDS
 ;
MAXLNG() ;Return the Maximum length string we will recalculate percentage
 N MAX
 S MAX=$$GET^XPAR("ALL","ORQQTIU COPY/PASTE FIND LIMIT",,"Q")
 I MAX="" S MAX=10000
 Q MAX
 ;
PCT(INST) ;Return the Copy/Paste verification percentage
 ;   Call using $$PCT^TIUCOP(INSTITUTION IEN)
 ;
 ;   Input
 ;     INST - institution ien
 ;
 ;   Output
 ;     - Percent pasted text matches copied text needed to be considered
 ;       as derived from the copied text (example ".5")
 ;                Or
 ;       Error condition "-1^Error Msg"
 ;
 N IEN,PCT
 I $G(INST)="" S INST=$G(DUZ(2))
 I +INST<1 Q "-1^Invalid institution"
 S INST=$$FIND1^DIC(4,"","","`"_INST,"","","ERR")
 I +INST<1 Q "-1^Invalid institution"
 S IEN=$O(^TIU(8925.99,"B",INST,0))
 I +IEN=0 Q "-1^Institution not defined in TIU PARAMETERS file"
 S PCT=+$P($G(^TIU(8925.99,IEN,4)),U,2)
 I PCT=0 S PCT=90 D ERMSG^TIUCOPUT("PCT") ;Send error message if required percentage is not set in parameter
 Q PCT/100
 ;
DAYS(INST) ;Return the number of days to save copied text information
 ;   Call using $$DAYS^TIUCOP(INSTITUTION IEN)
 ;
 ;   Input
 ;     INST - institution ien
 ;
 ;   Output
 ;     - Days to save copied text (example "7")
 ;                Or
 ;       Error condition "-1^Error Msg"
 ;
 N IEN,DAYS
 I $G(INST)="" S INST=$G(DUZ(2))
 I +INST<1 Q "-1^Invalid institution"
 S INST=$$FIND1^DIC(4,"","","`"_INST,"","","ERR")
 I +INST<1 Q "-1^Invalid institution"
 S IEN=$O(^TIU(8925.99,"B",INST,0))
 I +IEN=0 Q "-1^Institution not defined in TIU PARAMETERS file"
 S DAYS=+$P($G(^TIU(8925.99,IEN,4)),U,3)
 I DAYS=0 S DAYS=1 D ERMSG^TIUCOPUT("DAY") ;Send error message if required percentage is not set in parameter
 Q DAYS
 ;
EXC(TIUDA) ;Return whether or not note is excluded from copy/paste tracking
 ;   Call using $$EXC^TIUCOP(TIU IEN)
 ;
 ;   Input
 ;     TIUDA - TIU ien (#8925)
 ;
 ;   Output
 ;     - Boolean (1: Exclude, 0:Don't Exclude)
 ;                Or
 ;       Error condition "-1^Error Msg"
 ;
 N CLDOC,IEN,EX,ND0,TMP,X
 S EX=0
 I $G(TIUDA)="" Q "-1^TIU IEN required"
 I +TIUDA<1 Q "-1^Invalid TIU IEN"
 I '$G(^TIU(8925,TIUDA,0)) Q "-1^Invalid TIU IEN"
 S IEN=+$P($G(^TIU(8925,TIUDA,0)),U,1)
 I '$D(^TIU(8925.1,IEN,0)) Q EX ;Missing TIU Document Type
 S ND0=$G(^TIU(8925.1,IEN,0))
 I ND0="" Q EX
 S CLDOC=$O(^TIU(8925.1,"B","CLINICAL DOCUMENTS",""))
 D ANCESTOR^TIUFLF4(IEN,ND0,.TMP,0)
 S X=""
 F  S X=$O(TMP(X)) Q:X=""  Q:IEN=CLDOC  D  Q:EX=1
 . S IEN=+$G(TMP(X))
 . I IEN=CLDOC Q
 . S IEN=$O(^TIU(8925.95,"B",IEN,0))
 . I +IEN<1 Q  ;"-1^Missing TIU Document Type"
 . S EX=+$P($G(^TIU(8925.95,IEN,10)),U,1)
 . I EX'="" S IEN=CLDOC
 Q EX
 ;
EXCLST(TIULST) ;Returns a list of all copy/paste excluded note titles
 N CNT,DOCTTL,DOCCLS,DOCIEN,DOCNM,TIUND0
 S (CNT,DOCCLS)=0
 F  S DOCCLS=$O(^TIU(8925.95,"AC",DOCCLS)) Q:DOCCLS=""  D
 . S TIUND0=$G(^TIU(8925.1,DOCCLS,0))
 . ;Track list of documents to return
 . I $P(TIUND0,U,4)="DOC" D
 . . S CNT=CNT+1
 . . S TIULST(CNT)=DOCCLS_U_$P(TIUND0,U,1)
 . . S TIULST("B",DOCCLS)=""
 . ;Track list of non-documents to review further
 . S DOCTTL=0
 . F  S DOCTTL=$O(^TIU(8925.1,"ACL",DOCCLS,DOCTTL)) Q:DOCTTL=""  D
 . . S DOCIEN=0
 . . F  S DOCIEN=$O(^TIU(8925.1,"ACL",DOCCLS,DOCTTL,DOCIEN)) Q:DOCIEN=""  D
 . . . S DOCNM=$P($G(^TIU(8925.1,DOCIEN,0)),U,1)
 . . . I '$D(TIULST("B",DOCIEN)) S CNT=CNT+1,TIULST(CNT)=DOCIEN_U_DOCNM,TIULST("B",DOCIEN)=""
 I CNT=0 S TIULST(1)=""
 K TIULST("B")
 Q
 ;
VIEW(USER,IEN,INST) ;Is user allowed to view copy/paste
 ;   Call using $$VIEW^TIUCOP(USER DUZ,TIU (NOTE) IEN,INSTITUTION)
 ;   RSLT=
 ;      0 - User is not allowed to view copy/paste information
 ;      1 - User is AUTHOR and note is UNSIGNED, or user is COSIGNER who has yet to
 ;          SIGN the note.
 ;      2 - User has a user class of "CHIEF, MIS", or "CHIEF, HIMS",
 ;          or "PRIVACY ACT OFFICER", or one of the user classes designated
 ;          at the site.
 N AUTH,AUTHSGN,CHIM,CMIS,COSGNSGN,COSIGN,FIN,HIM,INSTIEN,PAO,TIU12,TIU15
 N USRCLS,X
 S FIN=""
 I +USER=0 Q 0 ;Not a valid user, so not allowed to view
 S INST=$G(DUZ(2))
 I +INST=0 Q 0 ;Institution is required
 S CMIS="CHIEF, MIS"
 S CHIM="CHIEF, HIMS"
 S PAO="PRIVACY ACT OFFICER"
 F USRCLS=CHIM,CMIS,PAO D  Q:FIN
 . S FIN=$$ISA^USRLM(+USER,USRCLS)
 I FIN Q 2 ;User belongs to special user class
 S INSTIEN=$O(^TIU(8925.99,"B",INST,""))
 I INSTIEN>0 S X=0 F  S X=$O(^TIU(8925.99,INSTIEN,5,X)) Q:+X=0  D  Q:FIN
 . S USRCLS=$P(^TIU(8925.99,INSTIEN,5,X,0),U,1)
 . S FIN=$$ISA^USRLM(+USER,USRCLS)
 I FIN Q 2 ;User belongs to special user class
 I +$G(IEN)=0 Q 0 ;No ien.  User does not belong to special user class and no further checks.
 S TIU12=$G(^TIU(8925,+IEN,12))
 S TIU15=$G(^TIU(8925,+IEN,15))
 S AUTH=+$P(TIU12,U,2)
 S AUTHSGN=+$P(TIU15,U,2)
 ;I AUTH=USER,AUTH'=AUTHSGN Q 1 ;User is author and has not signed note.
 I AUTH=USER,AUTHSGN=0 Q 1 ;User is author and has not signed note.
 S COSIGN=+$P(TIU12,U,8)
 I 'COSIGN Q 0 ;No cosigner, so user not authorized.
 S COSGNSGN=+$P(TIU15,U,8)
 I COSIGN=USER,COSIGN'=COSGNSGN Q 1 ;User is cosigner and unsigned, author has signed.
 Q 0 ;User not authorized
 ;
PUTCOPY(INST,ARY,ERR) ;Save to copy buffer
 N SAVE
 S INST=$G(DUZ(2))
 S SAVE=$$PUTCOPY^TIUCOPC(INST,.ARY,.ERR)
 Q SAVE
 ;
GETCOPY(INST,DFN,ARY,STRT) ;Retrieve copy buffer
 I $G(STRT)="" S STRT=""
 S INST=$G(DUZ(2))
 D GETCOPY^TIUCOPC(INST,DFN,.ARY,STRT,1)
 Q
 ;
GETCOPY1 ;Retrieve copy buffer in background
 ;DFN,DIV,HWND,IP,NODE are saved variables as part of queued process
 ;ZTQUEUED,ZTREQ are variables that exist as part of a queued process
 ;DILOCKTM is a global variable
 N ARY,STRT
 I $D(ZTQUEUED) S ZTREQ="@"
 I $G(^XTMP(NODE,"STOP")) K ^XTMP(NODE) Q  ; client no longer polling
 I '$D(^XTMP(NODE,0)) Q                    ; XTMP node has been purged
 L +^XTMP(NODE):$S($G(DILOCKTM)>0:DILOCKTM,1:5)
 S ^XTMP(NODE,"DFN")=DFN
 S (ARY,STRT)=""
 D GETCOPY^TIUCOPC(DIV,DFN,.ARY,STRT,0)
 I $G(^XTMP(NODE,"STOP")) Q
 I +ARY(0,0)>0 D
 . N CNT,ND,ND1,X
 . S CNT=0
 . S ND="" F  S ND=$O(ARY(ND)) Q:ND=""  D
 .. S ND1="" F  S ND1=$O(ARY(ND,ND1)) Q:ND1=""  D
 ... I ND=0,ND1=0 Q
 ... S X="("_ND_","_ND1_")="
 ... S CNT=CNT+1
 ... S ^XTMP(NODE,"COPY",CNT)=X_$G(ARY(ND,ND1))
 ... K ARY(ND,ND1)
 ;... I (CNT#100)=0 H 10
 I +$G(ARY(0,0))=-1 S ^XTMP(NODE,"COPY",-1)=$P($G(ARY),U,2) K ARY(0,0)
 S ^XTMP(NODE,"DONE")=1
 I $G(^XTMP(NODE,"STOP")) K ^XTMP(NODE)
 L -^XTMP(NODE)
 Q
CHKPASTE(INST,DOC) ;Check note document for pasted text data
 S INST=$G(DUZ(2))
 Q $$CHKPASTE^TIUCOPP(DOC,INST)
 ;
PUTPASTE(RSLT,INST,ARY,ERR) ;Save pasted text SVARY
 N CNTR,DIV,PIEN,RSLT1,SAVE,SVARY
 S INST=$G(DUZ(2))
 S SAVE=""
 S SVARY=1
 S SAVE=$$PUTPASTE^TIUCOPP(INST,.ARY,.ERR,.SVARY)
 I +$G(SVARY(0))>0 S CNTR=0 F  S CNTR=$O(SVARY(CNTR)) Q:CNTR=""  D
 . S DIV=+$G(SVARY(CNTR)) Q:DIV=0
 . S PIEN=$P($G(SVARY(CNTR)),U,2)
 . D GETPST^TIUCOP1(PIEN,DIV,.RSLT1,1)
 I +$G(RSLT1(0,0))=-1 S RSLT(-1)=$P($G(RSLT1),U,2) S RSLT("0,0")=-1 K RSLT1(0,0) Q 0
 I +$G(RSLT1(0,0))>0 D
 . N CNT,ND,ND1
 . S CNT=0
 . S ND=0 F  S ND=$O(RSLT1(ND)) Q:ND=""  D
 .. S CNT=CNT+1
 .. S RSLT(CNT)=CNT_"="_$G(RSLT1(ND,0))
 .. K RSLT1(ND)
 Q SAVE
 ;
GETPASTE(TIUIEN,INST,APP,ARY) ;Retrieve pasted text
 S INST=$G(DUZ(2))
 D GETPASTE^TIUCOPP(TIUIEN,INST,APP,.ARY,0)
 Q
 ;
START(VAL,DFN,IP,HWND,DIV) ;Start copy buffer build in background
 N DT,NODE,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK ;,ORHTIME
 S DIV=$G(DUZ(2))
 S VAL=0
 S DT=$$DT^XLFDT
 S NODE="TIUCOP "_IP_"-"_HWND_"-"_DFN
 S ZTIO="",ZTRTN="GETCOPY1^TIUCOP",ZTDTH=$H
 S (ZTSAVE("DFN"),ZTSAVE("IP"),ZTSAVE("HWND"),ZTSAVE("DIV"),ZTSAVE("NODE"))=""
 S ZTDESC="CPRS GUI Background Data Retrieval"
 K ^XTMP(NODE)
 S ^XTMP(NODE,0)=$$FMADD^XLFDT(DT,1)_U_DT
 D ^%ZTLOAD I '$D(ZTSK) D  Q
 . K ^XTMP(NODE,0)
 . S VAL=0
 S $P(^XTMP(NODE,0),U,3)="Background CPRS "_ZTSK
 S VAL=1
 ; Start capacity planning timing clock - will be stopped in POLL code
 ;I +$G(^KMPTMP("KMPD-CPRS")) S ^KMPTMP("KMPDT","ORWCV",NODE)=$G(ORHTIME)_"^^"_$G(DUZ)_"^"_$G(IO("CLNM"))
 Q
 ;
POLL(LST,DFN,IP,HWND) ; poll for completed cover sheet parts
 N I,ILST,ID,LAST,LSTDATA,NODE,DONE,STOP,OLDI,QT
 S NODE="TIUCOP "_IP_"-"_HWND_"-"_DFN,ILST=1,DONE=0
 I '$D(^XTMP(NODE,"DFN")) S LST(1)="~DONE=1" Q
 I ^XTMP(NODE,"DFN")'=DFN S LST(1)="~DONE=1" Q
 S LST(1)="~DONE=0"
 I $G(^XTMP(NODE,"DONE")) S ILST=1,LST(1)="~DONE=1",DONE=1
 S LAST=$O(^XTMP(NODE,"COPY",""),-1)
 ;I LAST="" S LST(1)="~NO DATA YET" Q
 S STOP=99999999999
 I $G(LAST)'="" D
 . ;S STOP=($P($P($G(^XTMP(NODE,"COPY",LAST)),",",1),"(",2)-1)
 . S STOP=$P($P($G(^XTMP(NODE,"COPY",LAST)),",",1),"(",2)
 . I STOP<1 S STOP=0
 S (OLDI,QT)=0
 S I=0 F  S I=$O(^XTMP(NODE,"COPY",I)) Q:'I  D  Q:QT=1
 . I $G(^XTMP(NODE,"STOP"))=1 S (DONE,QT)=1,LST(1)="~DONE=1"
 . I $P($P($G(^XTMP(NODE,"COPY",I)),",",1),"(",2)>STOP S QT=1 Q
 . ;I ILST=1999!ILST-1=LAST S OLDI=($P($P($G(^XTMP(NODE,"COPY",I)),",",1),"(",2)-1)
 . ;I ((ILST>1999)!(LAST'<ILST)),OLDI'=($P($P($G(^XTMP(NODE,"COPY",I)),",",1),"(",2)-1) S QT=1 Q
 . S ILST=ILST+1,LST(ILST)=^(I)
 . I ILST=2000 S QT=1
 . K ^XTMP(NODE,"COPY",I)
 I 'DONE,$G(^XTMP(NODE,"STOP"))=1 S DONE=1,LST(1)="~DONE=1"
 ; Stop capacity planning timing clock - was started in START code
 I DONE K ^XTMP(NODE) Q  ;I +$G(^KMPTMP("KMPD-CPRS")) S $P(^KMPTMP("KMPDT","ORWCV",NODE),"^",2)=$H
 I $G(LST(1))="" S LST(1)="~NO DATA YET"
 Q
 ;
STOP(OK,DFN,IP,HWND) ; stop cover sheet data retrieval
 ;DILOCKTM is a global variable
 N NODE
 S NODE="TIUCOP "_IP_"-"_HWND_"-"_DFN
 S ^XTMP(NODE,"STOP")=1,OK=1
 L +^XTMP(NODE):$S($G(DILOCKTM)>0:DILOCKTM,1:5)
 I $G(^XTMP(NODE,"DONE")) K ^XTMP(NODE)
 L -^XTMP(NODE)
 Q
 ;
CLEAN(TASK) ;Start CLEANUP background process
 N DT,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S TASK=0
 S DT=$$DT^XLFDT
 S ZTIO="",ZTRTN="CLEANUP^TIUCOP",ZTDTH=$H
 S ZTDESC="TIU Copy/Paste Background ^XTMP global clean-up"
 D ^%ZTLOAD I '$D(ZTSK) Q Y
 S TASK=ZTSK
 Q
 ;
CLEANUP ; clean up ^XTMP nodes
 N %Y,DT,KILLDATE,NODE,TIUNMSPC,X,X1,X2
 S DT=$$DT^XLFDT ;Get current date
 ;Loop through Copy Buffer polling (retrieval) nodes
 S NODE="TIUCOP"
 F  S NODE=$O(^XTMP(NODE)) Q:$E(NODE,1,6)'="TIUCOP"  D
 . S (%Y,KILLDATE,X,X1,X2)=""
 . S X1=DT
 . S X2=$P($G(^XTMP(NODE,0)),U,1)
 . D ^%DTC
 . I +X>1 K ^XTMP(NODE)
 ;. W !,X K ^XTMP(NODE)
 ;Loop through Copy Buffer save nodes
 S TIUNMSPC="TIU COPY/PASTE:"
 F  S TIUNMSPC=$O(^XTMP(TIUNMSPC)) Q:TIUNMSPC=""!(TIUNMSPC'["TIU COPY/PASTE:")  D
 . S (%Y,KILLDATE,X,X1,X2)=""
 . S X1=DT
 . S X2=$P($G(^XTMP(TIUNMSPC,0)),U,1)
 . D ^%DTC
 . ;Kill off entry if 2 days past its expiration date
 . I +X>1 K ^XTMP(TIUNMSPC)
 Q
 ;
DELPST(NOTE) ;Delete pastes associated with a deleted note
 N DA,DIK
 S DIK="^TIUP(8928,"
 S DA=""
 F  S DA=$O(^TIUP(8928,"AD",8925,NOTE,DA)) Q:DA=""  D
 . D ^DIK
 Q
 ;
