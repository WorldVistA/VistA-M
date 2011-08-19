DGPFAA ;ALB/RPM - PRF ASSIGNMENT API'S ; 3/27/03
 ;;5.3;Registration;**425**;Aug 13, 1993
 ;
 Q  ;no direct entry
 ;
GETALL(DGDFN,DGIENS,DGSTAT,DGCAT) ;retrieve list of assignment IENs
 ;This function returns an array of patient record flag assignment IENs
 ;for a given patient.  The returned IEN array may optionally be
 ;filtered by Active or Inactive status and by flag category.
 ;
 ;  Input:
 ;    DGDFN - (required) Pointer to patient in PATIENT (#2) file
 ;   DGIENS - (required) Result array passed by reference
 ;   DGSTAT - (optional) Status filter (0:Inactive,1:Active,"":Both).
 ;            Defaults to Both.
 ;    DGCAT - (optional) Category filter
 ;            (1:Category I,2:Category II,"":Both).  Defaults to Both.
 ;
 ;  Output:
 ;   Function Value - Count of returned IENs
 ;         DGIENS - Output array subscripted by the assignment IENs
 ;
 N DGCNT   ;number of returned values
 N DGIEN   ;single IEN
 N DGCKS   ;check status flag (1:check, 0:ignore)
 N DGFLAG  ;pointer to #26.11 or #26.15
 ;
 S DGCNT=0
 I $G(DGDFN)>0,$D(^DGPF(26.13,"B",DGDFN)) D
 . S DGFLAG=""
 . S DGCKS=0
 . S DGSTAT=$G(DGSTAT)
 . I DGSTAT=0!(DGSTAT=1) S DGCKS=1
 . S DGCAT=+$G(DGCAT)
 . S DGCAT=$S(DGCAT=1:"26.15",DGCAT=2:"26.11",1:0)
 . F  S DGFLAG=$O(^DGPF(26.13,"C",DGDFN,DGFLAG)) Q:(DGFLAG="")  D
 . . I DGCAT,DGFLAG'[DGCAT Q
 . . S DGIEN=$O(^DGPF(26.13,"C",DGDFN,DGFLAG,0))
 . . I DGCKS,'$D(^DGPF(26.13,"D",DGDFN,DGSTAT,DGIEN)) Q
 . . S DGCNT=DGCNT+1
 . . S DGIENS(DGIEN)=""
 Q DGCNT
 ;
GETASGN(DGPFIEN,DGPFA) ;retrieve a single assignment record
 ;This function returns a single patient record flag assignment in an
 ;array format.
 ;
 ;  Input:
 ;    DGPFIEN - (required) Pointer to patient record flag assignment in
 ;              PRF ASSIGNMENT (#26.13) file
 ;      DGPFA - (required) Result array passed by reference
 ;
 ;  Output:
 ;   Function Value - Returns 1 on success, 0 on failure
 ;            DGPFA - Output array containing assignment record field
 ;                    values.
 ;                    Subscript          Field#   Data
 ;                    --------------     -------  ---------------------
 ;                    "DFN"              .01      internal^external
 ;                    "FLAG"             .02      internal^external
 ;                    "STATUS"           .03      internal^external
 ;                    "OWNER"            .04      internal^external
 ;                    "ORIGSITE"         .05      internal^external
 ;                    "REVIEWDT"         .06      internal^external
 ;                    "NARR",line#,0     1        character string
 ;
 N DGIENS   ;IEN string for DIQ
 N DGFLDS   ;results array for DIQ
 N DGERR  ;error arrary for DIQ
 N DGRSLT
 ;
 S DGRSLT=0
 I $G(DGPFIEN)>0,$D(^DGPF(26.13,DGPFIEN)) D
 . S DGIENS=DGPFIEN_","
 . D GETS^DIQ(26.13,DGIENS,"*","IEZ","DGFLDS","DGERR")
 . Q:$D(DGERR)
 . S DGRSLT=1
 . S DGPFA("DFN")=$G(DGFLDS(26.13,DGIENS,.01,"I"))_U_$G(DGFLDS(26.13,DGIENS,.01,"E"))
 . S DGPFA("FLAG")=$G(DGFLDS(26.13,DGIENS,.02,"I"))_U_$G(DGFLDS(26.13,DGIENS,.02,"E"))
 . S DGPFA("STATUS")=$G(DGFLDS(26.13,DGIENS,.03,"I"))_U_$G(DGFLDS(26.13,DGIENS,.03,"E"))
 . S DGPFA("OWNER")=$G(DGFLDS(26.13,DGIENS,.04,"I"))_U_$G(DGFLDS(26.13,DGIENS,.04,"E"))
 . S DGPFA("ORIGSITE")=$G(DGFLDS(26.13,DGIENS,.05,"I"))_U_$G(DGFLDS(26.13,DGIENS,.05,"E"))
 . S DGPFA("REVIEWDT")=$G(DGFLDS(26.13,DGIENS,.06,"I"))_U_$G(DGFLDS(26.13,DGIENS,.06,"E"))
 . ;build assignment narrative word processing array
 . M DGPFA("NARR")=DGFLDS(26.13,DGIENS,1)
 . K DGPFA("NARR","E"),DGPFA("NARR","I")
 Q DGRSLT
 ;
FNDASGN(DGPFDFN,DGPFFLG) ;Find Assignment
 ;  This function finds a patient record flag assignment record.
 ;
 ;  Input:
 ;    DGDFN - Pointer to patient in the PATIENT (#2) file
 ;   DGFLAG - Pointer to flag in either the PRF LOCAL FLAG (#26.11)
 ;            file or the PRF NATIONAL FLAG (#26.15) file
 ;
 ;  Output:
 ;   Function Value - Returns IEN of existing record on success, 0 on
 ;                    failure
 ;
 N DGIEN
 ;
 I $G(DGPFDFN)>0,($G(DGPFFLG)>0) D
 . S DGIEN=$O(^DGPF(26.13,"C",DGPFDFN,DGPFFLG,0))
 Q $S($G(DGIEN)>0:DGIEN,1:0)
 ;
STOASGN(DGPFA,DGPFERR) ;store a single PRF ASSIGNMENT (#26.13) file record
 ;
 ;  Input:
 ;    DGPFA - (required) array of values to be filed (see GETASGN tag
 ;            above for valid array structure)
 ;  DGPFERR - (optional) passed by reference to contain error messages
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
 F DGSUB="DFN","FLAG","STATUS","OWNER","ORIGSITE" D
 . S DGFLD(DGSUB)=$P($G(DGPFA(DGSUB)),U,1)
 ;
 ;only build DGFLD("REVIEWDT") if "REVIEWDT" is passed
 I $D(DGPFA("REVIEWDT"))=1 S DGFLD("REVIEWDT")=$P(DGPFA("REVIEWDT"),U,1)
 ;
 I $D(DGPFA("NARR")) M DGFLD("NARR")=DGPFA("NARR")
 I $$VALID^DGPFUT("DGPFAA1",26.13,.DGFLD,.DGPFERR) D
 . S DGIEN=$$FNDASGN^DGPFAA(DGFLD("DFN"),DGFLD("FLAG"))
 . I DGIEN S DGIENS=DGIEN_","
 . E  S DGIENS="+1,"
 . S DGFDA(26.13,DGIENS,.01)=DGFLD("DFN")
 . S DGFDA(26.13,DGIENS,.02)=DGFLD("FLAG")
 . S DGFDA(26.13,DGIENS,.03)=DGFLD("STATUS")
 . S DGFDA(26.13,DGIENS,.04)=DGFLD("OWNER")
 . S DGFDA(26.13,DGIENS,.05)=DGFLD("ORIGSITE")
 . ;
 . ;only touch REVIEW DATE (#.06) field if "REVIEWDT" is passed
 . I $D(DGFLD("REVIEWDT")) S DGFDA(26.13,DGIENS,.06)=DGFLD("REVIEWDT")
 . ;
 . S DGFDA(26.13,DGIENS,1)="DGFLD(""NARR"")"
 . I DGIEN D
 . . D FILE^DIE("","DGFDA","DGERR")
 . . I $D(DGERR) S DGIEN=0
 . E  D
 . . D UPDATE^DIE("","DGFDA","DGFDAIEN","DGERR")
 . . I '$D(DGERR) S DGIEN=$G(DGFDAIEN(1))
 Q $S($G(DGIEN)>0:DGIEN,1:0)
 ;
STOALL(DGPFA,DGPFAH,DGPFERR) ;store both the assignment and history record
 ;This function acts as a wrapper around the $$STOASGN and $$STOHIST
 ;filer calls.
 ;
 ;  Input:
 ;    DGPFA - (required) array of assignment values to be filed (see
 ;            $$GETASGN^DGPFAA for valid array structure)
 ;   DGPFAH - (required) array of assignment history values to be filed
 ;            (see $$STOHIST^DGPFAAH for valid array structure)
 ;  DGPFERR - (optional) passed by reference to contain error messages
 ;
 ;  Output:
 ;   Function Value - Returns circumflex("^") delimited results of
 ;                    $$STOASGN^DGPFAA and $$STOHIST^DGPFAAH calls
 ;          DGPFERR - Undefined on success, error message on failure
 ;
 N DGOIEN    ;existing assignment file IEN used for "roll-back"
 N DGPFOA    ;existing assignment data array used for "roll-back"
 N DGAIEN    ;assignment file IEN
 N DGAHIEN   ;assignment history file IEN
 N DGDFN     ;"DFN" value
 N DGFLG     ;"FLAG" value
 ;
 S (DGAIEN,DGAHIEN)=0
 S DGDFN=$P($G(DGPFA("DFN")),U,1)
 S DGFLG=$P($G(DGPFA("FLAG")),U,1)
 S DGOIEN=$$FNDASGN^DGPFAA(DGDFN,DGFLG)
 D   ;drops out of block if can't rollback or assignment filer fails
 . I DGOIEN,'$$GETASGN^DGPFAA(DGOIEN,.DGPFOA) Q  ;can't rollback, so quit
 . ;
 . ;store the assignment
 . S DGAIEN=$$STOASGN^DGPFAA(.DGPFA,.DGPFERR)
 . I $D(DGPFERR) S DGAIEN=0
 . Q:'DGAIEN  ;assignment filer failed, so quit
 . ;
 . ;store the assignment history
 . S DGPFAH("ASSIGN")=DGAIEN
 . S DGAHIEN=$$STOHIST^DGPFAAH(.DGPFAH,.DGPFERR)
 . I $D(DGPFERR) S DGAHIEN=0
 . I DGAHIEN=0 D    ;history filer failed, so rollback the assignment 
 . . I 'DGOIEN,'$D(DGPFOA) S DGPFOA("DFN")="@"
 . . I $$ROLLBACK^DGPFAA2(DGAIEN,.DGPFOA) S DGAIEN=0
 Q $S(+$G(DGAHIEN)=0:0,1:DGAIEN_"^"_DGAHIEN)
