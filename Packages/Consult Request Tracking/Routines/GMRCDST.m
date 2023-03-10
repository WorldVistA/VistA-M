GMRCDST ;ABV/BL - Retrieve Decision from DST server;May 21, 2020@07:06:12
 ;;3.0;CONSULT/REQUEST TRACKING;**124,139,152,145,177**;DEC 27, 1997;Build 4
 ;
 ;SAC EXEMPTION 20200131-01 : GMRC use of vendor specific code
 ;IA6173
 ;IA6171
 ;
PROT(MSG)  ;GMRC SIGNED CONSULT DST-PROTOCOL ENTRY POINT
 ;
 ;Extract Order Number FROM THE ORC SEGMENT
 N GMRCMSG,GMRCPKG,MSH,ORC,IEN123,SIGN,ORA,X,SIGNED,DUP
 S GMRCMSG=$S($L($G(MSG)):MSG,1:"MSG") Q:'$O(@GMRCMSG@(0))
 S MSH=0 F  S MSH=$O(@GMRCMSG@(MSH)) Q:MSH'>0  Q:$E(@GMRCMSG@(MSH),1,3)="MSH"
 Q:'MSH  Q:'$L($G(@GMRCMSG@(MSH)))
 ;
 S ORC=MSH F  S ORC=$O(@GMRCMSG@(+ORC)) Q:ORC'>0  I $E(@GMRCMSG@(ORC),1,3)="ORC" D
 . S ORC=ORC_U_@GMRCMSG@(ORC)
 . S ORIFN=+$P($P(ORC,"|",3),";")
 ;GET THE CONSULT IEN FROM THE ORDER
 S IEN123=0,X=$G(^OR(100,ORIFN,4)) I $P(X,";",2)="GMRC" S IEN123=+X
 I IEN123="" Q "-1^No Consult found"
 ;QUIT IF ORDER IS NOT SIGNED
 S ORA=0,SIGN=0,SIGNED=0
 F  S ORA=$O(^OR(100,ORIFN,8,ORA)) Q:+ORA'=ORA!(SIGNED)  D
 . S SIGN=$P(^OR(100,ORIFN,8,ORA,0),"^",6)
 . I SIGN>0 S SIGNED=1
 Q:SIGNED=0 "-1^ORDER NOT SIGNED"
 ;
 ;Need the DUZ of user from Order file for Autoforward
 K GMRCORNP
 S GMRCORNP=$$GET1^DIQ(100,ORIFN,3,"I")
 S ID=$$FINDIDO(ORIFN)
 I ID="" Q "-1^NO DST ID FOUND"
 I $P(ID,"^")="-1" Q "-1^NO DST DATA FOUND"
 ;Check if this DST Note has been added to the consult already
 ;is there an existing comment on the consult, check for duplicate ID
 S DUP=0
 I $D(^GMR(123,IEN123,40,0)) S DUP=$$DUPID(IEN123,ID)
 I DUP Q "-1^DST NOTE ALREADY ADDED TO CONSULT"
 ;
 Q $$GETDST(IEN123,ID)
 ;
