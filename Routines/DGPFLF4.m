DGPFLF4 ;ALB/RBS - PRF FLAG MANAGEMENT LM PROTOCOL ACTIONS CONT. ; 4/15/04 12:15pm
 ;;5.3;Registration;**425,554,650**;Aug 13, 1993 ;Build 3
 ;
 ;no direct entry
 QUIT
 ;
EF ;Entry point for DGPF EDIT FLAG action protocol.
 ;
 ;  Input: DGCAT - flag category (1=National, 2=Local)
 ;
 ; Output: Edit File entry in PRF LOCAL FLAG FILE (#26.11)
 ;         New File entry in PRF LOCAL FLAG HISTORY FILE (#26.12)
 ;         Set variable VALMBCK to 'R' = refresh screen
 ;
 N X,Y,DIRUT,DTOUT,DUOUT,DIROUT       ;input/output vars for ^DIR
 N DGIDXIEN ;ien of flag record from the "IDX" 
 N DGPFLF   ;array containing flag record field values
 N DGPFLH   ;array containing flag history record field values
 N DGPFORIG ;save original array containing flag record field values
 N DGABORT  ;abort flag
 N DGRESULT ;result of $$STOALL^DGPFALF1 api call
 N DGERR    ;if error returned
 N DGOK     ;ok flag to enter record flag entry & flag description
 N DGLOCK   ;lock var for flag file edit
 N DGSEL    ;user selection (list item)
 N VALMY    ;output of EN^VALM2 call, array of user selected entries
 N DGMSG    ;user message
 N DGQ,DGSUB ;counters and quit flag
 ;
 ;init vars
 S (DGABORT,DGLOCK,DGRESULT,DGQ,DGSUB)=0
 S DGOK=1,(DGSEL,DGIDXIEN)=""
 ;
 ;set screen to full scrolling region
 D FULL^VALM1
 W !
 ;
 ;check flag category (only Category II flags can be edited)
 I DGCAT=1 D
 . D BLD^DIALOG(261129,"Can not edit 'Category I' flags.","","DGERR","F")
 . D MSG^DIALOG("WE","","","","DGERR") W *7
 . D PAUSE^VALM1
 . S DGOK=0
 ;
 ;init flag record and history arrays
 ; The DGPFLF array will contain 2 "^" pieces (internal^external)
 ; for a final full screen display before filing.
 K DGPFLF,DGPFLH,DGPFORIG
 ;
 ;allow user to select a single flag for editing
 D:DGOK
 . S DGOK=0,VALMBCK=""
 . D EN^VALM2($G(XQORNOD(0)),"S")
 . Q:'$D(VALMY)
 . S DGSEL=$O(VALMY(""))
 . Q:DGSEL']""
 . Q:'$D(@VALMAR@("IDX",DGSEL))
 . S DGIDXIEN=$G(@VALMAR@("IDX",DGSEL))
 . ; lock flag record
 . S DGLOCK=$$LOCKLF^DGPFALF1(DGIDXIEN)
 . I 'DGLOCK D  Q
 . . X DGMSG
 . . W !?7,"Unable to Lock Flag, another User is Editing this Flag.",*7
 . . D PAUSE^VALM1
 . ;
 . ; call api to get record back in array DGPFLF
 . I '$$GETLF^DGPFALF($P(DGIDXIEN,";"),.DGPFLF) D  Q
 . . X DGMSG
 . . W !?7,"No Local Flag record data found.  Please check your selection.",*7
 . . D PAUSE^VALM1
 . ;
 . M DGPFORIG=DGPFLF  ;save original array to compare for edits later
 . S DGOK=1
 ;
 ;Call DGPFLF5 for user prompts to edit fields
 ;   - split from this one due to size
 I DGOK D
 . D EFCONT^DGPFLF5(.DGPFLF,.DGPFLH,.DGPFORIG,.DGABORT,DGIDXIEN)
 . Q:DGABORT
 . ;
 . ;check to see if user changed anything
 . S DGSUB="",DGQ=0
 . I $G(DGPFLF("OLDFLAG"))]""  S DGQ=1  ;flag name has changed
 . I 'DGQ D
 . . F DGSUB="STAT","TYPE","REVFREQ","NOTIDAYS","REVGRP","TIUTITLE" D  Q:DGQ
 . . . I DGPFLF(DGSUB)'=DGPFORIG(DGSUB) S DGQ=1
 . . Q:DGQ
 . . ;
 . . ;was description modified?
 . . I $O(DGPFLF("DESC",""),-1)'=$O(DGPFORIG("DESC",""),-1) S DGQ=1
 . . Q:DGQ
 . . ;
 . . S DGSUB=0
 . . F  S DGSUB=$O(DGPFLF("DESC",DGSUB)) Q:DGSUB=""  D  Q:DGQ
 . . . I DGPFLF("DESC",DGSUB,0)'=$G(DGPFORIG("DESC",DGSUB,0)) S DGQ=1
 . . Q:DGQ
 . . ;
 . . S DGSUB=0
 . . F  S DGSUB=$O(DGPFLF("PRININV",DGSUB)) Q:DGSUB=""  D  Q:DGQ
 . . . I DGPFLF("PRININV",DGSUB,0)'=$G(DGPFORIG("PRININV",DGSUB,0)) S DGQ=1
 . ;
 . I 'DGQ D  Q
 . . W !!,"   >>> No edits to "_$P(DGPFLF("FLAG"),U,2)_" were found."
 . . S DGABORT=1
 . ;
 . K DGPFORIG  ;kill array - no longer needed
 . ;
 . ;re-display user's answers on full screen
 . D REVIEW^DGPFUT3(.DGPFLF,.DGPFLH,"",XQY0,XQORNOD(0))
 . ;
 . ;file the edits
 . W !,*7
 . I $$ANSWER^DGPFUT("Would you like to file the local record flag changes","YES","Y")'>0 S DGABORT=1 Q
 . ;
 . W !,"Updating the local record flag..."
 . ;
 . ;setup remaining flag history array nodes for filing
 . ;note, the DGPFLH("FLAG") will be setup in $$STOALL^DGPFALF1
 . S DGPFLH("ENTERDT")=$$NOW^XLFDT()   ;current date/time
 . S DGPFLH("ENTERBY")=DUZ             ;current user
 . ;
 . ;file both the (#26.11) & (#26.12) entries
 . S DGRESULT=$$STOALL^DGPFALF1(.DGPFLF,.DGPFLH,.DGERR)
 . ;
 . W !!,"   >>> Local record flag was "_$S(+DGRESULT:"filed successfully.",1:"not filed successfully."),*7
 . ;
 . D PAUSE^VALM1
 ;
 I DGLOCK,$$UNLOCK^DGPFALF1(DGIDXIEN)
 ;
 I DGABORT D
 . W !!,"   >>> The '"_$P($G(XQORNOD(0)),U,3)_"' action is aborting, nothing has been filed.",*7
 . I $$ANSWER^DGPFUT("Enter RETURN to continue","","E")  ;pause
 ;
 ;re-build list of local record flags
 D BLD^DGPFLF
 ;
 ;return to LM (refresh screen)
 S VALMBCK="R"
 Q
 ;
