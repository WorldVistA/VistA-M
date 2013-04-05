FBAARR3 ;WOIFO/SAB - REINITIATE REJECTED LINE ITEMS ;4/26/2012
 ;;3.5;FEE BASIS;**132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ; ICRs
 ;  #2053   FILE^DIE
 ;  #2054   CLEAN^DILF, DA^DILF
 ;  #2056   $$GET1^DIQ, GETS^DIQ
 ;
DELREJ(FBFILE,FBPIENS,FBNB) ; Delete Reject Flag
 ; input
 ;   FBFILE - payment file (162.03, 162.04, 162.11, 162.5)
 ;   FBPIENS - IEN of payment line in file, FileMan DBS format
 ;   FBNB - IEN of new batch, only pass when re-initiate
 ; return value
 ;   =1 when successfully processed
 ;   =0^message when not
 ;
 N FBAP,FBFIELDS,FBN,FBRET,FBSKIPIC
 S FBRET=1
 ;
 ; verify inputs
 I $G(FBFILE)="" S FBRET="0^File number not provided."
 I $G(FBPIENS)="" S FBRET="0^Line Item IENs not provided."
 I $G(FBNB),"^O^A^"'[("^"_$$GET1^DIQ(161.7,FBNB_",",11,"I")_"^") D
 . S FBRET="0^New batch status is not OPEN or ASSIGNED PRICE."
 ;
 ; determine field numbers based on file
 I FBRET D
 . ; FBFIELDS will contain the numbers of the following fields/sub-file
 . ;   piece 1 = batch number
 . ;   piece 2 = amount paid
 . ;   piece 3 = reject status
 . ;   piece 4 = reject reason
 . ;   piece 5 = old batch number
 . ;   piece 6 = interface reject
 . ;   piece 7 = reject code
 . ;   piece 8 = reject code sub-file number
 . I FBFILE="162.03" S FBFIELDS="7^2^19^20^21^21.3^21.6^162.031"
 . I FBFILE="162.04" S FBFIELDS="1^2^4^5^6^6.3^6.6^162.041"
 . I FBFILE="162.11" S FBFIELDS="13^6.5^17^18^19^19.3^19.6^162.111"
 . I FBFILE="162.5" S FBFIELDS="20^8^13^14^15^15.3^15.6^162.515"
 . I $G(FBFIELDS)="" S FBRET="0^Could not determine field numbers"
 ;
 ; get line item data
 I FBRET D
 . S FBAP=$$GET1^DIQ(FBFILE,FBPIENS,$P(FBFIELDS,"^",2)) ; amount paid
 . S FBN=$$GET1^DIQ(FBFILE,FBPIENS,$P(FBFIELDS,"^",5),"I") ; old batch
 . I FBN="" S FBRET="0^OLD BATCH NUMBER is null, Line is not rejected."
 ;
 ; restore to original batch when input FBNB is null (not re-initiate)
 I FBRET D
 . S:$G(FBNB)="" FBNB=FBN
 ;
 ; if file is 162.11 and invoice already has a line on the batch then
 ;   set flag to prevent increase to the batch invoice count
 I FBRET,FBFILE=162.11 D
 . I $O(^FBAA(162.1,"AE",FBNB,$P(FBPIENS,",",2),0)) S FBSKIPIC=1
 ;
 ; update line item
 I FBRET D
 . N DIERR,FBFDA,FBRIENS,FBX
 . S FBFDA(FBFILE,FBPIENS,$P(FBFIELDS,"^",1))=FBNB ; batch number
 . S FBFDA(FBFILE,FBPIENS,$P(FBFIELDS,"^",3))="@" ; reject status
 . S FBFDA(FBFILE,FBPIENS,$P(FBFIELDS,"^",4))="@" ; reject reason
 . S FBFDA(FBFILE,FBPIENS,$P(FBFIELDS,"^",5))="@" ; old batch number
 . S FBFDA(FBFILE,FBPIENS,$P(FBFIELDS,"^",6))="@" ; interface reject
 . ;
 . ; get list of entries in REJECT CODE multiple
 . D GETS^DIQ(FBFILE,FBPIENS,$P(FBFIELDS,"^",7)_"*","","FBX")
 . ;
 . ; loop thru REJECT CODE entries
 . S FBRIENS=""
 . F  S FBRIENS=$O(FBX($P(FBFIELDS,"^",8),FBRIENS)) Q:FBRIENS=""  D
 . . S FBFDA($P(FBFIELDS,"^",8),FBRIENS,.01)="@" ; REJECT CODE
 . ;
 . D FILE^DIE("","FBFDA")
 . I $D(DIERR) S FBRET="0^Error updating line item."
 . D CLEAN^DILF
 ;
 I FBRET D
 . ; the software often checks $DATA of the "FBREJ" node to determine
 . ; if a line item is flagged as rejected.  To ensure this checks works
 . ; correctly the node will be killed.
 . N FBDA
 . D DA^DILF(FBPIENS,.FBDA)
 . I FBFILE=162.03 K ^FBAAC(FBDA(3),1,FBDA(2),1,FBDA(1),1,FBDA,"FBREJ")
 . I FBFILE=162.04 K ^FBAAC(FBDA(1),3,FBDA,"FBREJ")
 . I FBFILE=162.11 K ^FBAA(162.1,FBDA(1),"RX",FBDA,"FBREJ")
 . I FBFILE=162.5 K ^FBAAI(FBDA,"FBREJ")
 ;
 ; update new batch fields to reflect addition of line item
 I FBRET D
 . N DIERR,FBFDA,FBIC,FBLC,FBTOT
 . ; get existing data
 . S FBTOT=$$GET1^DIQ(161.7,FBNB_",",8) ; TOTAL DOLLARS
 . S FBIC=$$GET1^DIQ(161.7,FBNB_",",9) ; INVOICE COUNT
 . S FBLC=$$GET1^DIQ(161.7,FBNB_",",10) ; PAYMENT LINE COUNT
 . ; 
 . S FBFDA(161.7,FBNB_",",8)=FBTOT+FBAP ; TOTAL DOLLARS
 . S FBFDA(161.7,FBNB_",",10)=FBLC+1 ; PAYMENT LINE COUNT
 . ; update INVOICE COUNT when appropriate
 . ; this field is not curently maintained for batch types B2 and B3
 . I FBFILE=162.5 S FBFDA(161.7,FBNB_",",9)=FBIC+1 ; INVOICE COUNT
 . I FBFILE=162.11,'$G(FBSKIPIC) D
 . . S FBFDA(161.7,FBNB_",",9)=FBIC+1 ; INVOICE COUNT
 . ;
 . I $D(FBFDA) D FILE^DIE("","FBFDA")
 . I $D(DIERR) S FBRET="0^Error updating data for new batch."
 . D CLEAN^DILF
 ;
 ; update old batch if no more rejects pending
 I FBRET D
 . N DIERR,FBFDA
 . I FBFILE=162.03,$D(^FBAAC("AH",FBN)) Q
 . I FBFILE=162.04,$D(^FBAAC("AG",FBN)) Q
 . I FBFILE=162.11,$D(^FBAA(162.1,"AF",FBN)) Q
 . I FBFILE=162.5,$D(^FBAAI("AH",FBN)) Q
 . S FBFDA(161.7,FBN_",",15)="@" ; REJECTS PENDING
 . I $D(FBFDA) D FILE^DIE("","FBFDA")
 . I $D(DIERR) S FBRET="0^Error updating data for old batch."
 . D CLEAN^DILF
 ;
 Q FBRET
 ;
 ;FBAARR3
