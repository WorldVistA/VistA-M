FBAAIAE ;ALB/FA - ADD/EDIT AN IPAC VENDOR AGREEMENT ;04 Dec 2013 07:27 AM
 ;;3.5;FEE BASIS;**123**;JAN 30, 1995;Build 51
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;-----------------------------------------------------------------------------
 ;                           Entry Points
 ; ADDEDIT  - Add/Edit an IPAC Vendor Agreement
 ;            NOTE: (actually called from first line of routine)
 ;-----------------------------------------------------------------------------
 ;
ADDEDIT ;EP
 ; Add/Edit an IPAC Vendor Agreement
 ; Called From: Menu - FBAA IPAC AGREEMENT Add/Edit an IPAC agreement
 N XX
 F  S XX=$$ADDEDIT1() Q:XX=1
 Q
 ;
ADDEDIT1()  ; Used to loop
 ; Input:       None
 ; Returns:     1 - User timed out or typed '^' to exit, 0 otherwise
 ; Called From: ADDEDT
 N IX,FLINE,MODE,STEXT,VAEDITED,VAIEN,VASTAT,VASTATO
 S FLINE="The following IPAC Agreements are currently on file:"
 S STEXT="Please select the IPAC agreement to edit or type NEW to create a new entry"
 S MODE=$$SELVA^FBAAIAU(FLINE,STEXT,1,"")       ; Select an IPAC Agreement
 I MODE="" Q 1                                  ; User exit
 I MODE=0 D ADDVA Q 0                           ; Add a new IPAC Agreement
 S VAIEN=MODE,MODE=1                            ; Edit IPAC agreement
 ;
 ; Attempt to lock the IPAC Vendor Agreement file
 Q:'$$LOCKVA^FBAAIAU(VAIEN) 0                   ; Attempt to lock the Vendor Agreement
 ;
 ; Warn the user if the selected agreement is incomplete
 S VASTATO=$P(^FBAA(161.95,VAIEN,0),U,4)        ; Current Agreement status
 I VASTATO="N" D                                ; Incomplete Vendor Agreement warning
 . W !!,"This IPAC Vendor Agreement is not complete. Complete it using this option"
 . W !,"or use the IPAC Vendor Agreement delete option to delete it."
 ;
 ; Store current Vendor agreement field values
 K ^TMP($J,"FBAAIAC")
 F IX=0:1:6 S ^TMP($J,"FBAAIAC",IX)=$G(^FBAA(161.95,VAIEN,IX))
 D EDITVA1(VAIEN)                               ; Edit the IPAC Agreement
 S VASTAT=$P(^FBAA(161.95,VAIEN,0),U,4)         ; Current Agreement status
 ;
 ; IPAC Agreement is still incomplete - unlock it and quit
 I VASTAT="N" D  Q 0
 . D UNLOCKVA^FBAAIAU(VAIEN)                    ; Unlock the Vendor Agreement
 . K ^TMP($J,"FBAAIAC")
 ;
 ; Check if the status went from N to A - First time agreement is complete
 I VASTATO="N",VASTAT="A" D  Q 0                ; Send ADD MRA
 . D A^FBAAIAQ(VAIEN)                           ; Create an ADD MRA record
 . D UNLOCKVA^FBAAIAU(VAIEN)                    ; Unlock the Vendor Agreement
 . K ^TMP($J,"FBAAIAC")
 ;
 ; Check to see if any of the field values were changed 
 S VAEDITED=0
 F IX=0:1:6 D  Q:VAEDITED
 . I $G(^FBAA(161.95,VAIEN,IX))'=$G(^TMP($J,"FBAAIAC",IX)) S VAEDITED=1
 ;
 ; Agreement was edited, create a MRA record for the changes
 D:VAEDITED=1 C^FBAAIAQ(VAIEN)                  ; Send Change MRA
 D UNLOCKVA^FBAAIAU(VAIEN)                      ; Unlock the Vendor Agreement
 K ^TMP($J,"FBAAIAC")
 Q 0
 ;
