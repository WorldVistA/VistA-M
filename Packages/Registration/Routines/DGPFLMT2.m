DGPFLMT2 ;ALB/RBS - PRF TRANSMISSION ERRORS LM PROTOCOL ACTIONS ; 6/24/05 12:20pm
 ;;5.3;Registration;**650**;Aug 13, 1993;Build 3
 ;
 ;no direct entry
 QUIT
 ;
 ;
SL ;Entry point for DGPF TRANSMIT SORT LIST action protocol.
 ;
 ;The following Input variable is a 'system wide variable' in the
 ;DGPF TRANSMISSION ERRORS List Manager screen:
 ;
 ;   Input:
 ;       DGSRTBY - list sort by criteria
 ;                 "N" = Patient Name
 ;                 "D" = Date/Time Error Received
 ;  Output:
 ;       DGSRTBY - list sort by criteria
 ;       VALMBCK - 'R' = refresh screen
 ;
 ;is action selection allowed?
 I '$D(@VALMAR@("IDX")) D  Q
 . W !
 . D BLD^DIALOG(261129," There are no transmission error records to display.","","DGERR","F")
 . D MSG^DIALOG("WE","","","","DGERR") W *7
 . D WAIT^VALM1
 . S VALMBCK="R"
 ;
 ;change sort (flip / flop)
 S DGSRTBY=$S($G(DGSRTBY)="N":"D",1:"N")
 ;
 ;re-build list for sort criteria
 D BLD^DGPFLMT
 ;
 ;return to LM (refresh screen)
 S VALMBCK="R"
 Q
 ;
 ;
RM ;Entry point for DGPF TRANSMIT REJECT MESSAGE action protocol.
 ;
 ;   Input: None
 ;  Output: VALMBCK - 'R' = refresh screen
 ;
 N DGERR    ;if error returned
 N DGDFN    ;patient dfn
 N DGPFIEN  ;ien of record in PRF HL7 TRANSMISSION LOG (#26.17) file
 N DGSEL    ;user selection
 N VALMY    ;array output of EN^VALM2 call of user selected entry(s)
 ;
 S (DGSEL,DGPFIEN)=""
 ;
 ;- if user selected RM Retransmit Message action while in the
 ;  VM View Message details action, use the single entry value at
 ;  the ^TMP("DGPFSORT",$J,"SELECTION",<n>) node for retransmission.
 ;- Note, this temp node gets deleted after the RM action processes.
 ;
 S DGSEL=+$O(^TMP("DGPFSORT",$J,"SELECTION",""))
 S:DGSEL VALMY(DGSEL)=""
 ;
 ;- if no single entry found, is action selection allowed?
 ;- Note, this check will also stop the user from trying to retransmit
 ;  a single selection multiple times from the VM View Message action.
 ;
 I 'DGSEL,'$D(@VALMAR@("IDX")) D
 . W !
 . D BLD^DIALOG(261129," There are no transmission error messages to select.","","DGERR","F")
 . D MSG^DIALOG("WE","","","","DGERR") W *7
 . D WAIT^VALM1
 . ;- else, if no single entry found, prompt user for selection(s)
 E  D:'DGSEL
 . D EN^VALM2($G(XQORNOD(0)))
 . S DGSEL=$O(VALMY(""))
 ;
 ;- call to retransmit error message(s)
 I DGSEL D
 . ;
 . I $$EN^DGPFLMT5(.VALMY)
 . ;
 . D WAIT^VALM1
 . ;
 . ;- don't re-build list if $D(^TMP("DGPFSORT",$J,"SELECTION"))
 . ;  because this RM action is being called from the VM action.
 . ;
 . D:'$D(^TMP("DGPFSORT",$J,"SELECTION")) BLD^DGPFLMT
 . ;
 . ;- always clean up single entry so it can't be selected again
 . K ^TMP("DGPFSORT",$J,"SELECTION")
 ;
 ;return to LM (refresh screen)
 S VALMBCK="R"
 Q
 ;
 ;
VM ;Entry point for DGPF TRANSMIT VIEW MESSAGE action protocol.
 ;
 ;  Input: None
 ; Output: VALMBCK - 'R' = refresh screen
 ;
 N DGERR    ;if error returned
 N DGDFN    ;patient dfn
 N DGPFIEN  ;ien of record in PRF HL7 TRANSMISSION LOG (#26.17) file
 N DGSEL    ;user selection
 N VALMY    ;output of EN^VALM2 call, array of user selected entry
 ;
 ;is action selection allowed?
 I '$D(@VALMAR@("IDX")) D  Q
 . W !
 . D BLD^DIALOG(261129," There are no transmission error records to display.","","DGERR","F")
 . D MSG^DIALOG("WE","","","","DGERR") W *7
 . D WAIT^VALM1
 . S VALMBCK="R"
 ;
 ;ask user to select a single error for displaying details
 S (DGSEL,DGPFIEN)=""
 D EN^VALM2($G(XQORNOD(0)),"S")
 ;
 ;process user selection
 S DGSEL=$O(VALMY(""))
 I DGSEL,$D(@VALMAR@("IDX",DGSEL,DGSEL)) D
 . S DGPFIEN=$P($G(@VALMAR@("IDX",DGSEL,DGSEL)),U,3)
 . S DGDFN=$P($G(@VALMAR@("IDX",DGSEL,DGSEL)),U,4)
 . ;
 . ;- capture user single selection in ^TMP() global -
 . ;  This is used to determine if the user selected to retransmit a
 . ;  single record entry by selecting the Retransmit Message action
 . ;  while in the View Message action.
 . ;  If undefined after returning from the View Message action, then
 . ;  the user did use the Retransmit Message action.
 . ;  This would require Quiting the View Message screen back to the
 . ;  main screen and doing a rebuild of all display and sort files.
 . ;
 . S ^TMP("DGPFSORT",$J,"SELECTION",DGSEL)=$G(@VALMAR@("IDX",DGSEL,DGSEL))
 . ;
 . ;- call to display error message details
 . D EN^DGPFLMT3(DGDFN,DGPFIEN)
 . ;
 . ;clean-up user single selection when exiting this action.
 . K ^TMP("DGPFSORT",$J,"SELECTION")
 ;
 ;- re-build and display list
 D BLD^DGPFLMT
 ;
 ;return to LM (refresh screen)
 S VALMBCK="R"
 Q
