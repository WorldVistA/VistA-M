DGPFLF2 ;ALB/KCL - PRF FLAG MANAGEMENT LM PROTOCOL ACTIONS ; 3/18/03
 ;;5.3;Registration;**425**;Aug 13, 1993 
 ;
 ;no direct entry
 QUIT
 ;
 ;
SL ;Entry point for DGPF SORT FLAG LIST action protocol.
 ;
 ;  Input:
 ;   DGSRTBY - flag list sort by criteria (N=Flag Name, T=Flage Type)
 ;
 ; Output:
 ;   DGSRTBY - flag list sort by criteria (N=Flag Name, T=Flage Type)
 ;   VALMBCK - 'R' = refresh screen
 ;
 N DGCODE,DGFG
 ;
 ;set screen to full scrolling region
 D FULL^VALM1
 ;
 D
 . ;- prompt for sort criteria
 . W !
 . S DGFG=DGSRTBY  ;save original sort to default to
 . S DGCODE="Y"    ;DIC(0)="Y" for Yes/No answering
 . S DGSRTBY=$$ANSWER^DGPFUT("Would you like to sort the list by '"_$S($G(DGFG)="N":"Flag Type",1:"Flag Name")_"'","Yes",DGCODE)
 . I $G(DGSRTBY)'=1 S DGSRTBY=DGFG Q      ;no sort change
 . S DGSRTBY=$S($G(DGFG)="N":"T",1:"N")  ;change sort (flip / flop)
 . ;
 . ;- re-build list for selected sort criteria
 . D BLD^DGPFLF
 ;
 ;return to LM (refresh screen)
 S VALMBCK="R"
 Q
 ;
 ;
CC ;Entry point for DGPF CHANGE CATEGORY action protocol.
 ;
 ;  Input:
 ;   DGCAT - flag category (1=National, 2=Local)
 ;
 ; Output:
 ;    DGCAT - flag category (1=National, 2=Local)
 ;  VALMBCK - 'R' = refresh screen
 ;
 N DGCODE
 N DGFG
 ;
 ;set screen to full scrolling region
 D FULL^VALM1
 ;
 ;change category
 S DGCAT=$S($G(DGCAT)=1:2,1:1)
 ;
 ;re-build list for category change
 D BLD^DGPFLF
 ;
 ;return to LM (refresh screen)
 S VALMBCK="R"
 Q
 ;
 ;
DF ;Entry point for DGPF DISPLAY FLAG DETAIL action protocol.
 ;
 ; Input:
 ;
 ; Output:
 ;   VALMBCK - 'R' = refresh screen
 ;
 N SEL     ;user selection
 N VALMY   ;output of EN^VALM2 call, array of user selected entries
 N DGPFIEN ;IEN of record in PRF NATIONAL FLAG or PRF LOCAL FLAG file
 ;          [ex: "1;DGPF(26.15,"]
 ;
 ;set screen to full scroll region
 D FULL^VALM1
 ;
 ;is action selection allowed?
 I '$D(@VALMAR@("IDX")) D  Q
 . W !!?2,">>> '"_$P($G(XQORNOD(0)),U,3)_"' action not allowed at this point.",*7
 . W !?6,"There are no record flags to display."
 . D PAUSE^VALM1
 . S VALMBCK="R"
 ;
 ;ask user to select a single flag for displaying details
 S (SEL,DGPFIEN,VALMBCK)=""
 D EN^VALM2($G(XQORNOD(0)),"S")
 ;
 ;process user selection
 S SEL=$O(VALMY(""))
 I SEL,$D(@VALMAR@("IDX",SEL)) D
 . S DGPFIEN=$P($G(@VALMAR@("IDX",SEL)),U)
 . ;- display flag details
 . N VALMHDR
 . D EN^DGPFLFD
 ;
 ;return to LM (refresh screen)
 S VALMBCK="R"
 Q