ADDVA ;
 ; Add a new IPAC Vendor Agreement
 ; Called From: ADDEDIT
 N FYR,VAIEN,VASTAT,VENIEN,XX
 S VENIEN=$$VENDSEL()                           ; Select a Vendor
 Q:VENIEN=""                                    ; No Vendor selected
 ;
 ; Display any active or new agreements for the selected vendor
 Q:'$$DISPVA(VENIEN)
 S FYR=$$FYR()                                  ; Ask fiscal year via DIR
 ;
 ; Add an IPAC Vendor Agreement for the selected vendor
 Q:'$$ADDVA1(VENIEN,FYR,.VAIEN)
 S VASTAT=$P(^FBAA(161.95,VAIEN,0),U,4)         ; Current Agreement status
 D:VASTAT'="N" A^FBAAIAQ(VAIEN)                 ; Create an ADD MRA record
 Q
 ;
VENDSEL()   ; Selects a Vendor to add an agreement for
 ; Input:       None
 ; Output:      None
 ; Returns:     VENIEN          - IEN of the selected Vendor or "" if not selected
 ; Called From: ADDVA
 N DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,QUIT,VENIEN,X,Y
 S DIC="^FBAAV(",DIC(0)="AEQM"
 S DIC("A")="Select a Vendor: "
 S DIC("S")="I $P($G(^(""AMS"")),""^"",4)=""F"""    ; Only Show Federal Vendors
 D ^DIC
 I Y'>0 Q ""                                        ; No selected Vendor
 S VENIEN=+Y,QUIT=0
 I $P($G(^FBAAV(VENIEN,"ADEL")),U,1)="Y" D          ; Deleted Vendor
 . S DIR(0)="Y"
 . W !!,"This vendor has been deleted from the Austin vendor database"
 . S DIR("A")="Do you wish to continue",DIR("B")="No"
 . D ^DIR
 . S:Y'>0 QUIT=1
 Q:QUIT ""
 Q VENIEN
 ;
FYR() ; Prompt the user for the Fiscal year of the agreement
 ; Input:       None
 ; Output:      None
 ; Returns:     FYR     - IEN of the selected Vendor or "" if not selected
 ; Called From: ADDVA
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,XX,Y,FBCURR,FBMON,FBYR
 S DIR(0)="161.95,2"
 S FBCURR=$$FMTE^XLFDT(DT,"7D")    ; current date
 S FBMON=$P(FBCURR,"/",2)          ; current month
 S FBYR=$P(FBCURR,"/",1)           ; current year
 I FBMON'<10 S FBYR=FBYR+1         ; for Oct-Dec, Fiscal year is Calendar year+1
 S DIR("B")=FBYR
 D ^DIR
 Q Y
 ;
DISPVA(VENIEN) ; Display any active or new agreements on file for this vendor
 ; Input:       VENIEN      - Selected Vendor IEN
 ; Output:      New/Active agreements for vendor are displayed
 ; Returns:     Selected Vendor or "" if no vendor was de-selected
 ; Called From: ADDVA
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,FLINE,VAIEN,VASTAT,X,Y
 ;
 ; Selected Vendor doesn't have any new or active agreements
 I '$D(^FBAA(161.95,"AVA",VENIEN,"A")),'$D(^FBAA(161.95,"AVA",VENIEN,"N")) Q VENIEN
 S FLINE="This vendor has the following active IPAC agreement(s) on file:"
 D SELVA^FBAAIAU(FLINE,"",0,VENIEN)
 W !
 S DIR(0)="Y",DIR("A")="Do you wish to continue with this vendor",DIR("B")="No"
 D ^DIR
 Q:Y'>0 ""                                      ; De-select the vendor
 Q VENIEN
 ;
