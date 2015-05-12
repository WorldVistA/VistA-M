FBAAIAQ ;ALB/FA - Managing IPAC Agreement MRAs ;04 Dec 2013  7:36 AM
 ;;3.5;FEE BASIS;**123**;JAN 30, 1995;Build 51
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Contains methods for creating add/edit/delete Master Record Adjustments for a
 ; selected IPAC Vendor Agreement
 ;
 ;-----------------------------------------------------------------------------
 ;                           Entry Points
 ; A            - Create an Add Master Record Adjustment for a newly created IPAC
 ;                Vendor Agreement
 ; AA           - Create an Add Master Record Adjustment for a specified IPAC Vendor 
 ;                Agreement without changing existing data. Called from
 ;                FBAA IPAC AGREEMENT MRA MENU/FBAA MRA IPAC ADD TYPE
 ; C            - Create an Edit Master Record Adjustment for an edited IPAC Vendor
 ;                agreement   
 ; CC           - Create an Edit Master Record Adjustment for a specified Vendor 
 ;                Agreement without changing existing data. Called from
 ;                FBAA IPAC AGREEMENT MRA MENU/FBAA MRA IPAC CHANGE TYPE
 ; D            - Create a Delete Master Record Adjustment record
 ; DD           - Create a delete Master Record Adjustment record for a specified 
 ;                Vendor Agreement without changing existing data. Called from
 ;                FBAA IPAC AGREEMENT MRA MENU/FBAA MRA IPAC DELETE TYPE
 ;-----------------------------------------------------------------------------
 ;
A(VAIEN) ;EP
 ; Create an IPAC Vendor Agreement Add MRA record. Only called when adding
 ; a new Vendor agreement
 ; Input:       VAIEN       - Vendor Agreement IEN to create an ADD MRA
 ;                            record for
 ; Output:
 ; Called From: FBAAIAE@ADDVA
 N VAID
 S VAID=$P(^FBAA(161.95,VAIEN,0),U,1)
 D NEWMRA(VAIEN,VAID,"A")
 Q
 ;
C(VAIEN) ;EP
 ; Create a Change MRA record for the edited Vendor Agreement
 ; Input:       VAIEN               - Vendor Agreement IEN
 ;              ^TMP($J,"FBAAIAC")  - Vendor Agreement values prior to being
 ;                                    being edited. Used to detect changes.
 ; Called From: FBAAIAC@EDITF
 N MRAACT,VAID
 S VAID=$P(^FBAA(161.95,VAIEN,0),U,1)
 ;
 ; If a pending MRA record already exists for this agreement quit now
 Q:$$PENDMRA(VAID,.MRAACT)
 D NEWMRA(VAIEN,VAID,"C")
 Q
 ;
D(VAID) ;EP
 ; Create a Delete MRA record for the selected Vendor Agreement
 ; Input:       VAID        - ID of the Selected Vendor Agreement
 ; Output:      Delete Master Record Adjustment record created (potentially)
 ; Called From: DEL@FBAAIAD
 N MRAACT,MRAIEN
 S MRAIEN=$$PENDMRA(VAID,.MRAACT)
 ;
 ; If a pending MRA record for the Vendor agreement exists, it must be either an
 ; ADD or a CHANGE record. It cannot be a DELETE record because before a DELETE
 ; MRA record is filed for a Vendor agreement, the agreement is deleted from the
 ; file making it impossible to be deleted again. If a pending MRA record is an 
 ; ADD action we just need to delete it because the user deleted the Vendor
 ; agreement before it was ever transmitted. If it is a CHANGE action we need to
 ; edit it and change the action to DELETE and re-file it rather than file a new one.
 I MRAIEN>0 D  Q
 . I MRAACT="A" D DELMRA(MRAIEN) Q
 . N DA,DIE,DR,DTOUT
 . S DIE=161.96,DA=MRAIEN
 . S DR="1////@;3////D"
 . D ^DIE
 D NEWMRA("",VAID,"D")                          ; Create a DELETE MRA record
 Q
 ;
