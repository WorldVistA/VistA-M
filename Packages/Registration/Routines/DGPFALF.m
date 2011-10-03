DGPFALF ;ALB/KCL,RBS - PRF LOCAL FLAG API'S ; 4/8/04 4:03pm
 ;;5.3;Registration;**425,554**;Aug 13, 1993
 ;
 ;- no direct entry
 QUIT
 ;
GETLF(DGPFIEN,DGPFLF) ;retrieve a single PRF LOCAL FLAG (#26.11) record
 ;This function returns a single flag record from the PRF LOCAL FLAG
 ;file and returns it in an array format.
 ;
 ;  Input:
 ;   DGPFIEN - (required) pointer to local flag record in the
 ;             PRF LOCAL FLAG (#26.11) file
 ;    DGPFLF - (required) result array passed by reference
 ;
 ; Output:
 ;   Function Value - returns 1 on success, 0 on failure
 ;           DGPFLF - output array containing local flag record field
 ;                    values.
 ;                    Subscript          Field#   Data
 ;                    --------------     -------  -------------------
 ;                    "FLAG"              .01      internal^external
 ;                    "STAT"              .02      internal^external
 ;                    "TYPE"              .03      internal^external
 ;                    "REVFREQ"           .04      internal^external
 ;                    "NOTIDAYS"          .05      internal^external
 ;                    "REVGRP"            .06      internal^external
 ;                    "TIUTITLE"          .07      internal^external
 ;                    "DESC",line#,0      1        character string
 ;                    "PRININV",line#,0   2        character string
 ;
 N DGIENS  ;IEN string for DIQ
 N DGFLDS  ;results array for DIQ
 N DGERR   ;error arrary for DIQ
 N DGSUB   ;pincipal investigator multiple subscript
 N RESULT  ;return function value
 ;
 S RESULT=0
 ;
 I $G(DGPFIEN)>0,$D(^DGPF(26.11,DGPFIEN)) D
 . S DGIENS=DGPFIEN_","
 . D GETS^DIQ(26.11,DGIENS,"**","IEZ","DGFLDS","DGERR")
 . Q:$D(DGERR)
 . ;
 . ;-- build local flag array
 . S DGPFLF("FLAG")=$G(DGFLDS(26.11,DGIENS,.01,"I"))_U_$G(DGFLDS(26.11,DGIENS,.01,"E"))
 . S DGPFLF("STAT")=$G(DGFLDS(26.11,DGIENS,.02,"I"))_U_$G(DGFLDS(26.11,DGIENS,.02,"E"))
 . S DGPFLF("TYPE")=$G(DGFLDS(26.11,DGIENS,.03,"I"))_U_$G(DGFLDS(26.11,DGIENS,.03,"E"))
 . S DGPFLF("REVFREQ")=$G(DGFLDS(26.11,DGIENS,.04,"I"))_U_$G(DGFLDS(26.11,DGIENS,.04,"E"))
 . S DGPFLF("NOTIDAYS")=$G(DGFLDS(26.11,DGIENS,.05,"I"))_U_$G(DGFLDS(26.11,DGIENS,.05,"E"))
 . S DGPFLF("REVGRP")=$G(DGFLDS(26.11,DGIENS,.06,"I"))_U_$G(DGFLDS(26.11,DGIENS,.06,"E"))
 . S DGPFLF("TIUTITLE")=$G(DGFLDS(26.11,DGIENS,.07,"I"))_U_$G(DGFLDS(26.11,DGIENS,.07,"E"))
 . ;-- flag description word processing array
 . M DGPFLF("DESC")=DGFLDS(26.11,DGIENS,1)
 . K DGPFLF("DESC","E"),DGPFLF("DESC","I")
 . ;-- principal investigator(s) multiple
 . S DGSUB="" F  S DGSUB=$O(DGFLDS(26.112,DGSUB)) Q:DGSUB=""  D
 . . S DGPFLF("PRININV",+DGSUB,0)=$G(DGFLDS(26.112,DGSUB,.01,"I"))_U_$G(DGFLDS(26.112,DGSUB,.01,"E"))
 . ;
 . S RESULT=1
 ;
 Q RESULT
 ;
FNDFLAG(DGPFFLG) ;Find Flag Name IEN
 ;  This function finds a flag record IEN using the name field.
 ;  Input:
 ;   DGPFFLG - Flag Name field (.01) value
 ;
 ;  Output:
 ;   Function Value - Returns IEN of existing record on success, 0 on
 ;                    failure
 N DGIEN
 I $G(DGPFFLG)["" D
 . S DGIEN=$O(^DGPF(26.11,"B",DGPFFLG,0))
 ;
 Q $S($G(DGIEN)>0:DGIEN,1:0)
 ;
STOFLAG(DGPFLF,DGPFERR) ;store a single PRF LOCAL FLAG (#26.11) file record
 ;
 ;  Input:
 ;   DGPFLF - (required) array of values to be filed (see GETLF tag
 ;             above for valid array structure)
 ;  DGPFERR - (optional) passed by reference to contain error messages
 ;
 ;  Output:
 ;   Function Value - Returns IEN of record on success, 0 on failure
 ;          DGPFERR - Undefined on success, error message on failure
 ;
 N DGSUB,DGFLD,DGIEN,DGIENS,DGFDA,DGFDAIEN,DGERR
 ;
 F DGSUB="FLAG","STAT","TYPE","REVFREQ","NOTIDAYS","REVGRP","TIUTITLE" D
 . S DGFLD(DGSUB)=$P($G(DGPFLF(DGSUB)),U)
 I $D(DGPFLF("DESC")) M DGFLD("DESC")=DGPFLF("DESC")
 I $D(DGPFLF("PRININV")) M DGFLD("PRININV")=DGPFLF("PRININV")
 I $$VALID^DGPFUT("DGPFALF1",26.11,.DGFLD,.DGPFERR) D
 . ;
 . ;if name change lookup on original name, otherwise lookup on new name
 . S DGIEN=$$FNDFLAG^DGPFALF($S($G(DGPFLF("OLDFLAG"))]"":DGPFLF("OLDFLAG"),1:DGFLD("FLAG")))
 . ;the "?+" on an existing record will do LAYGO to lookup and add new
 . ; entries.  This was needed for adding another entry to the
 . ;  Principal Investigator(s) multiple (#26.112)
 . I DGIEN S DGIENS=DGIEN_","               ;EDIT existing record
 . E  S DGIENS="+1,"                        ;ADD new record
 . S DGFDA(26.11,DGIENS,.01)=DGFLD("FLAG")
 . S DGFDA(26.11,DGIENS,.02)=DGFLD("STAT")
 . S DGFDA(26.11,DGIENS,.03)=DGFLD("TYPE")
 . S DGFDA(26.11,DGIENS,.04)=DGFLD("REVFREQ")
 . S DGFDA(26.11,DGIENS,.05)=DGFLD("NOTIDAYS")
 . S DGFDA(26.11,DGIENS,.06)=DGFLD("REVGRP")
 . S DGFDA(26.11,DGIENS,.07)=DGFLD("TIUTITLE")
 . S DGFDA(26.11,DGIENS,1)="DGFLD(""DESC"")"
 . ;-- principal investigator(s) multiple
 . I $D(DGFLD("PRININV")) D PRININV(+DGIEN,.DGFDA)
 . ;
 . D UPDATE^DIE("","DGFDA","DGFDAIEN","DGERR")
 . I '$D(DGERR),'DGIEN S DGIEN=$G(DGFDAIEN(1))
 ;
 Q $S($G(DGIEN)>0:DGIEN,1:0)
 ;
PRININV(DGPFIEN,DGFDA) ; setup principal investigator(s) multiple (#26.112)
 ;  Input:
 ;   DGPFIEN - value will indicate to EDIT or ADD a New Record
 ;            IEN# = IEN of existing entry - Edit to existing Record
 ;               0 = Add New Record
 ;  DGFDA - array used by FileMan (passed by reference)
 ;
 ;  Output:
 ;   DGFDA array subscript entries for "PRININV"
 ;
 ; The DGFDA FDA_ROOT array needs the "?+" on an existing IEN so
 ;  that FileMan will do LAYGO to lookup and add new entires.
 ; This was needed for adding another entry to an existing
 ;  Principal Investigator(s) multiple (#26.112) field.
 ;
 S DGPFIEN=+$G(DGPFIEN)
 N DGSUB,DGIENS
 ;
 S DGSUB=0 F  S DGSUB=$O(DGFLD("PRININV",DGSUB)) Q:DGSUB=""  D
 . I DGPFIEN D                       ;existing record
 . . S DGIENS=DGSUB_","_DGPFIEN_","  ;delete
 . . Q:DGFLD("PRININV",DGSUB,0)="@"
 . . S DGIENS="?+"_DGIENS            ;non-delete uses LAYGO
 . E  S DGIENS="+"_(DGSUB+1)_",+1,"  ;new record
 . ;
 . S DGFDA(26.112,DGIENS,.01)=$P(DGFLD("PRININV",DGSUB,0),U)
 ;
 Q
