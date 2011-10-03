IBJPI3 ;DAOU/BHS - IBJP IIV MOST POPULAR PAYER LIST SCREEN ;25-NOV-2003
 ;;2.0;INTEGRATED BILLING;**271**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; IIV - Insurance Identification and Verification Interface
 ;
EN ; -- main entry pt for IBJP IIV MOST POPULAR PAYERS
 N POP,X,CTRLCOL,VALMHDR,VALMCNT,%DT
 D EN^VALM("IBJP IIV MOST POPULAR PAYERS")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)=" "_$S($D(^TMP($J,"IBJPI3-MODS")):"Unsaved Changes Exist",1:"Last Saved:  "_$$FMTE^XLFDT($P($G(^IBE(350.9,1,51)),U,21),"5Z"))
 S VALMHDR(2)="     "_$$FO^IBCNEUT1(" ",49)_"  "_$$FO^IBCNEUT1(" ",11)_"  Nat.  Loc."
 S VALMHDR(3)="  #  "_$$FO^IBCNEUT1("Payer Name ",49)_"  "_$$FO^IBCNEUT1("National ID",11)_"  Act?  Act?"
 Q
 ;
INIT ; -- init vars and list array
 ; Init temp globals
 K ^TMP($J,"IBJPI3")
 K ^TMP($J,"IBJPI3-IENS")
 K ^TMP($J,"IBJPI3-LIST")
 K ^TMP($J,"IBJPI3-MODS")
 D CLEAN^VALM10  ; Kills data and video control arrays w/active list
 D BLD           ; Build list from site params
 D DISP          ; Build display array
 Q
 ;
HELP ; HELP screen for Most Pop screen
 D FULL^VALM1   ; Full screen mode
 W @IOF
 D EN^DDIOL("Most Popular Payer List Edit Actions")
 D EN^DDIOL(" ")
 D EN^DDIOL("Add Entry - Inserts a new payer into the list at any position as")
 D EN^DDIOL("  long as the list has fewer than ten entries.  The entry will be inserted and")
 D EN^DDIOL("  existing entries from the new position through the end of the list will be")
 D EN^DDIOL("  shifted down one position.")
 D EN^DDIOL(" ")
 D EN^DDIOL("Delete Entry - Deletes a payer from the list at any position as")
 D EN^DDIOL("  long as the list has at least one entry.  The entries following the deleted")
 D EN^DDIOL("  entry will be shifted up one position.")
 D EN^DDIOL(" ")
 D EN^DDIOL("Modify Entry - Modifies a payer from the list at any position as")
 D EN^DDIOL("  long as the list has at least one entry.  The new payer must be")
 D EN^DDIOL("  valid in order to replace the existing entry.")
 D EN^DDIOL(" ")
 D EN^DDIOL("Print Current List - Allows the user to specify a device and print the current")
 D EN^DDIOL("  items in the list.")
 D PAUSE^VALM1
 D EN^DDIOL("Reorder Entry - Changes a payer from the list at any position to")
 D EN^DDIOL("  another position so long as the list has at least two entries.  Moving the")
 D EN^DDIOL("  entry to a lower position shifts entries following the original position up")
 D EN^DDIOL("  one position except for those lower than the new position.  Moving the entry")
 D EN^DDIOL("  to a higher position shifts entries following the new position down one")
 D EN^DDIOL("  position except for those lower than the original position.")
 D EN^DDIOL(" ")
 D EN^DDIOL("Restore Saved List - If editing actions were performed, the user will be")
 D EN^DDIOL("  prompted to verify that they wish to discard all changes.")
 D EN^DDIOL(" ")
 D EN^DDIOL("Save Current List - Saves the current list to the Site Parameters file.")
 D EN^DDIOL(" ")
 D EN^DDIOL("Exit Action - If editing actions were performed, the user will be prompted")
 D EN^DDIOL("  to save the current list or exit without filing changes.")
 D PAUSE^VALM1  ; Press return to continue
 W @IOF
 S VALMBCK="R"  ; Refresh screen
 Q
 ;
