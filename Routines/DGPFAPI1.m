DGPFAPI1 ;ALB/RBS - PRF EXTERNAL API'S ; 9/27/06 3:00pm
 ;;5.3;Registration;**554,650**;Aug 13, 1993;Build 3
 ;
 Q  ;no direct entry
 ;
GETHTIU(DGDFN,DGTITLE,DGHTIU) ;retrieve PRF/TIU PN link Assignment data
 ;This function is used to return a patient's ASSIGNMENT (active or
 ;inactive) based on the TIU PN title.  If an ASSIGNMENT is found
 ;then all ASSIGNMENT HISTORY records will be returned.
 ;If the request is not from the Owner Site of the PRF Assignment,
 ;no data is returned.
 ;The TIU Progress Note Title IEN will be used to search for the
 ;patient assignment that is linked to the associated record flag.
 ;
 ;  Associated DBIA:  #4383 - DGPF ASSIGNMENT LINK TIU PN
 ;
 ;  Input:
 ;     DGDFN - [Required] IEN of PATIENT (#2) file
 ;   DGTITLE - [Required] IEN of TIU DOCUMENT DEFINITION (#8925.1) file
 ;    DGHTIU - [Optional] - default name is "DGPFHTIU"
 ;             (Closed Root (local or global) array of return values)
 ;
 ;  Output:
 ;   Function result - returns 1 on success
 ;                   - returns two piece string on failure
 ;                      Format: 0^error text generated from EZBLD^DIALOG
 ;
 ;    DGHTIU() - Array, passed by closed root reference.
 ;               If this function is successful, this array will
 ;               contain the PRF/TIU PN link Assignment data where
 ;               the Subscript field value equals:
 ;                   Internal Value^External Value
 ;               Note: The "HISTORY" subscript level will contain a
 ;               unique node for each PRF Assignment History record
 ;               associated with the Assignment where nn = a unique
 ;               number for each History record.
 ;
 ; Subscript                 Field Name      Field #/File #
 ; -----------------------   -----------     ------------
 ; "ASSIGNIEN"               NUMBER          (.001)/(#26.13)
 ; "FLAG"                    FLAG NAME       (.02)/(#26.13)
 ; "HISTORY"                 # OF HISTORY RECORDS    N/A
 ; "HISTORY",nn,"ACTION"     ACTION          (.03)/(#26.14)
 ; "HISTORY",nn,"DATETIME")  DATE/TIME       (.02)/(#26.14)
 ; "HISTORY",nn,"HISTIEN")   NUMBER          (.001)/(#26.14)
 ; "HISTORY",nn,"TIUIEN")    TIU PN LINK     (.06)/(#26.14)
 ;
 N DGAIEN    ;ien of record flag assignment in (#26.13) file
 N DGDIALOG  ;failure reason generated from EZBLD^DIALOG
 N DGFIEN    ;variable pointer to #26.11 or #26.15 ie. "1;DGPF(26.15,"
 N DGFLAG    ;flag name
 N DGHIEN    ;ien of history record in (#26.14) file
 N DGHIENS   ;array of all assignment history IEN's
 N DGPFA     ;flag assignment array
 N DGPFAH    ;flag assignment history array
 N DGRSLT    ;function result
 N DGTHCNT   ;"nn"=number of history records returned
 ;
 S DGDFN=+$G(DGDFN)
 S DGTITLE=+$G(DGTITLE)
 ;
 ;setup return array
 S DGHTIU=$G(DGHTIU)
 I DGHTIU']"" S DGHTIU="DGPFHTIU"       ;setup default array name
 K @DGHTIU                              ;Kill/initialize work array
 ;
 S DGRSLT=0
 ;
 ;get IEN variable pointer of National or Local flag
 S DGFIEN=$P($$FNDTITLE(DGTITLE),U,1)  ;strip off flag name
 ;
 I '$G(DGFIEN) S DGDIALOG=$$EZBLD^DIALOG(261107)  ;no flag link
 ;
 ;if flag is assoc with TIU Progres Note Title (quit on failure)
 I $G(DGFIEN) D
 . ;
 . ;get IEN of assignment linked to flag linked to TIU PN Title
 . S DGAIEN=$$FNDASGN^DGPFAA(DGDFN,DGFIEN)
 . I '$G(DGAIEN) S DGDIALOG=$$EZBLD^DIALOG(261108) Q
 . ;
 . ;get all assignment data for patient
 . I '$$GETASGN^DGPFAA(DGAIEN,.DGPFA) S DGDIALOG=$$EZBLD^DIALOG(261102) Q
 . ;
 . ;check for owner site of assignment
 . I '$$ISDIV^DGPFUT($P(DGPFA("OWNER"),U)) S DGDIALOG=$$EZBLD^DIALOG(261103) Q
 . ;
 . ;get all history ien's
 . I '$$GETALL^DGPFAAH(DGAIEN,.DGHIENS) S DGDIALOG=$$EZBLD^DIALOG(261101) Q
 . ;
 . S DGHIEN="",DGTHCNT=0
 . ;
 . ;loop all assignment history ien's
 . F  S DGHIEN=$O(DGHIENS(DGHIEN)) Q:DGHIEN=""  D  Q:$D(DGDIALOG)
 . . K DGPFAH
 . . ;get assignment history record
 . . I '$$GETHIST^DGPFAAH(DGHIEN,.DGPFAH) S DGDIALOG=$$EZBLD^DIALOG(261101),DGTHCNT=0 Q
 . . ;
 . . S DGTHCNT=DGTHCNT+1
 . . S @DGHTIU@("HISTORY",DGTHCNT,"ACTION")=$G(DGPFAH("ACTION"))
 . . S @DGHTIU@("HISTORY",DGTHCNT,"DATETIME")=$G(DGPFAH("ASSIGNDT"))
 . . S @DGHTIU@("HISTORY",DGTHCNT,"HISTIEN")=DGHIEN_U_DGHIEN
 . . S @DGHTIU@("HISTORY",DGTHCNT,"TIUIEN")=$G(DGPFAH("TIULINK"))
 . ;
 . Q:$D(DGDIALOG)  ;stop on error
 . ;
 . I DGTHCNT D
 . . S @DGHTIU@("ASSIGNIEN")=DGAIEN_U_$P($G(DGPFA("DFN")),U,2)
 . . S @DGHTIU@("FLAG")=$G(DGPFA("FLAG"))
 . . S @DGHTIU@("HISTORY")=DGTHCNT
 . ;
 . S DGRSLT=1  ;success
 ;
 ;if failure delete return array
 I $D(DGDIALOG) K @DGHTIU
 ;
 Q $S(DGRSLT:1,1:DGRSLT_"^"_$G(DGDIALOG))
 ;
FNDTITLE(DGTITLE) ;retrieve IEN of associated PRF (National or Local) Flag
 ;This function returns the IEN and Name of the National or Local flag
 ;that is associated with the TIU Progress Note Title.
 ;
 ;  Input:
 ;   DGTITLE - [Required] IEN of TIU DOCUMENT DEFINITION (#8925.1) file
 ;
 ;  Output:
 ;   Function Value - returns two piece ^ string on failure or success
 ;                  On Failure - 0^error text generated from EZBLD^DIALOG
 ;                  On Success - IEN^External Flag Name
 ;                    [example:  1;DGPF(26.15,^BEHAVIORAL]
 ;                    [Note:    "1;DGPF(26.15," is a variable pointer]
 ;
 S DGTITLE=+$G(DGTITLE)
 ;
 N DGDIALOG ;failure reason
 N DGFLAG   ;flag name
 N DGIEN    ;ien of flag
 ;
 ; search for Local Flag
 I $D(^DGPF(26.11,"ATIU",DGTITLE)) D
 . S DGFLAG=$O(^DGPF(26.11,"ATIU",DGTITLE,""))
 . I DGFLAG]"" D
 . . S DGIEN=$O(^DGPF(26.11,"ATIU",DGTITLE,DGFLAG,0))
 . . I '$D(^DGPF(26.11,DGIEN,0)) K DGIEN Q
 . . S:$G(DGIEN) DGIEN=DGIEN_";DGPF(26.11,^"_DGFLAG  ;add flag name
 ;
 ; search for National Flag - (if Title not found in Local Flag file)
 I '$G(DGIEN),$D(^DGPF(26.15,"ATIU",DGTITLE)) D
 . S DGFLAG=$O(^DGPF(26.15,"ATIU",DGTITLE,""))
 . I DGFLAG]"" D
 . . S DGIEN=$O(^DGPF(26.15,"ATIU",DGTITLE,DGFLAG,0))
 . . I '$D(^DGPF(26.15,DGIEN,0)) K DGIEN Q
 . . S:$G(DGIEN) DGIEN=DGIEN_";DGPF(26.15,^"_DGFLAG  ;add flag name
 ;
 I '$G(DGIEN) S DGDIALOG=$$EZBLD^DIALOG(261107)
 ;
 Q $S($G(DGIEN)>0:DGIEN,1:"0^"_$G(DGDIALOG))
 ;
GETLINK(DGTIUIEN) ;get linked assignment history ien
 ;This function returns the IEN of a patient's record flag assignment
 ;history record that is linked to a specific TIU Progress Note.
 ;
 ; Associated DBIA:  #4383 - DGPF ASSIGNMENT LINK TIU PN
 ;
 ;  Input:
 ;   DGTIUIEN - [Required] IEN of TIU DOCUMENT (#8925) file
 ;
 ;  Output:
 ;   Function result - returns IEN of linked history record on success
 ;                   - "0" if no link found
 ;
 Q +$O(^DGPF(26.14,"ATIUPN",+$G(DGTIUIEN),0))
