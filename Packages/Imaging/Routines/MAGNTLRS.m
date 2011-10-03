MAGNTLRS ;WOIFO/NST - TeleReader Configuration  ; 26 May 2010 5:11 PM
 ;;3.0;IMAGING;**114**;Mar 19, 2002;Build 1827;Aug 17, 2010
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
 ;***** Add/Update/Delete a service in TELEREADER ACQUISITION SERVICE file (#2006.5841)
 ; RPC: MAG3 TELEREADER ACQ SRVC SETUP
 ;
 ; Input Parameters
 ; ================
 ;   Delete action:
 ;     MAGPARAM("ACTION")           = "DELETE"
 ;     MAGPARAM("IEN")              = IEN of the record that will be deleted
 ;   Add or Update action:
 ;     MAGPARAM("ACTION")           = "ADD" or "UPDATE"
 ;     MAGPARAM("NAME")             = A pointer to REQUEST SERVICES file (#123.5)
 ;     MAGPARAM("PROCEDURE")        = A pointer to GMRC PROCEDURE file (#123.5)
 ;     MAGPARAM("SPECIALTY INDEX")  = A pointer to the SPECIALTY file (#2005.84)
 ;     MAGPARAM("PROCEDURE INDEX")  = A pointer to the PROCEDURE/EVENT file (#2005.85)
 ;     MAGPARAM("ACQUISITION SITE") = A pointer to the INSTITUTION file (#4) 
 ;     MAGPARAM("UNREAD LIST CREATION TRIGGER") = I/O/F
 ;     MAGPARAM("TIU NOTE FILE")    = A pointer to TIU DOCUMENT file (#8925.1)
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY = "0^Error"
 ; if success MAGRY = "1^IEN" - IEN of the record that is updated
 ;                               or IEN of the added record
 ;
UASRVC(MAGRY,MAGPARAM) ;RPC [MAG3 TELEREADER ACQ SRVC SETUP]
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 ;
 N X,MAGNFDA,MAGNIEN,MAGNXE,IENS,MAGRESA
 N DA,DIK
 ;
 ;^MAG(2006.5841,D0,0)=1=NAME, 2=PROCEDURE, 3=SPECIALTY INDEX, 4=PROCEDURE INDEX,
 ;                     5=ACQUISITION SITE, 6=UNREAD LIST CREATION TRIGGER, 7=TIU NOTE FILE
 ;
 I MAGPARAM("ACTION")="DELETE" D  Q  ; Delete an entry IEN and exit
 . S DIK="^MAG(2006.5841,"
 . S DA=MAGPARAM("IEN")
 . D ^DIK
 . S MAGRY=1
 . Q
 ;
 S MAGRY=""
 I MAGPARAM("ACTION")="ADD" D  Q:MAGRY'=""  ; Quit if a service already exists
 . D FIND^DIC(2006.5841,"","@;IX","PQX",MAGPARAM("NAME"),"1","B","","","X")
 . I $D(X("DILIST","1",0)) S MAGRY="0^Service already exists"
 . S IENS="+1,"
 E  S IENS=MAGPARAM("IEN")_",",MAGNIEN(1)=MAGPARAM("IEN")
 ;  
 S MAGNFDA(2006.5841,IENS,.01)=MAGPARAM("NAME")
 S MAGNFDA(2006.5841,IENS,1)=MAGPARAM("PROCEDURE")
 S MAGNFDA(2006.5841,IENS,2)=MAGPARAM("SPECIALTY INDEX")
 S MAGNFDA(2006.5841,IENS,3)=MAGPARAM("PROCEDURE INDEX")
 S MAGNFDA(2006.5841,IENS,4)=MAGPARAM("ACQUISITION SITE")
 S MAGNFDA(2006.5841,IENS,5)=MAGPARAM("UNREAD LIST CREATION TRIGGER")
 S MAGNFDA(2006.5841,IENS,6)=MAGPARAM("TIU NOTE FILE")
 ;
 D UPDATE^DIE("SK","MAGNFDA","MAGNIEN","MAGNXE")
 ;
 I $D(MAGNXE("DIERR","E")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"MAGNXE")
 . S MAGRY="0^"_MAGRESA(1)
 . Q
 E  S MAGRY="1^"_MAGNIEN(1)
 Q
 ;
 ;***** Add/Update/Delete a service in DICOM HEALTHCARE PROVIDER SERVICE file (#2006.5831)
 ; RPC: MAG3 TELEREADER PDR SRVC SETUP
 ;
 ; Input Parameters
 ; ================
 ;   Delete action:
 ;     MAGPARAM("ACTION")            = "DELETE"
 ;     MAGPARAM("IEN")               = IEN of the record that will be deleted
 ;   Add or Update action:
 ;     MAGPARAM("ACTION")            = "ADD" or "UPDATE"
 ;     MAGPARAM("REQUESTED SERVICE") = A pointer to the "Request Services" file (#123.5)
 ;     MAGPARAM("SERVICE GROUP")     = A pointer to the SPECIALTY file (#2005.84)
 ;     MAGPARAM("SERVICE DIVISION")  = A pointer to the INSTITUTION file (#4)
 ;     MAGPARAM("CLINIC")            = "^" delimited string with clinics IENS in file (#44)
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY = "0^Error"
 ; if success MAGRY = "1^IEN" - IEN of the record that is updated
 ;                               or IEN of the added record
 ;
UPSRVC(MAGRY,MAGPARAM) ;RPC [MAG3 TELEREADER PDR SRVC SETUP]
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 ;
 N X,MAGNFDA,MAGNIEN,MAGNXE,IENS,IEN,MAGRESA
 N DA,DIK
 ;
 ;^MAG(2006.5831,D0,0)=1=REQUESTED SERVICE, 2=SERVICE GROUP, 3=SERVICE DIVISION
 ;
 I MAGPARAM("ACTION")="DELETE" D  Q  ; Delete an entry IEN and exit
 . S DIK="^MAG(2006.5831,"
 . S DA=MAGPARAM("IEN")
 . D ^DIK
 . S MAGRY=1
 . Q
 ;
 S MAGRY=""
 I MAGPARAM("ACTION")="ADD" D  Q:MAGRY'=""  ; Quit if a service already exists
 . D FIND^DIC(2006.5831,"","@;IX","PQX",MAGPARAM("REQUESTED SERVICE"),"1","","","","X")
 . I $D(X("DILIST","1",0)) S MAGRY="0^Service already exists"
 . S IENS="+1,"
 . S MAGNIEN(1)=MAGPARAM("REQUESTED SERVICE") ; if you add a new item using P^DI the new IEN will be value of field "NAME" (#.01)
 . Q
 E  S IENS=MAGPARAM("IEN")_",",MAGNIEN(1)=MAGPARAM("IEN")
 ;  
 S MAGNFDA(2006.5831,IENS,.01)=MAGPARAM("REQUESTED SERVICE")
 S MAGNFDA(2006.5831,IENS,2)=MAGPARAM("SERVICE GROUP")
 S MAGNFDA(2006.5831,IENS,3)=MAGPARAM("SERVICE DIVISION")
 ;
 D UPDATE^DIE("SK","MAGNFDA","MAGNIEN","MAGNXE")
 ;
 I $D(MAGNXE("DIERR","E")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"MAGNXE")
 . S MAGRY="0^"_MAGRESA(1)
 . Q
 ;
 I $D(MAGPARAM("CLINIC")) I '$$UCLINIC^MAGNTLRS(.MAGRY,MAGPARAM("CLINIC"),MAGNIEN(1)) Q
 ;
 S MAGRY="1^"_MAGNIEN(1)
 Q
 ; #######################
 ; UCLINIC -  Update Clinic multiple field in file #2006.5831
 ;
 ; Returns 0 if failed
 ;         1 success
 ; Input parameters
 ;   CLINS = "^" delimited string with clinics IENS
 ;   IEN   = IEN in file #2006.5831
 ;
 ; Output parameters
 ;   RES = "0^Error"
 ;
UCLINIC(RES,CLINS,IEN) ; Update Clinic field in file #2006.58314
 N CLIN,CLINA,OUT,MSG,I
 N DA,DIK
 N MAGNFDA,MAGNXE,MAGNIEN
 S RES=""
 D LIST^DIC(2006.58314,","_IEN_",","@;.01I","",,,,,,,"OUT","MSG")
 I $D(MSG("DIERR","E")) S RES="0^Error updating CLINIC field" Q 0
 ;
 S DA(1)=IEN  ; set the variables so we can perform deletion of multiple if needed
 S DIK="^MAG(2006.5831,"_IEN_",1,"
 ;
 F I=1:1 S CLIN=$P(CLINS,"^",I) Q:CLIN=""  S CLINA(CLIN)=""
 ;
 ; delete multiple if they are not present in CLINA (CLINS)
 S I=0
 F  S I=$O(OUT("DILIST","ID",I)) Q:'I  D
 . S CLIN=OUT("DILIST","ID",I,".01")
 . I $D(CLINA(CLIN)) K CLINA(CLIN) Q   ; The Clin ID exists in multiple. Delete from CLINA and continue
 . S DA=OUT("DILIST","2",I)
 . D ^DIK
 . Q 
 ;
 ; insert the new multiples
 S CLIN=""
 F  S CLIN=$O(CLINA(CLIN)) Q:CLIN=""  Q:RES'=""  D
 . K MAGNFDA,MAGNXE,MAGNIEN
 . S MAGNFDA(2006.58314,"+1,"_IEN_",",.01)=CLIN
 . D UPDATE^DIE("","MAGNFDA","","MAGNXE")
 . I $D(MAGNXE("DIERR","E")) S RES="0^Error inserting CLINIC field " Q
 . Q
 Q $S(RES="":1,1:0)  ; return 
 ;
 ;***** Add/Update/Delete a site in TELEREADER ACQUISITION SITE file (#2006.5842)
 ; RPC: MAG3 TELEREADER SITE SETUP
 ;
 ; Input Parameters
 ; ================
 ;   Delete action:
 ;     MAGPARAM("ACTION")                  = "DELETE"
 ;     MAGPARAM("IEN")                     = IEN of the record that will be deleted
 ;   Add or Update action:
 ;     MAGPARAM("ACTION")                  = "ADD" or "UPDATE"
 ;     MAGPARAM("NAME")                    = A pointer to the INSTITUTION file (#4)
 ;     MAGPARAM("PRIMARY SITE")            = A pointer to the INSTITUTION file (#4)
 ;     MAGPARAM("STATUS")                  = 0 or 1 (Active or Inactive)
 ;     MAGPARAM("LOCK TIMEOUT IN MINUTES") = value of field #3 of file (#2006.5842)
 ;
 ; Return Values
 ; =============
 ; if error MAGRY = "0^Error"
 ; if success MAGRY = "1^IEN" - IEN of the record that is updated
 ;                               or IEN of the added record
 ;
USITE(MAGRY,MAGPARAM) ;RPC [MAG3 TELEREADER SITE SETUP]
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 ;
 N X,MAGNFDA,MAGNIEN,MAGNXE,IENS,MAGRESA
 N DA,DIK
 ;
 ;^MAG(2006.5842,D0,0)=1=NAME,2=PRIMARY SITE,3=STATUS,4=LOCK TIMEOUT IN MINUTES
 ;
 I MAGPARAM("ACTION")="DELETE" D  Q  ; Delete an entry IEN and exit
 . S DIK="^MAG(2006.5842,"
 . S DA=MAGPARAM("IEN")
 . D ^DIK
 . S MAGRY=1
 . Q
 ;
 S MAGRY=""
 I MAGPARAM("ACTION")="ADD" D  Q:MAGRY'=""  ; Quit if a record already exists
 . D FIND^DIC(2006.5842,"","@;IX","PQX",MAGPARAM("NAME"),"1","B","","","X")
 . I $D(X("DILIST","1",0)) S MAGRY="0^Record already exists"
 . S IENS="+1,"
 E  S IENS=MAGPARAM("IEN")_","
 ;
 S MAGNIEN(1)=MAGPARAM("NAME") ; if you add a new item using P^DI the new IEN will be value of field "NAME" (#.01)
 S MAGNFDA(2006.5842,IENS,.01)=MAGPARAM("NAME")
 S MAGNFDA(2006.5842,IENS,1)=MAGPARAM("PRIMARY SITE")
 S MAGNFDA(2006.5842,IENS,2)=MAGPARAM("STATUS")
 S MAGNFDA(2006.5842,IENS,3)=MAGPARAM("LOCK TIMEOUT IN MINUTES")
 ;
 D UPDATE^DIE("SK","MAGNFDA","MAGNIEN","MAGNXE")
 ;
 I $D(MAGNXE("DIERR","E")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"MAGNXE")
 . S MAGRY="0^"_MAGRESA(1)
 . Q
 E  S MAGRY="1^"_MAGNIEN(1)
 Q
 ;
 ;*****  Add/Update/Delete TELEREADER READER file (#2006.5843)
 ; RPC: MAG3 TELEREADER READER SETUP
 ;
 ; Input Parameters
 ; ================
 ;   Delete actions:
 ;     Reader
 ;       MAGPARAM("ACTION") = "DELETE READER"
 ;       MAGPARAM("READER") = Reader internal value
 ;     Acquisition Site
 ;       MAGPARAM("ACTION")           = "DELETE SITE"
 ;       MAGPARAM("READER")           = Reader internal value
 ;       MAGPARAM("ACQUISITION SITE") = Acquisition Site internal value
 ;     Specialty
 ;       MAGPARAM("ACTION")           = "DELETE SPECIALTY"
 ;       MAGPARAM("READER")           = Reader internal value
 ;       MAGPARAM("ACQUISITION SITE") = Acquisition Site internal value
 ;       MAGPARAM("SPECIALTY INDEX")  = Specialty Index internal value
 ;     Procedure
 ;       MAGPARAM("ACTION")           = "DELETE PROCEDURE"
 ;       MAGPARAM("READER")           = Reader internal value
 ;       MAGPARAM("ACQUISITION SITE") = Acquisition Site internal value
 ;       MAGPARAM("SPECIALTY INDEX")  = Specialty Index internal value
 ;       MAGPARAM("PROCEDURE INDEX")  = Procedure Index internal value
 ;   Update Status field:
 ;     Acquisition Site
 ;       MAGPARAM("ACTION")           = "SET SITE STATUS"
 ;       MAGPARAM("READER")           = Reader internal value
 ;       MAGPARAM("ACQUISITION SITE") = Acquisition Site internal value
 ;       MAGPARAM("ACQUISITION SITE STATUS") = 0 or 1 (Active or Inactive)
 ;     Specialty 
 ;       MAGPARAM("ACTION")           = "SET SPECIALTY STATUS"
 ;       MAGPARAM("READER")           = Reader internal value
 ;       MAGPARAM("ACQUISITION SITE") = Acquisition Site internal value
 ;       MAGPARAM("SPECIALTY INDEX")  = Specialty Index internal value
 ;       MAGPARAM("SPECIALTY INDEX STATUS") = 0 or 1 (Active or Inactive)
 ;     Procedure
 ;       MAGPARAM("ACTION")           = "SET PROCEDURE STATUS"
 ;       MAGPARAM("READER")           = Reader internal value
 ;       MAGPARAM("ACQUISITION SITE") = Acquisition Site internal value
 ;       MAGPARAM("SPECIALTY INDEX")  = Specialty Index internal value
 ;       MAGPARAM("PROCEDURE INDEX")  = Procedure Index internal value
 ;       MAGPARAM("PROCEDURE STATUS") = 0 or 1 (Active or Inactive)
 ;   Add action:
 ;     MAGPARAM("ACTION")           = "ADD"
 ;     MAGPARAM("READER")           = Reader internal value
 ;     MAGPARAM("ACQUISITION SITE") = Acquisition Site internal value
 ;     MAGPARAM("ACQUISITION SITE STATUS") = Acquisition Site Status
 ;     MAGPARAM("SPECIALTY INDEX")  = Specialty Index internal value
 ;     MAGPARAM("SPECIALTY INDEX STATUS") = Specialty Index Status
 ;     MAGPARAM("PROCEDURE INDEX")  = Procedure Index internal value
 ;     MAGPARAM("PROCEDURE INDEX STATUS") = 0 or 1 (Active or Inactive)
 ;     MAGPARAM("PROCEDURE INDEX USER PREFERENCE") = 0 or 1 (Active or Inactive)
 ;
 ; Return Values
 ; =============
 ; if error MAGRY = "0^Error"
 ; if success MAGRY = "1^IEN" - IEN of the record that is updated
 ;                               or IEN of the added record
 ;
UREADER(MAGRY,MAGPARAM) ;RPC [MAG3 TELEREADER READER SETUP]
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 ;
 N MAGNFDA,MAGNIEN,MAGNXE,MAGRESA
 ;
 I MAGPARAM("ACTION")="DELETE READER" D  Q  ; Delete an entry and exit
 . D DREADER(.MAGPARAM)
 . S MAGRY=1
 . Q
 ;
 I MAGPARAM("ACTION")="DELETE SITE" D  Q  ; Delete an entry and exit
 . D DACQSITE(.MAGPARAM)
 . S MAGRY=1
 . Q
 ;
 I MAGPARAM("ACTION")="DELETE SPECIALTY" D  Q  ; Delete an entry and exit
 . D DSPECIDX(.MAGPARAM)
 . S MAGRY=1
 . Q
 ;
 I MAGPARAM("ACTION")="DELETE PROCEDURE" D  Q  ; Delete an entry and exit
 . D DPROCIDX(.MAGPARAM)
 . S MAGRY=1
 . Q
 ;
 I MAGPARAM("ACTION")="SET SITE STATUS" D  Q  ; Exit
 . S MAGRY=$$USITEST(.MAGPARAM)
 . Q
 ;
 I MAGPARAM("ACTION")="SET SPECIALTY STATUS" D  Q  ; Exit
 . S MAGRY=$$USPECST(.MAGPARAM)
 . Q
 ;
 I MAGPARAM("ACTION")="SET PROCEDURE STATUS" D  Q  ; Exit
 . S MAGRY=$$UPROCST(.MAGPARAM)
 . Q
 ;
 ; Add
 S MAGNFDA(2006.5843,"?+1,",.01)=MAGPARAM("READER")
 S MAGNFDA(2006.58431,"?+2,?+1,",.01)=MAGPARAM("ACQUISITION SITE")
 S MAGNFDA(2006.58431,"?+2,?+1,",.5)=MAGPARAM("ACQUISITION SITE STATUS")
 S MAGNFDA(2006.584311,"?+3,?+2,?+1,",.01)=MAGPARAM("SPECIALTY INDEX")
 S MAGNFDA(2006.584311,"?+3,?+2,?+1,",.5)=MAGPARAM("SPECIALTY INDEX STATUS")
 S MAGNFDA(2006.5843111,"?+4,?+3,?+2,?+1,",.01)=MAGPARAM("PROCEDURE INDEX")
 S MAGNFDA(2006.5843111,"?+4,?+3,?+2,?+1,",.5)=MAGPARAM("PROCEDURE INDEX STATUS")
 S MAGNFDA(2006.5843111,"?+4,?+3,?+2,?+1,",1)=MAGPARAM("PROCEDURE INDEX USER PREFERENCE")
 ;
 D UPDATE^DIE("S","MAGNFDA","MAGNIEN","MAGNXE")
 ;
 I $D(MAGNXE("DIERR","E")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"MAGNXE")
 . S MAGRY="0^"_MAGRESA(1)
 . Q
 E  S MAGRY="1^OK"
 Q
 ;
DREADER(MAGPARAM) ; Delete a reader
 N MAGD0,DA,DIK
 S MAGD0=$O(^MAG(2006.5843,"B",MAGPARAM("READER"),""))
 S DA=MAGD0
 S DIK="^MAG(2006.5843,"
 D ^DIK
 Q
 ;
DACQSITE(MAGPARAM) ; Delete acquisition  site
 N MAGD0,MAGD1,DA,DIK
 S MAGD0=$O(^MAG(2006.5843,"B",MAGPARAM("READER"),""))
 S MAGD1=$O(^MAG(2006.5843,MAGD0,1,"B",MAGPARAM("ACQUISITION SITE"),""))
 S DA=MAGD1
 S DA(1)=MAGD0
 S DIK="^MAG(2006.5843,"_MAGD0_",1,"
 D ^DIK
 I $O(^MAG(2006.5843,MAGD0,1,"B",""))="" D DREADER(.MAGPARAM) Q  ; no more sites
 Q
 ;
DSPECIDX(MAGPARAM) ; Delete specialty
 N MAGD0,MAGD1,MAGD2,DA,DIK
 S MAGD0=$O(^MAG(2006.5843,"B",MAGPARAM("READER"),""))
 S MAGD1=$O(^MAG(2006.5843,MAGD0,1,"B",MAGPARAM("ACQUISITION SITE"),""))
 S MAGD2=$O(^MAG(2006.5843,MAGD0,1,MAGD1,1,"B",MAGPARAM("SPECIALTY INDEX"),""))
 S DA=MAGD2
 S DA(1)=MAGD1
 S DA(2)=MAGD0
 S DIK="^MAG(2006.5843,"_MAGD0_",1,"_MAGD1_",1,"
 D ^DIK
 I $O(^MAG(2006.5843,MAGD0,1,MAGD1,1,"B",""))="" D DACQSITE(.MAGPARAM) Q  ; no more specialties
 Q
 ;
DPROCIDX(MAGPARAM) ; Delete Procedure index from file #2006.5843
 N MAGD0,MAGD1,MAGD2,MAGD3,DA,DIK
 S MAGD0=$O(^MAG(2006.5843,"B",MAGPARAM("READER"),""))
 S MAGD1=$O(^MAG(2006.5843,MAGD0,1,"B",MAGPARAM("ACQUISITION SITE"),""))
 S MAGD2=$O(^MAG(2006.5843,MAGD0,1,MAGD1,1,"B",MAGPARAM("SPECIALTY INDEX"),""))
 S MAGD3=$O(^MAG(2006.5843,MAGD0,1,MAGD1,1,MAGD2,1,"B",MAGPARAM("PROCEDURE INDEX"),""))
 S DA=MAGD3
 S DA(1)=MAGD2
 S DA(2)=MAGD1
 S DA(3)=MAGD0
 S DIK="^MAG(2006.5843,"_MAGD0_",1,"_MAGD1_",1,"_MAGD2_",1,"
 D ^DIK
 I $O(^MAG(2006.5843,MAGD0,1,MAGD1,1,MAGD2,1,"B",""))="" D DSPECIDX(.MAGPARAM) Q  ; no more procedures
 Q
 ;
USITEST(MAGPARAM) ; Update Acquisition Site Status
 N MAGNFDA,MAGNIEN,MAGNXE,MAGRESA
 N MAGD0,MAGD1
 S MAGD0=$O(^MAG(2006.5843,"B",MAGPARAM("READER"),""))
 S MAGD1=$O(^MAG(2006.5843,MAGD0,1,"B",MAGPARAM("ACQUISITION SITE"),""))
 S MAGNFDA(2006.58431,MAGD1_","_MAGD0_",",.5)=MAGPARAM("ACQUISITION SITE STATUS")
 D UPDATE^DIE("S","MAGNFDA","MAGNIEN","MAGNXE")
 I $D(MAGNXE("DIERR","E")) D  Q "0^"_MAGRESA(1)
 . D MSG^DIALOG("A",.MAGRESA,245,5,"MAGNXE")
 . Q
 E  Q "1^OK"
 Q
 ;
USPECST(MAGPARAM) ; Update Specialty Index Status
 N MAGNFDA,MAGNIEN,MAGNXE,MAGRESA
 N MAGD0,MAGD1,MAGD2
 S MAGD0=$O(^MAG(2006.5843,"B",MAGPARAM("READER"),""))
 S MAGD1=$O(^MAG(2006.5843,MAGD0,1,"B",MAGPARAM("ACQUISITION SITE"),""))
 S MAGD2=$O(^MAG(2006.5843,MAGD0,1,MAGD1,1,"B",MAGPARAM("SPECIALTY INDEX"),""))
 S MAGNFDA(2006.584311,MAGD2_","_MAGD1_","_MAGD0_",",.5)=MAGPARAM("SPECIALTY INDEX STATUS")
 D UPDATE^DIE("S","MAGNFDA","MAGNIEN","MAGNXE")
 I $D(MAGNXE("DIERR","E")) D  Q "0^"_MAGRESA(1)
 . D MSG^DIALOG("A",.MAGRESA,245,5,"MAGNXE")
 . Q
 E  Q "1^OK"
 Q
 ;
UPROCST(MAGPARAM) ; Update Procedure Index Status
 N MAGNFDA,MAGNIEN,MAGNXE,MAGRESA
 N MAGD0,MAGD1,MAGD2,MAGD3
 S MAGD0=$O(^MAG(2006.5843,"B",MAGPARAM("READER"),""))
 S MAGD1=$O(^MAG(2006.5843,MAGD0,1,"B",MAGPARAM("ACQUISITION SITE"),""))
 S MAGD2=$O(^MAG(2006.5843,MAGD0,1,MAGD1,1,"B",MAGPARAM("SPECIALTY INDEX"),""))
 S MAGD3=$O(^MAG(2006.5843,MAGD0,1,MAGD1,1,MAGD2,1,"B",MAGPARAM("PROCEDURE INDEX"),""))
 S MAGNFDA(2006.5843111,MAGD3_","_MAGD2_","_MAGD1_","_MAGD0_",",.5)=MAGPARAM("PROCEDURE INDEX STATUS")
 D UPDATE^DIE("S","MAGNFDA","MAGNIEN","MAGNXE")
 I $D(MAGNXE("DIERR","E")) D  Q "0^"_MAGRESA(1)
 . D MSG^DIALOG("A",.MAGRESA,245,5,"MAGNXE")
 . Q
 E  Q "1^OK"
 Q
 ;
 ;***** Set Time Out for an application
 ; RPC: MAG3 SET TIMEOUT
 ;
 ; Input Parameters
 ; ================
 ;   MAGAPP is "DISPLAY", "CAPTURE", "VISTARAD", or "TELEREADER"
 ;   MAGTIME is time out value
 ;
 ; Return Values
 ; =============
 ; if error MAGRY = first "^" piece is zero if record is not found or 
 ;                   updating error
 ; if success MAGRY = "1^IEN" - IEN of the record that is updated
 ;                              
TIMEOUT(MAGRY,MAGAPP,MAGTIME) ;RPC [MAG3 SET TIMEOUT]
 ; Set the timeout for the APP from IMAGING SITE PARAMETERS File
 ;  MAGAPP is either 'DISPLAY', 'CAPTURE','VISTARAD', or 'TELEREADER'
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 ;
 N MAGNFDA,MAGNIEN,MAGNXE,MAGPLC,IEN,MAGFLD
 N MAGRESA
 ;
 S MAGRY=""
 S MAGPLC=$$PLACE^MAGBAPI(DUZ(2))
 I 'MAGPLC S MAGRY="0^No record found" Q
 ;
 S IEN=MAGPLC_","
 I MAGAPP="DISPLAY" S MAGFLD=121
 I MAGAPP="CAPTURE" S MAGFLD=122
 I MAGAPP="VISTARAD" S MAGFLD=123
 I MAGAPP="TELEREADER" S MAGFLD=131
 ;
 S MAGNFDA(2006.1,IEN,MAGFLD)=MAGTIME
 D UPDATE^DIE("S","MAGNFDA","MAGNIEN","MAGNXE")
 I $D(MAGNXE("DIERR","E")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"MAGNXE")
 . S MAGRY="0^"_MAGRESA(1)
 . Q
 E  S MAGRY="1^"_MAGPLC
 Q
