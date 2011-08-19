RORRP012 ;HCIOFO/SG - RPC: MISCELLANEOUS ; 12/15/05 4:03pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** RETURNS THE CURRENT DATE/TIME ON THE SERVER
 ; RPC: [ROR GET SERVER TIME]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; Return Values:
 ;
 ; The current dat/time (in internal FileMan format) is returned
 ; in the RESULTS(1). RESULTS(0) alwais contains 0.
 ;
GETSRVDT(RESULTS) ;
 S RESULTS(0)=0
 S RESULTS(1)=$$NOW^XLFDT
 Q
 ;
 ;***** RETURNS A LIST OF ITEMS FROM THE 'ROR LIST ITEM' FILE
 ; RPC: [ROR LIST ITEMS]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; REGIEN        Registry IEN
 ;
 ; TYPE          Type of the items:
 ;                 3  Lab Group
 ;                 4  Drug Group
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0)
 ; indicates an error (see the RPCSTK^RORERR procedure for more
 ; details).
 ;
 ; Otherwise, number of items is returned in the RESULTS(0)
 ; and the subsequent nodes of the array contain the items.
 ; 
 ; RESULTS(0)            Number of item
 ;
 ; RESULTS(i)            List Item
 ;                         ^01: IEN
 ;                         ^02: Text
 ;                         ^03: Code
 ;
LSTITEMS(RESULTS,REGIEN,TYPE) ;
 N CNT,CODE,ITEMS,RC,RORERRDL
 D CLEAR^RORERR("LSTITEMS^RORRP012",1)
 K RESULTS  S RESULTS(0)=0
 ;--- Check the parameters
 S RC=0  D  I RC<0  D RPCSTK^RORERR(.RESULTS,RC)  Q
 . ;--- Registry IEN
 . I $G(REGIEN)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"REGIEN",$G(REGIEN))
 . S REGIEN=+REGIEN
 . ;--- Type
 . I $G(TYPE)'>0  D  Q
 . . S RC=$$ERROR^RORERR(-88,,,,"TYPE",$G(TYPE))
 . S TYPE=+TYPE
 ;--- Load the list items
 S RC=$$ITEMLIST^RORUTL09(TYPE,REGIEN,.ITEMS)
 ;--- Populate the output array
 S CODE="",CNT=0
 F  S CODE=$O(ITEMS(CODE))  Q:CODE=""  D
 . S CNT=CNT+1,RESULTS(CNT)=$P(ITEMS(CODE),U,1,2)
 . S $P(RESULTS(CNT),U,3)=CODE
 S RESULTS(0)=CNT
 Q
 ;
 ;***** CHECKS FOR PRODUCTION ACCOUNT
 ; RPC: [ROR PRODUCTION ACCOUNT]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; Return Values:
 ;
 ; 1 is returned in RESULTS(0) in case of a production account.
 ; Otherwise, zero is returned.
 ;
PROD(RESULTS) ;
 S RESULTS(0)=+$$PROD^XUPROD()
 Q
 ;
 ;***** CHECKS IF THE RESCHEDULING CODE IS VALID
 ; ROR: [ROR TASK VALIDATE RESCHEDULING]
 ;
 ; .RESULTS      Reference to a local variable where the results
 ;               are returned to.
 ;
 ; SCHCODE       Rescheduling code
 ;
 ; [SCHDT]       Date when a task is scheduled to run for the
 ;               first time (FileMan). By default (if $G(SCHDT)'>0),
 ;               the current date/time is used.
 ;
 ; Return Values:
 ;
 ; A negative value of the first "^"-piece of the RESULTS(0) indicates
 ; an error (see the RPCSTK^RORERR procedure for more details).
 ;
 ; Otherwise, either 1 (the rescheduling code is valid) or 0 (the
 ; code is not valid) is returned in the RESULTS(0). If the code is
 ; valid then the next date/time to run the task (FileMan format)
 ; is returned in the RESULTS(1).
 ;
VALIDSCH(RESULTS,SCHCODE,SCHDT) ;
 N NEXT,RORMSG,TMP  K RESULTS
 I $G(SCHCODE)=""  S RESULTS(0)=1  Q
 S RESULTS(0)=0
 ;--- Check if the rescheduling code is correct
 S:$G(SCHDT)'>0 SCHDT=$$NOW^XLFDT
 S NEXT=$$SCH^XLFDT(SCHCODE,SCHDT,1)
 Q:NEXT'>0
 ;--- Make sure that a task will not be rescheduled in less
 ;--- than 60 seconds (to be able to delete it if necessary)
 S TMP=$$SCH^XLFDT(SCHCODE,NEXT,1)
 S:$$FMDIFF^XLFDT(TMP,NEXT,2)'<60 RESULTS(0)=1,RESULTS(1)=NEXT
 Q
