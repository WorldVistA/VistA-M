PRCHJUTL ;OI&T/LKG,KCL-UTILITY FUNCTIONS IFCAP/ECMS INTERFACE ;5/10/13  15:46
 ;;5.1;IFCAP;**167,174**;Oct 20, 2000;Build 23
 ;Per VHA Directive 2004-38, this routine should not be modified.
 ;
 ;
ECMS2237(PRCHJDA) ;Checks 2237 to see if processed in eCMS - Returns 1 if
 ;processed in eCMS and 0 if not. Check on basis of whether the ECMS
 ;ACTIONUID field is populated.
 N X S X=($P($G(^PRCS(410,PRCHJDA,1)),U,8)'="")
 Q X
 ;
UPD443(PRC443R,PRCERR) ;Update file #443 record
 ;This function is used to update the following fields in
 ;a REQUEST WORKSHEET (#443) record:
 ;
 ; Field Name           Field #
 ; -------------------  -------
 ; CURRENT STATUS       1.5
 ; ACCOUNTABLE OFFICER  2
 ; VALIDATION CODE      3
 ; ESIG DATE/TIME       4
 ;
 ;  Input:
 ;  PRC443R - (required) IEN of record in REQUEST WORKSHEET (#443) file
 ;
 ; Output:
 ;   Function Value - returns 1 on success, 0 on failure
 ;           PRCERR - (optional) on failure, an error message is returned,
 ;                    pass by ref
 ;
 N PRCRSLT ;function result
 N PRCIENS ;iens string for FM data array
 N PRCFDA  ;FM data array
 ;
 S PRC443R=+$G(PRC443R)
 S PRCRSLT=0
 S PRCERR="Invalid input parameter"
 ;
 I PRC443R>0 D
 . K PRCERR
 . S PRCIENS=PRC443R_","
 . S PRCFDA(443,PRCIENS,1.5)=60 ;Pending Accountable Officer Sig.
 . S PRCFDA(443,PRCIENS,2)="@"  ;delete
 . S PRCFDA(443,PRCIENS,3)="@"  ;delete
 . S PRCFDA(443,PRCIENS,4)="@"  ;delete
 . D FILE^DIE("K","PRCFDA","PRCERR")
 . ;quit if filing error
 . I $D(PRCERR) S PRCERR=$G(PRCERR("DIERR","1","TEXT",1)) Q
 . ;
 . ;success
 . S PRCRSLT=1
 ;
 Q PRCRSLT
 ;
 ;
UPD410(PRC410R,PRCERR) ;Update file #410 record
 ;This function is used to update the following fields in
 ;a CONTROL POINT ACTIVITY (#410) record:
 ;
 ; Field Name           Field #
 ; -------------------  -------
 ; ACCOUNTABLE OFFICER  39
 ; AO SIGNATURE DATE    69
 ;
 ;  Input:
 ;  PRC410R - (required) IEN of record in CONTROL POINT ACTIVITY (#410) file
 ;
 ; Output:
 ;   Function Value - returns 1 on success, 0 on failure
 ;           PRCERR - (optional) on failure, an error message is returned,
 ;                    pass by ref
 ;
 N PRCRSLT ;function result
 N PRCIENS ;iens string for FM data array
 N PRCFDA  ;FM data array
 ;
 S PRC410R=+$G(PRC410R)
 S PRCRSLT=0
 S PRCERR="Invalid input parameter"
 ;
 I PRC410R>0 D
 . K PRCERR
 . S PRCIENS=PRC410R_","
 . S PRCFDA(410,PRCIENS,39)="@" ;delete
 . S PRCFDA(410,PRCIENS,69)="@" ;delete
 . D FILE^DIE("K","PRCFDA","PRCERR")
 . ;quit if filing error
 . I $D(PRCERR) S PRCERR=$G(PRCERR("DIERR","1","TEXT",1)) Q
 . ;
 . ;success
 . S PRCRSLT=1
 ;
 Q PRCRSLT
 ;
 ;
ITDES(PRC410R,PRCITIEN) ;Check single line item for a description
 ;This function checks a single line item on a 2237 to make sure it has a description.
 ;
 ;  Input:
 ;    PRC410R - (required) IEN of record in CONTROL POINT ACTIVITY (#410) file
 ;   PRCITIEN - (required) IEN of record in ITEM (#410.02) sub-file
 ;
 ; Output:
 ;  Function value - 1 on success, 0 on failure (no line item description)
 ;
 N PRCIENS  ;iens string for GET1^DIQ
 N PRCDESC  ;word processing field target array
 N PRCRSLT  ;function result
 ;
 ;
 S PRC410R=+$G(PRC410R)
 S PRCITIEN=+$G(PRCITIEN)
 S PRCRSLT=1
 ;
 ;failure if 2237 record not found in #410 file
 I (PRC410R'>0)!('$D(^PRCS(410,PRC410R))) S PRCRSLT=0
 ;
 ;failure if record not found in ITEM (#410.02) sub-file
 I (PRCITIEN'>0)!('$D(^PRCS(410,PRC410R,"IT",PRCITIEN,0))) S PRCRSLT=0
 ;
 I PRCRSLT D  ;drop out of DO block on failure
 . ;
 . ;attempt to retrieve the contents of word processing Item
 . ;Description field and store text in the target array
 . K PRCDESC
 . S PRCIENS=PRCITIEN_","_PRC410R_","
 . S PRCDESC=$$GET1^DIQ(410.02,PRCIENS,1,"Z","PRCDESC")
 . ;if no data exists, quit and function result=failure
 . I PRCDESC="" S PRCRSLT=0 Q
 . ;
 . ;strip WP nodes of spaces and tabs; if node still contains data then ok
 . N PRCWP,PRCNODE,PRCOK
 . S (PRCWP,PRCOK)=0
 . F  S PRCWP=$O(PRCDESC(PRCWP)) Q:'PRCWP!(PRCOK)  D
 . . S PRCNODE=$G(PRCDESC(PRCWP,0))
 . . S PRCNODE=$TR(PRCNODE," ","")   ;strip spaces
 . . S PRCNODE=$TR(PRCNODE,$C(9),"") ;strip tabs
 . . ;ok, data in the WP node
 . . I $L(PRCNODE)>0 S PRCOK=1
 . I 'PRCOK S PRCRSLT=0
 ;
 Q PRCRSLT
 ;
 ;
ITDESALL(PRC410R,PRCERR) ;Check all line items for description
 ;This function checks all line items on a document to make sure they have a description.
 ;
 ;  Input:
 ;   PRC410R - (required) IEN of record in CONTROL POINT ACTIVITY (#410) file
 ;
 ; Output:
 ;  Function value - 1 on success, 0 on failure (one or more line items don't have description)
 ;          PRCERR - (optional) on failure, an error message array is returned, pass by ref
 ;                    Array format:
 ;                     PRCERR(1)="Line Item #3 Description is missing."
 ;                     PRCERR(2)="Line Item #5 Description is missing."
 ;                     PRCERR(3), etc.
 ;
 N PRCLINE  ;line items
 N PRCITIEN ;line item IEN
 N PRCLNUM  ;Line Item Number
 N PRCIDX   ;error array subscript
 N PRCRSLT  ;function result
 ;
 S PRC410R=+$G(PRC410R)
 S PRCRSLT=1
 ;
 ;quit if 2237 record not found in #410 file
 I (PRC410R'>0)!('$D(^PRCS(410,PRC410R))) D  Q PRCRSLT
 . S PRCRSLT=0
 . S PRCERR(1)="Control Point Activity record not found."
 ;
 S (PRCLINE,PRCITIEN,PRCIDX)=0
 ;loop thru "B" index of ITEM multiple
 F  S PRCLINE=+$O(^PRCS(410,PRC410R,"IT","B",PRCLINE)) Q:'PRCLINE  D
 . ;
 . ;get IEN of record in ITEM (#410.02) sub-file
 . S PRCITIEN=0
 . S PRCITIEN=+$O(^PRCS(410,PRC410R,"IT","B",$G(PRCLINE),PRCITIEN))
 . I 'PRCITIEN D  Q
 . . S PRCRSLT=0
 . . S PRCIDX=PRCIDX+1
 . . S PRCERR(PRCIDX)="Item not found in Control Point Activity record."
 . ;
 . ;does line item have a description?
 . I '$$ITDES(PRC410R,$G(PRCITIEN)) D
 . . S PRCRSLT=0
 . . S PRCLNUM=""
 . . S PRCLNUM=$P($G(^PRCS(410,PRC410R,"IT",$G(PRCITIEN),0)),U,1)
 . . S PRCIDX=PRCIDX+1
 . . S PRCERR(PRCIDX)="Line Item #"_$G(PRCLNUM)_" Description is missing."
 ;
 Q PRCRSLT
 ;
 ;
REQCHECK(PRC410R,PRCWARN,PRCQUIET) ;2237 required field checks
 ;This function is used to check a document and determine if the following fields
 ;are populated:
 ;  - Requesting Service
 ;  - Description field for all line items
 ;
 ;  Input:
 ;    PRC410R - (required) IEN of record in CONTROL POINT ACTIVITY (#410) file
 ;   PRCQUIET - (optional) 0=silent call, 1=output warning msgs
 ;
 ; Output: 
 ;   Function value - 1 on success, 0 on failure-field(s) not populated
 ;          PRCWARN - (optional) on failure, an warning msg array is returned, pass by ref
 ;                    Array format:
 ;                     PRCWARN(1)="Requesting Service is missing."
 ;                     PRCWARN(2)="Line Item #3 Description is missing."
 ;                     PRCWARN(3), etc.
 ;
 N PRCRSLT ;function result
 N PRCERR  ;error msg array returned by $$ITDESALL^PRCHJUTL
 N PRCI    ;error msg array index
 N PRCIDX  ;warning msg array index
 ;
 S PRC410R=+$G(PRC410R)
 S PRCIDX=0
 S PRCRSLT=1
 ;
 ;check for Requesting Service
 I $$GET1^DIQ(410,PRC410R,6.3)']"" D
 . S PRCRSLT=0
 . S PRCIDX=PRCIDX+1
 . S PRCWARN(PRCIDX)="Requesting Service is missing."
 ;
 ;check all line items for missing description
 I '$$ITDESALL^PRCHJUTL(PRC410R,.PRCERR) D
 . S PRCRSLT=0
 . S PRCI=0
 . F  S PRCI=$O(PRCERR(PRCI)) Q:'PRCI  D
 . . S PRCIDX=PRCIDX+1
 . . S PRCWARN(PRCIDX)=$G(PRCERR(PRCI))
 ;
 ;on failure and not silent, output warning
 I 'PRCRSLT,$G(PRCQUIET) D
 . W !!,"WARNING - Transaction "_$$GET1^DIQ(410,PRC410R,.01)_" is missing required data!",*7
 . S PRCIDX=0
 . F  S PRCIDX=$O(PRCWARN(PRCIDX)) Q:'PRCIDX  D
 . . W !?2,">>> "_$G(PRCWARN(PRCIDX))
 . W !,"The request needs to be edited prior to approval.",!
 ;
 Q PRCRSLT
