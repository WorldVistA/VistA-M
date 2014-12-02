MAGVDGWP ;WOIFO/NST/RRB - Retrieve DGW settings ; 09 Jul 2012 2:53 PM
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
 ;***** Return list of Instruments in DGW from DICOM GATEWAY INSTRUMENT DICTIONARY file (#2006.911)
 ; RPC: MAGV DGW INSTRUMENT LIST
 ;
 ; Input Parameters
 ; ================
 ; HOSTNAME - Host name;
 ;           If HOSTNAME is blank all setting will be returned
 ;  
 ; Return Values
 ; =============
 ; if error found during execution
 ;   MAGRY(0) = "-1^Error getting instrument list"
 ; if success
 ;   MAGRY(0)    = "0^#CNT" - where #CNT is a number of records returned
 ;   MAGRY(1)    = "HOSTNAME^DATETIME^NICKNAME^DESCRIPTION^SERVICE^PORT^SITE ID^SITE^MACHINE ID"
 ;   MAGRY(2..n) = "^" delimited string with values of fields listed in MAGRY(1) 
 ;
 Q
 ; 
INSTRMNT(MAGRY,HOSTNAME) ;RPC [MAGV DGW INSTRUMENT LIST]
 N OUT,I,CNT,MAGNIEN,MAGNHOST,MAGNDATE
 N X
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 E  S X="ERR^MAGGTERR",@^%ZOSF("TRAP")
 S MAGRY(0)="-1^Error getting instrument list"
 S HOSTNAME=$TR(HOSTNAME,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 D LIST^DIC(2006.911,"","@;.01;2","PI","","","","","","","OUT")
 I $D(OUT("DIERR")) Q  ; Error getting the list
 S I=0
 S CNT=1
 F  S I=$O(OUT("DILIST",I)) Q:'+I  D
 . S X=OUT("DILIST",I,0)
 . S MAGNIEN=$P(X,"^",1)
 . S MAGNHOST=$P(X,"^",2)
 . S MAGNDATE=$P(X,"^",3)
 . I HOSTNAME'="" Q:HOSTNAME'=MAGNHOST  ; Check if HOSTNAME parameter 
 . D GETINSTR(.MAGRY,.CNT,MAGNIEN,MAGNHOST,MAGNDATE)
 . Q
 S MAGRY(0)="0^"_(CNT-1)
 S MAGRY(1)="HOSTNAME^DATETIME^NICKNAME^DESCRIPTION^SERVICE^PORT^SITE ID^SITE^MACHINE ID"
 Q
 ;
GETINSTR(MAGRY,CNT,MAGNIEN,MAGNHOST,MAGNDATE) ; Get list of instruments for a hostname
 ;
 N OUT,MSG,I,STATION,SITEIEN
 D LIST^DIC(2006.9112,","_MAGNIEN_",","@;.01;2;3I;4;5I;5;6","P","","","","","","","OUT","MSG")
 I $D(MSG("DIERR")) Q  ; Error getting the list
 S I=0
 F  S I=$O(OUT("DILIST",I)) Q:'+I  D
 . S CNT=CNT+1
 . ; Get site IEN
 . S SITEIEN=$P(OUT("DILIST",I,0),"^",6)
 . ; Get station based on site IEN 
 . S STATION=$$STA^XUAF4(SITEIEN) ; IA #2171 Get Station Number
 . ; Set station into return array
 . S $P(OUT("DILIST",I,0),"^",6)=STATION
 . S MAGRY(CNT)=MAGNHOST_"^"_MAGNDATE_"^"_$P(OUT("DILIST",I,0),"^",2,8)
 . Q 
 Q
 ;
 ;***** Return list of Modalities in DGW from DICOM GATEWAY MODALITY DICTIONARY file (#2006.912)
 ; RPC: MAGV DGW MODALITY LIST
 ;
 ; Input Parameters
 ; ================
 ; HOSTNAME - Host name;
 ;            If HOSTNAME is blank all setting will be returned
 ;  
 ; Return Values
 ; =============
 ; if error found during execution
 ;   MAGRY(0) = "-1^Error getting modality list"
 ; if success
 ;   MAGRY(0)    = "0^#CNT" - where #CNT is a number of records returned
 ;   MAGRY(1)    = "HOSTNAME^DATETIME^MANUFACTURER^MODEL^MODALITY^IMAGING SERVICE^ACTIVE"
 ;   MAGRY(2..n) = "^" delimited string with values of fields listed in MAGRY(1) 
 ;
MODALITY(MAGRY,HOSTNAME) ;RPC [MAGV DGW MODALITY LIST]
 N OUT,I,CNT,MAGNIEN,MAGNHOST,MAGNDATE
 N X
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 E  S X="ERR^MAGGTERR",@^%ZOSF("TRAP")
 S MAGRY(0)="-1^Error getting modality list"
 S HOSTNAME=$TR(HOSTNAME,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 D LIST^DIC(2006.912,"","@;.01;2","PI","","","","","","","OUT")
 I $D(OUT("DIERR")) Q  ; Error getting the list
 S I=0
 S CNT=1
 F  S I=$O(OUT("DILIST",I)) Q:'+I  D
 . S X=OUT("DILIST",I,0)
 . S MAGNIEN=$P(X,"^",1)
 . S MAGNHOST=$P(X,"^",2)
 . S MAGNDATE=$P(X,"^",3)
 . I HOSTNAME'="" Q:HOSTNAME'=MAGNHOST  ; Check if HOSTNAME parameter 
 . D GETMODAL(.MAGRY,.CNT,MAGNIEN,MAGNHOST,MAGNDATE)
 . Q
 S MAGRY(0)="0^"_(CNT-1)
 S MAGRY(1)="HOSTNAME^DATETIME^MANUFACTURER^MODEL^MODALITY^IMAGING SERVICE^ACTIVE"
 Q
 ;
GETMODAL(MAGRY,CNT,MAGNIEN,MAGNHOST,MAGNDATE) ; Get list of modalities for a hostname
 ;
 N OUT,MSG,I
 D LIST^DIC(2006.9122,","_MAGNIEN_",","@;.01;2;3;8;9","PI","","","","","","","OUT","MSG")
 I $D(MSG("DIERR")) Q  ; Error getting the list
 S I=0
 F  S I=$O(OUT("DILIST",I)) Q:'+I  D
 . S CNT=CNT+1
 . S MAGRY(CNT)=MAGNHOST_"^"_MAGNDATE_"^"_$P(OUT("DILIST",I,0),"^",2,7)
 . Q 
 Q
 ;
 ;***** Return list of UID
 ;      from DICOM UID SPECIFIC ACTION file (#2006.539)
 ; RPC: MAGV DGW ACTION UID LIST
 ;
 ; Input Parameters
 ; ================
 ; MAGTYPE - Type (e.g. "SOP Class")
 ; MAGSUBT - Subtype (e.g. "Storage")
 ; MAGACT  - Action Type (e.g. "Storage SCP")
 ;  
 ; Return Values
 ; =============
 ; if error found during execution
 ;   MAGRY(0) = "-1^Error getting actions list"
 ; if success
 ;   MAGRY(0)    = "0^#CNT" - where #CNT is a number of records returned
 ;   MAGRY(1)    = "UID^DESCRIPTION^ACTION CODE^ACTION COMMENT"
 ;   MAGRY(2..n) = "^" delimited string with values of fields listed in MAGRY(1) 
 ;
ACTUIDS(MAGRY,MAGTYPE,MAGSUBT,MAGACT) ;RPC [MAGV DGW ACTION UID LIST]
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 E  S X="ERR^MAGGTERR",@^%ZOSF("TRAP")
 N OUT,OUT2,MAGA,IEN,MAGX,CNT
 I (MAGTYPE="")!(MAGSUBT="")!(MAGACT="") S MAGRY(0)="-1^Blank parameters" Q 
 ;
 S MAGRY(0)="-1^Error getting action UID list"
 ;
 S MAGA(1)=MAGTYPE  ;"SOP Class"
 S MAGA(2)=MAGSUBT   ;"Storage"
 D FIND^DIC(2006.539,"","@;.01;2;","PQX",.MAGA,"*","D","","","OUT")
 I $D(OUT("DIERR")) Q  ; Error getting the list
 S I=0
 S CNT=1
 F  S I=$O(OUT("DILIST",I)) Q:'+I  D
 . S MAGX=OUT("DILIST",I,0)
 . S IEN=$P(MAGX,"^",1)
 . D FIND^DIC(2006.5391,","_IEN_",","@;2;3","PQX",MAGACT,"*","B","","","OUT2")
 . I '$D(OUT2("DILIST","1",0)) Q
 . S CNT=CNT+1
 . S MAGRY(CNT)=$P(MAGX,"^",2,3)_"^"_$P(OUT2("DILIST","1",0),"^",2,3)
 . Q
 S MAGRY(0)="0^"_(CNT-1)
 S MAGRY(1)="UID^DESCRIPTION^ACTION CODE^ACTION COMMENT"
 Q
 ;
 ;***** Update DICOM GATEWAY INSTRUMENT DICTIONARY file (#2006.911)
 ;      from DICOM Gateway file (#2006.581)
 ; RPC: MAGV DICOM SET INSTRUMENT LIST
 ;
 ; Input Parameters
 ; ================
 ; HOSTNAME - DICOM Gateway host name
 ; LOCATION - Identifies the institution where this DICOM Gateway computer resides
 ; MAGDATA  - Data in DICOM Gateway file (#2006.581)
 ; 
 ; Return Values
 ; =============
 ; if error found during execution
 ;   MAGRY = "-1^Error updating list"
 ; if success
 ;   MAGRY = 0
 ;
SETINSTR(MAGRY,HOSTNAME,LOCATION,MAGDATA) ; RPC [MAGV DICOM SET INSTRUMENT LIST]
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 E  S X="ERR^MAGGTERR",@^%ZOSF("TRAP")
 N NOW,DA,DIK,D0,IENS,X,MAGNFDA,MAGNIEN,MAGNXE,ERR
 S MAGRY="-1^Error updating file (#2006.911)"
 I $G(HOSTNAME)="" S MAGRY="-1^No HostName provided." Q
 I '$G(LOCATION) S MAGRY="-1^No location provided." Q
 S HOSTNAME=$TR(HOSTNAME,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 S NOW=$$HTFM^XLFDT($H)
 D FIND^DIC(2006.911,"","@;IX","PQX",HOSTNAME,"1","","","","X")
 I $D(X("DILIST","1",0)) D
 . S D0=$P(X("DILIST","1",0),"^",1)
 . S DIK="^MAGDICOM(2006.911,"
 . S DA=D0
 . D ^DIK
 . S MAGNIEN(1)=D0
 . Q
 S IENS="?+1,"
 S MAGNFDA(2006.911,IENS,.01)=HOSTNAME
 S MAGNFDA(2006.911,IENS,1)=LOCATION
 S MAGNFDA(2006.911,IENS,2)=NOW
 D UPDATE^DIE("SK","MAGNFDA","MAGNIEN","MAGNXE")
 I $D(MAGNXE("DIERR","E")) Q  ; MAGRY is set at the beginning
 S D0=MAGNIEN(1)
 S IENS="+1,"_D0_","
 S I=""
 S ERR=0
 F  S I=$O(MAGDATA(I)) Q:(I="")!ERR  D
 . K MAGNFDA,MAGNIEN,MAGNXE
 . S X=MAGDATA(I)
 . S MAGNFDA("2006.9112",IENS,".01")=$P(X,"^",1) ; "CR1"
 . S MAGNFDA("2006.9112",IENS,"2")=$P(X,"^",2) ; "Test CR"
 . S MAGNFDA("2006.9112",IENS,"3")=$P(X,"^",3) ;"RAD"
 . S MAGNFDA("2006.9112",IENS,"4")=$P(X,"^",4) ;"60100"
 . S MAGNFDA("2006.9112",IENS,"5")=$P(X,"^",5) ;"660"
 . S MAGNFDA("2006.9112",IENS,"6")=$P(X,"^",6) ;""
 . D UPDATE^DIE("SK","MAGNFDA","MAGNIEN","MAGNXE")
 . I $D(MAGNXE("DIERR","E")) S ERR=1
 . Q
 I ERR Q  ; MAGRY is set at the beginning
 ; 
 S MAGRY=0
 Q
 ;
 ;***** Update DICOM GATEWAY MODALITY DICTIONARY file (#2006.912)
 ;      from DICOM Gateway file (#2006.582)
 ; RPC: MAGV DICOM SET MODALITY LIST
 ;
 ; Input Parameters
 ; ================
 ; HOSTNAME - DICOM Gateway host name
 ; LOCATION - Identifies the institution where this DICOM Gateway computer resides
 ; MAGDATA  - Data in DICOM Gateway file (#2006.582)
 ; 
 ; Return Values
 ; =============
 ; if error found during execution
 ;   MAGRY = "-1^Error updating list"
 ; if success
 ;   MAGRY = "0"
 ;
SETMODAL(MAGRY,HOSTNAME,LOCATION,MAGDATA) ; RPC [MAGV DICOM SET MODALITY LIST]
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 E  S X="ERR^MAGGTERR",@^%ZOSF("TRAP")
 N NOW,DA,DIK,D0,IENS,X,MAGNFDA,MAGNIEN,MAGNXE,ERR
 S MAGRY="-1^Error updating file (#2006.912)"
 I $G(HOSTNAME)="" S MAGRY="-1^No HostName provided." Q
 I '$G(LOCATION) S MAGRY="-1^No location provided." Q
 S HOSTNAME=$TR(HOSTNAME,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 S NOW=$$HTFM^XLFDT($H)
 D FIND^DIC(2006.912,"","@;IX","PQX",HOSTNAME,"1","","","","X")
 I $D(X("DILIST","1",0)) D
 . S D0=$P(X("DILIST","1",0),"^",1)
 . S DIK="^MAGDICOM(2006.912,"
 . S DA=D0
 . D ^DIK
 . S MAGNIEN(1)=D0
 . Q
 S IENS="?+1,"
 S MAGNFDA(2006.912,IENS,.01)=HOSTNAME
 S MAGNFDA(2006.912,IENS,1)=LOCATION
 S MAGNFDA(2006.912,IENS,2)=NOW
 D UPDATE^DIE("SK","MAGNFDA","MAGNIEN","MAGNXE")
 I $D(MAGNXE("DIERR","E")) Q  ; MAGRY is set at the beginning
 S D0=MAGNIEN(1)
 S IENS="+1,"_D0_","
 S I=""
 S ERR=0
 F  S I=$O(MAGDATA(I)) Q:(I="")!ERR  D
 . K MAGNFDA,MAGNIEN,MAGNXE
 . S X=MAGDATA(I)
 . S MAGNFDA("2006.9122",IENS,".01")=$P(X,"^",1)
 . S MAGNFDA("2006.9122",IENS,"2")=$P(X,"^",2)
 . S MAGNFDA("2006.9122",IENS,"3")=$P(X,"^",3)
 . S MAGNFDA("2006.9122",IENS,"4")=$P(X,"^",4)
 . S MAGNFDA("2006.9122",IENS,"5")=$P(X,"^",5)
 . S MAGNFDA("2006.9122",IENS,"6")=$P(X,"^",6)
 . S MAGNFDA("2006.9122",IENS,"7")=$P(X,"^",7)
 . S MAGNFDA("2006.9122",IENS,"8")=$P(X,"^",8)
 . S MAGNFDA("2006.9122",IENS,"9")=$P(X,"^",9)
 . D UPDATE^DIE("SK","MAGNFDA","MAGNIEN","MAGNXE")
 . I $D(MAGNXE("DIERR","E")) S ERR=1
 . Q
 I ERR Q  ; MAGRY is set at the beginning
 ; 
 S MAGRY=0
 Q
 ;
 ;***** Return DGW email configuration entries from DICOM Gateway Mail (#2006.9191)
 ; RPC: MAGV GET DGW CONFIG
 ; 
 ; Input Parameters
 ; ================
 ; HOSTNAME - Host name;
 ;           If HOSTNAME error message will be returned
 ;  
 ; Return Values
 ; =============
 ; if error found during execution
 ;   MAGRY = "-1^Error message"
 ; if success
 ;   MAGRY = HOSTNAME~MAILGROUP~POSTOFFICE~POSTPORT~IMPORTER~STATION NUMBER
 ; 
GETGWCFG(MAGRY,HOSTNAME) ;RPC [MAGV GET DGW CONFIG]
 N OUT,I,CNT,MAGNIEN,MAGNHOST,MAILGROUP,POSTOFFICE,POSTPORT,IMPORTER,SITEIEN,STATION
 N X
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 E  S X="ERR^MAGGTERR",@^%ZOSF("TRAP")
 S MAGRY="-1~Error getting DGW Config info"
 I $G(HOSTNAME)="" S MAGRY="-1~No HostName provided" Q
 S HOSTNAME=$TR(HOSTNAME,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 D LIST^DIC(2006.9191,"","@;.01;1;2;3;4;5","PI","","","","","","","OUT")
 I $D(OUT("DIERR")) Q  ; Error getting the list
 S I=0
 F  S I=$O(OUT("DILIST",I)) Q:'+I  D  Q:HOSTNAME=MAGNHOST
 . S X=OUT("DILIST",I,0)
 . S MAGNIEN=$P(X,"^",1)
 . S MAGNHOST=$P(X,"^",2)
 . S MAILGROUP=$P(X,"^",3)
 . S POSTOFFICE=$P(X,"^",4)
 . S POSTPORT=$P(X,"^",5)
 . S IMPORTER=$P(X,"^",6)
 . S SITEIEN=$P(X,"^",7)
 . S STATION=$$STA^XUAF4(SITEIEN) ; IA #2171 Get Station Number
 . Q
 I HOSTNAME'=MAGNHOST D  Q  ; Check if HOSTNAME parameter matches return
 . S MAGRY="-1~HostName returned from DB,"_MAGNHOST_", doesn't match request."
 . Q 
 ;
 S MAGRY="0~"_HOSTNAME_"~"_MAILGROUP_"~"_POSTOFFICE_"~"_POSTPORT_"~"_IMPORTER_"~"_STATION
 Q
 ;
 ;
 ;***** Set DGW email configuration entries into DICOM Gateway Mail (#2006.9191)
 ; RPC: MAGV SET DGW CONFIG
 ; 
 ; Input Parameters
 ; ================
 ; HOSTNAME 
 ; MAILGROUP
 ; POSTOFFICE
 ; POSTPORT
 ; [IMPORTER]
 ; LOCATION
 ; If any of the input parameters are missing an error message will be returned.
 ;  
 ; Return Values
 ; =============
 ;  0 - Success
 ; -1 - Error
 ; 
SETGWCFG(MAGRY,HOSTNAME,MAILGROUP,POSTOFFICE,POSTPORT,IMPORTER,LOCATION) ; RPC [MAGV SET DGW CONFIG]
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 E  S X="ERR^MAGGTERR",@^%ZOSF("TRAP")
 N NOW,IENS,X,MAGNFDA,MAGNXE
 S MAGRY="-1~Error updating file (#2006.9191)"
 I $G(HOSTNAME)="" S MAGRY="-1~No HostName provided." Q
 I $G(MAILGROUP)="" S MAGRY="-1~No MailGroup provided." Q
 I $G(POSTOFFICE)="" S MAGRY="-1~No PostOffice provided." Q
 I $G(POSTPORT)="" S MAGRY="-1~No PostPort provided." Q
 I $G(LOCATION)="" S MAGRY="-1~No Location provided." Q
 S HOSTNAME=$TR(HOSTNAME,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 S NOW=$$HTFM^XLFDT($H)
 S IENS="?+1,"
 S MAGNFDA(2006.9191,IENS,.01)=HOSTNAME
 S MAGNFDA(2006.9191,IENS,1)=MAILGROUP
 S MAGNFDA(2006.9191,IENS,2)=POSTOFFICE
 S MAGNFDA(2006.9191,IENS,3)=POSTPORT
 S MAGNFDA(2006.9191,IENS,4)=$G(IMPORTER)
 S MAGNFDA(2006.9191,IENS,5)=LOCATION
 D UPDATE^DIE("SK","MAGNFDA","","MAGNXE")
 I $D(MAGNXE("DIERR","E")) Q  ; MAGRY set at the beginning
 S MAGRY="0~DGW Config info update ok"
 Q
