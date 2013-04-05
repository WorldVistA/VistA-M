PRCHJUTL ;OI&T/LKG,KCL-UTILITY FUNCTIONS IFCAP/ECMS INTERFACE ;6/22/12  15:52
 ;;5.1;IFCAP;**167**;Oct 20, 2000;Build 17
 ;Per VHA Directive 2004-38, this routine should not be modified.
 ;
 ;
ECMS2237(PRCHJDA) ;Checks 2237 to see if processed in eCMS - Returns 1 if
 ;processed in eCMS and 0 if not. Check on basis of whether the ECMS
 ;ACTIONUID field is populated.
 N X S X=($P($G(^PRCS(410,PRCHJDA,1)),U,8)'="")
 Q X
 ;
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