PENDMRA(VAID,MRASTAT)  ; Checks to see if an MRA record in a pending status already
 ; exists for the specified IPAC Vendor Agreement
 ; Input:       VAID    - ID of the selected IPAC Vendor Agreement
 ; Output:      MRAACT  - Action of the pending MRA record
 ;                        "" if no pending MRA record exists
 ; Returns:     IEN of the pending MRA record if one exists, 0 otherwise
 ; Called From: AA,C,CC,D
 N MRAIEN,STOP
 S MRASTAT="",MRAIEN="",STOP=0
 F  D  Q:MRAIEN=""  Q:STOP
 . S MRAIEN=$O(^FBAA(161.96,"AS","P",MRAIEN))
 . Q:MRAIEN=""
 . ;
 . ; Quit if the MRA is not for the selected Vendor Agreement
 . Q:$P(^FBAA(161.96,MRAIEN,0),U,3)'=VAID
 . S STOP=1
 S:STOP MRASTAT=$P(^FBAA(161.96,MRAIEN,0),U,4)
 Q:STOP MRAIEN
 Q 0
 ;
AA ;EP
 ; Create and ADD Master Record Adjustment for a specified Vendor Agreement without
 ; changing existing data
 ; Input:       None
 ; Called From: Menu - FBAA IPAC AGREEMENT MRA MENU/FBAA MRA IPAC ADD TYPE 
 N DIC,DTOUT,DUOUT,MRAACT,MRAIEN,MRASTAT,VAID,VAIEN,X,Y
 S DIC=161.95,DIC(0)="AEQMZ"
 S DIC("A")="Select an IPAC Vendor Agreement: "
 D ^DIC                                         ; Select an agreement
 Q:Y'>0
 S VAIEN=+Y                                     ; Selected Vendor Agreement EIN
 Q:VAIEN'>0                                     ; No selected agreement
 I $P(^FBAA(161.95,VAIEN,0),U,4)="N" D  Q
 . W !!,"IPAC Vendor Agreement Status is NEW."
 . W !,"First edit the Vendor Agreement and complete it."
 S VAID=$P(^FBAA(161.95,VAIEN,0),U,1)
 ;
 ; Check to see if the selected Vendor Agreement already has a pending MRA record
 S MRAIEN=$$PENDMRA(VAID,.MRAACT)
 ;
 ; No pending record exists, attempt to add a pending MRA add record for the selected
 ; Vendor agreement
 I MRAIEN=0 D  Q
 . I '$$LOCKVA^FBAAIAU(VAIEN,0) D  Q
 . . W !!,"Someone else is editing this agreement. "
 . . W !,"An ADD MRA cannot be created at this time."
 . . W !,"Try again later."
 . D NEWMRA(VAIEN,VAID,"A")
 . D UNLOCKVA^FBAAIAU(VAIEN)
 . W !!,"ADD MRA created and ready for transmission.",!!
 ;
 S MRASTAT=$P(^FBAA(161.96,MRAIEN,0),U,5)
 I MRASTAT="P",MRAACT="A" W !!,"ADD MRA already exists." Q
 ;
 ; Prompt the user to ask if we should change a pending CHANGE MRA record to a 
 ; pending Add MRA record
 I MRASTAT="P",MRAACT="C" D
 . I '$$LOCKVA^FBAAIAU(VAIEN,0) D  Q
 . . W !!,"Someone else is editing this agreement. "
 . . W !,"An ADD MRA cannot be created at this time."
 . . W !,"Try again later."
 . W !,"An MRA is with a status of CHANGE is currently Pending."
 . N DA,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,Y
 . S DIR(0)="Y",DIR("A")="Do you want to change the type to ADD?"
 . S DIR("B")="No"
 . D ^DIR
 . I +Y=0 D UNLOCKVA^FBAAIAU(VAIEN) Q
 . S DIE=161.96,DA=MRAIEN
 . S DR="3////A;4////P"
 . D ^DIE
 . D UNLOCKVA^FBAAIAU(VAIEN)
 . W !!,"ADD MRA created from a CHANGE MRA and ready for transmission.",!!
 Q
 ;
