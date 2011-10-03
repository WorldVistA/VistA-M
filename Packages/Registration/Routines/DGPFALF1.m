DGPFALF1 ;ALB/KCL,RBS - PRF LOCAL FLAG API'S CONTINUED ; 4/20/04 12:02pm
 ;;5.3;Registration;**425,554**;Aug 13, 1993
 ;
 ;- no direct entry
 QUIT
 ;
STOALL(DGPFLF,DGPFLH,DGPFERR) ;File both LOCAL FLAG(#26.11) & HISTORY(#26.12)
 ;This function acts as a wrapper around the $$STOFLAG^DGPFALF
 ;and the $$STOHIST^DGPFALH filer calls.
 ;
 ;  Input:
 ;   DGPFLF - (required) array of Local Flag values to be filed
 ;            (see $$GETLF^DGPFALF for valid array structure)
 ;   DGPFLH - (required) array of Flag History values to be filed
 ;            (see $$GETHIST^DGPFALH for valid array structure)
 ;  DGPFERR - (optional) passed by reference to contain error messages
 ;
 ;  Output:
 ;   Function Value - Returns circumflex("^") delimited results of
 ;                    $$STOFLAG^DGPFALF and $$STOHIST^DGPFALH calls.
 ;                          Example:   "3^12"
 ;                    On Success - "IEN of (#26.11)^IEN of (#26.12)"
 ;                    On Failure - 0
 ;          DGPFERR - Undefined on success, error message on failure
 ;
 N DGOIEN    ;existing Local Flag file IEN used for "roll-back"
 N DGPFOLF   ;existing Local Flag data array used for "roll-back"
 N DGLIEN    ;Local Flag file IEN
 N DGLHIEN   ;Local Flag history file IEN
 N DGFLG     ;"FLAG" value
 ;
 S (DGLIEN,DGLHIEN)=0
 S DGFLG=$P($G(DGPFLF("FLAG")),U)
 S DGOIEN=$$FNDFLAG^DGPFALF(DGFLG)
 I 'DGOIEN!(DGOIEN&($$GETLF^DGPFALF(DGOIEN,.DGPFOLF))) D
 . S DGLIEN=$$STOFLAG^DGPFALF(.DGPFLF,.DGPFERR)
 . I $D(DGPFERR) S DGLIEN=0
 . I DGLIEN D
 . . S DGPFLH("FLAG")=DGLIEN
 . . S DGLHIEN=$$STOHIST^DGPFALH(.DGPFLH,.DGPFERR)
 . . I $D(DGPFERR) S DGLHIEN=0
 . . I DGLHIEN=0 D    ;roll back the Local Flag file setup
 . . . I 'DGOIEN,'$D(DGPFOLF) S DGPFOLF("FLAG")="@"
 . . . I $$ROLLBACK^DGPFALF1(26.11,DGLIEN,.DGPFOLF,"FLAG") S DGLIEN=0
 Q $S(DGLHIEN=0:0,1:DGLIEN_"^"_DGLHIEN)
 ;
ROLLBACK(DGFILE,DGFIEN,DGPFOA,DGKEY) ;Rollback a FILE record
 ;  Input:
 ;    DGFILE - File reference that will be used for rollback
 ;    DGFIEN - IEN of record to rollback in DGFILE
 ;    DGPFOA - Original array of data prior to record modification
 ;    DGKEY  - .01 Field Name reference to DELETE whole record
 ;  Output:
 ;    Function value - 1 on successful Rollback
 ;                     0 on failure
 ;
 N DGIENS,DGFDA,DGERR,DGRSLT
 S DGRSLT=0
 I $D(DGFILE),+$G(DGFIEN),$D(DGPFOA),$D(DGKEY) D
 . Q:'$D(^DGPF(DGFILE))
 . Q:'$D(^DGPF(DGFILE,DGFIEN))
 . S DGIENS=DGFIEN_","
 . I $G(DGPFOA(DGKEY))="@" D
 . . S DGFDA(DGFILE,DGIENS,.01)="@"
 . . D FILE^DIE("","DGFDA","DGERR")
 . . I '$D(DGERR) S DGRSLT=1
 . E  D
 . . I $$STOFLAG^DGPFALF(.DGPFOA,.DGERR),'$D(DGERR) S DGRSLT=1
 Q DGRSLT
 ;
LOCKLF(DGPFLIEN) ; Lock Flag ien
 ;  Input:
 ;   DGPFLIEN - IEN of record
 ;  Output:
 ;   Function Value - Returns 1 on success
 ;                            0 on failure
 L +^DGPF(26.11,DGPFLIEN):10 I '$T Q 0
 Q 1
 ;
UNLOCK(DGPFLIEN) ; Un-Lock Flag ien
 ;  Input:
 ;   DGPFLIEN - IEN of record
 ;  Output:
 ;   Function Value - Returns 1 on success
 ;                            0 on failure
 L -^DGPF(26.11,DGPFLIEN):2 I '$T Q 0
 Q 1
 ;
 ;
 ; PRF LOCAL FLAG FILE (#26.11) Field VALIDATION data
 ;  don't do the Principal Investigator(s) multiple fields...
 ;  they're pointers anyway and won't be Validated.
 ; PRININV;2;0;0;principal investigator(s) (if Research Flag)(pointer)
 ;
 ; *** Only Validate the following fields...
XREF ;;array node name;field#;required param;word processing?;description
 ;;FLAG;.01;1;0;flag name
 ;;STAT;.02;1;0;active/inactive
 ;;TYPE;.03;1;0;pointer to PRF TYPE FILE (#26.16)
 ;;REVFREQ;.04;1;0;review frequency
 ;;NOTIDAYS;.05;1;0;notification days
 ;;REVGRP;.06;0;0;pointer to MAIL GROUP FILE (#3.8)
 ;;TIUTITLE;.07;1;0;pointer to TIU DOCUMENT (#8925.1) file
 ;;DESC;1;1;1;description of flag
