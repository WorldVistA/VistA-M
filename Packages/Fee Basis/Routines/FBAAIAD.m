FBAAIAD ;ALB/FA - DELETE AN IPAC AGREEMENT ;03 Dec 2013  2:10 PM
 ;;3.5;FEE BASIS;**123**;JAN 30, 1995;Build 51
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;-----------------------------------------------------------------------------
 ;                           Entry Points
 ; ISEL     - Delete the specified IPAC Vendor Agreement
 ;            NOTE: (actually called from first line of routine)
 ;-----------------------------------------------------------------------------
 ;                         
ISEL ;EP
 ; Delete the specified IPAC Vendor Agreement
 ; Input:       None
 ; Output:      IPAC Vendor agreement deleted (potentially)
 ; Called From: Menu - FBAA IPAC AGREEMENT Delete an IPAC agreement
 N XX
 F  S XX=$$ISEL1() Q:XX=1
 Q
 ;
ISEL1() ;
 ; Input:       None
 ; Returns:     1 - User timed out or typed '^' to exit, 0 otherwise
 ; Called From: ISEL
 N EOUT,FLINE,STEXT,VAIEN,XX
 S FLINE="The following IPAC Agreements are currently on file:"
 S STEXT="Please select the IPAC agreement to delete"
 S VAIEN=$$SELVA^FBAAIAU(FLINE,STEXT,0,"")      ; Select an IPAC Agreement
 I VAIEN="" Q 1                                 ; User exit
 ;
 ; Check for current invoices for the selected agreement
 I $D(^FBAAC("IPAC",VAIEN))!($D(^FBAA(162.1,"IPAC",VAIEN))!($D(^FBAAI("IPAC",VAIEN)))) D  Q EOUT
 . N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 . W !!,"This IPAC agreement has invoice activity associated with it"
 . W !,"and cannot be deleted.",!
 . S EOUT=0
 . S DIR(0)="E"
 . D ^DIR
 . S:$D(DTOUT)!$D(DUOUT) EOUT=1                 ; User timed out or pressed '^'
 ;
 S XX=$$ASKDISP(VAIEN)                          ; Ask to display the agreement
 I XX=-1 Q 1                                    ; User timeout or '^'
 I XX D                                         ; Display the agreement
 . W !!
 . D VADISP^FBAAIAU(VAIEN,1)
 . W !
 S XX=$$ASKSURE(VAIEN)                          ; Final verification before delete attempt
 I XX=-1 Q 1                                    ; User timeout or '^'
 Q:'XX 0                                        ; User chose not to delete
 Q:'$$LOCKVA^FBAAIAU(VAIEN) 0                   ; Attempt to lock the Vendor Agreement
 D DEL(VAIEN)                                   ; Perform the actual deletion
 D UNLOCKVA^FBAAIAU(VAIEN)                      ; Unlock the deleted agreement
 Q 0
 ;
ASKDISP(VAIEN)  ; Ask the user if they want to see the agreement details
 ; Input:       VAIEN       - IEN of the selected Vendor agreement
 ; Output:      User is prompted to display the agreement
 ; Returns:     1 - User wants to display the agreement
 ;              0 - User doesn't want to display the agreement
 ;             -1 - User timed out or typed '^'
 ; Called From: ISEL
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="Y",DIR("A")="Display this IPAC Vendor Agreement",DIR("B")="No"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q -1                     ; User timed out or pressed '^'
 Q:Y'>0 0
 Q Y
 ;
ASKSURE(VAIEN)  ; Make sure the user selected the correct Vendor agreement
 ; Input:       VAIEN       - IEN of the selected vendor agreement
 ; Output:      User is prompted again
 ; Returns:     1 - User verifies deletion
 ;              0 - User chose not to delete
 ;             -1 - User timed out or typed '^'
 ; Called From: ISEL
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="Y",DIR("A")="Delete this IPAC Vendor Agreement",DIR("B")="No"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q -1                     ; User timed out or pressed '^'
 Q:Y'>0 0
 Q Y
 ;
DEL(VAIEN) ; Perform the actual Vendor agreement deletion
 ; Input:       VAIEN       - IEN of the selected vendor agreement
 ; Output:      Selected Vendor Agreement and its Master Record Adjustment are deleted
 ; Called From: ISEL
 N DA,DIK,VAID,VASTAT
 S DA=VAIEN,DIK="^FBAA(161.95,"
 S VASTAT=$P(^FBAA(161.95,VAIEN,0),U,4)         ; Current Agreement Status
 ;
 S VAID=$P(^FBAA(161.95,VAIEN,0),U,1)           ; Vendor Agreement ID
 D ^DIK                                         ; Delete the Vendor Agreement
 Q:(VASTAT="N")!(VASTAT="")                     ; No MRA to delete
 D D^FBAAIAQ(VAID)                              ; Create a Delete MRA record
 Q