ADDVA1(VENIEN,FYR,VAIEN) ; Add a new IPAC Vendor agreement for the selected vendor
 ; Input:       VENIEN      - Selected Vendor IEN
 ;              FYR         - Fiscal Year of the new IPAC agreement
 ; Output:      VAIEN       - IEN of the added/edited Vendor agreement
 ;              Vendor agreement is filed for the selected vendor
 ; Returns:     0 if New entry couldn't be added 1 otherwise
 ; Called From: ADDVA
 N DA,DIC,DIE,DO,DR,DTOUT,VAID,X,Y
 Q:'$$LOCKVA 0                                  ; Lock IPAC Agreement file
 S VAID=$$NEXTVAID()                            ; Last IPAC ID number
 D UNLOCKVA                                     ; Unlock Vendor Agreement file            
 ;
 ; Add a new entry to the IPAC Vendor Agreement file with Identity fields only
 ; NOTE: if not all the identity fields are added, no agreement is filed
 S X=VAID,DIC=161.95
 S DIC(0)="Z",DIC("DR")="1////^S X=VENIEN;2///^S X=FYR;3////N"
 D FILE^DICN
 I (+Y'>0)!($P(Y,U,3)'=1) D  Q 0
 . W !!," A new IPAC Agreement cannot be filed at this time."
 S VAIEN=+Y
 S DIE=161.95,DA=VAIEN
 S DR="4:16"
 D ^DIE
 D CHKREQ^FBAAIAU(VAIEN)                        ; Check the status
 Q 1
 ;
NEXTVAID()  ; Increments the last IPAC ID number in the parameter file
 ; and returns the new value
 ; Input:       None
 ; Output:      Sets the Last IPAC ID number parameter
 ; Returns:     Next Available IPAC ID number
 N DA,DR,DIE,DTOUT,VAID
 I '$D(^FBAA(161.4,1,"IPAC"))!'$D(^FBAA(161.95)) S VAID=100
 E  S VAID=^FBAA(161.4,1,"IPAC")
 ;
 ; Make sure this is truly the last number and if not, find the last one
 S:$D(^FBAA(161.95,"B",VAID)) VAID=$O(^FBAA(161.95,"B",""),-1)
 S VAID=VAID+1                                  ; Get the new 'LAST' ID
 S DIE=161.4,DA=1,DR="80///^S X=VAID"
 D ^DIE                                         ; File the new last number
 Q VAID
 ; 
EDITVA1(VAIEN) ; Edit the selected IPAC Vendor agreement
 ; Input:       VAIEN       - IEN of the IPAC Vendor agreement to edit
 ; Called From: ADDVA
 N DA,DIE,DR,DTOUT,INV,VASTAT
 S DIE=161.95,DA=VAIEN
 S VASTAT=$P(^FBAA(161.95,VAIEN,0),U,4),INV=0
 ;
 ; Check for current invoices for the selected agreement
 S:$D(^FBAAC("IPAC",VAIEN))!($D(^FBAA(162.1,"IPAC",VAIEN))!($D(^FBAAI("IPAC",VAIEN)))) INV=1
 ;
 ; Display Vendor and Fiscal Year but don't allow edit if invoices exist
 I INV D
 . N FYR,VENDOR
 . S VENDOR=$P(^FBAA(161.95,VAIEN,0),"^",2)
 . S VENDOR=$E($P(^FBAAV(VENDOR,0),"^",1),1,36)
 . S FYR=$P(^FBAA(161.95,VAIEN,0),"^",3)
 . W !!,"The IPAC Agreement you have selected has been used on one or more payment "
 . W !,"records.  Because of this the Vendor and the Fiscal Year are not editable."
 . W !!,"     VENDOR: ",$$LJ^XLFSTR(VENDOR,38),"(No editing allowed)"
 . W !,"FISCAL YEAR: ",$$LJ^XLFSTR(FYR,38),"(No editing allowed)",!
 S DR=$S('INV:"1:2;",1:"")
 S DR=DR_$S(VASTAT'="N":"3:16",1:"4:16")
 D ^DIE
 D CHKREQ^FBAAIAU(VAIEN)                        ; Check the status
 Q
 ;
LOCKVA() ; Attempt to lock the Vendor agreement file to add a new agreement
 ; Input:   None
 ; Output:  Vendor agreement file locked or error message displayed
 ; Returns: 1 - Vendor agreement file locked, 0 otherwise
 L +^FBAA(161.95,0):0
 I '$T D  Q 0
 . W !!,"Someone is editing the IPAC Agreement file.  Cannot enter a new IPAC agreement"
 . W !,"file at this time.  Try again at a later time."
 Q 1
 ;
UNLOCKVA() ; Unlock Vendor agreement file
 ; Input:   None
 ; Output:  Vendor agreement file unlocked
 L -^FBAA(161.95,0)
 Q
 ;
