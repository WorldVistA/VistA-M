MAGGTU6 ;WOIFO/GEK - Silent Utilities ; 4/7/09 2:30pm
 ;;3.0;IMAGING;**24,8,48,45,20,46,59,72,93**;Dec 02, 2009;Build 163
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
LOGACT(MAGRY,DATA) ;RPC [MAGGACTION LOG]
 ; Call to LogAction from Delphi Window 
 ;
 ; DATA is input variable it is '^' delimited string
 ; 'A|B|C|D|E' ^^ MAGIEN ^ 'Copy/Download' ^ DFN ^ '1';
 ;  DUZ is inserted as 2nd piece below.
 ; I.E. DATA  = "C^^103660^Copy To Clipboard^1033^1"
 N Y
 S MAGRY="0^Logging access..."
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 ;                 C       DUZ      MAGIEN     ACTION       DFN       1        Additional Data
 D ENTRY^MAGLOG($P(DATA,U),+$G(DUZ),$P(DATA,U,3),$P(DATA,U,4),$P(DATA,U,5),$P(DATA,U,6),$P(DATA,U,7))
 S MAGRY="1^Action was Logged."
 Q
 ;
LINKDT(MAGRY,MAGDA,DTTM) ; This is called when an Image is successfully 
 ; linked (Associated) with a Report/Procedure/Note etc.
 ;  MAGDA = Image IEN
 ;  DTTM = ""            No date sent, so use NOW 
 ;  DTTM = 1                     No Date Sent, but use Image capture Date.
 ;  DTTM = Valid FM Date/Time    , Use it.
 N MSG
 S DTTM=$G(DTTM)
 I 'DTTM S DTTM=$$NOW^XLFDT      ; Using NOW
 I '$D(^MAG(2005,MAGDA)) Q
 I DTTM=1 S DTTM=$P(^MAG(2005,MAGDA,2),"^",1) ; Using Date Image Captured.
 I '$$VALID^MAGGSIV1(2005,64,.DTTM,.MSG) S MAGRY="0^"_MSG Q
 S $P(^MAG(2005,MAGDA,2),"^",11)=DTTM
 S MAGRY="1^Okay"
 Q
 ;
TIMEOUT(MAGRY,APP) ;RPC [MAGG GET TIMEOUT]
 ; Call  Returns the timeout for the APP from IMAGING SITE PARAMETERS File
 ;  APP is either 'DISPLAY'  'CAPTURE' or   'VISTARAD'
 N I,MAGTIMES,MAGPLC
 S MAGRY=""
 S MAGPLC=$$PLACE^MAGBAPI(DUZ(2)) I 'MAGPLC Q  ; DBI - SEB 9/20/2002
 S MAGTIMES=$G(^MAG(2006.1,MAGPLC,"KEYS"))
 I APP="DISPLAY" S MAGRY=$P(MAGTIMES,U,2)
 I APP="CAPTURE" S MAGRY=$P(MAGTIMES,U,3)
 I APP="VISTARAD" S MAGRY=$P(MAGTIMES,U,4)
 I APP="TELEREADER" S MAGRY=$P(MAGTIMES,U,6)  ;  MJK - 2006.01.25 - TeleReader
 Q
 ;
EXIST(EKGPLACE) ;Does an ekg server exist in 2005.2
 I $$CONSOLID^MAGBAPI()=0 Q $O(^MAG(2005.2,"E","EKG","")) ; DBI - SEB 9/20/2002
 Q $O(^MAG(2005.2,"F",EKGPLACE,"EKG",""))
 ;
ONLINE(MAGR) ;RPC [MAG EKG ONLINE] EKG network location status    
 ;returns the status of the first EKG network location type
 ;0 if offline or a network location doesn't exist
 ;1 if online
 ;
 N EKG1,EKGPLACE
 S EKGPLACE=$$PLACE^MAGBAPI(DUZ(2)) ; DBI - SEB 9/20/2002
 I EKGPLACE=0 S EKGPLACE=$$PLACE^MAGBAPI(DUZ(2)) ;Convert to extrinsic /gek 8/2003
 I $$EXIST(EKGPLACE) D
 . I $$CONSOLID^MAGBAPI() S EKG1=$O(^MAG(2005.2,"F",EKGPLACE,"EKG","")) ; DBI - SEB 9/20/2002
 . E  S EKG1=$O(^MAG(2005.2,"E","EKG",""))
 . S MAGR=$P(^MAG(2005.2,+EKG1,0),U,6)
 . Q
 E  S MAGR=0
 Q
