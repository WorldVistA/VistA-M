DGPFAPI2 ;ALB/RBS - PRF EXTERNAL API'S ; 6/7/05 4:44pm
 ;;5.3;Registration;**554,650**;Aug 13, 1993;Build 3
 ;
 Q  ;no direct entry
 ;
STOTIU(DGDFN,DGAIEN,DGHIEN,DGTIUIEN) ;store TIU Progress Note link
 ;This function is used to update the TIU PN LINK (#.06) field of
 ;the PRF ASSIGNMENT HISTORY (#26.14) file with the IEN of the
 ;TIU Progress Note in the TIU DOCUMENT (#8925) file.
 ;
 ; Associated DBIA:  #4384 - DGPF FILE/DELETE TIU PN LINK
 ;  Supported DBIA:  #4380 - $$CHKDOC^TIUPRF - TIU API's for PRF
 ;
 ;  Input:
 ;     DGDFN - [Required] IEN of PATIENT (#2) file
 ;    DGAIEN - [Required] IEN of PRF ASSIGNMENT (#26.13) file
 ;    DGHIEN - [Required] IEN of PRF ASSIGNMENT HISTORY (#26.14) file
 ;  DGTIUIEN - [Required] IEN of TIU DOCUMENT (#8925) file
 ;
 ;  Output:
 ;   Function result - returns 1 on success
 ;                   - returns two piece string on failure
 ;                      Format: 0^error text generated from EZBLD^DIALOG
 ;
 N DGDIALOG  ;failure reason generated from EZBLD^DIALOG
 N DGPFA     ;flag assignment array
 N DGPFAH    ;flag assignment history array
 N DGRSLT    ;function result
 ;
 S DGDFN=+$G(DGDFN)
 S DGAIEN=+$G(DGAIEN)
 S DGHIEN=+$G(DGHIEN)
 S DGTIUIEN=+$G(DGTIUIEN)
 ;
 S DGRSLT=0
 ;
 D  ;drops out on error condition
 . ;
 . I '$$CHKDOC^TIUPRF(DGTIUIEN) S DGDIALOG=$$EZBLD^DIALOG(261104) Q
 . ;
 . ;check if progress note already setup (x-ref "ATIUPN")
 . I $D(^DGPF(26.14,"ATIUPN",DGTIUIEN)) S DGDIALOG=$$EZBLD^DIALOG(261109) Q
 . ;
 . ;get history record that is being updated
 . I '$$GETHIST^DGPFAAH(DGHIEN,.DGPFAH) S DGDIALOG=$$EZBLD^DIALOG(261101) Q
 . ;
 . ;check if correct history record of the patient assignment
 . I $P($G(DGPFAH("ASSIGN")),U)'=DGAIEN S DGDIALOG=$$EZBLD^DIALOG(261101) Q
 . ;
 . ;check for existing entry
 . I +$P($G(DGPFAH("TIULINK")),U) S DGDIALOG=$$EZBLD^DIALOG(261109) Q
 . ;
 . ;get assignment record
 . I '$$GETASGN^DGPFAA(DGAIEN,.DGPFA) S DGDIALOG=$$EZBLD^DIALOG(261102) Q
 . ;
 . ;check if current site is Owner Site
 . I '$$ISDIV^DGPFUT($P(DGPFA("OWNER"),U)) S DGDIALOG=$$EZBLD^DIALOG(261103) Q
 . ;
 . ;file the TIU PN LINK
 . S DGRSLT=$$STOHIST(DGHIEN,DGTIUIEN)
 . I 'DGRSLT S DGDIALOG=$P($G(DGRSLT),"^",2) Q
 . ;
 . S DGRSLT=1
 ;
 Q $S(DGRSLT:1,1:DGRSLT_"^"_$G(DGDIALOG))
 ;
STOHIST(DGHIEN,DGTIUIEN) ;update TIU Progress Note link
 ;This function is used to update the TIU PN LINK (#.06) field of
 ;the PRF ASSIGNMENT HISTORY (#26.14) file.
 ;
 ;  Input:
 ;    DGHIEN - [Required] IEN of PRF ASSIGNMENT HISTORY (#26.14) file
 ;  DGTIUIEN - [Required] IEN of TIU DOCUMENT (#8925) file
 ;
 ;  Output:
 ;   Function result - returns 1 on success
 ;                   - returns two piece string on failure
 ;                      Format: 0^error text generated from EZBLD^DIALOG
 ;
 N DGDIALOG ;failure reason generated from EZBLD^DIALOG
 N DGERR    ;FILE^DIE error array (undefined on filing success)
 N DGFDA    ;FILE^DIE formatted array containing field ien and data
 N DGFIL    ;file number to file data
 N DGRSLT   ;function result
 ;
 S DGHIEN=+$G(DGHIEN)
 S DGTIUIEN=+$G(DGTIUIEN)
 ;
 S DGRSLT=0
 S DGFIL=26.14
 ;
 D  ;drops out on error condition
 . S DGFDA(DGFIL,DGHIEN_",",.06)=DGTIUIEN
 . D FILE^DIE("","DGFDA","DGERR")
 . I $D(DGERR) S DGDIALOG=$$EZBLD^DIALOG(261105) Q
 . ;
 . S DGRSLT=1
 ;
 Q $S(DGRSLT:1,1:DGRSLT_"^"_$G(DGDIALOG))
 ;
DELTIU(DGTIUIEN) ;delete TIU Progress Note link
 ;This function is used to delete the TIU PN LINK (#.06) field of
 ;the PRF ASSIGNMENT HISTORY (#26.14) file.
 ;
 ; Associated DBIA:  #4384 - DGPF FILE/DELETE TIU PN LINK
 ;  Supported DBIA:  #4380 - $$CHKDOC^TIUPRF - TIU API's for PRF
 ;
 ;  Input:
 ;  DGTIUIEN - [Required] IEN of record in TIU DOCUMENT (#8925) file
 ;
 ;  Output:
 ;   Function result - returns 1 on success
 ;                   - returns two piece string on failure
 ;                      Format: 0^error text generated from EZBLD^DIALOG
 ;
 N DGDIALOG ;failure reason generated from EZBLD^DIALOG
 N DGERR    ;FILE^DIE error array (undefined on filing success)
 N DGFDA    ;FILE^DIE formatted array containing field ien and data
 N DGFIL    ;file number to file data
 N DGHIEN   ;IEN of history record
 N DGRSLT   ;function result
 ;
 S DGTIUIEN=+$G(DGTIUIEN)
 S (DGRSLT,DGHIEN)=0
 S DGFIL=26.14
 ;
 D  ;drops out on error condition
 . ;
 . S DGHIEN=+$O(^DGPF(DGFIL,"ATIUPN",DGTIUIEN,DGHIEN))
 . I '$D(^DGPF(DGFIL,DGHIEN,0)) S DGDIALOG=$$EZBLD^DIALOG(261101) Q
 . S DGFDA(DGFIL,DGHIEN_",",.06)="@"
 . D FILE^DIE("","DGFDA","DGERR")
 . I $D(DGERR) S DGDIALOG=$$EZBLD^DIALOG(261106) Q
 . ;
 . S DGRSLT=1
 ;
 Q $S(DGRSLT:1,1:DGRSLT_"^"_$G(DGDIALOG))
