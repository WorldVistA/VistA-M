DGPFANF ;ALB/KCL - PRF NATIONAL FLAG API'S ; 4/7/04 2:09pm
 ;;5.3;Registration;**425,554**;Aug 13, 1993
 ;
 ;- no direct entry
 QUIT
 ;
GETNF(DGPFIEN,DGPFNF) ;retrieve a single NATIONAL FLAG record
 ;This function returns a single flag record from the PRF NATIONAL FLAG
 ;file and returns it in an array format.
 ;
 ;  Input:
 ;   DGPFIEN - (required) pointer to national flag record in the
 ;             PRF NATIONAL FLAG (#26.15) file
 ;    DGPFNF - (required) result array passed by reference
 ;
 ; Output:
 ;   Function Value - returns 1 on success, 0 on failure
 ;           DGPFNF - output array containing national flag record field
 ;                    values.
 ;                    Subscript          Field#   Data
 ;                    --------------     -------  ---------------------
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
 I $G(DGPFIEN)>0,$D(^DGPF(26.15,DGPFIEN)) D
 . S DGIENS=DGPFIEN_","
 . D GETS^DIQ(26.15,DGIENS,"**","IEZ","DGFLDS","DGERR")
 . Q:$D(DGERR)
 . ;
 . ;-- build national flag array
 . S DGPFNF("FLAG")=$G(DGFLDS(26.15,DGIENS,.01,"I"))_U_$G(DGFLDS(26.15,DGIENS,.01,"E"))
 . S DGPFNF("STAT")=$G(DGFLDS(26.15,DGIENS,.02,"I"))_U_$G(DGFLDS(26.15,DGIENS,.02,"E"))
 . S DGPFNF("TYPE")=$G(DGFLDS(26.15,DGIENS,.03,"I"))_U_$G(DGFLDS(26.15,DGIENS,.03,"E"))
 . S DGPFNF("REVFREQ")=$G(DGFLDS(26.15,DGIENS,.04,"I"))_U_$G(DGFLDS(26.15,DGIENS,.04,"E"))
 . S DGPFNF("NOTIDAYS")=$G(DGFLDS(26.15,DGIENS,.05,"I"))_U_$G(DGFLDS(26.15,DGIENS,.05,"E"))
 . S DGPFNF("REVGRP")=$G(DGFLDS(26.15,DGIENS,.06,"I"))_U_$G(DGFLDS(26.15,DGIENS,.06,"E"))
 . S DGPFNF("TIUTITLE")=$G(DGFLDS(26.15,DGIENS,.07,"I"))_U_$G(DGFLDS(26.15,DGIENS,.07,"E"))
 . ;-- flag description word processing array
 . M DGPFNF("DESC")=DGFLDS(26.15,DGIENS,1)
 . K DGPFNF("DESC","E"),DGPFNF("DESC","I")
 . ;-- principal investigator(s) multiple
 . S DGSUB="" F  S DGSUB=$O(DGFLDS(26.152,DGSUB)) Q:DGSUB=""  D
 . . S DGPFNF("PRININV",+DGSUB,0)=$G(DGFLDS(26.152,DGSUB,.01,"I"))_U_$G(DGFLDS(26.152,DGSUB,.01,"E"))
 . ;
 . S RESULT=1
 ;
 Q RESULT