SHARE(MAGRY,TYPE) ;RPC [MAG GET NETLOC]
 ; Get list of image shares
 ;TYPE = One of the STORAGE TYPE codes : MAG, EKG, WORM, URL or ALL
 N TMP,I,DATA0,DATA2,DATA3,DATA6,INFO,VALUE,STYP,PHYREF
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 S:TYPE="" TYPE="ALL"
 S MAGRY(0)="1^SUCCESS"
 S I=0 F  S I=$O(^MAG(2005.2,I)) Q:'I  D
 . Q:$$LOCDRIVE(I)
 . S DATA0=$G(^MAG(2005.2,I,0))
 . S DATA2=$G(^MAG(2005.2,I,2))
 . S DATA3=$G(^MAG(2005.2,I,3))
 . S DATA6=$G(^MAG(2005.2,I,6))
 . ; 
 . S PHYREF=$P(DATA0,"^",2) ; PHYSICAL REFERENCE
 . S STYP=$P(DATA0,"^",7) ; STORAGE TYPE
 . ;
 . I TYPE'="ALL" Q:STYP'[TYPE
 . Q:$P(DATA0,"^",6)=0  ; Share is offline (don't return offline shares)
 . I STYP'="URL" Q:(PHYREF[".")  ; pre 45
 . I STYP'="URL" Q:($E(PHYREF,1,2)'="\\")  ; pre 45
 . ;
 . S INFO=$S($E(PHYREF,$L(PHYREF))="\":$E(PHYREF,1,$L(PHYREF)-1),1:PHYREF)
 . S $P(INFO,"^",2)=$P(DATA0,"^",7) ; Physical reference (path)
 . S $P(INFO,"^",3)=$P(DATA0,"^",6) ; Operational Status 0=OFFLINE 1=ONLINE
 . S $P(INFO,"^",4)=$P(DATA2,"^",1) ; Username
 . S $P(INFO,"^",5)=$P(DATA2,"^",2) ; Password
 . S $P(INFO,"^",6)=$P(DATA6,"^",1) ; MUSE Site #
 . S $P(INFO,"^",7)=$P($G(^MAG(2006.17,+$P(DATA6,"^",2),0)),"^",1) ; MUSE version #
 . S $P(INFO,"^",8)=$P(DATA3,"^",5) ; Network location SITE
 . S $P(INFO,"^",9)=$P(DATA0,"^",10) ; Place
 . S:'$D(TMP(INFO)) TMP(INFO)=I
 . Q
 S INFO="" F  S INFO=$O(TMP(INFO)) Q:INFO=""  D
 . S MAGRY($O(MAGRY(""),-1)+1)=TMP(INFO)_"^"_INFO
 . Q
 Q
 ;
LOCDRIVE(I) ; Returns 1 if this is a local drive, else 0
 ; Local Drive is determined by the DIR not being Type : URL and having a ":"
 I $P(^MAG(2005.2,I,0),"^",7)'="URL" I $P(^MAG(2005.2,I,0),"^",2)[":" Q 1
 Q 0
 ;
GETENV(MAGRY) ;RPC [MAG GET ENV]
 ; Get some environment variables (used by annotation control)
 S MAGRY=DUZ(2)_"^"_$$NOW^XLFDT
 Q
 ;
ANNCB(STATARR) ;Status Callback (called by the import API)
 ;
 N I,CDUZ,QINDEX,MAGA,COUNT
 N XMDUZ,XMSUB,XMTEXT,XMY
 ;  0 = error, all others are success.
 I $P(STATARR(0),"^",1)'=0 D
 . ;   Import was successful
 E  D
 . ;   Import failed - send mail to MAG SERVER group and person who queued the import
 . S XMDUZ=DUZ
 . S XMSUB="Import Error Report"
 . ;    get text of message from status array
 . S XMTEXT="MAGA("
 . ; XMD needs array to start with 1, not 0
 . S COUNT=1,I=""
 . F  S I=$O(STATARR(I)) Q:I=""  D
 . . S MAGA(COUNT)=I_") "_STATARR(I)
 . . S COUNT=COUNT+1
 . . Q
 . S MAGA(COUNT+1)=" "
 . S MAGA(COUNT+2)=" "
 . S MAGA(COUNT+3)="     The errors listed above were generated by"
 . S MAGA(COUNT+4)="     the VistA Imaging Annotation Editor while"
 . S MAGA(COUNT+5)="     trying to import your diagram.  Please"
 . S MAGA(COUNT+6)="     report these errors to your VistA Imaging"
 . S MAGA(COUNT+7)="     support personnel."
 . ;Get person who did the import
 . S QINDEX=STATARR(2)
 . S I=-1 F  S I=$O(^MAG(2006.034,QINDEX,1,I)) Q:I=""  D
 . . I $P($G(^MAG(2006.034,QINDEX,1,I,0)),"^",1)=8 S CDUZ=$P(^MAG(2006.034,QINDEX,1,I,0),"^",2)
 . ;Set recipients of message
 . S XMY("G.MAG SERVER")=""
 . I $G(CDUZ) S XMY(CDUZ)=""
 . D ^XMD
 . Q
 Q
 ;
GETCTP(MAGRY,DATA) ;RPC [MAG4 CT PRESETS GET]
 ; INPUT
 ;    DATA  = set of flags to determine which set of CT PRESETS
 ;    to return to client.  if $P(DATA,^,1)=2 then the second
 ;    set of CT PRESETS will be returned.
 ; OUTPUT
 ;    MAGRY = the set of presets from Imaging Site Paramters File
 S DATA=$G(DATA)
 N MAGPLC
 S MAGPLC=$$PLACE^MAGBAPI(DUZ(2))
 I 'MAGPLC S MAGRY="0^Error resolving Users Division" Q
 I $P(DATA,"^",1)=2 S MAGRY=$G(^MAG(2006.1,MAGPLC,"CT2"))
 E  S MAGRY=$G(^MAG(2006.1,MAGPLC,"CT"))
 I MAGRY="" S MAGRY="0^Site doesn't have CT Presets defined." Q
 S MAGRY="1^"_MAGRY
 Q
 ;
SAVECTP(MAGRY,VALUE,DATA) ;RPC [MAG4 CT PRESETS SAVE]
 ;    DATA  = set of flags to determine which set of CT PRESETS
 ;    are being saved.  if $P(DATA,^,1)=2 then VALUE will be saved
 ;    as CT PRESETS 2
 S DATA=$G(DATA)
 N MAGPLC
 S MAGPLC=$$PLACE^MAGBAPI(DUZ(2))
 I 'MAGPLC S MAGRY="0^Error resolving Users Division" Q
 I $P(DATA,"^",1)=2 S ^MAG(2006.1,MAGPLC,"CT2")=VALUE
 E  S ^MAG(2006.1,MAGPLC,"CT")=VALUE
 S MAGRY="1^CT Presets saved."
 Q
 ;
NETPLCS ; Create an array of Place, SiteCodes for all entries of
 ; Network Location entries.  
 N I,PLC,PLCODE,CONS
 S CONS=$$CONSOLID^MAGBAPI
 I 'CONS S PLC=$O(^MAG(2006.1,0)),PLCODE=$P(^MAG(2006.1,PLC,0),"^",9)
 ; 
 K MAGJOB("NETPLC")
 S I=0 F  S I=$O(^MAG(2005.2,I)) Q:'I  D
 . I 'CONS S MAGJOB("NETPLC",I)=PLC_"^"_PLCODE Q
 . ; Here, for consolidated sites we get the real Site IEN, and Site Code.
 . I CONS S PLC=$P($G(^MAG(2005.2,I,0)),"^",10),PLCODE=$S(PLC:$P($G(^MAG(2006.1,PLC,0)),"^",9),1:"n/a")
 . S MAGJOB("NETPLC",I)=PLC_"^"_PLCODE
 . Q
 Q