DUPID(IEN123,ID)  ;Check to see if this ID has already been entered into the consult
 ;
 N CNODE,CINC,DUP,NOTEID,EDATA
 S DUP=0,CNODE=0,EDATA=0
 I IEN123="" Q DUP
 F  S CNODE=$O(^GMR(123,IEN123,40,CNODE)) Q:+CNODE'=CNODE!(DUP)  D
 . S CINC=0
 . F  S CINC=$O(^GMR(123,IEN123,40,CNODE,1,CINC)) Q:CINC=""!(DUP)  D
 . . I ^GMR(123,IEN123,40,CNODE,1,CINC,0)["CSC-Consult primary stop code:" S EDATA=1
 . . I ^GMR(123,IEN123,40,CNODE,1,CINC,0)["DST ID:" D
 . . . S NOTEID=""
 . . . S NOTEID=$P(^GMR(123,IEN123,40,CNODE,1,CINC,0),"DST ID:",2)
 . . . I NOTEID[ID S DUP=1
 ;Check if we have already loaded DST data
 ;If DUP is positive but EDATA=0 no data is actually loaded, set DUP to 0
 I 'EDATA S DUP=0
 Q DUP
 ;
GETDST(IEN123,ID) ;
 ;This API retrieves the decision data from the DST database using ID
 ;Input:
 ; IEN123 The IEN of file #123
 ; ID The DST ID
 ;Output:
 ; If decision data not found: -1^No decision data found
 ; If decision data found: 1
 ;
 ;Autoforwarding variables added
 ; AFOR: Indicator of Autoforward value = DAF-DST Forwarding:
 ; APAY: Name of consult service from file 123.5 to forward to
 ;
 N A,B,CAPTIONS,COM,COMCT,DATA,I,SERVER,SERVICE,RESOURCE,REQUEST,RESPONSE,RESULT,RET,X,ERRFLG
 K NUMERR
 S ERRFLG=0,NUMERR=0
 S SERVER="DST GET ID SERVER"
 S SERVICE="DST GET ID SERVICE"
 I ID=0 Q "-1^NO VALID ID SUBMITTED"
 S RESOURCE="/"_ID
 ; Get an instance of the REST request object.
 S REQUEST=$$GETREST^XOBWLIB(SERVICE,SERVER)
 S REQUEST.Timeout=60
 S REQUEST.OpenTimeout=30
 ;
TRYAG ; Execute the HTTP Get method.
 K XUERR,RESPJSON,AFOR,APAY,GMRCSS
 K COM ; WCJ;GMRC*3.0*177
 S ERRFLG=0  ; WCJ;GMRC*3.0*177
 S AFOR=0,APAY=""  ;Set variable to check for AutoForward
 S RESULT=$$GET^XOBWLIB(REQUEST,RESOURCE,.XUERR,0)
 I 'RESULT D
 . S COM(1)="DVE-DST Error from VistA:"  ;NEED TO WRITE ERROR TO 123 FILE
 . S COM(2)=XUERR.code
 . I XUERR["Http" S COM(3)=XUERR.statusLine
 . I XUERR["ObjectError" S COM(3)=XUERR.domain,COM(4)=XUERR.errorType
 . S ERRFLG=1,NUMERR=NUMERR+1
 ;If the ERRFLG then store the error in the consult
 I ERRFLG&(NUMERR<10) H 2 G TRYAG
 I ERRFLG D CMT^GMRCGUIB(IEN123,.COM,"",DT,DUZ) Q 0
 ; Process the response.
 S RESPONSE=REQUEST.HttpResponse
 S DATA=RESPONSE.Data
 ;code is not really in JSON format, not changing variable names
 S RESPJSON=""
 F  Q:DATA.AtEnd  Set RESPJSON=RESPJSON_DATA.ReadLine()
 S RESPJSON=$TR(RESPJSON,$C(10),"")
 ;current data is blob of text with ^ delimited fields. Put each field on its own line
 F I=1:1:$L(RESPJSON,"^") D
 . S COM(I)=$P(RESPJSON,"^",I)
 . I COM(I)="" K COM(I) Q  ;BL;152 need to quit before checking for Autoforward
 . ;check for autoforwarding GMRC*3.0*139
 . I COM(I)["DAF-DST Forwarding:" D
 . . I $P(COM(I),":",2)["YES" S AFOR=1
 . I COM(I)["AFD-DST Forward to" D
 . . S APAY=$P(COM(I),":",2)
 . . I $E(APAY,1)=" " S APAY=$E(APAY,2,$L(APAY))  ;REMOVE LEADING SPACE FOR FORWARDED CONSULT
 ;If we have data in the COM array store in the Note, other wise quit with an error
 I $D(COM) D
 . ;COM ARRAY IS EXPECTED TO BE SERIALLY NUMBERED
 . N TCOM,COMNUM,I
 . S COMNUM="",I=0
 . F  S COMNUM=$O(COM(COMNUM)) Q:COMNUM=""  D
 . . S I=I+1
 . . S TCOM(I)=COM(COMNUM)
 . ;Add autoforward message to data stream
 . I AFOR S TCOM(I+1)="Consult forwarded by DST"
 . ;
 . K COM
 . M COM=TCOM
 . K TCOM
 ;Need to make sure the Autoforward Service exists
 I AFOR D
 . ;Check for APAY being populated if not change AFOR and log an error
 . I APAY="" D  Q
 . . S AFOR=0
 . . S COM(I+1)="DVE-DST Error from VistA: No Autoforward Target"
 . ;Get Forwarding Service
 . S GMRCSS="" S GMRCSS=$O(^GMR(123.5,"B",APAY,GMRCSS))
 . Q:GMRCSS'=""
 . ;The forwarding service did not exist. Log error in msg, stop autoforward
 . S AFOR=0
 . S I="A" S I=$O(COM(I),-1)
 . S COM(I+1)="DVE-DST Error from VistA: Autoforward target not found"
 I $D(COM) D  Q 1
 . I 'AFOR D CMT^GMRCGUIB(IEN123,.COM,"",DT,DUZ) Q
 . I AFOR D AFORT(IEN123,APAY,.COM,GMRCSS,GMRCORNP) Q
 I '$D(COM) S COM(1)="DVE-DST ID ISSUE: No Content sent from DST"
 D CMT^GMRCGUIB(IEN123,.COM,"",DT,DUZ) Q 1
 Q
 ;
FINDIDO(ORIFN) ;
 ;1. Find IEN of consult record
 ;2. See if DST ID is in new field added by CPRS in GMRC*3.0*145 (file (#123), field (#85))
 ;3. If DST ID not found in 2. call $$FINDID45 to retrieve DST ID from the #100,#4.5 (RESPONSES multiple)
 ;4. If DST ID not found in 3. call $$FINDIDC to retrieve DST ID from #123,#20 (REASON FOR REQUEST)
 ;5. Call $$GETDST to retrieve Decision data from DST database and save it as a comment
 ;
 ;Input: ORIFN=IEN of file #100
 ;Output:
 ; 1=DST ID found, decision data retrieved, and comment created in the consult record
 ; -1^No Decision data found
 ;
 N ID,IEN123,X
 S IEN123=0,X=$G(^OR(100,ORIFN,4)) I $P(X,";",2)="GMRC" S IEN123=+X
 Q:'IEN123 "-1^No Decision data found"
 ;
 ;WCJ;GMRC*3.0*145;check if CPRS put it in the new field(#85) in the consult file(#123)
 N ERROR  ; just for kicks - don't really need returned error.
 S ID=$TR($$GET1^DIQ(123,IEN123_",",85,,,"ERROR")," ","")
 ;
 I ID="" S ID=$$FINDID45(ORIFN) ;Next search for the DST ID in field #100,#4.5 (RESPONSES)
 ;Having not found the ID in the #100,#4.5 field, now look for it in the consult
 I ID="" S ID=$$FINDIDC(IEN123)
 ;remove space
 S ID=$TR(ID," ","")
 I ID="" Q "-1^No Decision data found"
 Q ID
 ;Q $$GETDST(IEN123,ID)
 ;
FINDID45(ORIFN) ;
 ;This API searches through the #4.5 (RESPONSES) multiple in file #100 for the DST ID
 ;Input: ORIFN=IEN in file #100
 ;Output: DST ID or ""
 ;
 N I,ID,IENS,N,N1,N2,OUT,STR,X,Y
 S ID="",IENS=ORIFN_","
 K OUT D GETS^DIQ(100,IENS,"4.5*","","OUT")
 S N="" F  S N=$O(OUT(100.045,N)) Q:N=""  S (N1,STR)="" D
 . F  S N1=$O(OUT(100.045,N,N1)) Q:N1=""  S STR=STR_OUT(100.045,N,N1) D
 .. S N2="" F  S N2=$O(OUT(100.045,N,N1,N2)) Q:N2=""  S STR=STR_OUT(100.045,N,N1,N2)
 . I STR["DST ID:" D
 . . S STR=$P(STR,"DST ID:",2)
 . . S STR=$P(STR,"--",1)  ;After refactoring str includes dashes at the end
 . . F I=1:1:$L(STR) S Y=$E(STR,I) Q:Y="#"  S ID=ID_Y
 Q ID
 ;
FINDIDC(IEN123) ;
 ;This API searches FILE #123, FIELD #20 (REASON FOR REQUEST)looking for a
 ;"DST ID:" tag and, if found, will extract the DST ID and call API
 ;$$GETDST to retrieve the decision data from the DST database and create
 ;a comment in the consult containing the decision data
 ;
 ;Input: IEN123 IEN of file #123
 ;Output: DST ID or ""
 ;
 N I,ID,IENS,N,OUT,X,Y
 S ID="",IENS=IEN123_","
 K OUT D GETS^DIQ(123,IENS,"20","","OUT")
 S N="" F  S N=$O(OUT(123,IENS,20,N)) Q:N=""  S X=OUT(123,IENS,20,N) D:X["DST ID:"
 .S X=$P(X,"DST ID:",2) F I=1:1:$L(X) S Y=$E(X,I) Q:Y="#"  S ID=ID_Y
 Q ID
 ;
 ;
 ;Post Install to add DST web server/service
EN ;
 N FDA     ; -- FileMan Data Array
 N WEBVICE ; -- Web Service Internal Entry Number
 N WEBVER  ; -- Web Server Internal Entry Number
 N MULTIEN ; -- Web Service Multiple Internal Entry Number
 N WSTAT   ; -- Web Service Status
 N IENROOT,MSGROOT,IENROOT1,VICEIEN
 ;
 K FDA
 S WEBVICE=$O(^XOB(18.02,"B","DST GET ID SERVICE",0))
 S WEBVICE=$S(WEBVICE:WEBVICE,1:"+1")
 S FDA(18.02,WEBVICE_",",.01)="DST GET ID SERVICE"                  ; NAME
 S FDA(18.02,WEBVICE_",",.02)="REST"                                ; TYPE
 S FDA(18.02,WEBVICE_",",200)="vs/v1/consultFactor"                           ; CONTEXT ROOT
 D UPDATE^DIE("E","FDA","IENROOT","MSGROOT")
 K IENROOT,MSGROOT,FDA
 ;
 S WEBVER=$O(^XOB(18.12,"B","DST GET ID SERVER",0))
 S WEBVER=$S(WEBVER:WEBVER,1:"+1")
 S FDA(18.12,WEBVER_",",.01)="DST GET ID SERVER"                    ; NAME
 S FDA(18.12,WEBVER_",",.03)="443"                                          ; PORT
 S FDA(18.12,WEBVER_",",.04)="dst-dev.domain.ext"    ; SERVER
 S FDA(18.12,WEBVER_",",.06)="ENABLED"                                   ; STATUS 1-ENABLED / 0-DISABLED
 S FDA(18.12,WEBVER_",",.07)=60                                          ; DEFAULT HTTP TIMEOUT
 S FDA(18.12,WEBVER_",",1.01)="NO"                                       ; LOGIN REQUIRED
 S FDA(18.12,WEBVER_",",3.01)="FALSE"                                    ; SSL ENABLED
 ;Need to determine if we are creating a new file, or updating an existing one
 N NEW
 S NEW=1
 I $D(^XOB(18.12,WEBVER,0)) S NEW=0
 I NEW=1 D
 . D UPDATE^DIE("E","FDA","IENROOT","MSGROOT")
 I NEW=0 D
 . D FILE^DIE("E","FDA","MSGROOT")
 ;
 ;
 S IENROOT1=$G(IENROOT(1)),MULTIEN=0
 ;
 S WEBVER=$S(IENROOT1:IENROOT1,1:WEBVER)
 K IENROOT,MSGROOT,FDA
 S VICEIEN=0 F  S VICEIEN=$O(^XOB(18.12,WEBVER,100,"B",VICEIEN)) Q:'VICEIEN  I $$GET1^DIQ(18.02,VICEIEN,.01)="DST GET ID SERVICE" S MULTIEN=VICEIEN Q
 S MULTIEN=$S(MULTIEN:MULTIEN,1:"+1")
 S FDA(18.121,MULTIEN_","_WEBVER_",",.01)="DST GET ID SERVICE"       ; WEB SERVICE
 S FDA(18.121,MULTIEN_","_WEBVER_",",.06)="ENABLED"                  ; STATUS 1-ENABLED / 0-DISABLED
 D UPDATE^DIE("E","FDA","IENROOT","MSGROOT")
 ;
SPROT  ;Set protocol GMRC SIGNED CONSULT DST as an item on GMRC EVSEND OR
 ;
 N GMRDGIEN,GMRERR,GMREXIT,GMRFDA,GMRIEN,GMRRTCL,J,PRTCLITM,V,X,Y
 ;
 D MES^XPDUTL($T(+0)_" post-init routine started "_$$HTE^XLFDT($H))
 S V=$$SVDATA D MES^XPDUTL("Old data saved in "_V)
 S GMRRTCL="GMRC SIGNED CONSULT DST",GMRIEN=$O(^ORD(101,"B",GMRRTCL,0))
  ; protocol missing, write message and exit
 I '(GMRIEN>0) D MES^XPDUTL(GMRRTCL_" protocol not found. It must be installed to proceed.") Q
 ;
 S Y="GMRC EVSEND OR",GMRDGIEN=$O(^ORD(101,"B",Y,0))
 ; protocol missing, write message and exit
 I '(GMRDGIEN>0) D MES^XPDUTL(Y_" protocol not found.  No ITEM update performed.") Q
 ; make GMRC EVSEND OR an extended action
 S GMRFDA(101,GMRDGIEN_",",4)="X"
 D UPDATE^DIE("","GMRFDA","","GMRERR")
 I $D(GMRERR) D  Q  ; something went wrong
 .D MES^XPDUTL("FileMan error when editing GMRC EVSEND OR protocol")
 .N V S V="GMRERR" F  S V=$Q(@V) Q:V=""  D MES^XPDUTL(V_" = "_@V)
 ;
 ; is protocol already an item?
 S GMREXIT=$O(^ORD(101,GMRDGIEN,10,"B",GMRIEN,0))
 I GMREXIT D MES^XPDUTL(GMRRTCL_" already an ITEM in "_Y_".  No update needed.") Q
 ;
 ; add protocol as ITEM
 K GMRFDA,GMRERR
 S GMRFDA(101.01,"+1,"_GMRDGIEN_",",.01)=GMRIEN
 D UPDATE^DIE("","GMRFDA","PRTCLITM","GMRERR")
 I $D(GMRERR) D  Q  ; something went wrong
 .D MES^XPDUTL("FileMan error when adding ITEM to GMRC EVSEND OR protocol")
 .N V S V="GMRERR" F  S V=$Q(@V) Q:V=""  D MES^XPDUTL(V_" = "_@V)
 ; new ITEM sub-file IEN will be in PRTCLITM(1)
 D MES^XPDUTL(GMRRTCL_" protocol update finished "_$$HTE^XLFDT($H))
 ;
 Q
 ;
SVDATA() ; extrinsic variable, save original FileMan data, returns storage node
 ;
 D DT^DICRW
 N FMERRCNT,GMRXTMP,GMRIEN,LN,NTRY,TXT,V,X,Y
 ;S Y=$$NOW^XLFDT,GMRXTMP=$NA(^XTMP("GMR INSTALL LOG",Y))  ; XTMP storage location
 S Y=$$NOW^XLFDT,GMRXTMP=$NA(^XTMP("GMR INSTALL LOG "_Y))  ; XTMP storage location
 ; ^XTMP log data expires in 90 days
 S X=$G(@GMRXTMP@(0)) S:X="" @GMRXTMP@(0)=$$FMADD^XLFDT(DT,90)_U_Y_"^GMR installation "_$$FMTE^XLFDT(Y)
 ;
 S FMERRCNT=0  ; FileMan error counter
 ; save entries in FileMan items list
 F LN=1:1 S TXT=$P($T(FMITMS+LN),";;",2,99) Q:TXT=""  D
 .N FLNO,FMARRY,FMERR  ; file #, FileMan returned value and error message arrays
 .S FLNO=+$P(TXT,U),X=$P(TXT,U,2,99)  ; file number and target entry
 .Q:'(FLNO>1)!(X="")  ; file and entry required
 .S GMRIEN=$$FIND1^DIC(FLNO,"","",X,"","","FMERR")  ; lookup value in X is external format
 .I $D(FMERR) D  Q  ; log error message and quit
 ..S V="FMERR",FMERRCNT=FMERRCNT+1 F  S V=$Q(@V) Q:V=""  S @GMRXTMP@("FM LOOKUP ERROR",FMERRCNT,V)=@V
 .;
 .S:'(GMRIEN>0) FMERRCNT=FMERRCNT+1,@GMRXTMP@("FM ENTRY NOT FOUND",FMERRCNT)=TXT  ; entry
 .S:GMRIEN>0 @GMRXTMP@("ENTRY",FLNO,GMRIEN)="entry found"
 .K FMERR  ; just in case
 .D GETS^DIQ(FLNO,GMRIEN_",","**","EN","FMARRY","FMERR")  ; data including sub-files, ignore null values
 .I $D(FMERR) D  ; log error message
 ..S V="FMERR",FMERRCNT=FMERRCNT+1 F  S V=$Q(@V) Q:V=""  S @GMRXTMP@("FM DATA ERROR",FMERRCNT,V)=@V
 .; save the data
 .M @GMRXTMP@("ENTRY")=FMARRY
 ;
 Q GMRXTMP  ; return ^XTMP storage location
 ;
FMITMS ; list of FileMan entries: "file # ^ .01 field value"
 ;;101^GMRC EVSEND OR
 ;
 Q
AFORT(IEN123,APAY,COM,GMRCSS,GMRCORNP)  ; Entry point for AutoForwarding of a consult
 ;requires the Name of the consult we are forwarding too
 ;IEN123 - IEN of consult from File 123
 ;GMRCSS - Service to which consult is being forwarded
 ;GMRCATTN - Provider whose attention consult is sent to. Can be "" or pointer to File 200
 ;GMRCURGI - Urgency of the request from the 123 file pointing to the 101 file
 ;GMRCORNP - Person who is responsible for forwarding the consult
 ;COM is the comments array explaining the forwarding action from DST
 ;     passed in as COM(1)="Xxxx Xxxxx...",COM(2)="Xxxx Xx Xxx...", COM(3)="Xxxxx Xxx Xx...", etc.
 K GMRCATTN,ORDATE,GMRCURGI
 S GMRCATTN="",ORDATE=""
 S GMRCURGI=$P(^GMR(123,IEN123,0),"^",9)
 S Y=$$FR^GMRCGUIA(IEN123,GMRCSS,GMRCORNP,GMRCATTN,GMRCURGI,.COM,ORDATE)
 Q
