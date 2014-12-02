PSSHRQ2 ;WOIFO/AV,TS - Makes a request to PEPS and returns as Global ;09/20/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**136,163,168,160**;9/30/97;Build 76
 ;
 ; @authors - Alex Vazquez, Tim Sabat
 ; @date    - September 19, 2007
 ; @version - 1.0
 ;
 QUIT
 ;;
IN(PSSBASE) ;
 ; @DESC Handles request/response to PEPS
 ;
 ; @RETURNS Nothing. Value stored in output global.
 ;
 NEW PSS,PSSRESLT,PSSDOC,PSSXML,FDBFLG,PSSRBASE,PSSRBASX,PSSHRTMX,PSSHRTRT
 ; Cleanup output global
 ; KILL ^TMP($JOB,PSSBASE,"OUT")  ; PO: commented as requested by Stan Brown on 6/4/09
 ;
 ; save "IN" nodes
 S PSSHRTMX=0
 K ^TMP($J,"SAVE","IN")
 M ^TMP($J,"SAVE","IN")=^TMP($J,PSSBASE,"IN") S PSSRBASE=PSSBASE
 ;
 ;Check FDB status if an update is occurring
 S FDBFLG=$$CHKSTAT^PSSDSFDB()
 ;If FDB update set global and quit
 I FDBFLG S ^TMP($J,PSSBASE,"OUT",0)=FDBFLG GOTO END   ;QUIT
 ;
 ; Validate input global
 SET PSS("validationResult")=$$DRIVER^PSSHRVAL(PSSBASE)
 IF PSS("validationResult")=0  DO
 . ; Check if data written to global, set to 1 if data exist
 . IF $DATA(^TMP($JOB,PSSBASE,"OUT")) SET ^TMP($JOB,PSSBASE,"OUT",0)=1
 . ; If no data in output global , set to 0
 . IF '$DATA(^TMP($JOB,PSSBASE,"OUT")) SET ^TMP($JOB,PSSBASE,"OUT",0)=0
 . QUIT
 ; End call if no call to make
 IF PSS("validationResult")=0 GOTO END   ;QUIT
 ;
 ; Create XML request
 SET PSSXML=$$BLDPREQ^PSSHREQ(PSSBASE)
 ; Send XML request to PEPS, receive handle to XML in return
 ;
RETRY ;Retry entry point if first connection attempt fails
 SET PSSRESLT=$$PEPSPOST^PSSHTTP(.PSSDOC,PSSXML)
 ;
 ; If request unsuccessful go straight to error handling
 IF +PSSRESLT=0 DO ALTERROR^PSSHRQ2O(PSSBASE)
 ;
 ; If request is successful parse response
 ; and put in results global object.  Also set the last successful run time.
 IF +PSSRESLT>0 DO OUT^PSSHRQ2O(PSSDOC,PSSBASE),SLASTRUN^PSSHRIT($$NOW^XLFDT())
 ; 
 I 'PSSHRTMX S PSSHRTRT=$P($G(^TMP($J,PSSRBASE,"OUT",0)),"^") I PSSHRTRT'=0,PSSHRTRT'=1 K ^TMP($J,PSSRBASE,"OUT",0) D SHG G RETRY
 ;
END ; re-store "IN" nodes
 M ^TMP($J,PSSBASE,"IN")=^TMP($J,"SAVE","IN")
 K ^TMP($J,"SAVE","IN")
 S PSSRBASX=$P($G(^TMP($J,PSSRBASE,"OUT",0)),"^") I PSSRBASX'=-1,PSSRBASX'=0,PSSRBASX'=1 D
 .K ^TMP($J,PSSRBASE,"OUT")
 .S ^TMP($J,PSSRBASE,"OUT",0)="-1^An unexpected error has occurred."
 I $P($G(^TMP($J,PSSRBASE,"OUT",0)),"^")'=-1 D CLEXP^PSSHRQ2O
 QUIT
 ;;
 ;
SHG ;Hang before retry
 S PSSHRTMX=1
 I $E(PSSRBASE,1,4)'="PING"!($G(PSSMCHK)="CHECK") H 3 Q
 H 30
 Q