CC ;EP
 ; Change a Master Record Adjustment for a specified Vendor agreement without
 ; changing existing data
 ; Input:       None
 ; Called From: Menu - FBAA IPAC AGREEMENT MRA MENU/FBAA MRA IPAC CHANGE TYPE 
 N DIC,DTOUT,DUOUT,MRAACT,MRAIEN,MRASTAT,VAID,VAIEN,X,Y
 S DIC=161.95,DIC(0)="AEQMZ"
 S DIC("A")="Select an IPAC Vendor Agreement: "
 D ^DIC                                         ; Select an agreement
 Q:Y'>0
 S VAIEN=+Y                                     ; Selected Vendor Agreement EIN
 Q:VAIEN'>0                                     ; No selected agreement
 ;
 I $P(^FBAA(161.95,VAIEN,0),U,4)="N" D  Q
 . W !!,"IPAC Vendor Agreement Status is NEW."
 . W !,"First edit the Vendor Agreement and complete it."
 S VAID=$P(^FBAA(161.95,VAIEN,0),U,1)
 ;
 ; Check to see if the selected Vendor Agreement already has a pending MRA record
 S MRAIEN=$$PENDMRA(VAID,.MRAACT)
 ;
 ; No pending record exists, attempt to add a pending MRA change record for the selected
 ; Vendor agreement
 I MRAIEN=0 D  Q
 . I '$$LOCKVA^FBAAIAU(VAIEN,0) D  Q
 . . W !!,"Someone else is editing this agreement. "
 . . W !,"A CHANGE MRA cannot be created at this time."
 . . W !,"Try again later."
 . D NEWMRA(VAIEN,VAID,"C")
 . D UNLOCKVA^FBAAIAU(VAIEN)
 . W !!,"CHANGE MRA created and ready for transmission.",!!
 ;
 S MRASTAT=$P(^FBAA(161.96,MRAIEN,0),U,5)
 I MRASTAT="P",MRAACT="C" W !!,"CHANGE MRA already exists." Q
 ;
 ; Prompt the user to ask if we should change a pending Add MRA record to a 
 ; pending Add MRA record
 I MRASTAT="P",MRAACT="A" D
 . I '$$LOCKVA^FBAAIAU(VAIEN,0) D  Q
 . . W !!,"Someone else is editing this agreement. "
 . . W !,"A CHANGE MRA cannot be created at this time."
 . . W !,"Try again later."
 . W !,"An MRA is with a status of ADD is currently Pending."
 . N DA,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,Y
 . S DIR(0)="Y",DIR("A")="Do you want to change the type to CHANGE?"
 . S DIR("B")="No"
 . D ^DIR
 . I +Y=0 D UNLOCKVA^FBAAIAU(VAIEN) Q
 . S DIE=161.96,DA=MRAIEN
 . S DR="3////C;4///P"
 . D ^DIE
 . D UNLOCKVA^FBAAIAU(VAIEN)
 . W !!,"CHANGE MRA created from an ADD MRA and ready for transmission.",!!
 Q
 ;
DD ;EP
 ; Create a delete Master Record Adjustment record for a specified Vendor Agreement
 ; without changing actual data
 ; Called From: Menu - FBAA IPAC AGREEMENT MRA MENU/FBAA MRA IPAC DELETE TYPE 
 N DA,DIE,DR,DIR,FLINE,STEXT,MRAIEN,X,Y
 S FLINE="The following Transmitted DELETE MRA Records are currently on file:"
 S STEXT="Please select the DELETE MRA Record to re-transmit"
 ;
 ; Display a list of Transmitted Deleted MRA Records for selection
 S MRAIEN=$$SELMRA^FBAAIAU(FLINE,STEXT,"T","D")
 Q:MRAIEN=""                                    ; No MRA record selected
 ;
 ; Change the status and remove the transmit date of the selected transmitted
 ; record and refile it.
 S DIE="^FBAA(161.96,",DA=MRAIEN
 S DR="3///^S X="_"""DELETE"""
 S DR=DR_";4////P;5////@"
 D ^DIE
 W !!,"DELETE MRA processing completed."
 Q
 ;
NEWMRA(VAIEN,VAID,ACTION) ; Create an IPAC Vendor Agreement MRA record of 
 ; specified ACTION for the specified Vendor Agreement
 ; a new Vendor agreement
 ; Input:       VAIEN       - Vendor Agreement IEN to create an MRA
 ;                            record for. "" if creating a DELETE MRA
 ;              VAID        - Vendor Agreement ID to create and MRA record for
 ;              ACTION      - MRA Action ('A','C' or 'D')
 ; Output:      New MRA record is filed
 ; Called From: A,AA,C,CC,D,DD
 N DA,DIC,DO,DR,DTOUT,DUOUT,X,Y
 S DIC=161.96,DIC(0)="EZ"
 S X=$P($G(^FBAA(161.96,0)),U,4)+1
 S DIC("DR")="1///^S X=VAIEN;2///^S X=VAID;3///^S X=ACTION;4///P"
 D FILE^DICN
 Q
 ;
DELMRA(MRAIEN) ; Delete an existing MRA record
 ; Input:       MRAIEN      - IEN of the MRA record to be deleted
 ; Output:      Specified MRA record is deleted
 ; Called From: A,C,D
 N DA,DIK
 S DIK="^FBAA(161.96,"
 S DA=MRAIEN
 D ^DIK
 Q
 ;
