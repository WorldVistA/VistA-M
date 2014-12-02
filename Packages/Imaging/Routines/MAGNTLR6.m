MAGNTLR6 ;WOIFO/NST - TeleReader Configuration  ; 23 Apr 2012 2:30 PM
 ;;3.0;IMAGING;**127**;Mar 19, 2002;Build 4231;Apr 01, 2013
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
 ;     MAGPARAM("PROCEDURE")        = A pointer to GMRC PROCEDURE file (#123.3)
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
 N MAGNFDA,MAGNIEN,MAGNXE,IENS,MAGRESA
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
 I MAGPARAM("ACTION")="ADD" D  Q:MAGRY'=""  ; Quit if a (Service, Procedure) pair already exists
 . I $$FINDSRVC^MAGNTLR6(MAGPARAM("NAME"),MAGPARAM("PROCEDURE")) S MAGRY="0^(Service, Procedure) pair already exists." Q
 . S IENS="+1,"
 . Q
 E  S IENS=MAGPARAM("IEN")_",",MAGNIEN(1)=MAGPARAM("IEN")
 ;  
 ; A new record is created in two steps because of "AC" cross-reference definition for PROCEDURE field (#1).
 ; First create a record with empty procedure, then update the record if the procedure is not blank.
 S MAGNFDA(2006.5841,IENS,.01)=MAGPARAM("NAME")
 S:MAGPARAM("ACTION")'="ADD" MAGNFDA(2006.5841,IENS,1)=MAGPARAM("PROCEDURE")
 S MAGNFDA(2006.5841,IENS,2)=MAGPARAM("SPECIALTY INDEX")
 S MAGNFDA(2006.5841,IENS,3)=MAGPARAM("PROCEDURE INDEX")
 S MAGNFDA(2006.5841,IENS,4)=MAGPARAM("ACQUISITION SITE")
 S MAGNFDA(2006.5841,IENS,5)=MAGPARAM("UNREAD LIST CREATION TRIGGER")
 S MAGNFDA(2006.5841,IENS,6)=MAGPARAM("TIU NOTE FILE")
 ;
 D UPDATE^DIE("S","MAGNFDA","MAGNIEN","MAGNXE")
 ;
 I $D(MAGNXE("DIERR","E")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"MAGNXE")
 . S MAGRY="0^"_MAGRESA(1)
 . Q
 ;
 I (MAGPARAM("ACTION")'="ADD")!(MAGPARAM("PROCEDURE")="") S MAGRY="1^"_MAGNIEN(1) Q  ; Edit is done or procedure is blank
 ;
 ; Update procedure if it not blank
 K MAGNFDA
 S IENS=MAGNIEN(1)_","
 S MAGNFDA(2006.5841,IENS,1)=MAGPARAM("PROCEDURE")
 D UPDATE^DIE("S","MAGNFDA","MAGNIEN","MAGNXE")
 ;
 I $D(MAGNXE("DIERR","E")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"MAGNXE")
 . S MAGRY="0^"_MAGRESA(1)
 . Q
 S MAGRY="1^"_MAGNIEN(1)
 Q
 ;
 ;+++++ Finds if a (Service, Procedure) pair is defined in 
 ; TELEREADER ACQUISITION SERVICE file (#2006.5841)
 ;
 ; Input Parameters
 ; ================
 ; TOSERV  = A pointer to REQUEST SERVICES file (#123.5)
 ; PROC    = A pointer to GMRC PROCEDURE file (#123.3)
 ; 
 ; Return Values
 ; =============
 ; 1 if a pair (Service, Procedure) is defined in 
 ;   TELEREADER ACQUISITION SERVICE file (#2006.5841)
 ; 0 Otherwise
 ;
FINDSRVC(TOSERV,PROC) ; Is (Service, Procedure) pair defined
 N IEN
 S TOSERV=+$G(TOSERV)
 S PROC=+$G(PROC)
 S IEN=$O(^MAG(2006.5841,"AC",TOSERV,PROC,""))
 Q IEN>0