EXIT ; -- exit code
 S VALMBCK="R"
 ; If the list has been acted upon, prompt for save
 I $D(^TMP($J,"IBJPI3-MODS")) D
 . D EN^DDIOL("Unsaved changes exist!")
 . D SAVE^IBJPI4
 ; Kill temp globals
 K ^TMP($J,"IBJPI3")
 K ^TMP($J,"IBJPI3-LIST")
 K ^TMP($J,"IBJPI3-IENS")
 K ^TMP($J,"IBJPI3-MODS")
 D CLEAN^VALM10  ; Kills data and video control arrays w/active list
 Q
 ;
BLD ; -- build list array
 N IBIEN,IBCT,IEN
 ; Init temp globals
 K ^TMP($J,"IBJPI3-LIST")
 K ^TMP($J,"IBJPI3-IENS")
 K ^TMP($J,"IBJPI3-MODS")
 ; Loop thru current List of Payers
 S (IEN,IBCT)=0
 F  S IEN=$O(^IBE(350.9,1,51.18,IEN)) Q:'IEN  D
 . S IBIEN=$P($G(^IBE(350.9,1,51.18,IEN,0)),U) Q:'IBIEN  ; Bad IEN
 . S IBCT=IBCT+1
 . S ^TMP($J,"IBJPI3-LIST",IBCT)=IBIEN  ; List by pos 
 . S ^TMP($J,"IBJPI3-IENS",IBIEN)=""    ; IEN index
 Q
 ;
DISP ; Build display array of text
 N IBI,IBIEN,IBST,IBLN,IBAIEN,IBADATA
 ; Init display global
 K ^TMP($J,"IBJPI3")
 ; Loop thru current list of Payers
 S IBLN=0
 F IBI=1:1:10 S IBIEN=$G(^TMP($J,"IBJPI3-LIST",IBI)) Q:'IBIEN  D
 . S IBST=$$FO^IBCNEUT1(IBI,3,"R")_". "
 . ; Name
 . S IBST=IBST_$$FO^IBCNEUT1($P($G(^IBE(365.12,IBIEN,0)),U),49)
 . ; National ID
 . S IBST=IBST_"  "_$$FO^IBCNEUT1($P($G(^IBE(365.12,IBIEN,0)),U,2),11)
 . S (IBAIEN,IBADATA)=""
 . ; Payer App IEN
 . S IBAIEN=$$PYRAPP^IBCNEUT5("IIV",IBIEN)
 . ; WARNING - IIV application does not exist
 . I IBAIEN="" D  Q
 . . S IBLN=$$SET(IBLN,IBST)
 . . S IBST="       ** Please remove from this list: Payer not configured for IIV **"
 . . S IBLN=$$SET(IBLN,IBST)
 . S IBADATA=$G(^IBE(365.12,+IBIEN,1,+IBAIEN,0))
 . ; Nat Act Flg
 . S IBST=IBST_"  "_$$FO^IBCNEUT1($S('$P(IBADATA,U,2):"NO",1:"YES"),4)
 . ; Loc Act Flg
 . S IBST=IBST_"  "_$$FO^IBCNEUT1($S('$P(IBADATA,U,3):"NO",1:"YES"),4)
 . S IBLN=$$SET(IBLN,IBST)
 . ; WARNING - IIV application deactivated
 . I +$P(IBADATA,U,11) D  Q
 . . S IBST="       ** Please remove from this list: Payer is deactivated for IIV **"
 . . S IBLN=$$SET(IBLN,IBST)
 . ; WARNING - Id Inq Req ID = YES & Use SSN as ID = NO
 . I +$P(IBADATA,U,8),'$P(IBADATA,U,9) D
 . . S IBST="       ** Please remove from this list: Inquiries w/o subscriber ID rejected **"
 . . S IBLN=$$SET(IBLN,IBST)
 ; No Data Found if $O(^TMP($J,"IBJPI3-LIST",0))=""
 I $O(^TMP($J,"IBJPI3-LIST",0))="" S IBLN=$$SET(IBLN,"     *** NO DATA FOUND!!! ***")
 ; Update line ct
 S VALMCNT=IBLN
 Q
 ;
SET(LN,STR) ; Build list array
 S LN=$G(LN)+1
 D SET^VALM10(LN,STR)
 Q LN
 ;
