DGPFLMA1 ;ALB/KCL - PRF ASSIGNMENT LM PROTOCOL ACTIONS ; 6/10/03 3:57pm
 ;;5.3;Registration;**425**;Aug 13, 1993 
 ;
 ;no direct entry
 QUIT
 ;
SP ;Entry point for DGPF SELECT PATIENT action protocol.
 ;
 ;  Input: None
 ;
 ; Output:
 ;     DGDFN - pointer to patient in PATIENT #2 file
 ;   VALMBCK - 'R' = refresh screen
 ;
 N DGPAT ;patient lookup array
 ;
 ;set screen to full scrolling region
 D FULL^VALM1
 ;
 ;patient selection (lookup)
 D SELPAT^DGPFUT1(.DGPAT)
 I (+$G(DGPAT)>0) D
 . S DGDFN=+DGPAT
 . ;
 . Q:'$$CONTINUE^DGPFUT()
 . ;
 . ;- build header for selected patient
 . D BLDHDR^DGPFLMU(DGDFN,.VALMHDR)
 . ;
 . ;- build list of flag assignments for selected patient
 . D BLDLIST^DGPFLMU(DGDFN)
 ;
 ;return to LM (refresh screen)
 S VALMBCK="R"
 Q
 ;
 ;
DF ;Entry point for DGPF DISPLAY ASSIGNMENT DETAIL action protocol.
 ;
 ; Input: None
 ;
 ; Output:
 ;   VALMBCK - 'R' = refresh screen
 ;
 N DGDFN  ;patient dfn
 N DGIEN  ;assignment ien
 N SEL    ;user selection
 N VALMY  ;output of EN^VALM2 call, array of user selected entries
 ;
 ;set screen to full scroll region
 D FULL^VALM1
 ;
 ;is action selection allowed?
 I '$D(@VALMAR@("IDX")) D  Q
 . W !!?2,">>> '"_$P($G(XQORNOD(0)),U,3)_"' action not allowed at this point.",*7
 . I '$G(DGDFN) W !?6,"A patient has not been selected."
 . E  W !?6,"There are no record flag assignments for this patient."
 . D PAUSE^VALM1
 . S VALMBCK="R"
 ;
 ;ask user to select a single assignment for detail display
 S (SEL,DGIEN,VALMBCK)=""
 D EN^VALM2($G(XQORNOD(0)),"S")
 ;
 ;process user selection
 S SEL=$O(VALMY(""))
 I SEL,$D(@VALMAR@("IDX",SEL,SEL)) D
 . S DGIEN=$P($G(@VALMAR@("IDX",SEL,SEL)),U)
 . S DGDFN=$P($G(@VALMAR@("IDX",SEL,SEL)),U,2)
 . ;-display flag assignment details
 . N VALMHDR
 . D EN^DGPFLMAD
 ;
 ;return to LM (refresh screen)
 S VALMBCK="R"
 Q
