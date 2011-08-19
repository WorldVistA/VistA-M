DGPFAAH ;ALB/RPM - PRF ASSIGNMENT HISTORY API'S ; 4/8/04 4:13pm
 ;;5.3;Registration;**425,554**;Aug 13, 1993
 Q  ;no direct entry
 ;
GETALL(DGPFIEN,DGPFIENS) ;retrieve list of history IENs for an assignment
 ;
 ;  Input:
 ;    DGPFIEN - (required) Pointer to PRF ASSIGNMENT (#26.13) file
 ;   DGPFIENS - (required) Result array passed by reference
 ;
 ;  Output:
 ;   Function Value - Count of returned IENs
 ;         DGPFIENS - Output array subscripted by assignment history IENs
 ;                    
 N DGCNT   ;number of returned values
 N DGHIEN  ;single history IEN
 ;
 S DGCNT=0
 I $G(DGPFIEN)>0,$D(^DGPF(26.14,"B",DGPFIEN)) D
 . S DGHIEN=0
 . F  S DGHIEN=$O(^DGPF(26.14,"B",DGPFIEN,DGHIEN)) Q:'DGHIEN  D
 . . S DGPFIENS(DGHIEN)=""
 . . S DGCNT=DGCNT+1
 Q DGCNT
 ;
GETALLDT(DGPFIEN,DGPFIENS) ;retrieve list of history IENs for an assignment
 ;
 ;  Input:
 ;    DGPFIEN - (required) Pointer to PRF ASSIGNMENT (#26.13) file
 ;   DGPFIENS - (required) Result array passed by reference
 ;
 ;  Output:
 ;   Function Value - Count of returned IENs
 ;         DGPFIENS - Output array subscripted by assignment history date
 ;
 N DGADT   ;assignment date
 N DGCNT   ;number of returned values
 N DGHIEN  ;single history IEN
 ;
 S DGCNT=0
 I $G(DGPFIEN)>0,$D(^DGPF(26.14,"C",DGPFIEN)) D
 . S DGADT=0
 . F  S DGADT=$O(^DGPF(26.14,"C",DGPFIEN,DGADT)) Q:'DGADT  D
 . . S DGHIEN=0
 . . F  S DGHIEN=$O(^DGPF(26.14,"C",DGPFIEN,DGADT,DGHIEN)) Q:'DGHIEN  D
 . . . S DGPFIENS(DGADT)=DGHIEN
 . . . S DGCNT=DGCNT+1
 Q DGCNT
 ;
GETHIST(DGPFIEN,DGPFAH) ;retrieve a single assignment history record
 ;
 ;  Input:
 ;   DGPFIEN - (required) IEN for record in PRF ASSIGNMENT HISTORY
 ;             (#26.14) file 
 ;    DGPFAH - (required) Result array passed by reference
 ;
 ;  Output:
 ;   Function Value - Return 1 on success, 0 on failure
 ;           DGPFAH - Output array containing the field values
 ;                    Subscript            Field#
 ;                    -----------------    ------
 ;                    "ASSIGN"             .01
 ;                    "ASSIGNDT"           .02
 ;                    "ACTION"             .03
 ;                    "ENTERBY"            .04
 ;                    "APPRVBY"            .05
 ;                    "TIULINK"            .06
 ;                    "COMMENT",line#,0    1
 ;
 N DGIENS  ;IEN string for DIQ
 N DGFLDS  ;results array for DIQ
 N DGERR  ;error array for DIQ
 N DGRSLT
 S DGRSLT=0
 I $G(DGPFIEN)>0,$D(^DGPF(26.14,DGPFIEN)) D
 . S DGIENS=DGPFIEN_","
 . D GETS^DIQ(26.14,DGIENS,"*","IEZ","DGFLDS","DGERR")
 . Q:$D(DGERR)
 . S DGRSLT=1
 . S DGPFAH("ASSIGN")=$G(DGFLDS(26.14,DGIENS,.01,"I"))_U_$G(DGFLDS(26.14,DGIENS,.01,"E"))
 . S DGPFAH("ASSIGNDT")=$G(DGFLDS(26.14,DGIENS,.02,"I"))_U_$G(DGFLDS(26.14,DGIENS,.02,"E"))
 . S DGPFAH("ACTION")=$G(DGFLDS(26.14,DGIENS,.03,"I"))_U_$G(DGFLDS(26.14,DGIENS,.03,"E"))
 . S DGPFAH("ENTERBY")=$G(DGFLDS(26.14,DGIENS,.04,"I"))_U_$G(DGFLDS(26.14,DGIENS,.04,"E"))
 . S DGPFAH("APPRVBY")=$G(DGFLDS(26.14,DGIENS,.05,"I"))_U_$G(DGFLDS(26.14,DGIENS,.05,"E"))
 . S DGPFAH("TIULINK")=$G(DGFLDS(26.14,DGIENS,.06,"I"))_U_$G(DGFLDS(26.14,DGIENS,.06,"E"))
 . ;build review comments word processing array
 . M DGPFAH("COMMENT")=DGFLDS(26.14,DGIENS,1)
 . K DGPFAH("COMMENT","E"),DGPFAH("COMMENT","I")
 . ;
 Q DGRSLT
 ;
GETFIRST(DGPFIEN) ;get IEN of the initial assignment
 ;This function returns the IEN of the initial history record for a
 ;given patient record flag assignment.
 ;
 ;  Input:
 ;   DGPFIEN - (required) IEN of record in PRF ASSIGNMENT (#26.13) file
 ;
 ;  Output:
 ;   Function Value - IEN of initial history record on success
 ;                    0 on failure
 ;
 N DGHIEN  ;history IEN
 N DGEDT   ;edit date
 N DGPFAH  ;history record data array
 ;
 S DGHIEN=0
 I $G(DGPFIEN)>0,$D(^DGPF(26.13,DGPFIEN)) D
 . S DGEDT=$O(^DGPF(26.14,"C",DGPFIEN,0))
 . I DGEDT>0 D
 . . S DGHIEN=$O(^DGPF(26.14,"C",DGPFIEN,DGEDT,0))
 Q $S($G(DGHIEN)>0:DGHIEN,1:0)
 ;
GETLAST(DGPFIEN) ;determine IEN of last assignment history record
 ;This function returns the IEN of the most recent history record for a
 ;given patient record flag assignment.
 ;
 ;  Input:
 ;   DGPFIEN - (required) IEN for record in PRF ASSIGNMENT (#26.13) file 
 ;
 ;  Output:
 ;   Function Value - IEN of last history record on success, 0 on failure
 ;
 N DGDAT
 N DGHIEN
 S DGHIEN=0
 I $G(DGPFIEN)>0,$D(^DGPF(26.13,DGPFIEN)) D
 . S DGDAT=$O(^DGPF(26.14,"C",DGPFIEN,""),-1)
 . I DGDAT>0 D
 . . S DGHIEN=$O(^DGPF(26.14,"C",DGPFIEN,DGDAT,0))
 Q $S($G(DGHIEN)>0:DGHIEN,1:0)
 ;
GETADT(DGPFIEN) ;get the initial assignment date
 ;This function returns the initial assignment date for a given patient
 ;record flag assignment.
 ;
 ;  Input:
 ;   DGPFIEN - (required) IEN for record in PRF ASSIGNMENT (#26.13) file
 ;
 ;  Output:
 ;   Function Value - assignment date in internal^external format on
 ;                    success, 0 on failure
 ;
 N DGHIEN  ;history IEN
 N DGEDT   ;edit date
 N DGADT   ;assignment date
 N DGPFAH  ;history record data array
 ;
 S DGADT=0
 S DGHIEN=0
 I $G(DGPFIEN)>0,$D(^DGPF(26.13,DGPFIEN)) D
 . S DGEDT=$O(^DGPF(26.14,"C",DGPFIEN,0))
 . I DGEDT>0 D
 . . S DGHIEN=$O(^DGPF(26.14,"C",DGPFIEN,DGEDT,0))
 . . I DGHIEN>0,$$GETHIST^DGPFAAH(DGHIEN,.DGPFAH) D
 . . . I $P($G(DGPFAH("ACTION")),U,2)="NEW ASSIGNMENT" D
 . . . . S DGADT=$G(DGPFAH("ASSIGNDT"))
 Q DGADT
 ;
FNDHIST(DGAIEN,DGADT) ;Find Assignment
 ;  This function finds a patient record flag assignment record.
 ;
 ;  Input:
 ;    DGAIEN - Pointer to assignment in the PRF ASSIGNMENT (#26.13) file
 ;     DGADT - Assignment date
 ;
 ;  Output:
 ;   Function Value - Returns IEN of existing record on success, 0 on
 ;                    failure
 ;
 N DGIEN
 ;
 I $G(DGAIEN)>0,($G(DGADT)>0) D
 . S DGIEN=$O(^DGPF(26.14,"C",DGAIEN,DGADT,0))
 Q $S($G(DGIEN)>0:DGIEN,1:0)
 ;
STOHIST(DGPFAH,DGPFERR) ;file a PRF ASSIGNMENT HISTORY (#26.14) file record
 ;
 ;  Input:
 ;    DGPFAH - (required) Array of values to be filed (see GETHIST tag
 ;             above for valid array structure)
 ;   DGPFERR - (optional) Passed by reference to contain error messages
 ;
 ;  Output:
 ;   Function Value - Returns IEN of record on success, 0 on failure
 ;          DGPFERR - Undefined on success, error message on failure
 ;
 N DGSUB
 N DGFLD
 N DGIEN
 N DGIENS
 N DGFDA
 N DGFDAIEN
 N DGERR
 F DGSUB="ASSIGN","ASSIGNDT","ACTION","ENTERBY","APPRVBY","TIULINK" D
 . S DGFLD(DGSUB)=$P($G(DGPFAH(DGSUB)),U)
 I $D(DGPFAH("COMMENT")) M DGFLD("COMMENT")=DGPFAH("COMMENT")
 I $$VALID^DGPFUT("DGPFAAH1",26.14,.DGFLD,.DGPFERR) D
 . S DGIEN=$$FNDHIST^DGPFAAH(DGFLD("ASSIGN"),DGFLD("ASSIGNDT"))
 . I DGIEN S DGIENS=DGIEN_","
 . E  S DGIENS="+1,"
 . S DGFDA(26.14,DGIENS,.01)=DGFLD("ASSIGN")
 . S DGFDA(26.14,DGIENS,.02)=DGFLD("ASSIGNDT")
 . S DGFDA(26.14,DGIENS,.03)=DGFLD("ACTION")
 . S DGFDA(26.14,DGIENS,.04)=DGFLD("ENTERBY")
 . S DGFDA(26.14,DGIENS,.05)=DGFLD("APPRVBY")
 . S DGFDA(26.14,DGIENS,.06)=DGFLD("TIULINK")
 . S DGFDA(26.14,DGIENS,1)="DGFLD(""COMMENT"")"
 . I DGIEN D
 . . D FILE^DIE("","DGFDA","DGERR")
 . . I $D(DGERR) S DGIEN=0
 . E  D
 . . D UPDATE^DIE("","DGFDA","DGFDAIEN","DGERR")
 . . I '$D(DGERR) S DGIEN=$G(DGFDAIEN(1))
 Q $S($G(DGIEN)>0:DGIEN,1:0)
