FBAAVR4 ;WOIFO/SAB - FINALIZE BATCH (CONT) ;4/16/2012
 ;;3.5;FEE BASIS;**132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
SETREJ(FBN,FBTYPE,FBIENS,FBIREJ,FBRR,FBRRC) ; Set reject flag for line
 ; input
 ;   FBN - (conditionally required) Batch IEN, file 161.7
 ;   FBTYPE - (conditionally required) Batch type (B2, B3, B5, or B9)
 ;   FBIENS - (required) IENS of line being rejected, FileMan DBS format
 ;   FBIREJ - (optional) = 1 if reject from interface
 ;   FBRR - (required when not interface reject) free text reject reason
 ;   FBRRC - (required for interface reject), passed by reference
 ;           array of reject codes, FBRRC(#)=code
 ;           where # is an integer greater than 0. e.g. FBRRC(1)="C012"
 ;  returns a value
 ;         =1^batch number^amount paid if successful
 ;         =0^message if unsuccessful
 ;
 ; ICRs
 ;  #2053   FILE^DIE, UPDATE^DIE
 ;  #2054   CLEAN^DILF
 ;  #2056   $$GET1^DIQ
 ;
 N FBAP,FBFIELDS,FBFILE,FBRET
 S FBRET=1
 ;
 ; check inputs
 I $G(FBN)="",$G(FBTYPE)="" S FBRET="0^Batch number or type not provided."
 I $G(FBIENS)="" S FBRET="0^Line Item IENs not provided."
 I $G(FBIREJ),'$O(FBRRC(0)) S FBRET="0^Reject Code not provided."
 I '$G(FBIREJ),$G(FBRR)="" S FBRET="0^Reject Reason not provided."
 ;
 ; determine batch type if not provided
 I FBRET D
 . I $G(FBTYPE)="" S FBTYPE=$P($G(^FBAA(161.7,FBN,0)),"^",3) ; TYPE
 . I "^B2^B3^B5^B9^"'[(U_FBTYPE_U) S FBRET="0^Batch type invalid."
 ;
 ; determine payment/invoice file/sub-file of line item based on type
 I FBRET D
 . I FBTYPE="B2" S FBFILE="162.04" ; travel
 . I FBTYPE="B3" S FBFILE="162.03" ; outpatient or inpatient ancillary
 . I FBTYPE="B5" S FBFILE="162.11" ; pharmacy
 . I FBTYPE="B9" S FBFILE="162.5"  ; inpatient
 . I $G(FBFILE)="" S FBRET="0^Could not determine file to update"
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
 . ;   piece 7 = reject code sub-file number
 . ;   piece 8 = date finalized (n/a for 162.11)
 . I FBFILE="162.03" S FBFIELDS="7^2^19^20^21^21.3^162.031^5"
 . I FBFILE="162.04" S FBFIELDS="1^2^4^5^6^6.3^162.041^7"
 . I FBFILE="162.11" S FBFIELDS="13^6.5^17^18^19^19.3^162.111^"
 . I FBFILE="162.5" S FBFIELDS="20^8^13^14^15^15.3^162.515^19"
 . I $G(FBFIELDS)="" S FBRET="0^Could not determine field numbers"
 ;
 ; check status of payment line item
 I FBRET D
 . S FBN=$$GET1^DIQ(FBFILE,FBIENS,$P(FBFIELDS,"^",1),"I") ; batch IEN
 . I $D(DIERR) S FBRET="0^Error retrieving line item data." Q
 . I FBN="" D  Q  ; not in a batch
 . . I $$GET1^DIQ(FBFILE,FBIENS,$P(FBFIELDS,"^",3))'="" D  Q
 . . . S FBRET="0^Line is already flagged as rejected."
 . . S FBRET="0^Batch number field on line is a null value."
 . S FBAP=$$GET1^DIQ(FBFILE,FBIENS,$P(FBFIELDS,"^",2)) ; amount paid
 ;
 ; reject payment line item
 I FBRET D
 . N DIERR,FBFDA
 . S FBFDA(FBFILE,FBIENS,$P(FBFIELDS,"^",1))="@" ; batch number
 . S FBFDA(FBFILE,FBIENS,$P(FBFIELDS,"^",3))="P" ; reject status
 . I '$G(FBIREJ) S FBFDA(FBFILE,FBIENS,$P(FBFIELDS,"^",4))=FBRR ; reason
 . S FBFDA(FBFILE,FBIENS,$P(FBFIELDS,"^",5))=FBN ; old batch number
 . S:$G(FBIREJ) FBFDA(FBFILE,FBIENS,$P(FBFIELDS,"^",6))=1 ; interface
 . I $P(FBFIELDS,"^",8) D
 . . ; field will already be null except when post voucher reject msg
 . . S FBFDA(FBFILE,FBIENS,$P(FBFIELDS,"^",8))="@" ; date finalized
 . ;
 . D FILE^DIE("","FBFDA")
 . D CLEAN^DILF
 ;
 ; save reject codes for interface reject
 I FBRET,$G(FBIREJ) D
 . N DIERR,FBFDA,FBI
 . ; loop thru reject codes
 . S FBI=0 F  S FBI=$O(FBRRC(FBI)) Q:'FBI  D
 . . Q:FBRRC(FBI)=""
 . . S FBFDA($P(FBFIELDS,"^",7),"+"_FBI_","_FBIENS,.01)=FBRRC(FBI)
 . ;
 . D UPDATE^DIE("","FBFDA")
 . D CLEAN^DILF
 ;
 ; update batch data to reflect rejected line item
 I FBRET D
 . N DIERR,FBFDA,FBIC,FBLC,FBTOT
 . ; get existing data
 . S FBTOT=$$GET1^DIQ(161.7,FBN_",",8) ; TOTAL DOLLARS
 . S FBIC=$$GET1^DIQ(161.7,FBN_",",9) ; INVOICE COUNT
 . S FBLC=$$GET1^DIQ(161.7,FBN_",",10) ; PAYMENT LINE COUNT
 . ; 
 . S FBFDA(161.7,FBN_",",8)=FBTOT-FBAP ; TOTAL DOLLARS
 . S FBFDA(161.7,FBN_",",10)=FBLC-1 ; PAYMENT LINE COUNT
 . S FBFDA(161.7,FBN_",",15)="Y" ; REJECTS PENDING
 . ; update INVOICE COUNT when appropriate
 . ; this field is not curently maintained for batch types B2 and B3
 . I FBFILE=162.5 S FBFDA(161.7,FBN_",",9)=FBIC-1 ; INVOICE COUNT
 . I FBFILE=162.11 D
 . . ; quit if any lines from the pharmacy invoice remain on the batch
 . . Q:$O(^FBAA(162.1,"AE",FBN,$P(FBIENS,",",2),0))
 . . S FBFDA(161.7,FBN_",",9)=FBIC-1 ; INVOICE COUNT
 . ;
 . D FILE^DIE("","FBFDA")
 . D CLEAN^DILF
 ;
 ; if success add batch IEN and amount paid to return value
 I FBRET S FBRET=FBRET_"^"_FBN_"^"_FBAP
 Q FBRET
 ;
 ;FBAAVR4
