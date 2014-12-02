MAGVAQ01 ;WOIFO/NST - Utilities for RPC calls ; 28 Feb 2013 9:58 AM
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
 ;*****  Add a record to QUEUE file (#2006.927)
 ;       
 ; RPC: MAGVA CREATE QUEUE
 ; 
 ; Input Parameters
 ; ================
 ; 
 ;   MAGPARAM("NAME")
 ;   MAGPARAM("ACTIVE") = 0/1
 ;   MAGPARAM("QUEUE TYPE")
 ;   MAGPARAM("NUM RETRIES")
 ;   MAGPARAM("RETRY DELAY IN SECONDS")
 ;   MAGPARAM("TRIGGER DELAY IN SECONDS")
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^ Error message^
 ; if success MAGRY = Success status ^^IEN - IEN of the new record 
 ;
ADDQUEUE(MAGRY,MAGPARAM) ; RPC [MAGVA CREATE QUEUE]
 N MAGWP
 K MAGRY
 ; Add the record
 D ADDRCD^MAGVAF01(.MAGRY,2006.927,.MAGPARAM,.MAGWP)
 Q
 ;
 ;*****  Returns all records in QUEUE file (#2006.927)
 ;       
 ; RPC: MAGVA GET ALL QUEUES
 ; 
 ; if error found during execution
 ;   MAGRY(0) = Failure status ^ "Error getting the list"
 ; if success
 ;   MAGRY(0)    = Success status ^^#CNT - where #CNT is a number of records returned
 ;   MAGRY(1)    = "^" delimited string with all field names in Queue 
 ;   MAGRY(2..n) = "^" delimited string with values of fields listed in MAGRY(1) 
 ;
GETQUEUE(MAGRY) ; RPC [MAGVA GET ALL QUEUES]
 D GALLLST^MAGVAF03(.MAGRY,2006.927,"")
 ;
 ;*****  Add a record to QUEUE MESSAGE file (#2006.928)
 ;       
 ; RPC:MAGVA ENQUEUE Q MSG
 ; 
 ; Input Parameters
 ; ================
 ;  
 ; MAGPARAM("EXPIRATION DATE/TIME")
 ; MAGPARAM("EARLIEST DELIVERY DATE/TIME")
 ; MAGPARAM("PRIORITY")
 ; MAGPARAM("QUEUE") = Pointer to QUEUE file (#2006.927)
 ; MAGPARAM("MESSAGE GROUP ID") =  value of the field "MESSAGE GROUP ID"
 ;                                  in QUEUE file (#2006.927) or "*" or ""
 ; MAGMSG(1..n)= MESSAGE
 ; 
 ; Return Values
 ; =============
 ; if error MAGRY = Failure status ^ Error message^
 ; if success MAGRY = Success status ^^IEN - IEN of the new record 
 ; 
ADDQM(MAGRY,MAGPARAM,MAGMSG) ; RPC [MAGVA ENQUEUE Q MSG]
 ; build MAGMSG first - workaround for Old broker listener
 N L,LL
 S L="MAGMSG",LL=0
 K MAGMSG
 F  S L=$O(MAGPARAM(L)) Q:(L="")!($E(L,1,6)'="MAGMSG")  S LL=LL+1,MAGMSG(LL)=MAGPARAM(L) K MAGPARAM(L)
 ;
 N FILE,FILEQM,IENS,FLD,ISACTIVE
 N MAGWP
 K MAGRY
 ; Check if the queue exist and it is active
 S IEN=$G(MAGPARAM("QUEUE"))
 ; Check for QUEUE
 I IEN="" S MAGRY=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Input parameter QUEUE is required." Q  ; Error getting the IEN
 ; Check if queue is active
 S FILE=2006.927  ; Queue file
 S IENS=IEN_","
 S FLD=$$GETFLDID^MAGVAF01(FILE,"ACTIVE")
 S ISACTIVE=$$GET1^DIQ(FILE,IENS,FLD,"I")  ; get ACTIVE value
 I 'ISACTIVE S MAGRY=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"The queue is inactive" Q
 ; 
 S MAGPARAM("EXPIRATION DATE/TIME")=$$IDF2FM^MAGVAF01($G(MAGPARAM("EXPIRATION DATE/TIME")))
 S MAGPARAM("EARLIEST DELIVERY DATE/TIME")=$$IDF2FM^MAGVAF01($G(MAGPARAM("EARLIEST DELIVERY DATE/TIME")))
 S MAGPARAM("ENQUEUED DATE/TIME")=$$NOW^XLFDT
 M MAGWP("MESSAGE")=MAGMSG
 S FILEQM=2006.928
 D ADDRCD^MAGVAF01(.MAGRY,FILEQM,.MAGPARAM,.MAGWP)  ; add the record
 Q
 ;
 ;*****  Find, return and remove a queue message from the QUEUE MESSAGE file (#2006.928)
 ;       by QUEUE - IEN of record in QUEUE file (#2006.927)
 ;       and by MESSAGE GROUP ID.
 ;       If "MESSAGE GROUP ID" equals "*" it ignores "MESSAGE GROUP ID". 
 ;       If "MESSAGE GROUP ID" equals "" it looks only at queue messages with blank "MESSAGE GROUP ID".
 ;       Otherwise looks at queue messages with MESSAGE GROUP ID
 ;       
 ; RPC:MAGVA DEQUEUE Q MSG
 ; 
 ; Input Parameters
 ; 
 ;   MAGPARAM("QUEUE") = IEN in QUEUE file (#2006.927)
 ;   MAGPARAM("MESSAGE GROUP ID") = value of the field "MESSAGE GROUP ID"
 ;                                  in QUEUE file (#2006.927) or "*" or ""
 ;   
 ;   if MAGPARAM("MESSAGE GROUP ID") = "*" return oldest 
 ;   
 ; Return Values
 ; =============
 ; if error MAGRY(0) = Failure status ^ Error message
 ; if success MAGRY(0) = Success status ^^IEN
 ;            MAGRY(1..n) = The QUEUE MESSAGE
 ;            
 ;            if IEN equals 0 that means nothing was found
 ;            ;
DEQM(MAGRY,MAGPARAM) ; RPC [MAGVA DEQUEUE Q MSG]
 K MAGRY
 D FINDQM^MAGVAQ01(.MAGRY,.MAGPARAM,"D")
 Q
 ;
 ;*****  Get a queue message from the QUEUE MESSAGE file (#2006.928)
 ;       by QUEUE - IEN of record in QUEUE file (#2006.927)
 ;       and by MESSAGE GROUP ID.
 ;       If "MESSAGE GROUP ID" equals "*" it ignores "MESSAGE GROUP ID". 
 ;       If "MESSAGE GROUP ID" equals "" it looks only at queue messages with blank "MESSAGE GROUP ID".
 ;       Otherwise looks at queue messages with MESSAGE GROUP ID
 ;    
 ; RPC:MAGVA PEEK Q MSG
 ; 
 ; Input Parameters
 ; 
 ;   MAGPARAM("QUEUE") = IEN in QUEUE file (#2006.927)
 ;   MAGPARAM("MESSAGE GROUP ID") = value of the field "MESSAGE GROUP ID"
 ;                                  in QUEUE file (#2006.927) or "*" or ""
 ;
 ; Return Values
 ; =============
 ; if error MAGRY(0) = Failure status ^ Error message
 ; if success MAGRY(0) = Success status ^^IEN
 ;            MAGRY(1..n) = The QUEUE MESSAGE
 ;            
 ;            if IEN equals 0 that means nothing was found
 ;
PEEKQM(MAGRY,MAGPARAM) ; RPC [MAGVA PEEK Q MSG]
 K MAGRY
 D FINDQM^MAGVAQ01(.MAGRY,.MAGPARAM,"")
 Q
 ;
 ;+++++  Find, return and remove a queue message from the QUEUE MESSAGE file (#2006.928)
 ;       by QUEUE - IEN of record in QUEUE file (#2006.927)
 ;       The message will have the EARLIEST DELIVERY DATE/TIME equals NULL or the EARLIEST DELIVERY DATE/TIME less than 
 ;       current date/time 
 ;       and the EXPIRATION DATE/TIME equals NULL or the EXPIRATION DATE/TIME greater than current date/time.
 ;       
 ;       Delete the message if the flag is set 
 ; 
 ; Input Parameters
 ; ================
 ;  
 ;  MAGPARAM("QUEUE") = IEN in QUEUE file (#2006.927)
 ;  MAGPARAM("MESSAGE GROUP ID") = value of the field "MESSAGE GROUP ID"
 ;                                  in QUEUE file (#2006.927) or "*" or ""
 ;  FLAGS    =  [D] delete the message from QUEUE MESSAGE file (#2006.928)
 ;
 ; Return Values
 ; =============
 ; if error MAGRY(0) = Failure status ^ Error message
 ; if success MAGRY(0) = Success status ^^IEN
 ;            MAGRY(1..n) = The QUEUE MESSAGE
 ;            
 ;            if IEN equals 0 that means nothing was found
 ;
FINDQM(MAGRY,MAGPARAM,FLAGS) ;
 N MAGDT,IEN,FILE,FLDMINDT,FLDEXPDT
 N ERRMSG,FOUND
 N QUEUEIEN,MSGGRPID
 S QUEUEIEN=$G(MAGPARAM("QUEUE"))
 S MSGGRPID=$G(MAGPARAM("MESSAGE GROUP ID"))
 S FILE=2006.928  ; Queue Message file
 S FLDMINDT=$$GETFLDID^MAGVAF01(FILE,"EARLIEST DELIVERY DATE/TIME")
 S FLDEXPDT=$$GETFLDID^MAGVAF01(FILE,"EXPIRATION DATE/TIME")
 ; Check for QUEUE
 I QUEUEIEN="" S MAGRY(0)=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Input parameter QUEUE is required." Q  ; Error getting the IEN
 S FOUND=0
 S ERRMSG=""
 I MSGGRPID="*" D
 . ; Use ENQDT index to loop through the queue and enqueued dates
 . ; For each IEN found check if the EARLIEST DELIVERY DATE/TIME is NULL OR the EARLIEST DELIVERY DATE/TIME < NOW) 
 . ; and (the EXPIRATION DATE/TIME is NULL OR the EXPIRATION DATE/TIME > NOW) then quit and return the IEN
 . S MAGDT=""
 . S FOUND=0  ; If an eligible Queue message was found. IEN will be set to this record
 . F  Q:(ERRMSG'="")!FOUND  S MAGDT=$O(^MAGV(FILE,"ENQDT",QUEUEIEN,MAGDT)) Q:MAGDT=""  D
 . . S IEN=""
 . . F  Q:(ERRMSG'="")!FOUND  S IEN=$O(^MAGV(FILE,"ENQDT",QUEUEIEN,MAGDT,IEN)) Q:IEN=""  D
 . . . S FOUND=$$CHECKQM^MAGVAQ01(.ERRMSG,FILE,IEN,FLDMINDT,FLDEXPDT) ; see if we meet the criteria
 . . . I ERRMSG'="" S MAGRY(0)=ERRMSG
 . . . Q
 . . Q
 . Q
 ;
 I MSGGRPID="" D
 . ; Use ENQBLDT index to loop through the queue and enqueued dates
 . ; For each IEN found check if the EARLIEST DELIVERY DATE/TIME is NULL OR the EARLIEST DELIVERY DATE/TIME < NOW) 
 . ; and (the EXPIRATION DATE/TIME is NULL OR the EXPIRATION DATE/TIME > NOW) then quit and return the IEN
 . S MAGDT=""
 . S FOUND=0  ; If an eligible Queue message was found. IEN will be set to this record
 . F  Q:(ERRMSG'="")!FOUND  S MAGDT=$O(^MAGV(FILE,"ENQBLDT",QUEUEIEN,MAGDT)) Q:MAGDT=""  D
 . . S IEN=""
 . . F  Q:(ERRMSG'="")!FOUND  S IEN=$O(^MAGV(FILE,"ENQBLDT",QUEUEIEN,MAGDT,IEN)) Q:IEN=""  D
 . . . S FOUND=$$CHECKQM^MAGVAQ01(.ERRMSG,FILE,IEN,FLDMINDT,FLDEXPDT) ; see if we meet the criteria
 . . . I ERRMSG'="" S MAGRY(0)=ERRMSG
 . . . Q
 . . Q
 . Q
 ;
 I (MSGGRPID'=""),(MSGGRPID'="*") D
 . ; Use ENQPLDT index to loop through the queue, place and enqueued dates
 . ; For each IEN found check if the EARLIEST DELIVERY DATE/TIME is NULL OR the EARLIEST DELIVERY DATE/TIME < NOW) 
 . ; and (the EXPIRATION DATE/TIME is NULL OR the EXPIRATION DATE/TIME > NOW) then quit and return the IEN
 . S MAGDT=""
 . S FOUND=0  ; If an eligible Queue message was found. IEN will be set to this record
 . F  Q:(ERRMSG'="")!FOUND  S MAGDT=$O(^MAGV(FILE,"ENQPLDT",QUEUEIEN,MSGGRPID,MAGDT)) Q:MAGDT=""  D
 . . S IEN=""
 . . F  Q:(ERRMSG'="")!FOUND  S IEN=$O(^MAGV(FILE,"ENQPLDT",QUEUEIEN,MSGGRPID,MAGDT,IEN)) Q:IEN=""  D
 . . . S FOUND=$$CHECKQM^MAGVAQ01(.ERRMSG,FILE,IEN,FLDMINDT,FLDEXPDT) ; see if we meet the criteria
 . . . I ERRMSG'="" S MAGRY(0)=ERRMSG
 . . . Q
 . . Q
 . Q
 I ERRMSG'="" Q  ; Quit - Found error getting values
 ;
 I 'FOUND S MAGRY(0)=$$OK^MAGVAF02()_$$RESDEL^MAGVAF02()_$$RESDEL^MAGVAF02()_0 Q
 ; 
 ; Get the message and delete it from the queue if the flag is set
 ;
 D GXMLBYPK^MAGVAF03(.MAGRY,FILE,IEN,0)
 I '$$ISOK^MAGVAF02(MAGRY(0)) Q  ; Check for error and quit if we have one
 ;
 ; Delete the message from QUEUE MESSAGE file (#2006.928)
 I FLAGS["D" D
 . N DA,DIK
 . S DIK=$$GETFILGL^MAGVAF01(FILE)
 . S DA=IEN
 . D ^DIK
 . Q
 S MAGRY(0)=$$OK^MAGVAF02()_$$RESDEL^MAGVAF02()_$$RESDEL^MAGVAF02()_IEN
 Q
 ;
 ; ++++  Returns 1 if it meets the criteria, if not returns 0
 ; Check if (the EARLIEST DELIVERY DATE/TIME is NULL or the EARLIEST DELIVERY DATE/TIME < NOW) 
 ;  and (the EXPIRATION DATE/TIME is NULL OR the EXPIRATION DATE/TIME > NOW)
 ;  
 ; Input Parameters
 ; ================
 ; FILE = QUEUE MESSAGE file (#2006.928)
 ; IEN = IEN in QUEUE MESSAGE file (#2006.928)
 ; FLDMINDT = EARLIEST DELIVERY DATE/TIME field number in QUEUE MESSAGE file (#2006.928)
 ; FLDEXPDT = EXPIRATION DATE/TIME field number in QUEUE MESSAGE file (#2006.928)
 ; 
 ; Return Values
 ; =============
 ; if error ERRMSG = Failure status ^ Error message^
 ;  
CHECKQM(ERRMSG,FILE,IEN,FLDMINDT,FLDEXPDT) ; Returns 1 if it meets the criteria, if not returns 0 
 N ERR,FIELDS,OUT,IENS,MAGRESA,FOUND
 N NOW
 S FOUND=0
 S FIELDS=FLDMINDT_";"_FLDEXPDT
 S IENS=IEN_","
 D GETS^DIQ(FILE,IENS,FIELDS,"I","OUT","ERR") ; get EARLIEST DELIVERY DATE/TIME and EXPIRATION DATE/TIME values
 I $D(ERR("DIERR")) D  Q 0
 . D MSG^DIALOG("A",.MAGRESA,245,5,"ERR")
 . S ERRMSG=$$FAILED^MAGVAF02()_$$RESDEL^MAGVAF02()_"Error getting values: "_MAGRESA(1) Q  ; Error getting the values
 . Q
 ;
 ; Get the oldest QUEUE MESSAGE where
 ;      (the EARLIEST DELIVERY DATE/TIME is NULL OR the EARLIEST DELIVERY DATE/TIME < NOW) 
 ;  AND (the EXPIRATION DATE/TIME is NULL OR the EXPIRATION DATE/TIME > NOW)
 ;  
 S NOW=$$NOW^XLFDT
 I ((OUT(FILE,IENS,FLDMINDT,"I")="")!(OUT(FILE,IENS,FLDMINDT,"I")<NOW))&((OUT(FILE,IENS,FLDEXPDT,"I")="")!(OUT(FILE,IENS,FLDEXPDT,"I")>NOW)) S FOUND=1
 Q FOUND
